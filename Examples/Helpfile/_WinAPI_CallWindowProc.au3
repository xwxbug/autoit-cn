#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#include <GuiMenu.au3>
#include <WinAPI.au3>

Opt('MustDeclareVars', 1)

Global $ContextMenu, $CommonMenuItem, $FileMenuItem, $ExitMenuItem
Global $hGui, $cInput, $wProcOld

_Main()

Func _Main()
	Local $cInput2, $wProcNew, $DummyMenu
	
	$hGui = GUICreate("Type or paste some stuff", 400, 200, -1, -1, $WS_THICKFRAME, -1)
	$cInput = GUICtrlCreateInput("", 20, 20, 360, 20)
	$cInput2 = GUICtrlCreateInput("", 20, 50, 360, 20)

	GUICtrlCreateLabel("abcd", 1, 1, 30, 18)
	GUICtrlSetCursor(-1, 9)

	$wProcNew = DllCallbackRegister("_MyWindowProc", "ptr", "hwnd;uint;long;ptr")
	$wProcOld = _WinAPI_SetWindowLong(GUICtrlGetHandle($cInput), $GWL_WNDPROC, DllCallbackGetPtr($wProcNew))
	_WinAPI_SetWindowLong(GUICtrlGetHandle($cInput2), $GWL_WNDPROC, DllCallbackGetPtr($wProcNew))
	;_WinAPI_SetWindowLong(GUICtrlGetHandle($cInput3), $GWL_WNDPROC, DllCallbackGetPtr($wProcNew)) and so on

	$DummyMenu = GUICtrlCreateDummy()
	$ContextMenu = GUICtrlCreateContextMenu($DummyMenu)
	$CommonMenuItem = GUICtrlCreateMenuItem("Common", $ContextMenu)
	$FileMenuItem = GUICtrlCreateMenuItem("File", $ContextMenu)
	GUICtrlCreateMenuItem("", $ContextMenu)
	$ExitMenuItem = GUICtrlCreateMenuItem("Exit", $ContextMenu)


	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_Main

Func do_clever_stuff_with_clipboard($hWnd)
	Local $sData
	$sData = ClipGet()
	If @error Then Return 0;clip data is not text or clip empty
	;do whatever
	$sData = StringUpper($sData)
	;set text
	GUICtrlSetData(_WinAPI_GetDlgCtrlID($hWnd), $sData);or _GUICtrlEdit_SetText($hWnd, $sData)
	Return 1
EndFunc   ;==>do_clever_stuff_with_clipboard

; Show a menu in a given GUI window which belongs to a given GUI ctrl
Func ShowMenu($hWnd, $nContextID)
	Local $iSelected = _GUICtrlMenu_TrackPopupMenu(GUICtrlGetHandle($nContextID), $hWnd, -1, -1, -1, -1, 2)
	Switch $iSelected
		Case $CommonMenuItem
			ConsoleWrite("Common" & @LF)
		Case $FileMenuItem
			ConsoleWrite("File" & @LF)
		Case $ExitMenuItem
			ConsoleWrite("Exit" & @LF)
	EndSwitch
EndFunc   ;==>ShowMenu

Func _MyWindowProc($hWnd, $uiMsg, $wParam, $lParam)
	Switch $uiMsg
		Case $WM_PASTE
			Return do_clever_stuff_with_clipboard($hWnd)
		Case $WM_CONTEXTMENU
			If $hWnd = GUICtrlGetHandle($cInput) Then
				ShowMenu($hGui, $ContextMenu)
				Return 0
			EndIf
		Case $WM_SETCURSOR
			GUICtrlSetCursor(_WinAPI_GetDlgCtrlID($hWnd), 5);;set Ibeam cursor
			Return 1;;and don't let default windowproc mess things up
	EndSwitch

	;pass the unhandled messages to default WindowProc
	Return _WinAPI_CallWindowProc($wProcOld, $hWnd, $uiMsg, $wParam, $lParam)
EndFunc   ;==>_MyWindowProc