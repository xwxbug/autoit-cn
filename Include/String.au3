#include-once

; #INDEX# =======================================================================================================================
; Title .........: String
; Description ...: This module contains various String functions
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_HexToString
;_StringAddThousandsSep
;_StringBetween
;_StringEncrypt
;_StringExplode
;_StringInsert
;_StringProper
;_StringRepeat
;_StringReverse
;_StringToHex
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;==============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _HexToString
; Description ...: Convert a hex string to a string.
; Syntax.........: _HexToString($strHex)
; Parameters ....: $strHex - an hexadecimal string
; Return values .: Success - Returns a string.
;                  Failure - Returns -1 and sets @error to 1.
; Author ........: Jarvis Stubblefield
; Modified.......: 2005/09/04 jpm error checking
; Remarks .......:
; Related .......: _StringToHex
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _HexToString($strHex)
	Local $strChar, $aryHex, $i, $iDec, $Char, $iOne, $iTwo

	$aryHex = StringSplit($strHex, "")
	If Mod($aryHex[0], 2) <> 0 Then
		SetError(1)
		Return -1
	EndIf

	For $i = 1 To $aryHex[0]
		$iOne = $aryHex[$i]
		$i = $i + 1
		$iTwo = $aryHex[$i]
		$iDec = Dec($iOne & $iTwo)
		If @error <> 0 Then
			SetError(1)
			Return -1
		EndIf

		$Char = Chr($iDec)
		$strChar &= $Char
	Next

	Return $strChar
EndFunc   ;==>_HexToString

