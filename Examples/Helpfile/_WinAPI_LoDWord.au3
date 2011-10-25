#Include  <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Value = Int('0x1111111122222222')

msgbox(0, '_WinAPI_Lo/HiDWord ', '0x' & Hex( _WinAPI_HiDWord($Value)) & @CRLF & _
		' 0x' & Hex( _WinAPI_LoDWord($Value)))

