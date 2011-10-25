#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; *****************************************************************************
; 示例1 - 检查当前用户的账户是否被锁定
; *****************************************************************************
If _AD_IsObjectLocked() Then
	msgbox(64, "Active Directory Functions", "User account'" & @UserName & "'is locked")
Else
	msgbox(64, "Active Directory Functions", "User account'" & @UserName & "'is not locked")
EndIf

; *****************************************************************************
; 示例2 - 获取锁定账户的列表并检查首个值
; *****************************************************************************
Global $aLocked = _AD_GetObjectsLocked()

If $aLocked[0] > 0 Then
	Global $sUser = _AD_FQDNToSamAccountName($aLocked[1])
	If _AD_IsObjectLocked($sUser) Then
		msgbox(64, "Active Directory Functions", "User account'" & $sUser & "'is locked")
	Else
		msgbox(64, "Active Directory Functions", "User account'" & $sUser & "'is not locked")
	EndIf
Else
	msgbox(64, "Active Directory Functions", "No locked users accounts found")
EndIf
; 关闭Active Directory连接
_AD_Close()