; #FUNCTION# ====================================================================================================================
; Name...........: _StringAddThousandsSep
; Description ...: Returns the original numbered string with the Thousands delimiter inserted.
; Syntax.........: _StringAddThousandsSep($sString[, $sThousands = -1[, $sDecimal = -1]])
; Parameters ....: $sString    - The string to be converted.
;                  $sThousands - Optional: The Thousands delimiter
;                  $sDecimal   - Optional: The decimal delimiter
; Return values .: Success - The string with Thousands delimiter added.
; Author ........: SmOke_N (orignal _StringAddComma
; Modified.......: Valik (complete re-write, new function name)
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringAddThousandsSep($sString, $sThousands = -1, $sDecimal = -1)
	Local $sResult = "" ; Force string
	Local $rKey = "HKCU\Control Panel\International"
	If $sDecimal = -1 Then $sDecimal = RegRead($rKey, "sDecimal")
	If $sThousands = -1 Then $sThousands = RegRead($rKey, "sThousand")
;~ 	Local $aNumber = StringRegExp($sString, "(\d+)\D?(\d*)", 1)
	Local $aNumber = StringRegExp($sString, "(\D?\d+)\D?(\d*)", 1) ; This one works for negatives.
	If UBound($aNumber) = 2 Then
		Local $sLeft = $aNumber[0]
		While StringLen($sLeft)
			$sResult = $sThousands & StringRight($sLeft, 3) & $sResult
			$sLeft = StringTrimRight($sLeft, 3)
		WEnd
;~ 		$sResult = StringTrimLeft($sResult, 1) ; Strip leading thousands separator
		$sResult = StringTrimLeft($sResult, StringLen($sThousands)) ; Strip leading thousands separator
		If $aNumber[1] <> "" Then $sResult &= $sDecimal & $aNumber[1]
	EndIf
	Return $sResult
EndFunc   ;==>_StringAddThousandsSep

; #FUNCTION# ====================================================================================================================
; Name...........: _StringBetween
; Description ...: Returns the string between the start search string and the end search string.
; Syntax.........: _StringBetween($sString, $sStart, $sEnd[, $vCase = -1[, $iSRE = -1]])
; Parameters ....: $sString - The string to search.
;                  $sStart  - The beginning of the string to find
;                  $sEnd    - The end of the string to find
;                  $vCase   - Optional: Case sensitive search. Default or -1 is not Case sensitive else Case sensitive.
;                  $iSRE    - Optional: Toggle for regular string manipulation or StringRegExp search. Default is regular string manipulation.
; Return values .: Success - A 0 based $array[0] contains the first found string.
;                  Failure - 0
;                  |@Error  - 1 = No inbetween string found.
; Author ........: SmOke_N (Thanks to Valik for helping with the new StringRegExp (?s)(?i) isssue)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringBetween($sString, $sStart, $sEnd, $vCase = -1, $iSRE = -1)
	If $iSRE = -1 Or $iSRE = Default Then
		If $vCase = -1 Or $vCase = Default Then
			$vCase = 0
		Else
			$vCase = 1
		EndIf
		Local $sHold = '', $sSnSStart = '', $sSnSEnd = ''
		While StringLen($sString) > 0
			$sSnSStart = StringInStr($sString, $sStart, $vCase)
			If Not $sSnSStart Then ExitLoop
			$sString = StringTrimLeft($sString, ($sSnSStart + StringLen($sStart)) - 1)
			$sSnSEnd = StringInStr($sString, $sEnd, $vCase)
			If Not $sSnSEnd Then ExitLoop
			$sHold &= StringLeft($sString, $sSnSEnd - 1) & Chr(1)
			$sString = StringTrimLeft($sString, $sSnSEnd)
		WEnd
		If Not $sHold Then Return SetError(1, 0, 0)
		$sHold = StringSplit(StringTrimRight($sHold, 1), Chr(1))
		Local $avArray[UBound($sHold) - 1]
		For $iCC = 1 To UBound($sHold) - 1
			$avArray[$iCC - 1] = $sHold[$iCC]
		Next
		Return $avArray
	Else
		If $vCase = Default Or $vCase = -1 Then
			$vCase = '(?i)'
		Else
			$vCase = ''
		EndIf
		Local $aArray = StringRegExp($sString, '(?s)' & $vCase & $sStart & '(.*?)' & $sEnd, 3)
		If IsArray($aArray) Then Return $aArray
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_StringBetween

; #FUNCTION# ====================================================================================================================
; Name...........: _StringEncrypt
; Description ...: An RC4 based string encryption function.
; Syntax.........: _StringEncrypt($i_Encrypt, $s_EncryptText, $s_EncryptPassword[, $i_EncryptLevel = 1])
; Parameters ....: $i_Encrypt         - 1 to encrypt, 0 to decrypt.
;                  $s_EncryptText     - Text to encrypt/decrypt.
;                  $s_EncryptPassword - Password to encrypt/decrypt with.
;                  $i_EncryptLevel    - Optional: Level to encrypt/decrypt. Default = 1
; Return values .: Success - The Encrypted/Decrypted string.
;                  Failure - Blank string and @error = 1
; Author ........: Wes Wolfe-Wolvereness <Weswolf at aol dot com>
; Modified.......:
; Remarks .......: WARNING: This function has an extreme timespan if the encryption level or encrypted string are too large!
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringEncrypt($i_Encrypt, $s_EncryptText, $s_EncryptPassword, $i_EncryptLevel = 1)
	If $i_Encrypt <> 0 And $i_Encrypt <> 1 Then
		SetError(1)
		Return ''
	ElseIf $s_EncryptText = '' Or $s_EncryptPassword = '' Then
		SetError(1)
		Return ''
	Else
		If Number($i_EncryptLevel) <= 0 Or Int($i_EncryptLevel) <> $i_EncryptLevel Then $i_EncryptLevel = 1
		Local $v_EncryptModified
		Local $i_EncryptCountH
		Local $i_EncryptCountG
		Local $v_EncryptSwap
		Local $av_EncryptBox[256][2]
		Local $i_EncryptCountA
		Local $i_EncryptCountB
		Local $i_EncryptCountC
		Local $i_EncryptCountD
		Local $i_EncryptCountE
		Local $v_EncryptCipher
		Local $v_EncryptCipherBy
		If $i_Encrypt = 1 Then
			For $i_EncryptCountF = 0 To $i_EncryptLevel Step 1
				$i_EncryptCountG = ''
				$i_EncryptCountH = ''
				$v_EncryptModified = ''
				For $i_EncryptCountG = 1 To StringLen($s_EncryptText)
					If $i_EncryptCountH = StringLen($s_EncryptPassword) Then
						$i_EncryptCountH = 1
					Else
						$i_EncryptCountH += 1
					EndIf
					$v_EncryptModified = $v_EncryptModified & Chr(BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountG, 1)), Asc(StringMid($s_EncryptPassword, $i_EncryptCountH, 1)), 255))
				Next
				$s_EncryptText = $v_EncryptModified
				$i_EncryptCountA = ''
				$i_EncryptCountB = 0
				$i_EncryptCountC = ''
				$i_EncryptCountD = ''
				$i_EncryptCountE = ''
				$v_EncryptCipherBy = ''
				$v_EncryptCipher = ''
				$v_EncryptSwap = ''
				$av_EncryptBox = ''
				Local $av_EncryptBox[256][2]
				For $i_EncryptCountA = 0 To 255
					$av_EncryptBox[$i_EncryptCountA][1] = Asc(StringMid($s_EncryptPassword, Mod($i_EncryptCountA, StringLen($s_EncryptPassword)) + 1, 1))
					$av_EncryptBox[$i_EncryptCountA][0] = $i_EncryptCountA
				Next
				For $i_EncryptCountA = 0 To 255
					$i_EncryptCountB = Mod(($i_EncryptCountB + $av_EncryptBox[$i_EncryptCountA][0] + $av_EncryptBox[$i_EncryptCountA][1]), 256)
					$v_EncryptSwap = $av_EncryptBox[$i_EncryptCountA][0]
					$av_EncryptBox[$i_EncryptCountA][0] = $av_EncryptBox[$i_EncryptCountB][0]
					$av_EncryptBox[$i_EncryptCountB][0] = $v_EncryptSwap
				Next
				For $i_EncryptCountA = 1 To StringLen($s_EncryptText)
					$i_EncryptCountC = Mod(($i_EncryptCountC + 1), 256)
					$i_EncryptCountD = Mod(($i_EncryptCountD + $av_EncryptBox[$i_EncryptCountC][0]), 256)
					$i_EncryptCountE = $av_EncryptBox[Mod(($av_EncryptBox[$i_EncryptCountC][0] + $av_EncryptBox[$i_EncryptCountD][0]), 256)][0]
					$v_EncryptCipherBy = BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountA, 1)), $i_EncryptCountE)
					$v_EncryptCipher &= Hex($v_EncryptCipherBy, 2)
				Next
				$s_EncryptText = $v_EncryptCipher
			Next
		Else
			For $i_EncryptCountF = 0 To $i_EncryptLevel Step 1
				$i_EncryptCountB = 0
				$i_EncryptCountC = ''
				$i_EncryptCountD = ''
				$i_EncryptCountE = ''
				$v_EncryptCipherBy = ''
				$v_EncryptCipher = ''
				$v_EncryptSwap = ''
				$av_EncryptBox = ''
				Local $av_EncryptBox[256][2]
				For $i_EncryptCountA = 0 To 255
					$av_EncryptBox[$i_EncryptCountA][1] = Asc(StringMid($s_EncryptPassword, Mod($i_EncryptCountA, StringLen($s_EncryptPassword)) + 1, 1))
					$av_EncryptBox[$i_EncryptCountA][0] = $i_EncryptCountA
				Next
				For $i_EncryptCountA = 0 To 255
					$i_EncryptCountB = Mod(($i_EncryptCountB + $av_EncryptBox[$i_EncryptCountA][0] + $av_EncryptBox[$i_EncryptCountA][1]), 256)
					$v_EncryptSwap = $av_EncryptBox[$i_EncryptCountA][0]
					$av_EncryptBox[$i_EncryptCountA][0] = $av_EncryptBox[$i_EncryptCountB][0]
					$av_EncryptBox[$i_EncryptCountB][0] = $v_EncryptSwap
				Next
				For $i_EncryptCountA = 1 To StringLen($s_EncryptText) Step 2
					$i_EncryptCountC = Mod(($i_EncryptCountC + 1), 256)
					$i_EncryptCountD = Mod(($i_EncryptCountD + $av_EncryptBox[$i_EncryptCountC][0]), 256)
					$i_EncryptCountE = $av_EncryptBox[Mod(($av_EncryptBox[$i_EncryptCountC][0] + $av_EncryptBox[$i_EncryptCountD][0]), 256)][0]
					$v_EncryptCipherBy = BitXOR(Dec(StringMid($s_EncryptText, $i_EncryptCountA, 2)), $i_EncryptCountE)
					$v_EncryptCipher = $v_EncryptCipher & Chr($v_EncryptCipherBy)
				Next
				$s_EncryptText = $v_EncryptCipher
				$i_EncryptCountG = ''
				$i_EncryptCountH = ''
				$v_EncryptModified = ''
				For $i_EncryptCountG = 1 To StringLen($s_EncryptText)
					If $i_EncryptCountH = StringLen($s_EncryptPassword) Then
						$i_EncryptCountH = 1
					Else
						$i_EncryptCountH += 1
					EndIf
					$v_EncryptModified &= Chr(BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountG, 1)), Asc(StringMid($s_EncryptPassword, $i_EncryptCountH, 1)), 255))
				Next
				$s_EncryptText = $v_EncryptModified
			Next
		EndIf
		Return $s_EncryptText
	EndIf
