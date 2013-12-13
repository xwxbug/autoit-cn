#include <WinAPIProc.au3>
#include <WinAPISys.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>

If (_WinAPI_GetVersion() < '6.0') And (@AutoItX64) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'This example works from a 64-bit system only in Windows Vista or later.')
	Exit
EndIf

Local $Data = _WinAPI_EnumProcessModules()

_ArrayDisplay($Data, '_WinAPI_EnumProcessModules')
