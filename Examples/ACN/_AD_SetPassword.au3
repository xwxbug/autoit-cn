#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 查询SAMACccountName及密码并尝试改变密码
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 连接到Active Directory
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions - Example 1", "This script sets the password for a user you specify." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入用户及要修改的密码
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions - Example 1", 414, 124, 251, 112)
GUICtrlCreateLabel("User account (sAMAccountName or FQDN):", 8, 10, 231, 17)
GUICtrlCreateLabel("New password:", 8, 42, 121, 17)
Global $IUser = GUICtrlCreateInput("", 241, 8, 159, 21)
Global $IPassword = GUICtrlCreateInput("", 241, 40, 159, 21)
Global $BOK = GUICtrlCreateButton("Change Password", 8, 72, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 328, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sUser = GUICtrlRead($IUser)
			$sUser = _AD_SamAccountNameToFQDN($sUser)
			Global $sPassword = GUICtrlRead($IPassword)
			ExitLoop
	EndSwitch
WEnd

; 设置密码
Global $iValue = _AD_SetPassword($sUser, $sPassword)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions - Example 1", "Password for user'" & $sUser & "'successfully changed")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions - Example 1", "User'" & $sUser & "'does not exist")
Else
	msgbox(64, "Active Directory Functions - Example 1", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

