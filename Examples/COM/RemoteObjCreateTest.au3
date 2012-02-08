; AutoItCOM 3.1.1
;
; Test file
;
; Test usage of creating objects on a remote computer
;
; Notes:
;
;- The remote Object must have DCOM (Distributed COM) functionality.
;- The remote computer must have 'Remote Registry Service' and 'File and Printersharing' turned on!
;
; To check for any DCOM-Enabled Objects, use DCOMCNFG.EXE (=Component Services MMC) on the remote computer.

Local $RemoteComputer = "REMOTE" ; Change this to your remote computer name
Local $RemoteUsername = "REMOTE\Administrator" ; Change this to your username on the remote computer
Local $RemotePassword = "123456" ; Change this to your password on the remote computer

; First install our own Error Handler
Global $g_nCOMError = 0, $oErrObj = ObjEvent("AutoIt.Error", "MyErrFunc")

; Open MediaPlayer on a remote computer
Local $oRemoteMedia = ObjCreate("MediaPlayer.MediaPlayer.1", $RemoteComputer, $RemoteUsername, $RemotePassword)

If @error Then
	MsgBox(0, "Remote ObjCreate Test", "Failed to open remote Object. Error code: " & Hex(@error, 8))
	Exit
EndIf

MsgBox(0, "Remote Test", "ObjCreate() of a remote object successfull !")


Local $Enabled = $oRemoteMedia.IsSoundCardEnabled

If Not @error Then
	MsgBox(0, "Remote Test", "Invoking a method on a remote Object successfull!" & @CRLF & _
			"Result of 'IsSoundCardEnabled?':  " & $Enabled)
	If $Enabled = -1 Then
		$oRemoteMedia.Open("c:\windows\media\Windows XP Startup.wav")
		If Not @error Then MsgBox(0, "Remote Test", "Playing sound on a remote computer successful !")
	EndIf
Else
	MsgBox(0, "Remote Test", "Invoking a method on a remote Object Failed !")
EndIf


Exit


; ------------------------
; My custom error function

Func MyErrFunc()

	Local $hexnum = Hex($oErrObj.number, 8)

	MsgBox(0, "", "We intercepted a COM Error!!" & @CRLF & @CRLF & _
			"err.description is: " & $oErrObj.description & @CRLF & _
			"err.windescription is: " & $oErrObj.windescription & @CRLF & _
			"err.lastdllerror is: " & $oErrObj.lastdllerror & @CRLF & _
			"err.scriptline is: " & $oErrObj.scriptline & @CRLF & _
			"err.number is: " & $hexnum & @CRLF & _
			"err.source is: " & $oErrObj.source & @CRLF & _
			"err.helpfile is: " & $oErrObj.helpfile & @CRLF & _
			"err.helpcontext is: " & $oErrObj.helpcontext _
			)

	$g_nCOMError = $oErrObj.number
EndFunc   ;==>MyErrFunc
