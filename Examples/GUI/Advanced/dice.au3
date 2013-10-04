; AutoIt Version: 3.0
; Language:       English
; Author:         Larry Bailey
; Email:          psichosis@tvn.net
; Date: 		  November 15, 2004
; Modified:  	  August 03, 2012 by guinness
;
; Script Function
; Creates a GUI based dice rolling program using the Random function.

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

Example()

Func Example()
	Local $iRandomResult = 0
	Local $hGUI = GUICreate("Dice Roller", 265, 150, -1, -1)

	Local $iButton1 = GUICtrlCreateButton("D2", 5, 25, 50, 30)
	Local $iButton2 = GUICtrlCreateButton("D3", 65, 25, 50, 30)
	Local $iButton3 = GUICtrlCreateButton("D4", 125, 25, 50, 30)
	Local $iButton4 = GUICtrlCreateButton("D6", 5, 65, 50, 30)
	Local $iButton5 = GUICtrlCreateButton("D8", 65, 65, 50, 30)
	Local $iButton6 = GUICtrlCreateButton("D10", 125, 65, 50, 30)
	Local $iButton7 = GUICtrlCreateButton("D12", 5, 105, 50, 30)
	Local $iButton8 = GUICtrlCreateButton("D20", 65, 105, 50, 30)
	Local $iButton9 = GUICtrlCreateButton("D100", 125, 105, 50, 30)
	Local $iButton10 = GUICtrlCreateButton("Clear Dice", 185, 105, 65, 30)
	Local $iOutput = GUICtrlCreateLabel("", 185, 45, 70, 50, BitOR($BS_PUSHLIKE, $SS_CENTER))
	Local $iDie = GUICtrlCreateLabel("", 185, 25, 70, 20, $SS_SUNKEN)
	GUICtrlSetFont($iOutput, 24, 800, "", "Comic Sans MS")

	GUISetState(@SW_SHOW, $hGUI)

	; Run the GUI until the dialog is closed
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $iButton1
				$iRandomResult = Random(1, 2, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "2 Sided Die")

			Case $iButton2
				$iRandomResult = Random(1, 3, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "3 Sided Die")

			Case $iButton3
				$iRandomResult = Random(1, 4, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "4 Sided Die")

			Case $iButton4
				$iRandomResult = Random(1, 6, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "6 Sided Die")

			Case $iButton5
				$iRandomResult = Random(1, 8, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "8 Sided Die")

			Case $iButton6
				$iRandomResult = Random(1, 10, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "10 Sided Die")

			Case $iButton7
				$iRandomResult = Random(1, 12, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "12 Sided Die")

			Case $iButton8
				$iRandomResult = Random(1, 20, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "20 Sided Die")

			Case $iButton9
				$iRandomResult = Random(1, 100, 1)
				GUICtrlSetData($iOutput, $iRandomResult)
				GUICtrlSetData($iDie, "100 Sided Die")

			Case $iButton10
				GUICtrlSetData($iOutput, "")
				GUICtrlSetData($iDie, "")

		EndSwitch
	WEnd
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>Example
