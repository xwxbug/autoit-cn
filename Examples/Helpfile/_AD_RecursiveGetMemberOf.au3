#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 返回当前登录用户为其成员的组的递归搜索列表.
; 对于被继承的组, 返回组或用户的FQDN及继承组的FQDN, 用'|'分隔
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 返回当前登录用户为其成员的组的递归搜索列表
Global $aUser = _AD_RecursiveGetMemberOf(@UserName, 10, 1)
If @error > 0 Then
	msgbox(64, "Active Directory Functions - Example 1", "User'" & @UserName & "'has not been assigned to any group")
Else
	; 对于被继承的组, 返回组或用户的FQDN及继承组的FQDN, 用'|'分隔
	_ArrayDisplay($aUser, "Active Directory Functions - Example 1 - Group names user'" & @UserName & "'is a member of")
EndIf

; 关闭Active Directory连接
_AD_Close()

