#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

Global $hOpen, $hConnect
Global $sRead, $hFileHTM, $sFileHTM = @ScriptDir & "\Form.htm"

; Example1:
;    1. Open APNIC whois page (http://wq.apnic.net/apnic-bin/whois.pl)
;    2. Fill form on that page with these values/conditins:
;         - fill default form
;         - set ip address 4.2.2.2 to input box. Use name propery to locate input
;         - send form (click button)
;         - gather returned data

; Initialize and get session handle
$hOpen = _WinHttpOpen()
; Get connection handle
$hConnect = _WinHttpConnect($hOpen, "wq.apnic.net")
; Fill form on this page
$sRead = _WinHttpSimpleFormFill($hConnect, "apnic-bin/whois.pl", Default, "name:searchtext", "4.2.2.2")
; Close connection handle
_WinHttpCloseHandle($hConnect)
; Close session handle
_WinHttpCloseHandle($hOpen)

; See what's returned (in default browser or whatever)
If $sRead Then
	MsgBox(64 + 262144, "Done!", "Will open returned page in your default browser now." & @CRLF & _
			"When you close that window another example will run.")
	$hFileHTM = FileOpen($sFileHTM, 2)
	FileWrite($hFileHTM, $sRead)
	FileClose($hFileHTM)
	ShellExecuteWait($sFileHTM)
EndIf


;=====================================================================================================================
If MsgBox(262148, "Example 2", "Run new example?") = 7 Then Exit

; Example 2:
;    1. Open w3schools forms page (http://www.w3schools.com/html/html_forms.asp)
;    2. Fill form on that page with these values/conditins:
;         - form is to be identifide by its name "input0"
;         - set "OMG!!!" data to input box. Locate input box by its name "user"
;         - gather data

; Initialize and get session handle
$hOpen = _WinHttpOpen()
; Get connection handle
$hConnect = _WinHttpConnect($hOpen, "w3schools.com")
; Fill form on this page
$sRead = _WinHttpSimpleFormFill($hConnect, "html/html_forms.asp", "name:input0", "name:user", "OMG!!!")
; Close connection handle
_WinHttpCloseHandle($hConnect)
; Close session handle
_WinHttpCloseHandle($hOpen)

If $sRead Then
	MsgBox(64 + 262144, "Done!", "Will open returned page in your default browser now." & @CRLF & _
			"You should see 'OMG!!!' or 'OMG%21%21%21' (encoded version) somewhere on that page.")
	$hFileHTM = FileOpen($sFileHTM, 2)
	FileWrite($hFileHTM, $sRead)
	FileClose($hFileHTM)
	ShellExecuteWait($sFileHTM)
EndIf


;=====================================================================================================================
If MsgBox(262148, "Example 3", "Run new example?") = 7 Then Exit

; Example 3:
;    1. Open cs.tut.fi forms page (http://www.cs.tut.fi/~jkorpela/forms/testing.html)
;    2. Fill form on that page with these values/conditins:
;         - form is to be identifide by its index, It's first form on the page, i.e. index is 0
;         - set "Johnny B. Goode" data to textarea. Locate it by its name "Comments".
;         - check the checkbox. Locate it by name "box". Checked value is "yes".
;         - set "This is hidden, so what?" data to input field identified by name "hidden field".
;         - gather data

; Initialize and get session handle
$hOpen = _WinHttpOpen()
; Get connection handle
$hConnect = _WinHttpConnect($hOpen, "www.cs.tut.fi")
; Fill form on this page
$sRead = _WinHttpSimpleFormFill($hConnect, "~jkorpela/forms/testing.html", "index:0", "name:Comments", "Johnny B. Goode", "name:box", "yes", "name:hidden field", "This is hidden, so what?")
; Close connection handle
_WinHttpCloseHandle($hConnect)
; Close session handle now that's no longer needed
_WinHttpCloseHandle($hOpen)

If $sRead Then
	MsgBox(64 + 262144, "Done!", "Will open returned page in your default browser now." & @CRLF & _
			"It should show sent data.")
	$hFileHTM = FileOpen($sFileHTM, 2)
	FileWrite($hFileHTM, $sRead)
	FileClose($hFileHTM)
	ShellExecuteWait($sFileHTM)
EndIf


;=====================================================================================================================
If MsgBox(262148, "Example 4", "Run new example?") = 7 Then Exit

; Example 4:
;    1. Open yahoo mail login page (https://login.yahoo.com/config/login_verify2?&.src=ym)
;    2. Fill form on that page with these values/conditins:
;         - form is to be identifide by its name, Name is "login_form"
;         - set "MyUserName" data to user-name input box. Locate input box by its Id "username"
;         - set "MyPassword" data to password input box. Locate input box by its Id "passwd"
;         - gather data

; Initialize and get session handle
$hOpen = _WinHttpOpen()
; Get connection handle
$hConnect = _WinHttpConnect($hOpen, "login.yahoo.com")
; Fill form on this page
$sRead = _WinHttpSimpleFormFill($hConnect, "config/login_verify2?&.src=ym", "name:login_form", "username", "MyUserName", "passwd", "MyPassword")
;Close connection handle
_WinHttpCloseHandle($hConnect)
; Close session handle
_WinHttpCloseHandle($hOpen)

;Print returned:
ConsoleWrite($sRead & @CRLF)
MsgBox(262144, "The End", "Source of the last example is printed to console." & @CRLF & _
 "In case valid login data was passed it will be user's mail page on yahoo.mail")


