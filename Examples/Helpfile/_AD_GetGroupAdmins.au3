#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取当前用户作为成员的首个组的管理员列表
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取用户成为成员并排序后的组名数组(FQDN)
Global $aUser
$aUser = _AD_GetUserGroups(@UserName)
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "User'" & @UserName & "'has not been assigned to any group")
	Exit
Else
	_ArraySort($aUser, 0, 1)
EndIf

; 检查当前用户作为成员的所有组并显示首个带有管理员的组
Global $Found = False
Global $iCount, $aAdmins
For $iCount = 1 To $aUser[0]
	$aAdmins = _AD_GetGroupAdmins($aUser[1])
	If @error = 0 Then
		$Found = True
		ExitLoop
	EndIf
Next
If Not $Found Then
	msgbox(64, "Active Directory Functions", "No admins assigned to all groups the current user is a member of")
	Exit
Else
	_ArrayDisplay($aAdmins, "Active Directory Functions - Admins for group'" & $aUser[$iCount] & "'")
EndIf

; 关闭Active Directory连接
_AD_Close()

