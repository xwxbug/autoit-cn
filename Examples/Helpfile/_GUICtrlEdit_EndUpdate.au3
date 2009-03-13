#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiEdit.au3>
#include <GuiStatusBar.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_Ed = False ; Check ClassName being passed to Edit functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $StatusBar, $hEdit, $hGUI
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir") & "\include\changelog.txt"

	; Create GUI
	$hGUI = GUICreate("Edit End Update", 400, 300)
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268)
	$StatusBar = _GUICtrlStatusBar_Create($hGUI, -1)
	GUISetState()
	
	_GUICtrlEdit_BeginUpdate($hEdit)
	_GUICtrlEdit_SetText($hEdit, FileRead($sFile))
	_GUICtrlEdit_EndUpdate($hEdit)
	
	_GUICtrlStatusBar_SetIcon($StatusBar, 0, 97, "shell32.dll")
	_GUICtrlStatusBar_SetText($StatusBar, @TAB & "Lines: " & _GUICtrlEdit_GetLineCount($hEdit))
	
	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main