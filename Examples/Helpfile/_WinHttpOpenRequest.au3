#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; !!!Note that this example will fail because of invalid username and password!!!

; Authentication data
Global $sUsername = "UserName"
Global $sPassword = "Password"

; Address
Global $sAddress = "space.livevn.com"

; Initialize and get session handle
Global $hOpen = _WinHttpOpen()

; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, $sAddress)

; Request
Global $hRequest = _WinHttpOpenRequest($hConnect, _
		"POST", _ ; verb
		"/do.php?ac=71ee30ae117cddace55bd01714904227&&ref", _  ; target
		Default, _ ; version
		"http://space.livevn.com/index.php", _  ; referer
		"*/*") ; accept

; Send it
_WinHttpSendRequest($hRequest, _
		"Content-Type: application/x-www-form-urlencoded" & @CRLF, _
		"username=" & $sUsername & "&password=" & $sPassword & "&loginsubmit=&loginsubmit=loginnnnnnnnnnn&refer=network.html&formhash=c51a94db")

; Wait for the response
_WinHttpReceiveResponse($hRequest)

; See what's returned
If _WinHttpQueryDataAvailable($hRequest) Then
	Global $sHeader = _WinHttpQueryHeaders($hRequest)
	ConsoleWrite($sHeader & @CRLF)
	; Check if proper cookie is given
	If StringInStr($sHeader, 'Set-Cookie: uchome_loginuser=' & $sUsername) Then
		MsgBox(0, "", "Login success")
	Else
		MsgBox(0, "", "Login failed")
	EndIf
Else
	MsgBox(48, "Error", "Site is experiencing problems.")
EndIf


; Close open handles and exit
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)