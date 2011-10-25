#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; *****************************************************************************
; 示例1 - 测试多值属性
; *****************************************************************************
Global $aResult = _AD_GetObjectAttribute(@UserName, "proxyAddresses")
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "Attribute 'proxyAddresses' for user'" & @UserName & "'could not be found")
Else
	_ArrayDisplay($aResult, "Active Directory Functions - User'" & @UserName & "', Attribute 'proxyAddresses'")
EndIf

; *****************************************************************************
; 示例2 - 测试单值属性
; *****************************************************************************
$aResult = _AD_GetObjectAttribute(@UserName, "mail")
msgbox(64, "Active Directory Functions", _
		"String returned for User'" & @UserName & "', Attribute 'mail':" & $aResult)

; 关闭Active Directory连接
_AD_Close()

