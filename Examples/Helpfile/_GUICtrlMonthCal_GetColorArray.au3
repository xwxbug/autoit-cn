
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiMonthCal.au3>
#include  <EditConstants.au3>
#include  <WindowsConstants.au3>
#include  <Constants.au3>

Opt('MustDeclareVars', 1)

$Debug_MC = False ; 检查传递给MonthCal函数的类名,
设置为真并使用另一控件的句柄观察其工作

Global $iMemo

_Main()

Func _Main()
	Local $hMonthCal

	; 创建界面
	GUICreate( "Month Calendar
	Get Color Array" ,  425 ,  300 )
	$hMonthCal = GUICtrlCreateMonthCal("", 4, 4, -1, -1, $WS_BORDER, 0x00000000)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 4, 168, 417, 128, BitOR($WS_VSCROLL, $ES_MULTILINE))

	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")

	GUICtrlSendMsg($iMemo, $EM_SETREADONLY, True, 0)

	GUICtrlSetBkColor($iMemo, 0xFFFFFF)
	GUISetState()

	_GUICtrlMonthCal_SetColor($hMonthCal, $MCSC_MONTHBK, $CLR_MONEYGREEN)

	; 获取/设置月历颜色
	MemoWrite( _FormatOutPut( "Background
	color displayed between months:" ,  _GUICtrlMonthCal_GetColorArray ( $hMonthCal ,  $MCSC_BACKGROUND )))
	MemoWrite( _FormatOutPut(@CRLF & "Background color displayed within the
	month:" ,  _GUICtrlMonthCal_GetColorArray ( $hMonthCal ,  $MCSC_MONTHBK )))

	MemoWrite( _FormatOutPut(@CRLF & "Color used to display text within a
	month:" ,  _GUICtrlMonthCal_GetColorArray ( $hMonthCal ,  $MCSC_TEXT )))

	MemoWrite( _FormatOutPut(@CRLF & "Background color displayed in the calendar's
	title:" ,  _GUICtrlMonthCal_GetColorArray ( $hMonthCal ,  $MCSC_TITLEBK )))

	MemoWrite( _FormatOutPut(@CRLF & "Color used to display text within the
	calendar's title:" ,  _GUICtrlMonthCal_GetColorArray ( $hMonthCal ,  $MCSC_TITLETEXT )))
	MemoWrite( _FormatOutPut(@CRLF & "Color used to display header day and trailing
	day text:" ,  _GUICtrlMonthCal_GetColorArray ( $hMonthCal ,  $MCSC_TRAILINGTEXT )))

	; 循环至用户退出
	Do

	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

Func _FormatOutPut($sText, $aColors)
	Return $sText & _
			@CRLF & @TAB & "COLORREF rgbcolor:" & @TAB & $aColors[1] & _
			
	@CRLF & @TAB & "Hex BGR color:" & @TAB & @TAB & $aColors[2] & _
			@CRLF & @TAB & "Hex RGB color:" & @TAB & @TAB & $aColors[3]
endfunc   ;==>_FormatOutPut

;
向memo控件写入信息
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

