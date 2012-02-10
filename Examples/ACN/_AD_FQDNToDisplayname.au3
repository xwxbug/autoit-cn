#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; *****************************************************************************
; 示例 1 - 操作当前用户. 从SamAccountname获取FQDN. 然后从FQDN获取显示名称.
; *****************************************************************************
; 获取当前用户完全合法的域名(FQDN)
Global $sFQDN = _AD_SamAccountNameToFQDN()

; 获取当前用户的显示名称
Global $sDisplayName = _AD_FQDNToDisplayname($sFQDN)
If Not @error Then
	msgbox(64, "Active Directory Functions", _
			"The Fully Qualified Domain Name (FQDN) for the currently logged on user is:" & @CRLF & $sFQDN & @CRLF & @CRLF & _
			"The Display Name for the currently logged on user is:" & @CRLF & $sDisplayName)
Else
	msgbox(48, "Active Directory Functions", _
			"The Fully Qualified Domain Name (FQDN) for the current user could not be found:" & @CRLF & $sFQDN & @CRLF & @CRLF & _
			"Error / Extended Error:" & @error & " /" & @extended)
EndIf

; *****************************************************************************
