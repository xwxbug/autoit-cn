#include-once

#include <Date.au3>
#include <File.au3>
#include <String.au3>

; #INDEX# =======================================================================================================================
; Title .........: Sound
; AutoIt Version : 3.2 ++
; Language ......: English
; Description ...: Functions that assist with Sound management.
; Author(s) .....: RazerM, Melba23, Simucal, PsaltyDS
; Dll ...........: winmm.dll
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundOpen
; Description ...: Opens a sound file for use with other _Sound functions
; Syntax.........: _SoundOpen($sFile[, $sAlias = ""])
; Parameters ....: $sFile - The sound file, $sAlias[optional] - a name such as sound1,
;				   if you do not specify one it is randomly generated
; Return values .: Success      - string (the sound id)
;                  Failure      - 0
;				   @extended <> 0 - open failed, @error = 2 - File doesn't exist,
;				   @error = 3 - alias contains whitespace
; Author ........: RazerM, Melba23, some code by Simucal, PsaltyDS
; Modified.......: 
; Remarks .......:
; Related .......: _SoundClose, _SoundLength, _SoundPause, _SoundPlay, _SoundPos, _SoundResume, _SoundStatus, _SoundStop
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundOpen($sFile, $sAlias = "")
	;Declare variables
	Local $aSndID[3], $sSndID, $iCurrentPos, $iRet, $asAlias, $fTryNextMethod = False, $hFile
	Local $szDrive, $szDir, $szFName, $szExt, $iSndLenMs, $iSndLenMin, $iSndLenHour, $iSndLenSecs
	Local $sSndDirName, $sSndFileName, $sSndDirShortName, $oShell, $oShellDir, $oShellDirFile, $sRaw, $aInfo
	Local $sTrackLength, $iSoundTicks, $iActualTicks, $iVBRRatio, $aiTime, $sTag
	
	;check for file
	If Not FileExists($sFile) Then Return SetError(2, 0, 0)
	;search for whitespace by character
	$asAlias = StringSplit($sAlias, "")
	For $iCurrentPos = 1 To $asAlias[0]
		If StringIsSpace($asAlias[$iCurrentPos]) Then Return SetError(3, 0, 0)
	Next
	;create random alias if one is not supplied
	If $sAlias = "" Then
		$sSndID = __RandomStr(10)
	Else
		$sSndID = $sAlias
	EndIf
	
	If StringInStr($sSndID, '!') Then Return SetError(3, 0, 0) ;invalid file/alias
	
	$aSndID[0] = $sSndID
	
	_PathSplit($sFile, $szDrive, $szDir, $szFName, $szExt)

	If $szDrive = "" Then
		$sSndDirName = @WorkingDir & "\"
	Else
		$sSndDirName = $szDrive & $szDir
	EndIf
	$sSndFileName = $szFName & $szExt

	$sSndDirShortName = FileGetShortName($sSndDirName, 1)

	;open file
	$iRet = __mciSendString("open " & FileGetShortName($sFile) & " alias " & $aSndID[0])

	$oShell = ObjCreate("shell.application")
	If IsObj($oShell) Then
		$oShellDir = $oShell.NameSpace($sSndDirShortName)
		If IsObj($oShellDir) Then
			$oShellDirFile = $oShellDir.Parsename($sSndFileName)
			If IsObj($oShellDirFile) Then
				$sRaw = $oShellDir.GetDetailsOf($oShellDirFile, -1)
				$aInfo = StringRegExp($sRaw, ": ([0-9]{2}:[0-9]{2}:[0-9]{2})", 3)
				If Not IsArray($aInfo) Then
					$fTryNextMethod = True
				Else
					$sTrackLength = $aInfo[0]
				EndIf
			Else
				$fTryNextMethod = True
			EndIf
		Else
			$fTryNextMethod = True
		EndIf
	Else
		$fTryNextMethod = True
	EndIf
	
	If $fTryNextMethod Then
		$fTryNextMethod = False
		If $szExt = ".mp3" Then
			$hFile = FileOpen(FileGetShortName($sSndDirName & $sSndFileName), 4)
			$sTag = FileRead($hFile, 5156)
			FileClose($hFile)
			$sTrackLength = __ReadXingFromMP3($sTag)
			If @error Then $fTryNextMethod = True
		Else
			$fTryNextMethod = True
		EndIf
	EndIf
	
	If $fTryNextMethod Then
		$fTryNextMethod = False
		If $szExt = ".mp3" Then
			$sTrackLength = __ReadTLENFromMP3($sTag)
			If @error Then $fTryNextMethod = True
		Else
			$fTryNextMethod = True
		EndIf
	EndIf
	FileClose($hFile)

	If $fTryNextMethod Then
		$fTryNextMethod = False
		;tell mci to use time in milliseconds
		__mciSendString("set " & $aSndID[0] & " time format miliseconds")
		;receive length of sound
		$iSndLenMs = __mciSendString("status " & $aSndID[0] & " length", 255)
		
		;assign modified data to variables
		_TicksToTime($iSndLenMs, $iSndLenHour, $iSndLenMin, $iSndLenSecs)
		
		;assign formatted data to $sSndLenFormat
		$sTrackLength = StringFormat("%02i:%02i:%02i", $iSndLenHour, $iSndLenMin, $iSndLenSecs)
	EndIf
	
	; Convert Track_Length to mSec
	$aiTime = StringSplit($sTrackLength, ":")
	$iActualTicks = _TimeToTicks($aiTime[1], $aiTime[2], $aiTime[3])
	
	;tell mci to use time in milliseconds
	__mciSendString("set " & $aSndID[0] & " time format miliseconds")
	
	;;Get estimated length
	$iSoundTicks = __mciSendString("status " & $aSndID[0] & " length", 255)

	;Compare to actual length
	If Abs($iSoundTicks - $iActualTicks) < 1000 Then ;Assume CBR, as our track length from shell.application is only accurate within 1000ms
		$iVBRRatio = 0
	Else ;Set correction ratio for VBR operations
		$iVBRRatio = $iSoundTicks / $iActualTicks
	EndIf
	
	$aSndID[1] = $iVBRRatio
	$aSndID[2] = 0

	Return SetError($iRet<>0, $iRet, $aSndID)
