#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

Global $aDisabled[1]
; *****************************************************************************
; 示例1 - 显示当前被禁用的用户的列表
; *****************************************************************************
$aDisabled = _AD_GetObjectsDisabled()
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "No disabled user accounts could be found")
Else
	_ArrayDisplay($aDisabled, "Active Directory Functions - Disabled User Accounts")
EndIf

; *****************************************************************************
; 示例2 - 获取禁用的计算机的列表
; *****************************************************************************
$aDisabled = _AD_GetObjectsDisabled("computer")
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "No disabled computers could be found")
Else
	_ArrayDisplay($aDisabled, "Active Directory Functions - Disabled Computers")
EndIf

; 关闭Active Directory连接
_AD_Close()

