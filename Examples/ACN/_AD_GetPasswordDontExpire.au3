#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 返回密码不会过期的用户帐户数组
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 返回密码不会过期的用户帐户数组
Global $aNotExpire[1]
$aNotExpire = _AD_GetPasswordDontExpire()
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "No user accounts for which the password will not expire could be found")
Else
	_ArrayDisplay($aNotExpire, "Active Directory Functions - User accounts for which the password will not expire")
EndIf

; 关闭Active Directory连接
_AD_Close()

