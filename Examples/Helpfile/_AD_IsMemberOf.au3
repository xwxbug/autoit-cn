#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取当前用户为其成员的组名称列表. 检查当前用户所在的首个组的组成员. 将总是返回1.
; *****************************************************************************
#include  <AD.au3>

Global $aUser, $sFQDN_Group, $sFQDN_User, $iResult

; 打开Active Directory连接
_AD_Open()

; 获取当前用户的FQDN
$sFQDN_User = _AD_SamAccountNameToFQDN()

; 获取当前用户为其成员的组名称数组(FQDN)
$aUser = _AD_GetUserGroups(@UserName)
$sFQDN_Group = $aUser[1]

; 检查指定用户的所在组的指定组成员
$iResult = _AD_IsMemberOf($sFQDN_Group, $sFQDN_User)
Select
	Case $iResult = 1
		msgbox(64, "Active Directory Functions", _
				"User:" & $sFQDN_User & @CRLF & _
				"Group:" & $sFQDN_Group & @CRLF & _
				"User is a member of the specified group!")
	Case($iResult = 0 And @error = 1)
		msgbox(64, "Active Directory Functions", _
				"User:" & $sFQDN_User & @CRLF & _
				"Group:" & $sFQDN_Group & @CRLF & _
				"Group does not exist!")
	Case($iResult = 0 And @error = 2)
		msgbox(64, "Active Directory Functions", _
				"User:" & $sFQDN_User & @CRLF & _
				"Group:" & $sFQDN_Group & @CRLF & _
				"User does not exist!")
	Case($iResult = 0)
		msgbox(64, "Active Directory Functions", _
				"User:" & $sFQDN_User & @CRLF & _
				"Group:" & $sFQDN_Group & @CRLF & _
				"User is a not member of the specified group!")
EndSelect

; 关闭Active Directory连接
_AD_Close()

