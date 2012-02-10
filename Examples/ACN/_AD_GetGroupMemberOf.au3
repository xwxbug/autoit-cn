#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 返回组的组成员列表(FQDN)
; *****************************************************************************
#include  <AD.au3>

Global $aGroups, $aMemberOf[1]

; 打开Active Directory连接
_AD_Open()

; 获取用户将成为其成员的组的组名(FQDN)数组, 元素0为组数量.
$aGroups = _AD_GetUserGroups()

; 获取当前登录用户为其成员的首个组的排序后的成员列表
$aMemberOf = _AD_GetGroupMemberOf($aGroups[1])
_ArraySort($aMemberOf, 0, 1)
_arraydisplay($aMemberOf, "Active Directory Functions - Membership for group'" & $aGroups[1] & "'")

; 关闭Active Directory连接
_AD_Close()

