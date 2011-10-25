#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 启用邮件组
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 连接到Active Directory
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script mail enables an AD group." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入要改变的组
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions", 714, 124)
GUICtrlCreateLabel("Group to change (FQDN or sAMAccountName):", 8, 10, 231, 17)
Global $IGroup = GUICtrlCreateInput("", 241, 10, 459, 21)
Global $BOK = GUICtrlCreateButton("Mail enable Group", 8, 72, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 628, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
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

; 改变组
Global $iValue = _AD_MailEnableGroup($sGroup)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "Group'" & $sGroup & "'successfully changed")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "Group'" & $sGroup & "'does not exist")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

