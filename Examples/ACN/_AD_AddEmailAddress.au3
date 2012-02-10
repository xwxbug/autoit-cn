#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 将额外的SMTP邮件地址添加到可交换AD账户的'Email Addresses'标签页
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 连接到Active Directory
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script adds a SMTP mail address to an Exchange-enabled user." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入主用户Id, EMailAddress及将此地址设为默认地址的标记
Global $Form1 = GUICreate("Active Directory Functions", 714, 156)
GUICtrlCreateLabel("EMail-enabled userid (samAccountName or FQDN):", 8, 10, 331, 17)
GUICtrlCreateLabel("Address to add:", 8, 42, 231, 17)
GUICtrlCreateLabel("If set makes the new address the default address:", 8, 74, 331, 34)
Global $IUser = GUICtrlCreateInput(@UserName, 341, 8, 359, 21)
Global $IAddress = GUICtrlCreateInput("", 341, 40, 359, 21)
Global $IFlag = GUICtrlCreateCheckbox("", 341, 72, 359, 21)
Global $BOK = GUICtrlCreateButton("Add address", 8, 114, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 628, 114, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			Global $sUser = GUICtrlRead($IUser)
			Global $sAddress = GUICtrlRead($IAddress)
			Global $sFlag = BitAND(GUICtrlRead($IFlag), $GUI_CHECKED)
			ExitLoop
	EndSwitch
WEnd

; 添加新地址
Global $iValue = _AD_AddEmailAddress($sUser, $sAddress, $sFlag)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "Address'" & $sAddress & "'successfully added")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'does not exist")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions", "Could not connec to'" & $sUser & "'")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

