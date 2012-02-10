#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 分配组的组管理员("managedby"属性)
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 打开Active Directory连接
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions - Example 1", "This script assigns a group manager to a group." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入分配管理员的组和用户
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions - Example 1", 714, 124)
GUICtrlCreateLabel("Group (samAccountName or FQDN):", 8, 10, 231, 17)
GUICtrlCreateLabel("Manager for this group (samAccountName or FQDN):", 8, 42, 231, 34)
Global $IGroup = GUICtrlCreateInput("", 241, 8, 459, 21)
Global $IUser = GUICtrlCreateInput(@UserName, 241, 40, 459, 21)
Global $BOK = GUICtrlCreateButton("Assign Manager", 8, 82, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 628, 82, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sGroup = GUICtrlRead($IGroup)
			Global $sUser = GUICtrlRead($IUser)
			ExitLoop
	EndSwitch
WEnd

; 分配为组管理员的用户
Global $iValue = _AD_GroupAssignManager($sGroup, $sUser)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'successfuly assigned as manager to group'" & $sGroup & "'")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "Group'" & $sGroup & "'does not exist")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'does not exist")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

