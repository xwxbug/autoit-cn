
#include  <GuiConstantsEx.au3>
#include  <NetShare.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $sServer, $aInfo

	; 创建界面
	$hGUI = GUICreate("NetShare", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 获取服务器及共享信息
	$sServer = InputBox("NetWork Demo", "Enter Server Name:", "\\MyServer", "", 200, 130)
	If @error Then Exit

	; 获取会话信息
	$aInfo = _Net_Share_SessionGetInfo($sServer, @ComputerName, "Administrator")
	MemoWrite("Error ..........:" & @error)
	MemoWrite("Computer name ..:" & $aInfo[0])
	MemoWrite("User name ......:" & $aInfo[1])
	MemoWrite("Resources open .:" & $aInfo[2])
	MemoWrite("Seconds active .:" & $aInfo[3])
	MemoWrite("Seconds idle ...:" & $aInfo[4])
	MemoWrite("Connection type :" & $aInfo[5])
	MemoWrite("Client type ....:" & $aInfo[6])

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

