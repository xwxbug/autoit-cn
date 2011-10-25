#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Label, $hLabel

GUICreate('MyGUI ', 200, 60)
$hLabel = GUICtrlGetHandle($Label)
GUICtrlSetData(-1, _WinAPI_PathCompactPath($hLabel, @MyDocumentsDir & ' \Test.txt'))
GUISetState()

Do
Until GUIGetMsg() = -3

