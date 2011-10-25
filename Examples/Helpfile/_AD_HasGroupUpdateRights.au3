#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取当前用户为其成员的组名称列表. 检查当前用户是否具有更新数组中的首个组的权限.
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取当前用户作为成员的组列表
Global $aMemberOf = _AD_GetUserGroups()

; 检查当前用户是否具有更新数组中的组的成员关系的权限
Global $sUser = @UserName
If _AD_HasGroupUpdateRights($aMemberOf[1], $sUser) Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'has update rights on group'" & $aMemberOf[1] & "'")
Else
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'does not have update rights on group'" & $aMemberOf[1] & "'")
EndIf

; 关闭Active Directory连接
_AD_Close()

