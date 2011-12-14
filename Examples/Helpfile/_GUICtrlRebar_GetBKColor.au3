#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <GuiReBar.au3>
#include <GuiToolbar.au3>
#include <WindowsConstants.au3>

$Debug_RB = False

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hReBar, $hToolbar, $iExit, $iInput
	Local Enum $idNew = 1000, $idOpen, $idSave, $idHelp

	$hGUI = GUICreate("Rebar", 400, 396, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_MAXIMIZEBOX))

	; 创建伸缩条控件
	$hReBar = _GUICtrlRebar_Create($hGUI, BitOR($CCS_TOP, $WS_BORDER, $RBS_VARHEIGHT, $RBS_AUTOSIZE, $RBS_BANDBORDERS))

	$iMemo = GUICtrlCreateEdit("", 2, 100, 396, 250, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 10, 400, 0, "Courier New")

	; 在伸缩条中创建一个工具栏
	$hToolbar = _GUICtrlToolbar_Create($hGUI, BitOR($TBSTYLE_FLAT, $CCS_NORESIZE, $CCS_NOPARENTALIGN))

	; 添加标准系统位图
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

	; 在伸缩条中创建一个输入框
	$iInput = GUICtrlCreateInput("Input control", 0, 0, 120, 20)

	;添加包含控件的带区
	_GUICtrlRebar_AddBand($hReBar, GUICtrlGetHandle($iInput), 120, 200, "Name:")

	; 添加包含伸缩条开始处控件的带区
	_GUICtrlRebar_AddToolBarBand($hReBar, $hToolbar, "", 0)

	$iExit = GUICtrlCreateButton("Exit", 150, 360, 100, 25)
	GUICtrlSetState($iExit, $GUI_DEFBUTTON + $GUI_FOCUS)

	GUISetState(@SW_SHOW, $hGUI)

	_GUICtrlRebar_SetBandStyleBreak($hReBar, 1)

	MemoWrite("========== Bar Color ==========")
	MemoWrite("Previous BK Color..: " & _GUICtrlRebar_SetBKColor($hReBar, Int(0x00008B)))
	MemoWrite("BK Color...........: " & _GUICtrlRebar_GetBKColor($hReBar))
	MemoWrite("Previous Text Color: " & _GUICtrlRebar_SetTextColor($hReBar, Int(0xFFFFFF)))
	MemoWrite("Text Color.........: " & _GUICtrlRebar_GetTextColor($hReBar))

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $iExit
				Exit
		EndSwitch
	WEnd
EndFunc   ;==>_Main

; 写入消息到 memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
