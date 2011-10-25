#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Color = 0xAADDFF

$Color = _WinAPI_InvertColor($Color)
msgbox(64, invert color ', '0x' & Hex ( $Color , 6 ))
$Color = _WinAPI_InvertColor($Color)
msgbox(64, invert color ', '0x' & Hex ( $Color , 6 ))

