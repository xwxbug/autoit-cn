#include <WinAPIDlg.au3>
#include <Array.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 200, 100)
Local $Drive = DriveGetDrive('ALL')
$Drive = StringUpper(_ArrayToString($Drive, '|', 1))
GUICtrlCreateLabel('Select drive:', 15, 29, 62, 14)
Local $Combo = GUICtrlCreateCombo('', 79, 25, 40, 21, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $Drive, StringLeft($Drive, 2))
Local $Button = GUICtrlCreateButton('Format...', 65, 70, 70, 23)
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			_WinAPI_FormatDriveDlg(GUICtrlRead($Combo), 0, $hForm)
	EndSwitch
WEnd