EndFunc   ;==>_SoundOpen

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundClose
; Description ...: Closes a sound
; Syntax.........: _SoundClose($aFile)
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen
; Return values .: Success      - 1
;                  Failure      - 0 and @error =1
; Author ........: RazerM, Melba23
; Modified.......: 
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundClose($aSndID)
	If Not IsArray($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias

	If __mciSendString("close " & $aSndID[0]) = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundClose

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundPlay
; Description ...: Plays a sound from the current position (beginning is the default)
; Syntax.........:_SoundPlay($aSndID[, $fWait = 0])
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen or sound file
;				   $fWait - If set to 1 the script will wait for the sound to finish before continuing
; Return values .: Success      - 1
;                  Failure      - 0, @error = 1 - play failed, @error = 2 - $fWait is invalid
; Author ........: RazerM, Melba23
; Modified.......: 
; Remarks .......:
; Related .......: _SoundPause, _SoundStop, _SoundSeek, _SoundOpen, _SoundResume
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundPlay($aSndID, $fWait = 0)
	;Declare variables
	Local $iRet, $vTemp
	;validate $fWait
	If $fWait <> 0 And $fWait <> 1 Then Return SetError(2, 0, 0)
	If Not IsArray($aSndID) Then
		If Not FileExists($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
		$vTemp = FileGetShortName($aSndID)
		Dim $aSndID[3] = [$vTemp,0,0]
	EndIf
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias

	;if sound has finished, seek to start
	If _SoundPos($aSndID, 2) = _SoundLength($aSndID, 2) Then __mciSendString("seek " & $aSndID[0] & " to start")
	;If $fWait = 1 then pass wait to mci
	If $fWait = 1 Then
		$iRet = __mciSendString("play " & $aSndID[0] & " wait")
	Else
		$iRet = __mciSendString("play " & $aSndID[0])
	EndIf
	;return
	If $iRet = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundPlay

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundStop
; Description ...: Stops the sound
; Syntax.........: _SoundClose($sFile)
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen or sound file
; Return values .: Success      - 1
;                  Failure      - 0 and @error = 1
; Author ........: RazerM, Melba23
; Modified.......: 
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundStop($aSndID)
	;Declare variables
	Local $iRet, $iRet2, $vTemp
	If Not IsArray($aSndID) Then
		If Not FileExists($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
		$vTemp = FileGetShortName($aSndID)
		Dim $aSndID[3] = [$vTemp, 0,0]
	EndIf
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias

	;seek to start
	$iRet = __mciSendString("seek " & $aSndID[0] & " to start")
	;stop
	$iRet2 = __mciSendString("stop " & $aSndID[0])
	;return
	If $iRet = 0 And $iRet2 = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundStop

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundPause
; Description ...: Pauses the sound
; Syntax.........: _SoundPause($aSndID)
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen or sound file
; Return values .: Success      - 1
;                  Failure      - 0 and @error = 1
; Author ........: RazerM, Melba23
; Modified.......: 
; Remarks .......:
; Related .......: _SoundResume, _SoundOpen, _SoundPlay
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundPause($aSndID)
	;Declare variables
	Local $iRet, $vTemp
	If Not IsArray($aSndID) Then
		If Not FileExists($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
		$vTemp = FileGetShortName($aSndID)
		Dim $aSndID[3] = [$vTemp, 0,0]
	EndIf
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias

	;pause sound
	$iRet = __mciSendString("pause " & $aSndID[0])
	;return
	If $iRet = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundPause

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundResume
; Description ...: Resumes the sound after being paused
; Syntax.........: _SoundResume($aSndID)
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen or sound file
; Return values .: Success      - 1
;                  Failure      - 0 and @error = 1
; Author ........: RazerM, Melba23
; Modified.......: 
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundResume($aSndID)
	;Declare variables
	Local $iRet, $vTemp
	If Not IsArray($aSndID) Then
		If Not FileExists($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
		$vTemp = FileGetShortName($aSndID)
		Dim $aSndID[3] = [$vTemp,0,0]
	EndIf
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias

	;resume sound
	$iRet = __mciSendString("resume " & $aSndID[0])
	;return
	If $iRet = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundResume

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundLength
; Description ...: Returns the length of the sound in the format hh:mm:ss
; Syntax.........: _SoundLength($aSndID[, $iMode = 1])
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen or sound file,
;				   $iMode = 1 - hh:mm:ss, $iMode = 2 - milliseconds
; Return values .: Success      - Length of the sound
;                  Failure      - 0 and @error = 1 - $iMode is invalid
; Author ........: RazerM, Melba23
; Modified.......: jpm
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundLength($aSndID, $iMode = 1)
	;Declare variables
	Local $iSndLenMs, $iSndLenMin, $iSndLenHour, $iSndLenSecs, $sSndLenFormat, $vTemp = ""
	;validate $iMode
	If $iMode <> 1 And $iMode <> 2 Then Return SetError(1, 0, 0)
	If Not IsArray($aSndID) Then
		If Not FileExists($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
		$vTemp = FileGetShortName($aSndID)
		Dim $aSndID[3]
		$aSndID = _SoundOpen($vTemp)
	EndIf
	
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias

	;tell mci to use time in milliseconds
	__mciSendString("set " & $aSndID[0] & " time format miliseconds")
	;receive length of sound
	$iSndLenMs = Number(__mciSendString("status " & $aSndID[0] & " length", 255))
	If $aSndID[1] <> 0 Then $iSndLenMs = Round($iSndLenMs / $aSndID[1])
	
	If $vTemp <> "" Then _SoundClose($aSndID) ;if user called _SoundLength with a filename
	
	;assign modified data to variables
	_TicksToTime($iSndLenMs, $iSndLenHour, $iSndLenMin, $iSndLenSecs)
	
	;assign formatted data to $sSndLenFormat
	$sSndLenFormat = StringFormat("%02i:%02i:%02i", $iSndLenHour, $iSndLenMin, $iSndLenSecs)
	
	;return correct variable
	If $iMode = 1 Then Return $sSndLenFormat
	If $iMode = 2 Then Return $iSndLenMs
EndFunc   ;==>_SoundLength

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundSeek
; Description ...: Seeks the sound to a specified time
; Syntax.........:  _SoundSeek(ByRef $aSndID, $iHour, $iMin, $iSec)
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen (must NOT be a file), $iHour, $iMin, $iSec
; Return values .: Success      - 1
;                  Failure      - 0 and @error = 1
; Author ........: RazerM, Melba23
; Modified.......: 
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundSeek(ByRef $aSndID, $iHour, $iMin, $iSec)
	;Declare variables
	Local $iMs = 0, $iRet, $vTemp
	If Not IsArray($aSndID) Then
		If Not FileExists($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
		$vTemp = FileGetShortName($aSndID)
		Dim $aSndID[3] = [$vTemp,0,0]
	EndIf
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias
	
	;prepare mci to receive time in milliseconds
	__mciSendString("set " & $aSndID[0] & " time format miliseconds")
	;modify the $iHour, $iMin and $iSec parameters to be in milliseconds
	;and add to $iMs
	$iMs += $iSec * 1000
	$iMs += $iMin * 60 * 1000
	$iMs += $iHour * 60 * 60 * 1000
	If $aSndID[1] <> 0 Then
		$aSndID[2] = Round($iMs * $aSndID[1]) - $iMs
		$iMs = Round($iMs * $aSndID[1])
	EndIf
	; seek sound to time ($iMs)
	$iRet = __mciSendString("seek " & $aSndID[0] & " to " & $iMs)
	If _SoundPos($aSndID, 2) < 0 Then $aSndID[2] = 0
	;return
	If $iRet = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundSeek

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundStatus
; Description ...: All devices can return the "not ready", "paused", "playing", and "stopped" values.
; Syntax.........: _SoundStatus($aSndID)
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen or sound file
; Return values .: Sound Status
; Author ........: RazerM, Melba23
; Modified.......: 
; Remarks .......: Some devices can return the additional "open", "parked", "recording", and "seeking" values.(MSDN)
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundStatus($aSndID)
	Local $vTemp
	If Not IsArray($aSndID) Then
		If Not FileExists($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
		$vTemp = FileGetShortName($aSndID)
		Dim $aSndID[3] = [$vTemp,0,0]
	EndIf
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias

	;return status
	Return __mciSendString("status " & $aSndID[0] & " mode", 255)
EndFunc   ;==>_SoundStatus

; #FUNCTION# ====================================================================================================================
; Name...........: _SoundPos
; Description ...: Returns the current position of the song
; Syntax.........: _SoundPos($aSndID[, $iMode = 1])
; Parameters ....: $aSndID - Sound ID returned by _SoundOpen or sound file,
;				   $iMode = 1 - hh:mm:ss, $iMode = 2 - milliseconds
; Return values .: Success      - Current Position
;                  Failure      - 0 and @error = 1 - $iMode is invalid
; Author ........: RazerM, Melba23
; Modified.......: 
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _SoundPos($aSndID, $iMode = 1)
	;Declare variables
	Local $iSndPosMs, $iSndPosMin, $iSndPosHour, $iSndPosSecs, $sSndPosFormat, $vTemp
	;validate $iMode
	If $iMode <> 1 And $iMode <> 2 Then Return SetError(1, 0, 0)
	If Not IsArray($aSndID) Then
		If Not FileExists($aSndID) Then Return SetError(3, 0, 0) ; invalid file/alias
		$vTemp = FileGetShortName($aSndID)
		Dim $aSndID[3] = [$vTemp,0,0]
	EndIf
	If StringInStr($aSndID[0], '!') Then Return SetError(3, 0, 0) ; invalid file/alias

	;tell mci to use time in milliseconds
	__mciSendString("set " & $aSndID[0] & " time format miliseconds")
	;receive position of sound
	$iSndPosMs = Number(__mciSendString("status " & $aSndID[0] & " position", 255))
	If $aSndID[1] <> 0 Then
		$iSndPosMs -= $aSndID[2]
	EndIf
	
	;modify data and assign to variables
	_TicksToTime($iSndPosMs, $iSndPosHour, $iSndPosMin, $iSndPosSecs)

	;assign formatted data to $sSndPosFormat
	$sSndPosFormat = StringFormat("%02i:%02i:%02i", $iSndPosHour, $iSndPosMin, $iSndPosSecs)
	;return correct variable
	If $iMode = 1 Then Return $sSndPosFormat
	If $iMode = 2 Then Return $iSndPosMs
EndFunc   ;==>_SoundPos

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __mciSendString
; Description ...: Used internally within this file, not for general use
; Syntax.........: __mciSendString($string[, $iLen = 0])
; Author ........: RazerM, Melba23
; Modified.......: 
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func __mciSendString($string, $iLen = 0)
	Local $iRet
	$iRet = DllCall("winmm.dll", "int", "mciSendStringA", "str", $string, "str", "", "long", $iLen, "long", 0)
	If Not @error Then Return $iRet[2]
EndFunc   ;==>__mciSendString

Func __RandomStr($LEN)
	Local $string
	For $iCurrentPos = 1 To $LEN
		$string &= Chr(Random(97, 122, 1))
	Next
	Return $string
EndFunc   ;==>__RandomStr

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __ReadTLENFromMP3
; Description ...: Used internally within this file, not for general use
; Syntax.........: __ReadTLENFromMP3($sTag)
; Parameters ....: $sTag - >= 1024 bytes from 'read raw' mode.
; Return values .: Success      - Sound length (hh:mm:ss)
;                  Failure      - 0 ans=d @error = 1
; Author ........: Melba23
; Modified.......: RazerM
; Remarks .......: File must be an mp3 AFAIK
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func __ReadTLENFromMP3($sTag)
	Local $iTemp, $sTemp, $iLengthMs, $iLengthHour, $iLengthMin, $iLengthSecs

	; Check that an ID3v2.3 tag is present
	If StringLeft($sTag, 10) <> "0x49443303" Then Return SetError(1, 0, 0)

	$iTemp = StringInStr($sTag, "544C454E") + 21
	$sTag = StringTrimLeft($sTag, $iTemp)
	$sTemp = ""

	For $i = 1 To 32 Step 2
		If StringMid($sTag, $i, 2) = "00" Then
			ExitLoop
		Else
			$sTemp &= StringMid($sTag, $i, 2)
		EndIf
	Next

	$iLengthMs = Number(_HexToString($sTemp))

	If $iLengthMs > 0 Then
		_TicksToTime($iLengthMs, $iLengthHour, $iLengthMin, $iLengthSecs)
		
		;Convert to hh:mm:ss and return
		Return StringFormat("%02i:%02i:%02i", $iLengthHour, $iLengthMin, $iLengthSecs)
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>__ReadTLENFromMP3

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __ReadXingFromMP3
; Description ...: Used internally within this file, not for general use
; Syntax.........: __ReadXingFromMP3($sTag)
; Parameters ....: $sTag - first 5156 bytes from 'read raw' mode.
; Return values .: Success      - Sound length (hh:mm:ss)
;                  Failure      - 0 and @error = 1
; Author ........: Melba23
; Modified.......: RazerM
; Remarks .......: File must be an mp3 AFAIK
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func __ReadXingFromMP3($sTag)
	Local $iXingPos, $iFlags, $iFrames, $sHeader, $iMPEGByte, $iFreqByte, $iMPEGVer, $iLayerNum, $iSamples, $iFreqNum, $iFrequency, $iLengthMs, $iLengthHours, $iLengthMins, $iLengthSecs

	$iXingPos = StringInStr($sTag, "58696E67")
	If $iXingPos = 0 Then Return SetError(1, 0, 0)

	; Read fields flag
	$iFlags = Number("0x" & StringMid($sTag, $iXingPos + 14, 2))
	If BitAND($iFlags, 1) = 1 Then
		$iFrames = Number("0x" & StringMid($sTag, $iXingPos + 16, 8))
	Else
		Return SetError(1, 0, 0); No frames field
	EndIf

	; Now to find Samples per frame & Sampling rate
	; Go back to the frame header start
	$sHeader = StringMid($sTag, $iXingPos - 72, 8)

	; Read the relevant bytes
	$iMPEGByte = Number("0x" & StringMid($sHeader, 4, 1))
	$iFreqByte = Number("0x" & StringMid($sHeader, 6, 1))

	; Decode them
	; 8 = MPEG-1, 0 = MPEG-2
	$iMPEGVer = BitAND($iMPEGByte, 8)
	
	; 2 = Layer III, 4 = Layer II, 6 = Layer I
	$iLayerNum = BitAND($iMPEGByte, 6)

	Switch $iLayerNum
		Case 6
			$iSamples = 384
		Case 4
			$iSamples = 1152
		Case 2
			Switch $iMPEGVer
				Case 8
					$iSamples = 1152
				Case 0
					$iSamples = 576
				Case Else
					$iSamples = 0
			EndSwitch
		Case Else
			$iSamples = 0
	EndSwitch

	; If not valid return
	If $iSamples = 0 Then Return SetError(1, 0, 0)

	; 0 = bit 00, 4 = Bit 01, 8 = Bit 10
	$iFreqNum = BitAND($iFreqByte, 12)
	Switch $iFreqNum
		Case 0
			$iFrequency = 44100
		Case 4
			$iFrequency = 48000
		Case 8
			$iFrequency = 32000
		Case Else
			$iFrequency = 0
	EndSwitch

	; If not valid return
	If $iFrequency = 0 Then Return SetError(1, 0, 0)

	; MPEG-2 halves the value
	If $iMPEGVer = 0 Then $iFrequency = $iFrequency / 2

	; Duration in secs = No of frames * Samples per frame / Sampling freq
	$iLengthMs = Int(($iFrames * $iSamples / $iFrequency) * 1000)

	; Convert to hh:mm:ss and return
	_TicksToTime($iLengthMs, $iLengthHours, $iLengthMins, $iLengthSecs)

	Return StringFormat("%02i:%02i:%02i", $iLengthHours, $iLengthMins, $iLengthSecs)
EndFunc   ;==>__ReadXingFromMP3