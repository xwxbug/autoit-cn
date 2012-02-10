#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 连接到Active Directory
_AD_Open()

; *****************************************************************************
; 示例1 - 获取当前用户的完全合法的域名(FQDN)
; *****************************************************************************
Global $sFQDN = _AD_SamAccountNameToFQDN()
msgbox(64, "Active Directory Functions", "The Fully Qualified Domain Name (FQDN) for the currently logged on user is:" & @CRLF & $sFQDN)

; *****************************************************************************
; 示例2 - 获取运行该脚本的计算机的完全合法的域名(FQDN). $标记附加到计算机名以创建正确的SAMAccountName.
; *****************************************************************************
$sFQDN = _AD_SamAccountNameToFQDN(@ComputerName & "$")
msgbox(64, "Active Directory Functions", "The Fully Qualified Domain Name (FQDN) for this computer is:" & @CRLF & $sFQDN)

; 关闭Active Directory连接
_AD_Close()

