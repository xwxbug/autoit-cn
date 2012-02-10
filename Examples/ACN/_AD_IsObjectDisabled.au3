#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; *****************************************************************************
; 示例1 - 检查当前用户的账户是否禁用
; *****************************************************************************
If _AD_IsObjectDisabled() Then
	msgbox(64, "Active Directory Functions", "User account'" & @UserName & "'is disabled")
Else
	msgbox(64, "Active Directory Functions", "User account'" & @UserName & "'is not disabled")
EndIf

; *****************************************************************************
; 示例2 - 获取禁用账户的列表并检查首个值
; *****************************************************************************
Global $aDisabled = _AD_GetObjectsDisabled()

If $aDisabled[0] > 0 Then
	Global $sUser = _AD_FQDNToSamAccountName($aDisabled[1])
	If _AD_IsObjectDisabled($sUser) Then
		msgbox(64, "Active Directory Functions", "User account'" & $sUser & "'is disabled")
	Else
		msgbox(64, "Active Directory Functions", "User account'" & $sUser & "'is not disabled")
	EndIf
Else
	msgbox(64, "Active Directory Functions", "No disabled users accounts found")
EndIf

; 关闭Active Directory连接
_AD_Close()

