# Hostname and System Configuration Checker

This script is designed to collect detailed information about the system's hostname configuration and related settings on macOS. It saves the collected information to a log file and provides a terminal summary upon completion.

## Features

- **Collect System Information**:
  - Computer Name (as displayed in Finder).
  - Local Hostname (used for local network services like Bonjour).
  - Hostname (used in network configurations).
  - Bonjour/NetBIOS Name.
  - DHCP-assigned Hostname (if any).
  - Current User.
  - User-specific environment variables.

- **Analyze Configuration**:
  - Checks for custom hostname settings in startup scripts.
  - Lists network interfaces and their configurations.
  - Displays DNS search domains.
  - Verifies if MDM (Mobile Device Management) is enabled.
  - Searches system logs for hostname-related changes.

- **Output Options**:
  - Saves all results to a timestamped log file.
  - Displays a completion message in the terminal with the log file's location.

## Requirements

- macOS system
- Basic bash support
- Access to terminal and administrative privileges (if necessary for specific checks)

## Usage

1. Clone or download the script file to your macOS system.
2. Make the script executable:
   ```bash
   chmod +x check_hostname_with_terminal_notice.sh
   ```
3. Run the script:
   ```bash
   ./check_hostname_with_terminal_notice.sh
   ```

## Output

- The script will generate a log file named in the format:
  ```
  [hostname]_[YYYY-MM-DD_HH-MM-SS].log
  ```
  Example: `MacBook-Pro_2024-12-03_14-50-00.log`

- The log file includes detailed system information and is saved in the same directory as the script.

- After completion, the terminal will display:
  - A summary message indicating the log file's location.
  - A suggested command for viewing the log file (e.g., `cat <logfile>`).

## Example

### Terminal Output
```
===== 檢查完成 =====
日誌已儲存至檔案：MacBook-Pro_2024-12-03_14-50-00.log
您可以使用以下指令檢視檔案內容：
cat MacBook-Pro_2024-12-03_14-50-00.log
```

### Log File Content
```
===== 本機端名稱設定檢查 =====
電腦名稱 (Computer Name): MacBook-Pro
本地主機名稱 (Local Hostname): MacBook-Pro
主機名稱 (HostName): 未設定
Bonjour 名稱 (NetBIOS Name): 未設定
網路設定的主機名稱 (Network Hostname): MacBook-Pro.local
...
===== 檢查完成 =====
```

## Customization

You can modify the script to include additional checks or adjust the output format. If you'd like specific features, feel free to ask for assistance.

## License

This script is provided as-is, without warranty of any kind. Use it at your own risk.
