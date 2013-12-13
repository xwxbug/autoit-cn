#include <WinAPITheme.au3>
#include <APIThemeConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
GUISetFont(8.5, 400, 0, 'MS Shell Dlg', $hForm)
Local $Button = GUICtrlCreateButton('Set Theme Color', 140, 368, 115, 23)
GUICtrlCreateTab(7, 7, 388, 354)
GUICtrlCreateTabItem('About')
Local $Slider = GUICtrlCreateSlider(20, 45, 360, 26)
GUICtrlCreateTabItem('')
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			GUICtrlSetBkColor($Slider, _GetTabBodyColor($hForm))
			GUICtrlSetState($Button, $GUI_DISABLE)
	EndSwitch
WEnd

Func _GetTabBodyColor($hForm)
	Local $Default = _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE))

	Local $hTheme = _WinAPI_OpenThemeData($hForm, 'TAB')
	If @error Then
		Return $Default
	EndIf
	Local $Part
	Switch @OSVersion
		Case 'WIN_XP', 'WIN_2003'
			$Part = 10 ; TABP_BODY
		Case Else
			$Part = 11 ; TABP_AEROWIZARDBODY
	EndSwitch
	Local $Color = _WinAPI_GetThemeColor($hTheme, $Part, 1, $TMT_FILLCOLORHINT)
	_WinAPI_CloseThemeData($hTheme)
	If $Color < 0 Then
		Return $Default
	EndIf
	Return $Color
EndFunc   ;==>_GetTabBodyColor
