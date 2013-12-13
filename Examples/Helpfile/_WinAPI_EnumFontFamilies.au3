#include <WinAPIGdi.au3>
#include <APIGdiConstants.au3>
#include <FontConstants.au3>
#include <Array.au3>

; Enumerates all uniquely-named fonts excluding "@" fonts, which is designed for vertical text, in the ANSI character set
Local $Data = _WinAPI_EnumFontFamilies(0, '', $ANSI_CHARSET, BitOR($DEVICE_FONTTYPE, $TRUETYPE_FONTTYPE), '@*', 1)
If Not @error Then
	_ArrayDisplay($Data, '_WinAPI_EnumFontFamilies')
EndIf

; Enumerates all styles of "Arial" font in the ANSI character set
$Data = _WinAPI_EnumFontFamilies(0, 'Arial', $ANSI_CHARSET)
If Not @error Then
	_ArrayDisplay($Data, '_WinAPI_EnumFontFamilies')
EndIf
