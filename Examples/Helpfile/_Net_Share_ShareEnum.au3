
#include  <GuiConstantsEx.au3>
#include  <NetShare.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $iI, $aInfo
	Local Const $sShareName = "AutoIt Share"

	; 创建界面
	$hGUI = GUICreate("NetShare", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 查看是否存在共享
	If _Net_Share_ShareCheck(@ComputerName, $sShareName) = -1 Then
		; 创建本地机上的共享
		_Net_Share_ShareAdd(@ComputerName, $sShareName, 0, "C:\", "AutoIt Share Comment")
		If @error Then MsgBox(4096, "Information", "Share add error :" & @error)
		MemoWrite("Share added")
	Else
		MemoWrite("Share exists")
	EndIf

	; 显示有关本地共享的所有信息
	$aInfo = _Net_Share_ShareEnum(@ComputerName)
	MemoWrite("Entries read ............:" & $aInfo[0][0])
	For $iI = 1 To $aInfo[0][0]
		MemoWrite("Share name ..............:" & $aInfo[$iI][0])
		MemoWrite("Share type...............:" & _Net_Share_ResourceStr($aInfo[$iI][1]))
		MemoWrite("Comment .................:" & $aInfo[$iI][2])
		MemoWrite("Permissions .............:" & _Net_Share_PermStr($aInfo[$iI][3]))
		MemoWrite("Maximum connections .....:" & $aInfo[$iI][4])
		MemoWrite("Current connections .....:" & $aInfo[$iI][5])
		MemoWrite("Local path ..............:" & $aInfo[$iI][6])
		MemoWrite("Password ................:" & $aInfo[$iI][7])
		MemoWrite()
	Next

	; 删除共享
	_Net_Share_ShareDel(@ComputerName, $sShareName)
	If @error Then MsgBox(4096, "Information", "Share delete error :" & @error)
	MemoWrite("Share deleted")

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

