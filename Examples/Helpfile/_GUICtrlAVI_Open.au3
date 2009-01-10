#include <GuiConstantsEx.au3>
#include <GuiAVI.au3>

Opt('MustDeclareVars', 1)

$Debug_AVI = False ; Check ClassName being passed to AVI functions, set to True and use a handle to another control to see it work

Global $hAVI

_Main()

Func _Main()
	Local $hGUI, $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")  & "\Examples\GUI\SampleAVI.avi"

	; Create GUI
	$hGUI = GUICreate("(External) AVI Open", 300, 100)
	$hAVI = _GUICtrlAVI_Create ($hGUI, "", -1, 10, 10)
	GUISetState()

	; Play the sample AutoIt AVI
	_GUICtrlAVI_Open($hAVI, $sFile)

	; Play the sample AutoIt AVI
	_GUICtrlAVI_Play($hAVI)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Close AVI clip
	_GUICtrlAVI_Close($hAVI)

	
	GUIDelete()
EndFunc   ;==>_Main
