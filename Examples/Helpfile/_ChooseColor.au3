#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>

Opt('MustDeclareVars ', 1)

_Color_Examlpe()

Func _Color_Examlpe()
	Local $GUI, $Btn_COLORREF, $Btn_BGR, $Btn_RGB, $iMemo

	$GUI = GUICreate("_ChooseColor Examlpe ", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 55, 396, 243, BitOR($ES_AUTOVSCROLL, $ES_READONLY))
	GUICtrlSetFont($iMemo, 10, 400, 0, "Courier New ")
	$Btn_COLORREF = GUICtrlCreateButton("COLORREF ", 70, 10, 80, 40)
	$Btn_BGR = GUICtrlCreateButton("BGR ", 160, 10, 80, 40)
	$Btn_RGB = GUICtrlCreateButton("RGB ", 250, 10, 80, 40)
	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $Btn_COLORREF
				_ShowChoice($GUI, $iMemo, 0, _ChooseColor(0, 255, 0, $GUI), "COLORREF color of your choice: ")
			Case $Btn_BGR
				_ShowChoice($GUI, $iMemo, 1, _ChooseColor(2, 0x808000, 1, $GUI), "BGR Hex color of your choice: ")
			Case $Btn_RGB
				_ShowChoice($GUI, $iMemo, 2, _ChooseColor(2, 0x0080C0, 2, $GUI), "RGB Hex color of your choice: ")
		EndSwitch
	WEnd
endfunc   ;==>_Color_Examlpe

Func _ShowChoice($GUI, $iMemo, $Type, $Choose, $sMessage)
	Local $cr
	If $Choose <> -1 Then

		If $Type = 0 Then ; 将COLORREF转化为RGB
			$cr = Hex($Choose, 6)
			GUISetBkColor('0x' & StringMid($cr, 5, 2) & StringMid($cr, 3, 2) & StringMid($cr, 1, 2), $GUI)
		Else
			GUISetBkColor($Choose, $GUI)
		EndIf

		GUICtrlSetData($iMemo, $sMessage & $Choose & @CRLF, 1)

	Else
		GUICtrlSetData($iMemo, "User Canceled Selction" & @CRLF, 1)
	EndIf
endfunc   ;==>_ShowChoice

