#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; *****************************************************************************
; 示例1 - 检查当前用户的密码是否过期
; *****************************************************************************
If _AD_IsPasswordExpired() Then
	msgbox(64, "Active Directory Functions", "Password for user'" & @UserName & "'has expired")
Else
	msgbox(64, "Active Directory Functions", "Password for user'" & @UserName & "'has not expired")
EndIf

; *****************************************************************************
; 示例2 - 获取密码过期的账户列表并检查首个值
; *****************************************************************************
Global $aExpired = _AD_GetPasswordExpired()
If @error = 0 Then
	Global $sUser = _AD_FQDNToSamAccountName($aExpired[1])
	If _AD_IsPasswordExpired($sUser) Then
		msgbox(64, "Active Directory Functions", "Password for user'" & $sUser & "'has expired")
	Else
		msgbox(64, "Active Directory Functions", "Password for user'" & $sUser & "'has not expired")
	EndIf
Else
	msgbox(64, "Active Directory Functions", "No expired user passwords found")
EndIf

; 关闭Active Directory连接
_AD_Close()

