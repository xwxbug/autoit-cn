#include <WinAPIGdi.au3>

Local $Hue, $Luminance, $Saturation
_WinAPI_ColorRGBToHLS(0xFF8000, $Hue, $Luminance, $Saturation)

ConsoleWrite('Hue: ' & $Hue & @CRLF)
ConsoleWrite('Sat: ' & $Saturation & @CRLF)
ConsoleWrite('Lum: ' & $Luminance & @CRLF)
