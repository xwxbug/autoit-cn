#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 从指定组移除用户
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 连接到Active Directory
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script removes a user from a group." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入用户帐户和组
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions", 514, 124)
GUICtrlCreateLabel("User account (sAMAccountName or FQDN):", 8, 10, 231, 17)
GUICtrlCreateLabel("Group name (sAMAccountName or FQDN):", 8, 42, 231, 17)
Global $IUser = GUICtrlCreateInput(@UserName, 241, 8, 259, 21)
Global $IGroup = GUICtrlCreateInput("", 241, 40, 259, 21)
Global $BOK = GUICtrlCreateButton("Remove user from group", 8, 72, 130, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 428, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sUser = _AD_SamAccountNameToFQDN( GUICtrlRead($IUser))
			Global $sGroup = _AD_SamAccountNameToFQDN( GUICtrlRead($IGroup))
			ExitLoop
	EndSwitch
WEnd

; 从组中移除用户
Global $iValue = _AD_RemoveUserFromGroup($sGroup, $sUser)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'successfully removed from group'" & $sGroup & "'")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "Group'" & $sGroup & "'does not exist")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'does not exist")
ElseIf @error = 3 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'is not a member of group'" & $sGroup & "'")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

