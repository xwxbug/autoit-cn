#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 删除用户邮箱
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 打开Active Directory连接
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script deletes the mailbox of a user." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入必须的数据
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions", 514, 124)
GUICtrlCreateLabel("User account (FQDN or samAccountName):", 8, 10, 231, 17)
Global $lUser = GUICtrlCreateInput(@UserName, 241, 8, 259, 21)
Global $BOK = GUICtrlCreateButton("Delete mailbox", 8, 72, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 428, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sUser = GUICtrlRead($lUser)
			ExitLoop
	EndSwitch
WEnd

; 删除邮箱
Global $iValue = _AD_DeleteMailbox($sUser)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "Mailbox for User'" & $sUser & "'successfully created")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'does not exist")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'doesn't have a mailbox")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

