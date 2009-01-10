#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiEdit.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_Ed = False ; Check ClassName being passed to Edit functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hEdit
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir") & "\include\changelog.txt"
	Local $sBefore, $sAfter
	
	; Create GUI
	GUICreate("Edit FmtLines", 400, 300)
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	GUISetState()

	; Set Text
	_GUICtrlEdit_SetText($hEdit, FileRead($sFile, 500))

	; Text retrieved in default format
	$sBefore = _GUICtrlEdit_GetText($hEdit)
	
	; insert soft line-breaks
	_GUICtrlEdit_FmtLines($hEdit, True)

	; Text with soft line breaks
	$sAfter = _GUICtrlEdit_GetText($hEdit)

	MsgBox(4096, "Information", "Before:" & @LF & @LF & $sBefore & @LF & _
			'--------------------------------------------------------------' & @LF & _
			"After:" & @LF & @LF & $sAfter)
	
	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main