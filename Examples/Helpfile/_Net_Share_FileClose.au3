
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

	; 枚举服务器上打开的文件
	$aInfo = _Net_Share_FileEnum($sServer)
	MemoWrite("Error ...................:" & @error)
	MemoWrite("Entries read ............:" & $aInfo[0][0])

	; 强制关闭所有以"Test.txt"命名的文件
	For $iI = 1 To $aInfo[0][0]
		If StringInStr($aInfo[$iI][3], "Test.txt") > 0 Then
			_Net_Share_FileClose($sServer, $aInfo[$iI][0])
			MemoWrite("Closed file")
		EndIf
	Next

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

