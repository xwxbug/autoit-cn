#NoTrayIcon

#include <WinAPIFiles.au3>
#include <WinAPI.au3>
#include <MsgBoxConstants.au3>

Opt('WinWaitDelay', 0)

Global Const $Title = '_WinAPI_MapViewOfFile' & ChrW(160)

If Not $CmdLine[0] Then
	If WinExists($Title) Then
		Exit
	EndIf
	For $i = 1 To 2
		If Not @Compiled Then
			Run(@AutoItExe & ' "' & @ScriptFullPath & '" /' & $i)
		Else
			Run(@AutoItExe & ' /' & $i)
		EndIf
		Sleep(500)
	Next
	Exit
EndIf

Opt('TrayIconHide', 0)

Switch $CmdLine[1]
	Case '/1'
		_Sender()
	Case '/2'
		_Receiver()
	Case Else
		Exit
EndSwitch

Func _Receiver()
	Local $hMapping = _WinAPI_OpenFileMapping('MyFileMapping')
	If Not $hMapping Then Return

	Local $pAddress = _WinAPI_MapViewOfFile($hMapping)
	Local $tData = DllStructCreate('wchar[1024]', $pAddress)
	Local $Text
	While WinWait($Title, '', 1)
		Sleep(200)
		$Text = DllStructGetData($tData, 1)
		DllStructSetData($tData, 1, '')
		If $Text Then MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), $Title & " (receiver)", "                                               " & @CRLF & $Text)
	WEnd
	_WinAPI_UnmapViewOfFile($pAddress)
	_WinAPI_CloseHandle($hMapping)
EndFunc   ;==>_Receiver

Func _Sender()
	Local $hMapping = _WinAPI_CreateFileMapping(-1, 2048, 'MyFileMapping')
	If Not $hMapping Or @extended Then
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create file mapping (@extended=' & @extended & ').')
		Return
	EndIf

	Local $pAddress = _WinAPI_MapViewOfFile($hMapping)
	Local $tData = DllStructCreate('wchar[1024]', $pAddress)
	Local $Text
	While WinWaitClose($Title)
		$Text = StringStripWS(InputBox($Title & " (sender)", 'Type some text message.', '', '', -1, 171), 3)
		If Not $Text Then
			ExitLoop
		EndIf
		DllStructSetData($tData, 1, $Text)
		If Not WinWait($Title, '', 1) Then
			ExitLoop
		EndIf
	WEnd
	_WinAPI_UnmapViewOfFile($pAddress)
	_WinAPI_CloseHandle($hMapping)
EndFunc   ;==>_Sender
