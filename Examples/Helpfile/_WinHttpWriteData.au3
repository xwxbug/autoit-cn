#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Initialize and get session handle
Global $hOpen = _WinHttpOpen()
; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, "www.snee.com")
; Specify the reguest
Global $hRequest = _WinHttpOpenRequest($hConnect, "POST", "xml/crud/posttest.cgi?sgs")

Global $sPostData = "Additional data to send"
; Send request
_WinHttpSendRequest($hRequest, Default, Default, StringLen($sPostData))

; Write additional data to send
_WinHttpWriteData($hRequest, $sPostData)

; Wait for the response
_WinHttpReceiveResponse($hRequest)

; Check if there is data available...
If _WinHttpQueryDataAvailable($hRequest) Then
	MsgBox(64, "OK", _WinHttpReadData($hRequest))
Else
	MsgBox(48, "Error", "Site is experiencing problems (or you).")
EndIf

; Close handles
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)
