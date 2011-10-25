; *****************************************************************************
; 复制AD对象到另一个OU
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 打开Active Directory连接
_AD_Open()

$iReply = msgbox(308, "Active Directory Functions", "This script copies an object to another OU." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

; 输入要复制的对象和目标OU
#region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Active Directory Functions", 814, 124)
GUICtrlCreateLabel("Enter the object to copy (FQDN):", 8, 10, 231, 17)
GUICtrlCreateLabel("Enter the OU where to copy to (FQDN):", 8, 42, 231, 17)
$IObject = GUICtrlCreateInput( _AD_SamAccountNameToFQDN(@UserName), 241, 8, 559, 21)
$ITargetOU = GUICtrlCreateInput("", 241, 40, 559, 21)
$BOK = GUICtrlCreateButton("Copy object", 8, 72, 130, 33)
$BCancel = GUICtrlCreateButton("Cancel", 728, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			$sObject = GUICtrlRead($IObject)
			$sTargetOU = GUICtrlRead($ITargetOU)
			ExitLoop
	EndSwitch
WEnd

; 移动对象
$iValue = _AD_CopyObject($sTargetOU, $sObject)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "Object'" & $sObject & "'successfully copied to'" & $sTargetOU & "'")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "Target OU'" & $sTargetOU & "'does not exist")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions", "Object'" & $sObject & "'does not exist")
ElseIf @error = 3 Then
	msgbox(64, "Active Directory Functions", "Target OU and new Display Name are empty. At least one of this values has to be set")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

