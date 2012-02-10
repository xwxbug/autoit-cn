#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

Global $aProperties[1][2]

; *****************************************************************************
; 示例1 - 显示当前用户的属性
; *****************************************************************************
$aProperties = _AD_GetObjectProperties(@UserName)
_ArrayDisplay($aProperties, "Active Directory Functions - Properties for user'" & @UserName & "'")

; *****************************************************************************
; 示例2 - 显示当前计算机的属性
; *****************************************************************************
$aProperties = _AD_GetObjectProperties(@ComputerName & "$")
_ArrayDisplay($aProperties, "Active Directory Functions - Properties for computer'" & @ComputerName & "'")

; *****************************************************************************
; 示例3 - 获取用户将成为其成员的组名称的数组并显示首个组的属性
; *****************************************************************************
Global $aUser
$aUser = _AD_GetUserGroups(@UserName)
If $aUser[0] = 0 Then
	msgbox(64, "Active Directory Functions - Example 3", "User'" & @UserName & "'is not a member of any group")
Else
	Global $sGroup = _AD_FQDNToSamAccountName($aUser[1])
	$aProperties = _AD_GetObjectProperties($sGroup)
	_ArrayDisplay($aProperties, "Active Directory Functions - Properties for group'" & $sGroup & "'")
EndIf

; *****************************************************************************
; 示例4 - 显示从被指派给示例3的组的OU的属性
; *****************************************************************************
Global $sOU = StringTrimLeft($aUser[1], StringInStr($aUser[1], ","))
$aProperties = _AD_GetObjectProperties($sOU)
_ArrayDisplay($aProperties, "Active Directory Functions - Properties for OU'" & $sOU & "'")

; 关闭Active Directory连接
_AD_Close()

