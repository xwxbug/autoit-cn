#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Pos = _WinAPI_GetPosFromRect( _WinAPI_CreateRectEx(10, 10, 100, 100))

msgbox('', 'Rect Info ', 'Left:' & @TAB & $Pos[0] & @CRLF & _
		' Top:' & @TAB & $Pos[1] & @CRLF & _
		' Width:' & @TAB & $Pos[2] & @CRLF & _
		' Height:' & @TAB & $Pos[3])