EndFunc   ;==>_StringEncrypt

; #FUNCTION# ====================================================================================================================
; Name...........: _StringExplode
; Description ...: Splits up a string into substrings depending on the given delimiters as PHP Explode v5.
; Syntax.........: _StringExplode($sString, $sDelimiter [, $iLimit] )
; Parameters ....: $sString    - String to be split
;                  $sDelimiter - Delimiter to split on (split is performed on entire string, not individual characters)
;                  $iLimit     - [optional] Maximum elements to be returned
;                  |=0 : (default) Split on every instance of the delimiter
;                  |>0 : Split until limit, last element will contain remaining portion of the string
;                  |<0 : Split on every instance, removing limit count from end of the array
; Return values .: Success - an array containing the exploded strings.
; Author ........: WeaponX
; Modified.......:
; Remarks .......: Use negative limit values to remove the first possible elements.
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringExplode($sString, $sDelimiter, $iLimit = 0)
	If $iLimit > 0 Then
		;Replace delimiter with NULL character using given limit
		$sString = StringReplace($sString, $sDelimiter, Chr(0), $iLimit)

		;Split on NULL character, this will leave the remainder in the last element
		$sDelimiter = Chr(0)
	ElseIf $iLimit < 0 Then
		;Find delimiter occurence from right-to-left
		Local $iIndex = StringInStr($sString, $sDelimiter, 0, $iLimit)

		If $iIndex Then
			;Split on left side of string only
			$sString = StringLeft($sString, $iIndex - 1)
		EndIf
	EndIf

	Return StringSplit($sString, $sDelimiter, 3)
