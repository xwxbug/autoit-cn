#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Global Const $sTemp = @TempDir & ' \Test.au3 ',

Global $hFile

; 创建临时.au3文件
$hFile = FileOpen($sTemp, 2)
For $i = 1 To 3
	FileWriteLine($hFile, 'Run(@SystemDir & " \calc.exe " )')
Next
FileClose($hFile)

; 运行三次"calc.exe"并等待关闭所有三个进程
_RunWaitEx(@AutoItExe & ' /AutoIt3ExecuteScript "'& $sTemp &'"')

; 删除临时.au3文件
FileDelete($sTemp)

Func _RunWaitEx($sCMD)

	Local $tProcess = DllStructCreate($tagPROCESS_INFORMATION)
	Local $tStartup = DllStructCreate($tagSTARTUPINFO)
	Local $tInfo = DllStructCreate($tagJOBOBJECT_BASIC_ACCOUNTING_INFORMATION)
	Local $hJob, $hProcess, $hThread

	$hJob = _WinAPI_CreateJobObject(4)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	DllStructSetData($tStartup, 'Size ', DllStructGetSize($tStartup))

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
endfunc   ;==>_RunWaitEx

