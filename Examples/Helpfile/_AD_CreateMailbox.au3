#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 为用户创建邮箱
; *****************************************************************************
#include  <AD.au3>
#include  <ButtonConstants.au3>
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>

; 打开Active Directory连接
_AD_Open()

Global $iReply = msgbox(308, "Active Directory Functions", "This script creates a mailbox for a user." & @CRLF & @CRLF & _
		"Are you sure you want to change the Active Directory?")
If $iReply <> 6 Then Exit

Global $sUser, $sMailbox, $sIStore, $sServer, $sGroup, $sServerGroup
; 获取当前用户的表单数据
Global $sHomeMDB = _AD_GetObjectAttribute(@UserName, "HomeMDB")
If @error = 0 Then
	Global $aTemp = StringSplit($sHomeMDB, ",")
	$sMailbox = StringMid($aTemp[1], 4)
	$sIStore = StringMid($aTemp[2], 4)
	$sServer = StringMid($aTemp[4], 4)
	$sGroup = StringMid($aTemp[6], 4)
	$sServerGroup = StringMid($aTemp[8], 4)
EndIf
; 输入必须的数据
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Active Directory Functions", 514, 252)
GUICtrlCreateLabel("User account (FQDN or samAccountName):", 8, 10, 231, 17)
GUICtrlCreateLabel("Mailbox storename:", 8, 42, 231, 17)
GUICtrlCreateLabel("Information store:", 8, 74, 231, 17)
GUICtrlCreateLabel("EMail server:", 8, 106, 231, 17)
GUICtrlCreateLabel("Administrative group in Exchange:", 8, 138, 231, 17)
GUICtrlCreateLabel("Exchange Server Group:", 8, 170, 231, 17)
Global $lUser = GUICtrlCreateInput(@UserName, 241, 8, 259, 21)
Global $IMailbox = GUICtrlCreateInput($sMailbox, 241, 40, 259, 21)
Global $IIStore = GUICtrlCreateInput($sIStore, 241, 72, 259, 21)
Global $IServer = GUICtrlCreateInput($sServer, 241, 104, 259, 21)
Global $IGroup = GUICtrlCreateInput($sGroup, 241, 136, 259, 21)
Global $IServerGroup = GUICtrlCreateInput($sServerGroup, 241, 168, 259, 21)
Global $BOK = GUICtrlCreateButton("Create mailbox", 8, 200, 121, 33)
Global $BCancel = GUICtrlCreateButton("Cancel", 428, 200, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			Exit
		Case $BOK
			$sUser = GUICtrlRead($lUser)
			$sMailbox = GUICtrlRead($IMailbox)
			$sIStore = GUICtrlRead($IIStore)
			$sServer = GUICtrlRead($IServer)
			$sGroup = GUICtrlRead($IGroup)
			$sServerGroup = GUICtrlRead($IServerGroup)
			ExitLoop
	EndSwitch
WEnd

; 创建邮箱
Global $iValue = _AD_CreateMailbox($sUser, $sMailbox, $sIStore, $sServer, $sGroup, $sServerGroup)
If $iValue = 1 Then
	msgbox(64, "Active Directory Functions", "Mailbox for User'" & $sUser & "'successfully created")
ElseIf @error = 1 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'does not exist")
ElseIf @error = 2 Then
	msgbox(64, "Active Directory Functions", "User'" & $sUser & "'already has a mailbox defined")
Else
	msgbox(64, "Active Directory Functions", "Return code'" & @error & "'from Active Directory")
EndIf

; 关闭Active Directory连接
_AD_Close()

