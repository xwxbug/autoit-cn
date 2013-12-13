#include <WinAPILocale.au3>
#include <Array.au3>

Local $Data = _WinAPI_EnumUILanguages()

_ArrayDisplay($Data, '_WinAPI_EnumUILanguages')
