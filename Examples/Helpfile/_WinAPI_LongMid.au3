#Include  <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Value = 0x00FA0000

msgbox(0, '_WinAPI_LongMid ', '0x' & Hex( _WinAPI_LongMid($Value, 16, 4)) & @CRLF & _
		' 0x' & Hex( _WinAPI_LongMid($Value, 20, 4)))

