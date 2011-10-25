#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()

	Local $btn, $chk, $rdo, $Msg
	Local $sPath = RegRead(" HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt ", "InstallDir ") & " \Examples\GUI\Advanced\Images "

	GUICreate(" Buttons ", 300, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 60, 296, 236, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	$btn = GUICtrlCreateButton(" Button ", 10, 10, 40, 40, $BS_BITMAP)
	_GUICtrlButton_SetImage($btn, $sPath & "\blue.bmp")

	$chk = GUICtrlCreateCheckbox(" Checkbox ", 60, 10, 50, 32, $BS_ICON)
	_GUICtrlButton_SetImage($chk, "shell32.dll ", 14, True)

	$rdo = GUICtrlCreateRadio(" Radio ", 120, 10, 50, 32, $BS_ICON)
	_GUICtrlButton_SetImage($rdo, "shell32.dll ", 21, True)

	MemoWrite(" Button Image Handle:" & _GUICtrlButton_GetImage($btn))
	MemoWrite(" CheclBox Image Handle:" & _GUICtrlButton_GetImage($chk))
	MemoWrite(" Radio Image Handle:" & _GUICtrlButton_GetImage($rdo))

	While 1
		$Msg = GUIGetMsg()
		If $Msg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd

	Exit

endfunc   ;==>_Main

; 向编辑框写入信息
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

