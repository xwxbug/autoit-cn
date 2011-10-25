
#include  <SendMessage.au3>

_Main()

Func _Main()
	Local Const $Off = 2, $On = -1

	Opt("WinTitleMatchMode", 4)
	$hwnd = WinGetHandle('classname=Progman')
	_ToggleMonitor($hwnd, $Off)
	Sleep(3000)
	_ToggleMonitor($hwnd, $On)
endfunc   ;==>_Main

Func _ToggleMonitor($hwnd, $OnOff)
	Local Const $WM_SYSCOMMAND = 274
	Local Const $SC_MONITORPOWER = 61808
	_SendMessage($hwnd, $WM_SYSCOMMAND, $SC_MONITORPOWER, $OnOff)
	If @error Then
		MsgBox(0, "_ToggleMonitor", "_SendMessage Error:" & @error)
		Exit
	EndIf
endfunc   ;==>_ToggleMonitor

