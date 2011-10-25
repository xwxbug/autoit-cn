#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GuiConstantsEx.au3>
#include  <GuiDateTimePicker.au3>

Opt(" MustDeclareVars ", 1)

$Debug_DTP = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

Global $iMemo

_Main()

Func _Main()
	Local $hDTP, $aRange[14] = [True, @YEAR, 1, 1, 21, 45, 32, True, @YEAR, 12, 31, 23, 59, 59]

	; 创建界面
	GUICreate(" DateTimePick Get Month Calendar Font ", 400, 300)
	$hDTP = GUICtrlGetHandle( GUICtrlCreateDate("", 2, 6, 190))
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 设置显示格式
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd , yyyy hh:mm ttt ")

	; 设置日期范围
	_GUICtrlDTP_SetRange($hDTP, $aRange)

	; 显示日期范围
	$aRange = _GUICtrlDTP_GetRange($hDTP)
	MemoWrite(" Minimum date:" & GetDateStr(0))
	MemoWrite(" Maximum date:" & GetDateStr(7))
	MemoWrite(" Minimum time:" & GetTimeStr(4))
	MemoWrite(" Maximum time:" & GetTimeStr(11))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

; 返回日期部分
Func GetDateStr($iOff = 0)
	Return StringFormat(" %02d/%02d/%04d ", $aRange[$iOff + 2], $aRange[$iOff + 3], $aRange[$iOff + 1])
endfunc   ;==>GetDateStr

; 返回时间部分
Func GetTimeStr($iOff = 0)
	Return StringFormat(" %02d:%02d:%02d ", $aRange[$iOff], $aRange[$iOff + 1], $aRange[$iOff + 2])
endfunc   ;==>GetTimeStr

; 向memo控件写入一行
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

