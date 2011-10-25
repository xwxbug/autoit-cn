#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

Global $aDisabled[1]
; *****************************************************************************
; 示例1 - 获取过期用户账户的列表
; *****************************************************************************
$aDisabled = _AD_GetAccountsExpired()
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "No expired user accounts could be found")
Else
	_ArrayDisplay($aDisabled, "Active Directory Functions - Expired User Accounts")
EndIf

; *****************************************************************************
; 示例2 - 获取本年底过期用户账户的列表
; *****************************************************************************
$aDisabled = _AD_GetAccountsExpired("user", @YEAR & "/12/31")
If @error = 0 Then
	_ArrayDisplay($aDisabled, "Active Directory Functions - Expired User Accounts")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "No expired user accounts could be found")
Else
	msgbox(64, "Active Directory Functions", "Invalid parameters provided")
EndIf

; *****************************************************************************
; 示例3 - 获取本年1月到10月过期用户账户的列表
; *****************************************************************************
$aDisabled = _AD_GetAccountsExpired("user", @YEAR & "/10/31", @YEAR & "/01/01")
If @error = 0 Then
	_ArrayDisplay($aDisabled, "Active Directory Functions - Expired User Accounts")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "No expired user accounts could be found")
Else
	msgbox(64, "Active Directory Functions", "Invalid parameters provided")
EndIf

; *****************************************************************************
; 示例4 - 获取过期计算机帐户的列表
; *****************************************************************************
$aDisabled = _AD_GetAccountsExpired("computer")
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "No expired computer accounts could be found")
Else
	_ArrayDisplay($aDisabled, "Active Directory Functions - Expired computer Accounts")
EndIf

; 关闭Active Directory连接
_AD_Close()

