
#include  <GuiConstantsEx.au3>
#include  <GuiStatusBar.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_SB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

Global $iMemo

_Main()

Func _Main()

	Local $hGUI, $aInfo, $hStatus
	Local $aParts[3] = [75, 150, -1]

	; 创建界面
	$hGUI = GUICreate( "StatusBar Get
	Borders" ,  400 ,  300 )

	$hStatus = _GUICtrlStatusBar_Create($hGUI)
	_GUICtrlStatusBar_SetParts($hStatus, $aParts)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 274, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	;
	获取边界尺寸
	$aInfo = _GUICtrlStatusBar_GetBorders($hStatus)
	MemoWrite("Horizontal border width .:" & $aInfo[0])
	MemoWrite("Vertical border width ...:" & $aInfo[1])
	MemoWrite("Width between rectangles :" & $aInfo[2])

	;
	循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite


