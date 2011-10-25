
#include  <GuiReBar.au3>
#include  <GuiComboBox.au3>
#include  <GuiDateTimePicker.au3>
#include  <WindowsConstants.au3>
#include  <Constants.au3>
#include  <GuiConstantsEx.au3>

Opt("MustDeclareVars", 1)

$Debug_RB = False

_Main()

Func _Main()
	Local $hgui, $btnExit, $hCombo, $hReBar, $hDTP, $hInput

	$hgui = GUICreate("Rebar", 400, 396, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_MAXIMIZEBOX))

	; 创建伸缩条控件
	$hReBar = _GUICtrlReBar_Create($hgui, BitOR($CCS_TOP, $WS_BORDER, $RBS_VARHEIGHT, $RBS_AUTOSIZE, $RBS_BANDBORDERS))

	; 在伸缩条上创建一个组合框
	$hCombo = _GUICtrlComboBox_Create($hgui, "", 0, 0, 120)


	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($hCombo)

	;
	在伸缩条上创建一个时间日期拾取器
	$hDTP = _GUICtrlDTP_Create($hgui, 0, 0, 190)


	;
	在伸缩条上创建一个时间输入框
	$hInput = GUICtrlCreateInput("Input control", 0, 0, 120, 20)

	;
	添加控件的区段
	_GUICtrlReBar_AddBand($hReBar, $hCombo, 120, 200, "Dir *.exe")


	; 添加且强制第二行
	_GUICtrlReBar_AddBand($hReBar, $hDTP, 120)
	_GUICtrlRebar_SetBandStyleBreak($hReBar, 1)

	; 添加到伸缩条开始位置
	_GUICtrlReBar_AddBand($hReBar, GUICtrlGetHandle($hInput), 120, 200, "Name:", 0)

	$btnExit = GUICtrlCreateButton("Exit", 150, 360, 100, 25)
	GUISetState(@SW_SHOW)


	While 1
		Switch GUIGetMsg()

			Case $GUI_EVENT_CLOSE, $btnExit
				Exit
		EndSwitch
	WEnd
endfunc   ;==>_Main

