#include <Constants.au3>

; AutoItCOM 3.1.0
;
; Test file
;
; Counting the number of open shell windows

Local $oShell = ObjCreate("shell.application") ; Get the Windows Shell Object
Local $oShellWindows = $oShell.windows ; Get the collection of open shell Windows

If IsObj($oShellWindows) Then

	Local $string = "" ; String for displaying purposes

	For $Window In $oShellWindows ; Count all existing shell windows
		$string = $string & $Window.LocationName & @CRLF
	Next

	MsgBox($MB_SYSTEMMODAL, "Shell Windows", "You have the following shell windows:" & @CRLF & @CRLF & $string);

EndIf
