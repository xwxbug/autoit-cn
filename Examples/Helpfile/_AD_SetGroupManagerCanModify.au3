#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 设置组管理器以修改成员列表
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 连接到Active Directory
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions - Example 1", "This script sets the Group manager to be able to modify the member list." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入组名称
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions - Example 1", 714, 124)
GUICtrlCreateLabel("Group (samAccountName or FQDN):", 8, 10, 231, 17)
Global $IGroup = GUICtrlCreateInput("", 241, 8, 459, 21)
Global $BOK = GUICtrlCreateButton("Set Group Manager", 8, 82, 121, 33)
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
			ExitLoop
	EndSwitch
WEnd

; 修改组管理器
Global $iValue = _AD_SetGroupManagerCanModify($sGroup)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions - Example 1", "Successfuly modified the group manager for'" & $sGroup & "'")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions - Example 1", "Group'" & $sGroup & "'does not exist")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions - Example 1", "Group manager can already modify the member list for group'" & $sGroup & "'")
ElseIf @error = 3 Then
	msgbox(64, "Active Directory Functions - Example 1", "Group'" & $sGroup & "'does not have an assigned manager to modify")
Else
	msgbox(64, "Active Directory Functions - Example 1", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

