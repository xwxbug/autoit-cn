#include-once

; #INDEX# =======================================================================================================================
; Title .........: Debug
; AutoIt Version : 3.2.3++
; Language ......: English
; Description ...: Functions to help script debugging.
; Author(s) .....: Nutster, Jpm, Valik
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $g_hWndDbg = 0 ; Variable to keep track of the Notepad window used for Debug output.
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_Assert
;_DebugBugReportEnv
;_DebugOut
;_DebugSetup
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _Assert
; Description ...: Display a message if assertion fails.
; Syntax.........:  _Assert($bCondition, $sMsg, $bExit = True, $nCode = 0x7FFFFFFF, $sLine = @ScriptLineNumber)
; Parameters ....: $sCondition - IN - The condition that must evaluate to true.
;                  $bExit - IN/OPTIONAL - If true, the script is aborted.
;                  $nCode - IN/OPTIONAL - The exit code to use if the script is aborted.
;                  $sLine - IN/OPTIONAL - Displays the line number where the assertion failed.  If this value is not
;                                         changed, then the default value will show the correct line.
; Return values .: The result of the condition (Only valid when not exiting).
; Author ........: Valik
; Modified.......: jpm
; Remarks .......: @error and @extended are not destroyed on return.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _Assert($sCondition, $bExit = True, $nCode = 0x7FFFFFFF, $sLine = @ScriptLineNumber, Const $curerr = @error,  Const $curext = @extended)
Local $bCondition = Execute($sCondition)
If Not $bCondition Then
		MsgBox(16+262144, "Autoit Assert", "Assertion Failed (Line " & $sLine & "): " & @CRLF & @CRLF & $sCondition)
		If $bExit Then Exit $nCode
	EndIf
	Return SetError($curerr, $curext, $bCondition)
EndFunc	; _Assert()

; #FUNCTION# ====================================================================================================================
; Name...........: _DebugBugReportEnv
; Description ...: Outputs a string containing information for Bug report submission.
; Syntax.........: _DebugBugReportEnv()
; Parameters ....:
; Return values .: Returns a string containing all information needed to submit.
; Author ........: Jean-Paul Mesnage (jpm)
; Modified.......:
; Remarks .......: @error and @extended are not destroyed on return
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _DebugBugReportEnv(Const $curerr = @error, Const $curext = @extended)
	Local $AutoItX64 = ""
	If @AutoItX64 Then $AutoItX64 = " X64"
	Local $Compiled = ""
	If @Compiled Then $Compiled = " Compiled"
	Local $OsServicePack = ""
	If @OSServicePack Then $OsServicePack = "/" & @OSServicePack
	Return SetError($curerr, $curext, "Environment = " & @AutoItVersion & $AutoItX64 & $Compiled & " under  " & @OSVersion & $OsServicePack & " " & @OSArch)
EndFunc   ;==>_DebugBugReportEnv

; #FUNCTION# ====================================================================================================================
; Name...........: _DebugOut
; Description ...: Outputs a string to the Notepad window setup by _DebugSetup.
; Syntax.........: _DebugOut(Const $sOutput, Const $bActivate)
; Parameters ....: $sOutput = The string (or other printable value) to be output to the Notepad window.
;                  $bActivate = (Optional) True/False flag that inidicates that the Notepad window should be activated before sending characters.  This is needed if another window is activated during the main script.
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No error.
;                  |1 - $sOutput is an incompatible type.
;                  |2 - $bActivate is an incompatible type.
;                  |3 - _DebugSetup() did not run properly.  Make sure _DebugSetup() ran properly before calling this function.
;                  |4 - The Notepad window has been closed.  Output can not occur.
; Author ........: David Nuttall (Nutster)
; Modified.......:
; Remarks .......: Before calling this function, _DebugSetup must be called first to create the Notepad window.
; Related .......: _DebugSetup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _DebugOut(Const $sOutput, Const $bActivate = False, Const $curerr = @error, Const $curext = @extended)
	If IsNumber($sOutput) = 0 And IsString($sOutput) = 0 And IsBool($sOutput) = 0 Then
		Return SetError(1, 0, 0) ; $sOutput can not be printed
	ElseIf IsBool($bActivate) = False And IsNumber($bActivate) = False Then
		Return SetError(2, 0, 0) ; The $bActivate flag is set to an invalid type.  Must be able to convert to Bool.
	ElseIf IsHWnd($g_hWndDbg) = 0 Then
		Return SetError(3, 0, 0) ; Window was not assigned.
	ElseIf WinExists($g_hWndDbg) = 0 Then
		Return SetError(4, 0, 0) ; The Notepad window no longer exists
	Else
		If $bActivate Then WinActivate($g_hWndDbg)
		ControlCommand($g_hWndDbg, "", "Edit1", "EditPaste", String($sOutput) & @CRLF)
		Return SetError($curerr, $curext, 1) ; Return @error and @extende as before calling _DebugOut()
	EndIf
EndFunc   ;==>_DebugOut

; #FUNCTION# ====================================================================================================================
; Name...........: _DebugSetup
; Description ...: Sets up a debug session using a Microsoft Notepad window as the output target.
; Syntax.........: _DebugSetup(Const $sTitle)
; Parameters ....: $sTitle = (Optional) Title to be displayed on the Notepad window.  Default value is "Debug Info".
;                  $bBugReportInfos = (Optional) Display BugReport infos.  Default value is false.
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No error.
;                  |1 - $sTitle is an incompatable type.
;                  |2 - Another debug session is open.  Use it instead.
;                  |3 - Another Untitled MS-Notepad window is already open.  Save it or close it before continuing.
; Author ........: David Nuttall (Nutster)
; Modified.......: Jean-Paul Mesnage (jpm)
; Remarks .......: This must be called in your program before any _DebugOut() calls.
;                  Microsoft Notepad in the %PATH%
; Related .......: _DebugOut
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _DebugSetup(Const $sTitle = "Debug Info", Const $bBugReportInfos = False)
	Local $pNotepad ; process ID of the Notepad started by this function

	If $g_hWndDbg = 0 And WinExists($sTitle) Then
		; notepad started by an another script use it
		$g_hWndDbg = WinGetHandle($sTitle)
	EndIf
	If IsNumber($sTitle) = 0 And IsString($sTitle) = 0 And IsBool($sTitle) = 0 Then
		Return SetError(1, 0, 0) ; Not any of the acceptable types.
	ElseIf IsHWnd($g_hWndDbg) Then
		; Another session already started
		If WinExists($g_hWndDbg) Then
			Return SetError(2, 0, 0) ; The session is still active
		Else
			; Reset the session and assign new hWnd.
		EndIf
	EndIf

	$pNotepad = Run("Notepad.exe")
	$g_hWndDbg = WinWait("[CLASS:Notepad]")
	If $pNotepad <> WinGetProcess($g_hWndDbg) Then
		Return SetError(3, 0, 0)
	EndIf

	WinActivate($g_hWndDbg)
	WinSetTitle($g_hWndDbg, "", String($sTitle))
	If $bBugReportInfos Then _DebugOut(_DebugBugReportEnv() & @CRLF)
	Return 1
EndFunc   ;==>_DebugSetup
