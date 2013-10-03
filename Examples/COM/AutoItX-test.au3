#include <Constants.au3>

; AutoIt 3.1.1.x beta version
;
; COM Test file
;
; Test usage of AutoItX from within AutoItCOM

Local $oAutoIt = ObjCreate("AutoItX3.Control")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "AutoItX Test", "Failed to open AutoItX. Error code: " & Hex(@error, 8))
	Exit
EndIf

$oAutoIt.ClipPut("I am copied to the clipboard")

Local $text = $oAutoIt.ClipGet()

MsgBox($MB_SYSTEMMODAL, "Clipboard test", "Clipboard contains: " & $text)

; This will create a tooltip in the upper left of the screen

MsgBox($MB_SYSTEMMODAL, "Tooltip test", "Press OK to create a tooltip in the upper left corner.")

$oAutoIt.ToolTip("This is a tooltip", 0, 0)
$oAutoIt.Sleep(1000) ; Sleep to give tooltip time to display

Local $var = $oAutoIt.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion", "ProgramFilesDir")

MsgBox($MB_SYSTEMMODAL, "RegRead Test", "Program files are in:" & $var)
