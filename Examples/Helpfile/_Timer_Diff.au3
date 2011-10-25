
#include  <Timers.au3>

_Main()

Func _Main()
	HotKeySet(" {ESC} ", "_Quit")

	Local $starttime = _Timer_Init()
	While 1
		ToolTip( _Timer_Diff($starttime))
	WEnd
endfunc   ;==>_Main

Func _Quit()
	Exit
endfunc   ;==>_Quit

