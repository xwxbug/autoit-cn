#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; !!!Note that this example will fail because of invalid username and password!!!

Global $sAddress = "secure.imdb.com"
Global $sUserName = "SomeUserName"
Global $sPassword = "SomePassword"
; Post data:
Global $sPostData = "login=" & $sUserName & "&password=" & $sPassword & "&u=https%3A%2F%2Fsecure.imdb.com%2Fregister-imdb%2Flogin"

; Initialize and get session handle
Global $hOpen = _WinHttpOpen("Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1) Gecko/20090624 Firefox/3.5")

; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, $sAddress, $INTERNET_DEFAULT_HTTPS_PORT)

; Make a request
Global $hRequest = _WinHttpOpenRequest($hConnect, _
		"POST", _
		"register-imdb/login", _
		Default, _
		Default, _
		"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", _
		$WINHTTP_FLAG_SECURE)

; Add header fields to the request
_WinHttpAddRequestHeaders($hRequest, "Accept-Language: en-us,en;q=0.5")
_WinHttpAddRequestHeaders($hRequest, "Content-Type: application/x-www-form-urlencoded")
_WinHttpAddRequestHeaders($hRequest, "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7")
_WinHttpAddRequestHeaders($hRequest, "Keep-Alive: 300")
_WinHttpAddRequestHeaders($hRequest, "Connection: keep-alive")

; Send it
_WinHttpSendRequest($hRequest, -1, $sPostData)
; Wait for the response
_WinHttpReceiveResponse($hRequest)
; Check if there is a response
Global $sHeader, $sReturned
If _WinHttpQueryDataAvailable($hRequest) Then
	$sHeader = _WinHttpQueryHeaders($hRequest)
	MsgBox(64, "Header", $sHeader)
	Do
		$sReturned &= _WinHttpReadData($hRequest)
	Until @error
	; Print returned
	ConsoleWrite($sReturned)
Else
	ConsoleWriteError("!No data available." & @CRLF)
	MsgBox(48, "Failure", "No data available.")
EndIf

; Close handles
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)