EndFunc   ;==>_StringExplode

; #FUNCTION# ====================================================================================================================
; Name...........: _StringInsert
; Description ...: Inserts a string within another string.
; Syntax.........: _StringInsert($s_String, $s_InsertString, $i_Position)
; Parameters ....: $s_String   - Original string
;                  $s_InsertString   - String to be inserted
;                  $i_Position - Position to insert string (negatives values count from right hand side)
; Return values .: Success - Returns new modified string
;                  Failure - Returns original string and sets the @error to the following values:
;                  |@error = 1 : Source string empty
;                  |@error = 2 : Insert string empty
;                  |@error = 3 : Invalid position
; Author ........: Louis Horvath <celeri at videotron dot ca>
; Modified.......:
; Remarks .......: Use negative position values to insert string from the right hand side.
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringInsert($s_String, $s_InsertString, $i_Position)
	Local $i_Length, $s_Start, $s_End

	If $s_String = "" Or (Not IsString($s_String)) Then
		SetError(1) ; Source string empty / not a string
		Return $s_String
	ElseIf $s_InsertString = "" Or (Not IsString($s_String)) Then
		SetError(2) ; Insert string empty / not a string
		Return $s_String
	Else
		$i_Length = StringLen($s_String) ; Take a note of the length of the source string
		If (Abs($i_Position) > $i_Length) Or (Not IsInt($i_Position)) Then
			SetError(3) ; Invalid position
			Return $s_String
		EndIf
	EndIf

	; If $i_Position at start of string
	If $i_Position = 0 Then
		Return $s_InsertString & $s_String ; Just add them up :) Easy :)
		; If $i_Position is positive
	ElseIf $i_Position > 0 Then
		$s_Start = StringLeft($s_String, $i_Position) ; Chop off first part
		$s_End = StringRight($s_String, $i_Length - $i_Position) ; and the second part
		Return $s_Start & $s_InsertString & $s_End ; Assemble all three pieces together
		; If $i_Position is negative
	ElseIf $i_Position < 0 Then
		$s_Start = StringLeft($s_String, Abs($i_Length + $i_Position)) ; Chop off first part
		$s_End = StringRight($s_String, Abs($i_Position)) ; and the second part
		Return $s_Start & $s_InsertString & $s_End ; Assemble all three pieces together
	EndIf
