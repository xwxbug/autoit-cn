#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 启用AD对象(用户帐户, 计算机帐户).
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 打开Active Directory连接
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script enables the specified object (user account, computer account)." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入要启用的对象
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions", 714, 124)
GUICtrlCreateLabel("Object to enable (FQDN or SAMAccountName):", 8, 10, 231, 17)
Global $IObject = GUICtrlCreateInput("", 241, 10, 459, 21)
Global $BOK = GUICtrlCreateButton("Enable object", 8, 72, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 628, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sObject = GUICtrlRead($IObject)
			ExitLoop
	EndSwitch
WEnd

; 改变对象
Global $iValue = _AD_EnableObject($sObject)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "Object'" & $sObject & "'successfully changed")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "Object'" & $sObject & "'does not exist")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

