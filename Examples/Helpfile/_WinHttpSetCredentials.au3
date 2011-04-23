#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; !!! The result of this script will be this sent to the server:
#cs
	POST /admin.php HTTP/1.1
	Connection: Keep-Alive
	Accept: text/html, application/xhtml+xml, application/xml;q=0.9, */*;q=0.8
	User-Agent: AutoIt/3.3
	Content-Length: 0
	Host: 127.0.0.1
	Authorization: Basic YWRtaW46YWRtaW4=
#ce

; My server
Global $sLocalIP = "127.0.0.1"
; Initialize and get session handle
Global $hOpen = _WinHttpOpen()
; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, $sLocalIP)
; Specify the reguest
Global $hRequest = _WinHttpOpenRequest($hConnect, _
		"POST", _ ; verb
		"admin.php", _ ; object
		Default, _ ; version
		Default, _ ; referrer
		"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8") ; accept types

; Set credentials
_WinHttpSetCredentials($hRequest, $WINHTTP_AUTH_TARGET_SERVER, $WINHTTP_AUTH_SCHEME_BASIC, "admin", "admin")

; Send request
_WinHttpSendRequest($hRequest)
; Wait for the response
_WinHttpReceiveResponse($hRequest)

; .... The rest of the code here...

; Close handles
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)