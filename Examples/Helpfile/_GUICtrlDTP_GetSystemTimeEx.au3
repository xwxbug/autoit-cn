#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GuiConstantsEx.au3>
#include  <GuiDateTimePicker.au3>

Opt(" MustDeclareVars ", 1)

$Debug_DTP = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

Global $iMemo, $tDate

_Main()

Func _Main()
	Local $hDTP

	; 创建界面
	GUICreate(" DateTimePick System TimeEx ", 400, 300)
	$hDTP = GUICtrlGetHandle( GUICtrlCreateDate("", 2, 6, 190))
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 设置显示格式
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd , yyyy hh:mm ttt ")

	; 设置系统时间
	$tDate = DllStructCreate($tagDTPTIME)
	DllStructSetData($tDate, "Year ", @YEAR)
	DllStructSetData($tDate, "Month ", 8)
	DllStructSetData($tDate, "Day ", 19)
	DllStructSetData($tDate, "Hour ", 21)
	DllStructSetData($tDate, "Minute ", 57)
	DllStructSetData($tDate, "Second ", 34)
	_GUICtrlDTP_SetSystemTimeEx($hDTP, $tDate)

	; 显示系统时间
	$tData = _GUICtrlDTP_GetSystemTimeEx($hDTP)
	MemoWrite(" Current date:" & GetDateStr())
	MemoWrite(" Current time:" & GetTimeStr())

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

; 返回日期部分
Func GetDateStr()
	Return StringFormat(" %02d/%02d/%04d ", DllStructGetData($tDate, "Month "), DllStructGetData($tDate, "Day "), DllStructGetData($tDate, "Year "))
endfunc   ;==>GetDateStr

; 返回时间部分
Func GetTimeStr()
	Return StringFormat(" %02d/%02d/%04d ", DllStructGetData($tDate, "Hour "), DllStructGetData($tDate, "Minute "), DllStructGetData($tDate, "Second "))
endfunc   ;==>GetTimeStr

; 向memo控件写入一行
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

