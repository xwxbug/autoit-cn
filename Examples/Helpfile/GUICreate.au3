#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Example1()
Example2()

; example 1
Func Example1()
	Local $msg

	GUICreate("My GUI") ; will create a dialog box that when displayed is centered
	GUISetState(@SW_SHOW) ; will display an empty dialog box

	; Run the GUI until the dialog is closed
	While 1
		$msg = GUIGetMsg()

		If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	GUIDelete()
EndFunc   ;==>Example1

; example 2
Func Example2()
	Local $gui, $background, $pic, $basti_stay, $msg
	Local $sFile = "..\GUI\logo4.gif"
	
	$gui = GUICreate("Background", 400, 100)
	; background picture
	$background = GUICtrlCreatePic("..\GUI\msoobe.jpg", 0, 0, 400, 100)
		
	GUISetState(@SW_SHOW)

	; transparent MDI child window
	$pic = GUICreate("", 169, 68, 20, 20, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $gui)
	; transparent pic
	$basti_stay = GUICtrlCreatePic($sFile, 0, 0, 169, 68)
	GUISetState(@SW_SHOW)

	Do
		$msg = GUIGetMsg()

	Until $msg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example2