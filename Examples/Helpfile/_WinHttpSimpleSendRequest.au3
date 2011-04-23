#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Initialize and get session handle
Global $hOpen = _WinHttpOpen()
; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, "w3schools.com")
; Make a request
Global $hRequest = _WinHttpSimpleSendRequest($hConnect, Default, "tags/tag_input.asp")

If $hRequest Then
	; Simple-read...
	ConsoleWrite(_WinHttpSimpleReadData($hRequest) & @CRLF)
	MsgBox(64, "Okey do!", "Returned source is print to concole. Check it.")
Else
	MsgBox(48, "Error", "Error ocurred for _WinHttpSimpleSendRequest, Error number is " & @error)
EndIf

; Close handles
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)