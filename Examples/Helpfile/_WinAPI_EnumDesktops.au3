#include <WinAPISys.au3>
#include <Array.au3>

Local $Data = _WinAPI_EnumDesktops(_WinAPI_GetProcessWindowStation())

_ArrayDisplay($Data, '_WinAPI_EnumDesktops')
