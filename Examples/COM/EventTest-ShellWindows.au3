; AutoIt 3.1.1.x beta
;
; COM Test file
;
; Test receiving Events from an open shell window
;
; See also:
; http://msdn.microsoft.com/library/en-us/shellcc/platform/shell/programmersguide/shell_basics/shell_basics_programming/objectmap.asp

Local $WindowName = "COM" ;  Change this to an existing Window title

Global $g_nComError = 0, $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc") ; Catch any COM Errors

Local $oShell = ObjCreate("shell.application")

;See also: http://msdn.microsoft.com/library/en-us/shellcc/platform/shell/reference/objects/shellwindows/shellwindows.asp
Local $oShellWindows = $oShell.windows ; Get the collection of open shell Windows


If IsObj($oShellWindows) Then

	Local $string = ""
	Local $MyWindow = ""

	; Search in all windows for a window with the given name
	For $Window In $oShellWindows
		If $Window.LocationName = $WindowName Then $MyWindow = $Window ; Found a window
	Next

	If IsObj($MyWindow) Then
		; MyWindow is an Internet Explorer Object !
		;
		; See also:
		; http://msdn.microsoft.com/workshop/browser/webbrowser/reference/objects/internetexplorer.asp

		; Now we try to hook up our Event handler to this window

		Local $oMyEvent = ObjEvent($MyWindow, "MyEvent_")

		If @error Then ; Failed to initialize event handler

			MsgBox(0, "COM Test", "Error trying to hook Eventhandler on Window. Error number: " & Hex(@error, 8))
			$MyWindow = ""
			$oShellWindows = ""
			Exit

		EndIf
		MsgBox(0, "COM Test", "Successfully received Events from a shell Window !");
	EndIf

Else

	MsgBox(0, "", "you have no open shell window with the name " & $WindowName)

EndIf

Exit

;-------------------
;Shell Window Events
;-------------------

Func MyEvent_aa() ; Dummy

EndFunc   ;==>MyEvent_aa


;----------------

Func MyErrFunc()

	Local $HexNumber = Hex($oMyError.number, 8)

	MsgBox(0, "", "We intercepted a COM Error !" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $oMyError.description & @CRLF & _
			"err.windescription:" & @TAB & $oMyError.windescription & @CRLF & _
			"err.number is: " & @TAB & $HexNumber & @CRLF & _
			"err.lastdllerror is: " & @TAB & $oMyError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $oMyError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $oMyError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $oMyError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $oMyError.helpcontext _
			)

	$g_nComError = $oMyError.number ; to check for after this function returns
EndFunc   ;==>MyErrFunc

