#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 将计算机连接到域 - 必须以高级的_AD_CreateComputer建立计算机帐户.
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 打开Active Directory连接
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script joins a computer to the domain." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入要连接的计算机
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions", 714, 156)
GUICtrlCreateLabel("Computer to join (NetBIOSName):", 8, 10, 231, 17)
Global $IComputer = GUICtrlCreateInput("", 241, 8, 459, 21)
Global $BOK = GUICtrlCreateButton("Join Computer", 8, 114, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 628, 114, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sComputer = GUICtrlRead($IComputer)
			ExitLoop
	EndSwitch
WEnd

; 将计算机连接到域
Global $iValue = _AD_JoinDomain($sComputer)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "Computer'" & $sComputer & "'successfully joined. Please reboot the computer")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "Computer account for'" & $sComputer & "'does not exist in the domain")
ElseIf @error = 3 Then
	msgbox(64, "Active Directory Functions", "WMI object could not be created. @extended=" & @extended)
ElseIf @error = 4 Then
	msgbox(64, "Active Directory Functions", "Computer'" & $sComputer & "'is already a member of the domain")
ElseIf @error = 5 Then
	msgbox(64, "Active Directory Functions", "Joining computer'" & $sComputer & "'to the domain was not successful. @extended=" & @extended)
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

