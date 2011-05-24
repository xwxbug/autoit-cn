; ObjEvent example

ProgressOn("Example", "Loading page...")
Local $oIE = ObjCreate("InternetExplorer.Application.1") ; Create Internet Explorer application
Local $SinkObject = ObjEvent($oIE, "IEEvent_", "DWebBrowserEvents2") ; Assign events to UDFs starting with IEEvent_

; Do some browsing activities
$oIE.Visible = 1
$oIE.RegisterAsDropTarget = 1
$oIE.RegisterAsBrowser = 1
$oIE.Navigate("http://www.AutoItScript.com/")

Sleep(3000) ; Give it time to load the web page

$SinkObject = 0 ; Stop IE Events
$oIE.Quit ; Quit IE
$oIE = 0
Exit

; one of many Internet Explorer Event Functions

Func IEEvent_ProgressChange($Progress, $ProgressMax)
	Local $percent = Int(($Progress * 100) / $ProgressMax)
	If $percent >= 0 And $percent <= 100 Then
		ProgressSet($percent, $percent & " percent to go.", "loading web page")
	EndIf

EndFunc   ;==>IEEvent_ProgressChange

Exit

; COM Error Handler example
; -------------------------

$oIE = ObjCreate("InternetExplorer.Application.1") ; Create Internet Explorer application

Global $g_eventerror = 0 ; to be checked to know if com error occurs. Must be reset after handling.

Local $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc") ; Initialize a COM error handler

$oIE.UnknownMethod ; Deliberately call an undefined method

If $g_eventerror Then
	$g_eventerror = 0
	MsgBox(0, "AutoItCOM test", "Test passed: We got an error number: " & @error)
Else
	MsgBox(0, "AutoItCOM test", "Test failed!")
EndIf

Exit

; This is my custom defined error handler
Func MyErrFunc()

	MsgBox(0, "AutoItCOM Test", "We intercepted a COM Error !" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $oMyError.description & @CRLF & _
			"err.windescription:" & @TAB & $oMyError.windescription & @CRLF & _
			"err.number is: " & @TAB & Hex($oMyError.number, 8) & @CRLF & _
			"err.lastdllerror is: " & @TAB & $oMyError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $oMyError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $oMyError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $oMyError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $oMyError.helpcontext _
			)

	Local $err = $oMyError.number
	If $err = 0 Then $err = -1

	$g_eventerror = $err ; to check for after this function returns
EndFunc   ;==>MyErrFunc
