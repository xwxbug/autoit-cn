#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 在指定父OU中新建并激活用户
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 打开Active Directory连接
_AD_Open()

Global $sFQDN = _AD_SamAccountNameToFQDN()
Global $sParentOU = StringMid($sFQDN, StringInStr($sFQDN, ",OU=") + 1)
Global $iReply = msgbox(308, "Active Directory Functions - Example 1", "This script creates a new user in the specified OU." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入父OU及要创建的用户
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions - Example 1", 714, 124)
GUICtrlCreateLabel("Enter the OU (FQDN):", 8, 10, 231, 17)
GUICtrlCreateLabel("Enter the user to create (samAccountName)", 8, 42, 231, 17)
Global $IOU = GUICtrlCreateInput($sParentOU, 241, 8, 459, 21)
Global $IUser = GUICtrlCreateInput("Test-User", 241, 40, 459, 21)
Global $BOK = GUICtrlCreateButton("Create User", 8, 72, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 628, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sOU = GUICtrlRead($IOU)
			Global $sUser = GUICtrlRead($IUser)
			ExitLoop
	EndSwitch
WEnd

; 新建用户
Global $iValue = _AD_CreateUser($sOU, $sUser, "Doe John")
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions - Example 1", "User'" & $sUser & "'in OU'" & $sOU & "'successfully created")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions - Example 1", "User'" & $sUser & "'already exists")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions - Example 1", "OU'" & $sOU & "'does not exist")
ElseIf @error = 3 Then
	msgbox(64, "Active Directory Functions - Example 1", "Value for CN (e.g. Lastname Firstname) is missing")
ElseIf @error = 4 Then
	msgbox(64, "Active Directory Functions - Example 1", "Value for $sAD_User is missing")
Else
	msgbox(64, "Active Directory Functions - Example 1", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

