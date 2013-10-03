; AutoIt 3.1.1 beta version
;
; COM Test file
;
; Test usage of Events with Internet Explorer
;
; See also: http://msdn.microsoft.com/workshop/browser/webbrowser/reference/objects/internetexplorer.asp

; Create a simple GUI for our output

#include "GUIConstants.au3"
#include <Constants.au3>

Local $GUIMain = GUICreate("Event Test", 640, 480)
Global $GUIEdit = GUICtrlCreateEdit("Test Log:" & @CRLF, 10, 10, 600, 400)
GUISetState() ;Show GUI

Global $g_nComError, $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")

Local $oIE = ObjCreate("InternetExplorer.Application.1")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "Error opening Internet Explorer: " & @error)
	Exit
EndIf

$oIE.Visible = 1
$oIE.RegisterAsDropTarget = 1
$oIE.RegisterAsBrowser = 1

; The Event interfaces of the Internet Explorer are defined in: SHDOCVW.DLL
;
; HTMLElementEvents2
; DWebBrowserEvents
; DWebBrowserEvents2
; -> NOTE1: If you have installed VC6 (DevStudio8) this one is renamed to: DWebBrowserEvent2Sink !
; -> NOTE2: If you have installed the Adobe Acrobat Reader 6.0 IE plugin then the type library of this
;           interface is modified to "AcroIEHelper 1.0 Type Library"

Local $SinkObject = ObjEvent($oIE, "IEEvent_", "DWebBrowserEvents")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "AutoIt COM Test", "ObjEvent: Can't use interface 'DWebBrowserEvents'. error code: " & Hex(@error, 8))
	Exit
EndIf

ProgressOn("Internet Explorer Event test", "Loading web page", "", -1, -1, 16)

Local $URL = "http://www.AutoItScript.com/"
$oIE.Navigate($URL)

Sleep(5000) ; Give it the time to load the web page

$SinkObject = 0 ; Stop IE Events
$oIE.Quit ; Quit IE
$oIE = 0

ProgressOff()

GUISwitch($GUIMain) ; In case IE stealed the focus

GUICtrlSetData($GUIEdit, @CRLF & "End of Internet Explorer Events test." & @CRLF, "append")
GUICtrlSetData($GUIEdit, "You may close this window now !" & @CRLF, "append")

; Waiting for user to close the window
Local $msg
While 1
	$msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd

GUIDelete()

Exit

; a few Internet Explorer Event Functions
; ---------------------------------------

Func IEEvent_ProgressChange($Progress, $ProgressMax)
	If $ProgressMax Then ProgressSet(($Progress * 100) / $ProgressMax, ($Progress * 100) / $ProgressMax & " percent to go.", "loading web page")
EndFunc   ;==>IEEvent_ProgressChange

Func IEEvent_StatusTextChange($Text)
	GUICtrlSetData($GUIEdit, "IE Status text changed to: " & $Text & @CRLF, "append")
EndFunc   ;==>IEEvent_StatusTextChange

Func IEEvent_PropertyChange($szProperty)
	GUICtrlSetData($GUIEdit, "IE Changed the value of the property: " & $szProperty & @CRLF, "append")
EndFunc   ;==>IEEvent_PropertyChange

Func IEEvent_DownloadBegin()
	GUICtrlSetData($GUIEdit, "IE has started a navigation operation" & @CRLF, "append")
EndFunc   ;==>IEEvent_DownloadBegin

Func IEEvent_DownloadComplete()
	GUICtrlSetData($GUIEdit, "IE has finished a navigation operation" & @CRLF, "append")
EndFunc   ;==>IEEvent_DownloadComplete

Func IEEvent_NavigateComplete2($oWebBrowser, $URL)
	#forceref $oWebBrowser

	;    IDispatch *pDisp,
	;    VARIANT *URL

	GUICtrlSetData($GUIEdit, "IE has finished loading URL: " & $URL & @CRLF, "append")
EndFunc   ;==>IEEvent_NavigateComplete2

; AutoIt Error Event Function
; ---------------------------

Func MyErrFunc()
	Local $HexNumber = Hex($oMyError.number, 8)

	MsgBox($MB_SYSTEMMODAL, "", "We intercepted a COM Error !" & @CRLF & @CRLF & _
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
