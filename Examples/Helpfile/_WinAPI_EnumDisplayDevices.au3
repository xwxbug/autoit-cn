#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WinAPI.au3>
Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $aDevice, $i = 0, $text
	While 1
		$aDevice = _WinAPI_EnumDisplayDevices("", $i)
		If Not $aDevice[0] Then ExitLoop
		$text = "Successful? " & $aDevice[0] & @LF
		$text &= "Device (Adapter or Monitor): " & $aDevice[1] & @LF
		$text &= "Description (Adapter or Monitor): " & $aDevice[2] & @LF
		$text &= "Device State Flag: " & $aDevice[3] & @LF
		if BitAND($aDevice[3], 32) then $text &= @TAB & "- The device has more display modes than its output devices support" & @LF

		if BitAND($aDevice[3], 16) then $text &= @TAB & "- The device is removable; it cannot be the primary display" & @LF
		if BitAND($aDevice[3], 8) then $text &= @TAB & "- The device is VGA compatible" & @LF
		if BitAND($aDevice[3], 4) then $text &= @TAB & "- Represents a pseudo device used to mirror application drawing for remoting" & @LF
		if BitAND($aDevice[3], 2) then $text &= @TAB & "- The primary desktop is on the device" & @LF
		if BitAND($aDevice[3], 1) then $text &= @TAB & "- The device is part of the desktop" & @LF

		$text &= "Plug and Play identifier string: " & $aDevice[4] & @LF
		MsgBox(0, "", $text)
		$i += 1
	WEnd
EndFunc   ;==>_Main
