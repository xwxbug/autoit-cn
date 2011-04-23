#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Open needed handles
Global $hOpen = _WinHttpOpen()

; Set timeouts
_WinHttpSetTimeouts($hOpen, 10, 10, 10, 10)

; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, "msdn.microsoft.com")
; Specify the reguest:
Global $hRequest = _WinHttpOpenRequest($hConnect, Default, "en-us/library/aa384101(VS.85).aspx")

; Send request
_WinHttpSendRequest($hRequest)

; Wait for the response
_WinHttpReceiveResponse($hRequest)

Global $sHeader
; If there is data available...
If _WinHttpQueryDataAvailable($hRequest) Then
	$sHeader = _WinHttpQueryHeaders($hRequest) ; ...get full header
	; Display retrieved header
	MsgBox(0, "Header", $sHeader)
Else
	; Display retrieved header
	MsgBox(48, "Failure", "Maybe the new timeouts are unrealistic  ;)")
EndIf

; Clean
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)