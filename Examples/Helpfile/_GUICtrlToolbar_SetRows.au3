
#include  <GuiToolbar.au3>
#include  <GuiConstantsEx.au3>
#include  <WindowsConstants.au3>
#include  <Constants.au3>

Opt('MustDeclareVars', 1)

$Debug_TB = False ; 检查传递给函数的类名,
设置为真并使用另一控件的句柄观察其工作
Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hToolbar
	Local Enum $idNew = 1000, $idOpen, $idSave, $idHelp

	; 创建界面
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	$iMemo = GUICtrlCreateEdit("", 36, 2, 396, 262, $WS_VSCROLL)

	GUICtrlSetFont($iMemo, 10, 400, 0, "Courier New")

	GUISetState()

	;
	添加标准系统位图
	Switch _GUICtrlToolbar_GetBitmapFlags($hToolbar)

		Case 0
			_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_SMALL_COLOR)
		Case 2

			_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)
	EndSwitch

	; 添加按钮
	_GUICtrlToolbar_AddButton($hToolbar, $idNew, $STD_FILENEW)

	_GUICtrlToolbar_AddButton($hToolbar, $idOpen, $STD_FILEOPEN)
	_GUICtrlToolbar_AddButton($hToolbar, $idSave, $STD_FILESAVE)

	_GUICtrlToolbar_AddButtonSep($hToolbar)
	_GUICtrlToolbar_AddButton($hToolbar, $idHelp, $STD_HELP)


	; 创建垂直工具栏
	_GUICtrlToolbar_SetStyle($hToolbar, BitOR($CCS_LEFT, $TBSTYLE_FLAT))

	_GUICtrlToolbar_SetRows($hToolbar, 4)

	; 显示行数
	MemoWrite("Number of rows:" & _GUICtrlToolbar_GetRows($hToolbar))


	; 循环至用户退出
	Do

	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

