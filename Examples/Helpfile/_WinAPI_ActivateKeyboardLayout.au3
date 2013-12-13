#include <WinAPISys.au3>
#include <APISysConstants.au3>
#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 300, 200)
Local $Label = GUICtrlCreateLabel('', 10, 66, 280, 40, $SS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, 'Tahoma')
Local $Prev = GUICtrlCreateButton('<', 82, 164, 60, 24)
Local $Next = GUICtrlCreateButton('>', 158, 164, 60, 24)
GUISetState()

Local $Update = 1
While 1
	If $Update Then
		GUICtrlSetData($Label, '0x' & StringRight(@KBLayout, 4) & @CRLF & _WinAPI_GetLocaleInfo(Number('0x' & @KBLayout), $LOCALE_SLANGUAGE))
		$Update = 0
	EndIf

	Switch GUIGetMsg()
		Case -3
			ExitLoop
		Case $Next
			_WinAPI_ActivateKeyboardLayout($HKL_NEXT)
			$Update = 1
		Case $Prev
			_WinAPI_ActivateKeyboardLayout($HKL_PREV)
			$Update = 1
	EndSwitch
WEnd
