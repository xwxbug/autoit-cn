#include <WinAPIEx.au3>

Run('Notepad.exe')
Sleep(3000)
$process = ' Notepad.exe '
$hProcess = ProcessExists($process)
_WinAPI_SuspendProcess($hProcess)
Sleep(5000)
_WinAPI_ResumeProcess($hProcess)

