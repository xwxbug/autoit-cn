#include <WinAPIRes.au3>
#include <APIResConstants.au3>
#include <Array.au3>

Local $Data = _WinAPI_EnumResourceLanguages(@SystemDir & '\shell32.dll', $RT_DIALOG, 1003)

_ArrayDisplay($Data, '_WinAPI_EnumResourceLanguages')
