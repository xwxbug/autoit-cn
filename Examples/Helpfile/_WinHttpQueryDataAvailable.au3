#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Initialize and get session handle
Global $hOpen = _WinHttpOpen()
; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, "google.com")
; Specify the reguest
Global $hRequest = _WinHttpOpenRequest($hConnect)
; Send request
_WinHttpSendRequest($hRequest)

; Wait for the response
_WinHttpReceiveResponse($hRequest)

; Check there is data available...
If _WinHttpQueryDataAvailable($hRequest) Then
    MsgBox(64, "OK", "Data from google.com is available!")
Else
	MsgBox(48, "Error", "Site is experiencing problems (or you).")
EndIf

; Clean
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

