; WINHTTP Object example
;
; Retrieve the HTML source from a given URL
;
; Derived from a KiXtart script BBCodeParser.kix by Lonkero
;
; See also: http://www.gwspikval.com/jooel/scripts/BBCodeParser/Older%20versions/2.0.1/BBCodeParser2.kix
; and
; http://msdn.microsoft.com/library/en-us/winhttp/http/winhttprequest.asp

Local $URL = "http://www.AutoItScript.com"

#include "GUIConstants.au3"

; Create a simple GUI for our output
GUICreate("Event Test", 640, 480)
Local $GUIEdit = GUICtrlCreateEdit("HTTP Source Test:" & @CRLF, 10, 10, 600, 400)
GUISetState() ;Show GUI

Local $httpObj = ObjCreate("winhttp.winhttprequest.5.1")
$httpObj.open("GET", $URL)
$httpObj.send()

Local $HTMLSource = $httpObj.Responsetext

GUICtrlSetData($GUIEdit, "The HTML source of " & $URL & " is:" & @CRLF & @CRLF & StringAddCR($HTMLSource), "append")

; Waiting for user to close the window
Local $msg
While 1
	$msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd

GUIDelete()

Exit
