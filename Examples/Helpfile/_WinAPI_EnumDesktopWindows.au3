#include <WinAPISys.au3>
#include <WinAPIProc.au3>
#include <Array.au3>

Local $Data = _WinAPI_EnumDesktopWindows(_WinAPI_GetThreadDesktop(_WinAPI_GetCurrentThreadId()))

_ArrayDisplay($Data, '_WinAPI_EnumDesktopWindows')
