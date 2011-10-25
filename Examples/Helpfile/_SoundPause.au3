
#include  <Sound.au3>
;打开声音文件
$sound = _SoundOpen(@WindowsDir & "\media\Windows XP Startup.wav")
If @error = 2 Then
	msgbox(0, "Error", "The file does not exist")
	Exit
ElseIf @error = 3 Then
	msgbox(0, "Error", "The alias was invalid")
	Exit
ElseIf @extended <> 0 Then
	$extended = @extended ;由于@extended将被DllCall设置, 先赋值给另一个变量
	$stText = DllStructCreate("char[128]")
	$errorstring = DllCall("winmm.dll", "short", "mciGetErrorStringA", "str", $extended, "ptr", DllStructGetPtr($stText), "int", 128)
	msgbox(0, "Error", "The open failed." & @CRLF & "Error Number:" & $extended & @CRLF & "Error Description:" & DllStructGetData($stText, 1) & @CRLF & "Please Note: The sound may still play correctly.")
Else
	msgbox(0, "Success", "The file opened successfully")
EndIf
_SoundPlay($sound)
Sleep(1000)
_SoundPause($sound)
Sleep(1000)
_SoundResume($sound)
While 1
	Sleep(100)
	If _SoundPos($sound, 2) >= _SoundLength($sound, 2) Then ExitLoop
WEnd

_SoundClose($sound)

