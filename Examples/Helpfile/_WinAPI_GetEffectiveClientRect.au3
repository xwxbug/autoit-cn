#include <WinAPISys.au3>
#include <WinAPIGdi.au3>
#include <GUIConstantsEx.au3>
#include <GUIStatusBar.au3>
#include <StaticConstants.au3>

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 600, 400)
Local $Menu = GUICtrlCreateMenu("&File")
Local $Exit = GUICtrlCreateMenuItem("E&xit", $Menu)
Local $ID[2]
$ID[0] = _GUICtrlStatusBar_Create($hForm)
$ID[1] = GUICtrlCreateListView('', 0, 0, 600, 200, -1, 0)

; Calculate effective client area (excluding Menu, ListView, and StatusBar controls)
Local $tRECT = _WinAPI_GetEffectiveClientRect($hForm, $ID)
Local $Pos = _WinAPI_GetPosFromRect($tRECT)
GUICtrlCreateLabel($Pos[2] & 'x' & $Pos[3], $Pos[0], $Pos[1], $Pos[2], $Pos[3], BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 25, 400, 0, 'Tahoma')
GUICtrlSetBkColor(-1, 0xFFD0D0)

; Show GUI
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $Exit
			ExitLoop
	EndSwitch
WEnd
