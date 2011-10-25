#Include <Constants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

;Global Const $PROCESS_QUERY_INFORMATION = 0x0400
Global Const $PROCESS_QUERY_LIMITED_INFORMATION = 0x1000

Global $PID, $Name, $hProcess

$PID = Run('cmd.exe /c exit 5 ', '', @SW_HIDE, $STDOUT_CHILD)
If Not $PID Then
	Exit
EndIf

Switch @OSVersion
	Case ' WIN_2000 ', 'WIN_2003 ', 'WIN_XP ', 'WIN_XPe '
		$hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_INFORMATION, 0, $PID)
	Case Else
		$hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_LIMITED_INFORMATION, 0, $PID)
EndSwitch
If Not $hProcess Then
	Exit
EndIf

$Name = _WinAPI_GetProcessName($PID)
While ProcessExists($PID)
	Sleep(100)
WEnd

msgbox(0, 'ExitCode ', 'Process:' & $Name & @CR & ' PID:' & $PID & @CR & _
		' Exit code:' & _WinAPI_GetExitCodeProcess($hProcess))

_WinAPI_CloseHandle($hProcess)

