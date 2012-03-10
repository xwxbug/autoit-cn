#include <GUIConstantsEx.au3>

Global $iUserDummy

Example()

Func Example()
	Opt("GUIOnEventMode", 1) ; Set the option to use GUIOnEventMode.

	GUICreate("GUISendToDummy", 220, 200, 100, 200)
	GUISetBkColor(0x00E0FFFF) ; Change the background color of the GUI.
	GUISetOnEvent($GUI_EVENT_CLOSE, "OnClick") ; Set an event to call the 'OnClick' function when the GUI close button is selected.

	$iUserDummy = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "OnExit") ; Set an event to call the 'OnExit' function when this control is selected.

	GUICtrlCreateButton("Close", 70, 170, 85, 25)
	GUICtrlSetOnEvent(-1, "OnClick") ; Set an event to call the 'OnClick' function when this control is selected.

	; Display the GUI.
	GUISetState(@SW_SHOW)

	While 1
		Sleep(100)
	WEnd
EndFunc   ;==>Example

Func OnClick()
	Return GUICtrlSendToDummy($iUserDummy) ; Send a message to the dummy control that the close button was selected, which will then proceed to call the function 'OnExit'.
EndFunc   ;==>OnClick

Func OnExit()
	Exit ; Exit the script.
EndFunc   ;==>OnExit
