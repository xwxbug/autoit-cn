#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global Const $sTemp = @TempDir & '\Test.au3'

Global $hFile

; Create temporary .au3 file
$hFile = FileOpen($sTemp, 2)
For $i = 1 To 3
	FileWriteLine($hFile, 'Run(@SystemDir & "\calc.exe")')
Next
FileClose($hFile)

; Run 3 times the "calc.exe" and wait until you have closed all 3 processes
_RunWaitEx(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sTemp & '"')

; Delete temporary .au3 file
FileDelete($sTemp)

Func _RunWaitEx($sCMD)

	; Original idea by amel27

	Local $tProcess = DllStructCreate($tagPROCESS_INFORMATION)
	Local $tStartup = DllStructCreate($tagSTARTUPINFO)
	Local $tInfo = DllStructCreate($tagJOBOBJECT_BASIC_ACCOUNTING_INFORMATION)
	Local $hJob, $hProcess, $hThread

	$hJob = _WinAPI_CreateJobObject()
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	DllStructSetData($tStartup, 'Size', DllStructGetSize($tStartup))
	If Not _WinAPI_CreateProcess('', $sCMD, 0, 0, 0, 4, 0, 0, DllStructGetPtr($tStartup), DllStructGetPtr($tProcess)) Then
		Return SetError(1, _WinAPI_FreeHandle($hJob), 0)
	EndIf
	$hProcess = DllStructGetData($tProcess, 'hProcess')
	$hThread = DllStructGetData($tProcess, 'hThread')
	_WinAPI_AssignProcessToJobObject($hJob, $hProcess)
	_WinAPI_ResumeThread($hThread)
	_WinAPI_FreeHandle($hThread)
	Do
		If Not _WinAPI_QueryInformationJobObject($hJob, 1, $tInfo) Then
			ExitLoop
		EndIf
		Sleep(100)
	Until Not DllStructGetData($tInfo, 'ActiveProcesses')
	_WinAPI_FreeHandle($hProcess)
	_WinAPI_FreeHandle($hJob)
	Return 1
EndFunc   ;==>_RunWaitEx

Func _WinAPI_ResumeThread($hThread)

	Local $Ret = DllCall('kernel32.dll', 'dword', 'ResumeThread', 'ptr', $hThread)

	If (@error) Or (_WinAPI_DWordToInt($Ret[0]) = -1) Then
		Return SetError(1, 0, -1)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_AssignProcessToJobObject
