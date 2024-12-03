#!/bin/bash

# 獲取主機名稱和當天日期時間
hostname=$(hostname)
current_time=$(date "+%Y-%m-%d_%H-%M-%S")
log_file="${hostname}_${current_time}.log"

# 開始記錄日誌，同時保持終端輸出
exec > >(tee "$log_file") 2>&1

echo "===== 本機端名稱設定檢查 ====="

# 電腦名稱 (Computer Name)
computer_name=$(scutil --get ComputerName)
echo "電腦名稱 (Computer Name): $computer_name"

# 本地主機名稱 (Local Hostname)
local_hostname=$(scutil --get LocalHostName)
echo "本地主機名稱 (Local Hostname): $local_hostname"

# 主機名稱 (HostName)
sc_hostname=$(scutil --get HostName)
if [ -z "$sc_hostname" ]; then
  echo "主機名稱 (HostName): 未設定"
else
  echo "主機名稱 (HostName): $sc_hostname"
fi

# Bonjour 名稱
bonjour_name=$(defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName 2>/dev/null)
if [ -z "$bonjour_name" ];then
  echo "Bonjour 名稱 (NetBIOS Name): 未設定"
else
  echo "Bonjour 名稱 (NetBIOS Name): $bonjour_name"
fi

# 網路設定的主機名稱
network_hostname=$(hostname)
echo "網路設定的主機名稱 (Network Hostname): $network_hostname"

# 使用 scutil 檢查 DNS 名稱 (模擬 dnsdomainname)
dns_search_domains=$(scutil --dns | grep "search domain" | awk '{print $3}')
if [ -z "$dns_search_domains" ]; then
  echo "DNS 搜尋網域名稱: 未設定"
else
  echo "DNS 搜尋網域名稱: $dns_search_domains"
fi

# 檢查目前使用者
current_user=$(whoami)
echo "目前登入的使用者: $current_user"

# 使用者環境變數
echo "使用者環境變數："
env

# DHCP 是否影響 hostname
dhcp_hostname=$(ipconfig getoption en0 host_name 2>/dev/null)
if [ -z "$dhcp_hostname" ]; then
  echo "DHCP 分配的主機名稱: 未設定"
else
  echo "DHCP 分配的主機名稱: $dhcp_hostname"
fi

# 檢查啟動腳本中的設定
echo "===== 檢查啟動腳本中的設定 ====="
for file in /etc/profile ~/.bash_profile ~/.zshrc ~/.bashrc ~/.zprofile ~/.profile; do
  if [ -f "$file" ]; then
    echo "檢查 $file:"
    grep -i "hostname" "$file" || echo "無相關 hostname 設定"
  fi
done

# 網路介面清單
echo "網路介面清單："
networksetup -listallhardwareports

# 每個網路介面的 IP 設定
echo "網路介面詳細資訊："
ifconfig

# 檢查所有網路服務名稱及其啟用狀態
echo "網路服務名稱與狀態："
networksetup -listallnetworkservices

# 檢查 MDM 管理設定
echo "===== 檢查 MDM 管理設定 ====="
if [ -d "/Library/Managed Preferences" ]; then
  echo "已啟用 MDM，檢查 /Library/Managed Preferences:"
  ls /Library/Managed\ Preferences
else
  echo "未檢測到 MDM 設定檔案"
fi

# 檢查系統日誌中與 hostname 有關的記錄
echo "===== 系統日誌檢查 ====="
echo "檢查是否有 hostname 變更記錄 (可能由 DHCP 或其他程式觸發)"
grep "hostname" /var/log/system.log 2>/dev/null || echo "未找到 hostname 相關記錄"

echo "===== 檢查完成 ====="

# 結束提示
echo "日誌已儲存至檔案：$log_file"
echo "您可以使用以下指令檢視檔案內容："
echo "cat $log_file"
