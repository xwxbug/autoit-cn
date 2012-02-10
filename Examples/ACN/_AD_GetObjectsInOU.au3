#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取当前登录用户的FQDN
Global $sFQDN = _AD_SamAccountNameToFQDN()

; 清除CN
Global $iPos = StringInStr($sFQDN, ",")
Global $sOU = StringMid($sFQDN, $iPos + 1)

Global $aObjects[1][1]

; *****************************************************************************
; 示例1 - 获取当前被指派给用户的OU. 然后获取此OU中未经过滤的所有对象的列表
; *****************************************************************************
$aObjects = _AD_GetObjectsInOU($sOU, "(name=*)", 2, "sAMAccountName,distinguishedName,displayname")
If @error > 0 Then
	MsgBox(64, "Active Directory Functions - Example 1", "No OUs could be found")
Else
	_ArrayDisplay($aObjects, "Active Directory Functions - Objects in OU'" & $sOU & "'")
EndIf

; *****************************************************************************
; 示例2 - 获取当前被指派给用户的OU. 获取此OU中的所有用户的经过过滤后以当前用户的首字母开始的列表. 按显示名称排序.
; *****************************************************************************
Global $sUser = StringLeft(@UserName, 1)
$aObjects = _AD_GetObjectsInOU($sOU, "(&(objectcategory=person)(objectclass=user)(cn=" & $sUser & "*))", 2, "sAMAccountName,distinguishedName,displayname", "displayname")
If @error > 0 Then
	MsgBox(64, "Active Directory Functions - Example 2", "No OUs could be found")
Else
	_ArrayDisplay($aObjects, "Active Directory Functions - Objects in OU'" & $sOU & "'")
EndIf

; *****************************************************************************
; 示例3 - 使用ANR(Ambigous名称解析)搜索整个域获取相同给定名称的所有对象作为当前用户的ANR支持的属性字段
; *****************************************************************************
Global $sGivenName = _AD_GetObjectAttribute(@UserName, "GivenName")
$aObjects = _AD_GetObjectsInOU("", "(ANR=" & $sGivenName & ")", 2, "sAMAccountName,distinguishedName,displayname", "displayname")
If @error > 0 Then
	MsgBox(64, "Active Directory Functions", "No objects found")
Else
	_ArrayDisplay($aObjects, "Active Directory Functions - Ambigous Name Resolution. Search for'" & $sGivenName & "'")
EndIf

If MsgBox(36, "Active Directory Functions", "Would you like to see further examples using extended LDAP queries?") <> 7 Then
	$sOU = ""
	; ********************************
	; 未过期用户帐户
	; ********************************
	_Examples("(&(objectCategory=person)(objectClass=user)(|(accountExpires=9223372036854775807)(accountExpires=0)))", "sAMAccountName,distinguishedName,displayname", "User accounts that do not expire")
	; *************************************
	; 用户无需密码
	; *************************************
	_Examples("(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))", "sAMAccountName,distinguishedName,displayname", "Users not required to have a password")
	; **********************************************************************************
	; 任意组用户除了被指定为"基本"组的"域用户"
	; **********************************************************************************
	_Examples("(&(objectCategory=person)(objectClass=user)(!primaryGroupID=513))", "sAMAccountName,distinguishedName,displayname", "Users with any group other than 'Domain Users' designated as their 'primary group'")
	; **************************************************************
	; 下次登录时必须修改密码的用户
	; **************************************************************
	_Examples("(&(objectCategory=person)(objectClass=user)(pwdLastSet=0))", "sAMAccountName,distinguishedName,displayname", "Users that must change their password the next time they logon")
	; *********************************
	; 以前从未登录的用户
	; *********************************
	_Examples("(&(&(objectCategory=person)(objectClass=user))(|(lastLogon=0)(!(lastLogon=*))))", "sAMAccountName,distinguishedName,displayname", "Users that never logged on before")
	; **************************
	; 所有组策略列表
	; **************************
	_Examples("(objectClass=groupPolicyContainer)", "displayName,gPCFileSysPath", "List of Group Policies")
EndIf

; 关闭Active Directory连接
_AD_Close()

; **********************************************************
; 执行LDAP查询并以数组显示结果
; **********************************************************
Func _Examples($query, $fields, $description)

	Local $aObjects[1][1]
	$aObjects = _AD_GetObjectsInOU($sOU, $query, 2, $fields)
	If @error <> 0 Then
		MsgBox(64, "Active Directory Functions - Extended Example", "No entries found for LDAP query" & @CRLF & $query & @CRLF & $description & @CRLF & "Error:" & @error)
	Else
		_ArrayDisplay($aObjects, "LDAP query -" & $description & " -" & $query)
	EndIf

endfunc   ;==>_Examples

