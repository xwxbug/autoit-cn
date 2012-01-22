#include <Sound.au3>

Local $aSound = _SoundOpen(@WindowsDir & "\media\tada.wav")
If @error = 2 Then
	MsgBox(0, "Error", "The file does not exist")
	Exit
ElseIf @extended <> 0 Then
	Local $iExtended = @extended ;赋值, 因为 @extended 可能会在 DllCall 后被设置成其它返回值
	Local $tText = DllStructCreate("char[128]")
	DllCall("winmm.dll", "short", "mciGetErrorStringA", "str", $iExtended, "ptr", DllStructGetPtr($tText), "int", 128)
	MsgBox(0, "Error", "The open failed." & @CRLF & "Error Number: " & $iExtended & @CRLF & "Error Description: " & DllStructGetData($tText, 1) & @CRLF & "Please Note: The sound may still play correctly.")
Else
	MsgBox(0, "Success", "The file opened successfully")
EndIf
_SoundPlay($aSound, 0)

;播放声音一秒
Sleep(1000)

;搜寻定位到声音的 2 秒处
_SoundSeek($aSound, 0, 0, 2)
ConsoleWrite("After _SoundSeek: " & _SoundPos($aSound, 2) & " _SoundStatus: " & _SoundStatus($aSound) & @CRLF)

_SoundSeek($aSound, 0, 0, 1)
ConsoleWrite("After _SoundSeek1: " & _SoundPos($aSound, 2) & " _SoundStatus: " & _SoundStatus($aSound) & @CRLF)

_SoundPlay($aSound, 0)

While 1
	Sleep(100)
	If _SoundPos($aSound, 2) >= _SoundLength($aSound, 2) Then ExitLoop
WEnd

_SoundClose($aSound)
