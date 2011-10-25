#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Value = 9223372036854775807

msgbox(16, dec2hex64 ', 'DEC:' & $Value & @CRLF & ' HEX: 0x' & _WinAPI_Hex64 ( $Value ))

