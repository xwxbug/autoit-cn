#include <WinAPIRes.au3>
#include <APIResConstants.au3>
#include <Array.au3>

Local $Data = _WinAPI_EnumResourceNames(@SystemDir & '\shell32.dll', $RT_DIALOG)

_ArrayDisplay($Data, '_WinAPI_EnumResourceNames')
