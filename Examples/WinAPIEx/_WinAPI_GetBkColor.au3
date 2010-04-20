#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $hForm, $hDC

$hForm = GUICreate('MyGUI', 400, 400)
GUISetState()

$hDC = _WinAPI_GetDC($hForm)
ConsoleWrite('0x' & Hex(_WinAPI_GetBkColor($hDC), 6) & @CR)
_WinAPI_ReleaseDC($hForm, $hDC)

Do
Until GUIGetMsg() = -3
