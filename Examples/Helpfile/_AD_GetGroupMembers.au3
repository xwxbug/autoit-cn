#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取当前用户为其成员的所有组的列表. 然后获取该数组首个组的所有组成员排序后的列表.
; *****************************************************************************
#include  <AD.au3>

Global $aGroups[1], $aMembers[1]

; 打开Active Directory连接
_AD_Open()

; 获取用户将成为其成员的组的组名(FQDN)数组, 元素0为组数量.
$aGroups = _AD_GetUserGroups()
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "The current user is not a member of any group")
Else
	; 获取当前登录的用户做为其成员的首个组的排序后的成员列表
	$aMembers = _AD_GetGroupMembers($aGroups[1])
	If @error > 0 Then
		msgbox(64, "Active Directory Functions", "The group'" & $aGroups[1] & "'has no members")
	Else
		_ArraySort($aMembers, 0, 1)
		_ArrayDisplay($aMembers, "Active Directory Functions - List of members for group'" & $aGroups[1] & "'")
	EndIf
EndIf

; 关闭Active Directory连接
_AD_Close()

