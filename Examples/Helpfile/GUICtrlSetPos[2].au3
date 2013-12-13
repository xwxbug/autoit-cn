#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iOldOpt, $icon1, $icon2, $hGUI, $a = 0, $b = 0
	$iOldOpt = Opt("GUICoordMode", 1)

	$hGUI = GUICreate("My GUI icon Race", 350, 74, -1, -1)
	GUICtrlCreateLabel("", 331, 0, 1, 74, 5)
	$icon1 = GUICtrlCreateIcon(@ScriptDir & '\Extras\dinosaur.ani', -1, 0, 0, 32, 32)
	$icon2 = GUICtrlCreateIcon(@ScriptDir & '\Extras\horse.ani', -1, 0, 40, 32, 32)

	GUISetState(@SW_SHOW)

	While ($a < 300) And ($b < 300)
		$a += Random(0, 1, 1)
		$b += Random(0, 1, 1)
		GUICtrlSetPos($icon1, $a, 0)
		GUICtrlSetPos($icon2, $b, 40)
		Sleep(10)
	WEnd
	Opt("GUICoordMode", $iOldOpt)
	If $a > $b Then
		MsgBox($MB_SYSTEMMODAL, 'Race results', 'The dinosaur won', 0, $hGUI)
	Else
		MsgBox($MB_SYSTEMMODAL, 'Race results', 'The horse won', 0, $hGUI)
	EndIf
EndFunc   ;==>Example
