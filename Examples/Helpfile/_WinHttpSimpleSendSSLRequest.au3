#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Welcome to California. CALIFORNIA DEPARTMENT OF MOTOR VEHICLES
Global $sDomain = "eg.dmv.ca.gov"
Global $sPage = "foa/welcome.do"

; Initialize and get session handle
Global $hOpen = _WinHttpOpen()
; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, $sDomain)

; Make a SimpleSSL request
Global $hRequestSSL = _WinHttpSimpleSendSSLRequest($hConnect, Default, $sPage)

; Read...
Global $sReturned = _WinHttpSimpleReadData($hRequestSSL)
; Close handles
_WinHttpCloseHandle($hRequestSSL)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; See what's returned
ConsoleWrite($sReturned & @CRLF)
MsgBox(64 + 262144, "Done", "Page source is printed to console")