#include <WinAPIProc.au3>
#include <ProcessConstants.au3>
#include <WinAPISys.au3>

; _WinAPI_CreateProcess() will be the best solution
Local $PID = Run('cmd.exe /k')
If Not $PID Then
	Exit
EndIf

; Note, immediately open the process
Local $hProcess
If _WinAPI_GetVersion() >= 6.0 Then
	$hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_LIMITED_INFORMATION, 0, $PID)
Else
	$hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_INFORMATION, 0, $PID)
EndIf
If Not $hProcess Then
	Exit
EndIf

; Wait until the process exists, try enter "exit 6"
While ProcessExists($PID)
	Sleep(100)
WEnd

ConsoleWrite('Exit code: ' & _WinAPI_GetExitCodeProcess($hProcess) & @CRLF)

_WinAPI_CloseHandle($hProcess)
