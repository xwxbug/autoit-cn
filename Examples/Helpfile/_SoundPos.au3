#include <Sound.au3>

Local $aSound = _SoundOpen(@WindowsDir & "\media\tada.wav")
If @error = 2 Then
	MsgBox(4096, "Error", "The file does not exist")
	Exit
ElseIf @extended <> 0 Then
	Local $iExtended = @extended ;赋值, 因为 @extended 可能会在 DllCall 后被设置成其它返回值
	Local $tText = DllStructCreate("char[128]")
	DllCall("winmm.dll", "short", "mciGetErrorStringA", "str", $iExtended, "ptr", DllStructGetPtr($tText), "int", 128)
	MsgBox(4096, "Error", "The open failed." & @CRLF & "Error Number: " & $iExtended & @CRLF & "Error Description: " & DllStructGetData($tText, 1) & @CRLF & "Please Note: The sound may still play correctly.")
Else
	MsgBox(4096, "Success", "The file opened successfully")
EndIf

_SoundPlay($aSound, 0)
SplashTextOn("Current Position", _SoundPos($aSound, 1), 300, 90, Default, Default, 18, Default, 55)

While 1
	Sleep(100)
	ControlSetText("Current Position", "", "Static1", _SoundPos($aSound, 1))
	If _SoundPos($aSound, 2) >= _SoundLength($aSound, 2) Then ExitLoop
WEnd

_SoundClose($aSound)
