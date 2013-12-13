#include <WinAPIMisc.au3>
#include <APIMiscConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Local Const $sWav = @ScriptDir & '\Extras\Airplane.wav'

; Read Airplane.wav to memory
Local $bWav = FileRead($sWav)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to read "' & $sWav & '"')
	Exit
EndIf
Local $tWav = DllStructCreate('byte[' & BinaryLen($bWav) & ']')
DllStructSetData($tWav, 1, $bWav)
Local $pWav = DllStructGetPtr($tWav)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 200, 200)
Local $Button = GUICtrlCreateButton('Play', 70, 70, 60, 60)
GUISetState()

Local $Play = False
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			$Play = Not $Play
			If $Play Then
				_WinAPI_PlaySound($pWav, BitOR($SND_ASYNC, $SND_LOOP, $SND_MEMORY))
				GUICtrlSetData($Button, 'Stop')
			Else
				_WinAPI_PlaySound('')
				GUICtrlSetData($Button, 'Play')
			EndIf
	EndSwitch
WEnd
