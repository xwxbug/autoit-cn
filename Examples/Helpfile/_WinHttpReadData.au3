#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Initialize
Global $hOpen = _WinHttpOpen()

If @error Then
	MsgBox(48, "Error", "Error initializing the usage of WinHTTP functions.")
	Exit 1
EndIf

; Specify what to connect to
Global $hConnect = _WinHttpConnect($hOpen, "yahoo.com") ; <- yours here
If @error Then
	MsgBox(48, "Error", "Error specifying the initial target server of an HTTP request.")
	_WinHttpCloseHandle($hOpen)
	Exit 2
EndIf

; Create request
Global $hRequest = _WinHttpOpenRequest($hConnect)
If @error Then
	MsgBox(48, "Error", "Error creating an HTTP request handle.")
	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)
	Exit 3
EndIf

; Send it
_WinHttpSendRequest($hRequest)
If @error Then
	MsgBox(48, "Error", "Error sending specified request.")
	_WinHttpCloseHandle($hRequest)
	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)
	Exit 4
EndIf

; Wait for the response
_WinHttpReceiveResponse($hRequest)
If @error Then
	MsgBox(48, "Error", "Error waiting for the response from the server.")
	_WinHttpCloseHandle($hRequest)
	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)
	Exit 5
EndIf

; See if there is data to read
Global $sChunk, $sData
If _WinHttpQueryDataAvailable($hRequest) Then
	; Read
	While 1
		$sChunk = _WinHttpReadData($hRequest)
		If @error Then ExitLoop
		$sData &= $sChunk
	WEnd
	ConsoleWrite($sData & @CRLF) ; print to console
Else
	MsgBox(48, "Error", "Site is experiencing problems.")
EndIf

; Close handles when they are not needed any more
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)