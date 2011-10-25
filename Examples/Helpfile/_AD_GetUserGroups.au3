#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取用户将成为其成员的组名(FQDN)的排序数组
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取用户将成为其成员的组名(FQDN)的排序数组
Global $aUser = _AD_GetUserGroups(@UserName)
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "User'" & @UserName & "'has not been assigned to any group")
Else
	_ArraySort($aUser, 0, 1)
	_ArrayDisplay($aUser, "Active Directory Functions - Group names user'" & @UserName & "'is immediately a member of")
EndIf

; 关闭Active Directory连接
_AD_Close()

