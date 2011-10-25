#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 设置用户密码是否过期
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
;#include <EditConstants.au3>
#include  <WindowsConstants.au3>

; 连接到Active Directory
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script sets the password for a user you specify as expired or not expired." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

#region ### START Koda GUI section ### Form=
Global $Form = GUICreate("Active Directory Functions", 515, 162, 251, 112)
GUICtrlCreateLabel("UserId", 8, 12, 39, 21)
Global $IUserId = GUICtrlCreateInput(@UserName, 241, 8, 259, 21)
GUICtrlCreateLabel("Set password expired:", 8, 44, 131, 21)
Global $IRadio1 = GUICtrlCreateRadio("", 241, 40, 17, 21)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel("Set password not expired:", 8, 76, 131, 21)
Global $IRadio2 = GUICtrlCreateRadio("", 241, 72, 17, 21)
Global $BOK = GUICtrlCreateButton("Set Password Expiration", 8, 118, 130, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 428, 118, 73, 33)
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

Global $iFunction = 0
While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $SUserId = GUICtrlRead($IUserId)
			If GUICtrlRead($IRadio1) = $GUI_CHECKED Then $iFunction = 0
			If GUICtrlRead($IRadio2) = $GUI_CHECKED Then $iFunction = -1
			ExitLoop
	EndSwitch
WEnd

; 改变密码到期时间
Global $iValue = _AD_SetPasswordExpire($SUserId, $iFunction)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "User'" & $SUserId & "'successfully changed")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "User'" & $SUserId & "'does not exist")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

