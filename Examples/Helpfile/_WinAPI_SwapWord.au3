#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Value = 0x1122

msgbox(0, 'Result ', 'before:0x' & Hex($Value, 4) & @CRLF & ' after   :0x' & Hex( _WinAPI_SwapWord($Value), 4))

