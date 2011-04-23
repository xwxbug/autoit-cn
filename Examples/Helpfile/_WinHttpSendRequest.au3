#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; !!!Note that this example will fail because of invalid username and password!!!

Global $sUserName = "SomeUserName"
Global $sPassword = "SomePassword"
Global $sDomain = "www.google.com"
Global $sPage = "accounts/ClientLogin"
; Visit http://code.google.com/apis/accounts/docs/AuthForInstalledApps.html for more informations
Global $sAdditionalData = "accountType=HOSTED_OR_GOOGLE&Email=" & $sUserName & "&Passwd=" & $sPassword & "&service=mail&source=Gulp-CalGulp-1.05"

; Initialize and get session handle
Global $hOpen = _WinHttpOpen("Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6")

; Get connection handle
Global $hConnect = _WinHttpConnect($hOpen, $sDomain)

; Make a request
Global $hRequest = _WinHttpOpenRequest($hConnect, "POST", $sPage, -1, -1, -1, $WINHTTP_FLAG_SECURE)

; Send it. Specify additional data to send too. This is required by the Google API:
_WinHttpSendRequest($hRequest, "Content-Type: application/x-www-form-urlencoded", $sAdditionalData)

; Wait for the response
_WinHttpReceiveResponse($hRequest)

; See what's returned
Global $sReturned
If _WinHttpQueryDataAvailable($hRequest) Then ; if there is data
	Do
		$sReturned &= _WinHttpReadData($hRequest)
	Until @error
EndIf

; Close handles
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; See what's returned
MsgBox(0, "Returned", $sReturned)