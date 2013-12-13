Example()

Func Example()
	Local $iOldOpt, $n1, $n2, $a, $b
	$iOldOpt = Opt("GUICoordMode", 1)

	GUICreate("My GUI icon Race", 350, 74, -1, -1)
	GUICtrlCreateLabel("", 331, 0, 1, 74, 5)
	$n1 = GUICtrlCreateIcon(@ScriptDir & '\Extras\dinosaur.ani', -1, 0, 0, 32, 32)
	$n2 = GUICtrlCreateIcon(@ScriptDir & '\Extras\horse.ani', -1, 0, 40, 32, 32)

	GUISetState(@SW_SHOW)

	$a = 0
	$b = 0
	While ($a < 300) And ($b < 300)
		$a = $a + Int(Random(0, 1) + 0.5)
		$b = $b + Int(Random(0, 1) + 0.5)
		GUICtrlSetPos($n1, $a, 0)
		GUICtrlSetPos($n2, $b, 40)
		Sleep(20)
	WEnd
	Sleep(1000)
	Opt("GUICoordMode", $iOldOpt)
EndFunc   ;==>Example
