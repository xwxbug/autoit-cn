#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $R, $G, $B, $RGB = 0xFF8040

$R = _WinAPI_GetRValue($RGB)
$G = _WinAPI_GetGValue($RGB)
$B = _WinAPI_GetBValue($RGB)

msgbox(0, 'RGB Info ', 'Red:    0x' & Hex($R, 2) & @CR & _
		' Green:  0x' & Hex($G, 2) & @CR & _
		' Blue:   0x' & Hex($B, 2) & @CR & _
		' ---------------' & @CR & _
		' RGB:    0x' & Hex( _WinAPI_RGB($R, $G, $B), 6))