EndFunc   ;==>_StringInsert

; #FUNCTION# ====================================================================================================================
; Name...........: _StringProper
; Description ...: Changes a string to proper case, same a =Proper function in Excel
; Syntax.........: _StringProper($s_Str)
; Parameters ....: $s_Str - Input string
; Return values .: Success - Returns proper string.
;                  Failure - Returns "".
; Author ........: Jos van der Zande <jdeb at autoitscript dot com>
; Modified.......:
; Remarks .......: This function will capitalize every character following a None Apha character.
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringProper($s_Str)
	Local $iX = 0
	Local $CapNext = 1
	Local $s_nStr = ""
	Local $s_CurChar
	For $iX = 1 To StringLen($s_Str)
		$s_CurChar = StringMid($s_Str, $iX, 1)
		Select
			Case $CapNext = 1
				If StringRegExp($s_CurChar, '[a-zA-ZÀ-ÿšœžŸ]') Then
					$s_CurChar = StringUpper($s_CurChar)
					$CapNext = 0
				EndIf
			Case Not StringRegExp($s_CurChar, '[a-zA-ZÀ-ÿšœžŸ]')
				$CapNext = 1
			Case Else
				$s_CurChar = StringLower($s_CurChar)
		EndSelect
		$s_nStr &= $s_CurChar
	Next
	Return ($s_nStr)
EndFunc   ;==>_StringProper

; #FUNCTION# ====================================================================================================================
; Name...........: _StringRepeat
; Description ...: Repeats a string a specified number of times.
; Syntax.........: _StringRepeat($sString, $iRepeatCount)
; Parameters ....: $sString      - String to repeat
;                  $iRepeatCount - Number of times to repeat the string
; Return values .: Success - Returns string with specified number of repeats
;                  Failure - Returns an empty string and sets @error = 1
;                  |@Error  - 0 = No error.
;                  |@Error  - 1 = One of the parameters is invalid
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringRepeat($sString, $iRepeatCount)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $sResult

	Select
		Case Not StringIsInt($iRepeatCount)
			SetError(1)
			Return ""
		Case StringLen($sString) < 1
			SetError(1)
			Return ""
		Case $iRepeatCount <= 0
			SetError(1)
			Return ""
		Case Else
			For $iCount = 1 To $iRepeatCount
				$sResult &= $sString
			Next

			Return $sResult
	EndSelect
EndFunc   ;==>_StringRepeat

; #FUNCTION# ====================================================================================================================
; Name...........: _StringReverse
; Description ...: Reverses the contents of the specified string.
; Syntax.........: _StringReverse($sString)
; Parameters ....: $sString - String to reverse
; Return values .: Success - Returns reversed string
;                  Failure - Returns an empty string and sets @error = 1
;                  |@Error  - 0 = No error.
;                  |@Error  - 1 = One of the parameters is invalid
; Author ........: Jonathan Bennett <jon at hiddensoft com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringReverse($sString)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $sReverse
	Local $iCount

	If StringLen($sString) >= 1 Then
		For $iCount = 1 To StringLen($sString)
			$sReverse = StringMid($sString, $iCount, 1) & $sReverse
		Next

		Return $sReverse
	Else
		SetError(1)
		Return ""
	EndIf
EndFunc   ;==>_StringReverse

; #FUNCTION# ====================================================================================================================
; Name...........: _StringToHex
; Description ...: Convert a string to a hex string.
; Syntax.........: _StringToHex($strChar)
; Parameters ....: $strChar - string to be converted.
; Return values .: Success - Returns an hex string.
;                  Failure - Returns -1 and sets @error to 1.
; Author ........: Jarvis Stubblefield
; Modified.......: 2005/09/04 jpm error checking
; Remarks .......:
; Related .......: _HexToString
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringToHex($strChar)
	Local $aryChar, $i, $iDec, $hChar, $strHex

	$aryChar = StringSplit($strChar, "")

	For $i = 1 To $aryChar[0]
		$iDec = Asc($aryChar[$i])
		$hChar = Hex($iDec, 2)
		$strHex &= $hChar
	Next

	Return $strHex

EndFunc   ;==>_StringToHex