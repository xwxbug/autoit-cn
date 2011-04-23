#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Initialize
Global $hOpen = _WinHttpOpen()
; Specify what to connect to
Global $hConnect = _WinHttpConnect($hOpen, "en.wikipedia.org")
; Create request
Global $hRequest = _WinHttpOpenRequest($hConnect, -1, "wiki/Manchester_United_F.C.")
; Send it
_WinHttpSendRequest($hRequest)

; Wait for the response
_WinHttpReceiveResponse($hRequest)
If @error Then
	MsgBox(48, "Error", "Error ocurred for WinHttpReceiveResponse, Error number is " & @error)
Else
	MsgBox(64, "All right!", "Server at 'en.wikipedia.org' processed the request.")
EndIf

; Close handles
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

