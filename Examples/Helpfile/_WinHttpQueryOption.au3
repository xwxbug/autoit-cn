#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Initialize and get session handle
Global $hOpen = _WinHttpOpen()

; Set User-Agent string
_WinHttpSetOption($hOpen, $WINHTTP_OPTION_USER_AGENT, "Who the fuc*k is Alice???")

; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, "google.com")

; Specify the reguest
Global $hRequest = _WinHttpOpenRequest($hConnect)

; Send request
_WinHttpSendRequest($hRequest)

; Check what User-Agent string was used
ConsoleWrite("! Custom agent: " & _WinHttpQueryOption($hOpen, $WINHTTP_OPTION_USER_AGENT) & @CRLF & @CRLF)

; Wait for the response
_WinHttpReceiveResponse($hRequest)

Global $sHeader
; If there is data available...
If _WinHttpQueryDataAvailable($hRequest) Then $sHeader = _WinHttpQueryHeaders($hRequest) ; ...get full header

; Clean
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; Display retrieved header
ConsoleWrite($sHeader & @CRLF)