#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Initialize and get session handle
Global $hOpen = _WinHttpOpen()
; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, "thetimes.co.uk")
; Request
Global $hRequest = _WinHttpSimpleSendRequest($hConnect)

; Simple-read...
Global $sRead = _WinHttpSimpleReadData($hRequest)
MsgBox(64, "Returned (first 1100 characters)", StringLeft($sRead, 1100) & "...")

; Close handles
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)