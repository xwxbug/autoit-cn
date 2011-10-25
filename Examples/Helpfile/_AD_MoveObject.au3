#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 将AD对象移动到另一OU
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 连接到Active Directory
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script moves an object to another OU." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入要移动的对象和目标OU
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions", 814, 124)
GUICtrlCreateLabel("Object to move (FQDN or sAMAccountName):", 8, 10, 231, 17)
GUICtrlCreateLabel("OU where to move to (FQDN):", 8, 42, 231, 17)
Global $IObject = GUICtrlCreateInput( _AD_SamAccountNameToFQDN(@UserName), 241, 8, 559, 21)
Global $ITargetOU = GUICtrlCreateInput("", 241, 40, 559, 21)
Global $BOK = GUICtrlCreateButton("Move object", 8, 72, 130, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 728, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sObject = GUICtrlRead($IObject)
			Global $sTargetOU = GUICtrlRead($ITargetOU)
			ExitLoop
	EndSwitch
WEnd

; 移动对象
Global $iValue = _AD_MoveObject($sTargetOU, $sObject)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "Object'" & $sObject & "'successfully moved to'" & $sTargetOU & "'")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "Target OU'" & $sTargetOU & "'does not exist")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions", "Object'" & $sObject & "'does not exist")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

