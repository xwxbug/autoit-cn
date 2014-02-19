#include-once

#include "StringConstants.au3"

; #INDEX# =======================================================================================================================
; Title .........: String
; AutoIt Version : 3.3.10.0
; Description ...: Functions that assist with String management.
; Author(s) .....: Jarvis Stubblefield, SmOke_N, Valik, Wes Wolfe-Wolvereness, WeaponX, Louis Horvath, JdeB, Jeremy Landes, Jon, jchd, BrewManNH, guinness
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _HexToString
; _StringBetween
; _StringEncrypt
; _StringExplode
; _StringInsert
; _StringProper
; _StringRepeat
; _StringTitleCase
; _StringToHex
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Author ........: Jarvis Stubblefield
; Modified.......: SmOke_N - (Re-write using BinaryToString for speed)
; ===============================================================================================================================
Func _HexToString($sHex)
	If Not (StringLeft($sHex, 2) == "0x") Then $sHex = "0x" & $sHex
	Return BinaryToString($sHex)
EndFunc   ;==>_HexToString

; #FUNCTION# ====================================================================================================================
; Author ........: SmOke_N (Thanks to Valik for helping with the new StringRegExp (?s)(?i) issue)
; Modified.......: SmOke_N - (Re-write for speed and accuracy), jchd, Melba23 (added mode)
; ===============================================================================================================================
Func _StringBetween($sString, $sStart, $sEnd, $iMode = $STR_ENDISSTART, $fCase = False)
	; Set mode
    If $iMode <> $STR_ENDNOTSTART Then $iMode = $STR_ENDISSTART

    ; Set correct case sensitivity
    If $fCase = Default Then
        $fCase = False
    EndIf
    Local $sCase = "(?is)"
    If $fCase Then
        $sCase = "(?s)"
    EndIf

    ; If starting from beginning of string
    $sStart = $sStart ? "\Q" & $sStart & "\E" : "\A"

    ; If ending at end of string
    If $iMode = $STR_ENDISSTART Then
		; Use lookahead
		$sEnd = $sEnd ? "(?=\Q" & $sEnd & "\E)" : "\z"
    Else
		; Capture end string
		$sEnd = $sEnd ? "\Q" & $sEnd & "\E" : "\z"
    EndIf

    Local $aReturn = StringRegExp($sString, $sCase & $sStart & "(.*?)" & $sEnd, $STR_REGEXPARRAYGLOBALMATCH)
    If @error Then Return SetError(1, 0, 0)
    Return $aReturn
EndFunc   ;==>_StringBetween

; #FUNCTION# ====================================================================================================================
; Author ........: WeaponX
; Modified.......:
; ===============================================================================================================================
Func _StringExplode($sString, $sDelimiter, $iLimit = 0)
	Local Const $NULL = Chr(0) ; Different from the Null keyword.
	If $iLimit = Default Then $iLimit = 0
	If $iLimit > 0 Then
		; Replace delimiter with NULL character using given limit
		$sString = StringReplace($sString, $sDelimiter, $NULL, $iLimit)

		; Split on NULL character, this will leave the remainder in the last element
		$sDelimiter = $NULL
	ElseIf $iLimit < 0 Then
		; Find delimiter occurence from right-to-left
		Local $iIndex = StringInStr($sString, $sDelimiter, 0, $iLimit)
		If $iIndex Then
			; Split on left side of string only
			$sString = StringLeft($sString, $iIndex - 1)
		EndIf
	EndIf

	Return StringSplit($sString, $sDelimiter, $STR_NOCOUNT)
EndFunc   ;==>_StringExplode

; #FUNCTION# ====================================================================================================================
; Author ........: Louis Horvath <celeri at videotron dot ca>
; Modified.......: jchd - Removed explicitly checking if the source and insert strings were strings and forcing an @error return value
; ===============================================================================================================================
Func _StringInsert($sString, $sInsertString, $iPosition)
	; Casting Int() takes care of String/Int, Numbers
	$iPosition = Int($iPosition)

	; Retrieve the length of the source string
	Local $iLength = StringLen($sString)

	; Check the insert position isn't greater than the string length
	If Abs($iPosition) > $iLength Then
		Return SetError(1, 0, $sString) ; Invalid position as it's greater than the string length
	EndIf

	; Check if the source and insert strings are strings and convert accordingly if not
	If Not IsString($sInsertString) Then $sInsertString = String($sInsertString)
	If Not IsString($sString) Then $sString = String($sString)
	; Escape all "\" characters in the string to insert - otherwise they do not appear
	$sInsertString = StringReplace($sInsertString, "\", "\\")
	; Insert the string
	If $iPosition >= 0 Then
		Return StringRegExpReplace($sString, "(?s)\A(.{" & $iPosition & "})(.*)\z", "${1}" & $sInsertString & "$2") ; Insert to the left hand side
	Else
		Return StringRegExpReplace($sString, "(?s)\A(.*)(.{" & - $iPosition & "})\z", "${1}" & $sInsertString & "$2") ; Insert to the right hand side
	EndIf
EndFunc   ;==>_StringInsert

; #FUNCTION# ====================================================================================================================
; Author ........: Jos van der Zande <jdeb at autoitscript dot com>
; Modified.......:
; ===============================================================================================================================
Func _StringProper($sString)
	Local $fCapNext = True, $sChr = "", $sReturn = ""
	For $i = 1 To StringLen($sString)
		$sChr = StringMid($sString, $i, 1)
		Select
			Case $fCapNext = True
				If StringRegExp($sChr, '[a-zA-ZÀ-ÿšœžŸ]') Then
					$sChr = StringUpper($sChr)
					$fCapNext = False
				EndIf
			Case Not StringRegExp($sChr, '[a-zA-ZÀ-ÿšœžŸ]')
				$fCapNext = True
			Case Else
				$sChr = StringLower($sChr)
		EndSelect
		$sReturn &= $sChr
	Next
	Return $sReturn
EndFunc   ;==>_StringProper

; #FUNCTION# ====================================================================================================================
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......: guinness - Removed Select...EndSelect statement and replaced with an If...EndIf as well as optimised the code.
; ===============================================================================================================================
Func _StringRepeat($sString, $iRepeatCount)
	; Casting Int() takes care of String/Int, Numbers.
	$iRepeatCount = Int($iRepeatCount)
	; Zero is a valid repeat integer.
	If StringLen($sString) < 1 Or $iRepeatCount < 0 Then Return SetError(1, 0, "")
	Local $sResult = ""
	While $iRepeatCount > 1
		If BitAND($iRepeatCount, 1) Then $sResult &= $sString
		$sString &= $sString
		$iRepeatCount = BitShift($iRepeatCount, 1)
	WEnd
	Return $sString & $sResult
EndFunc   ;==>_StringRepeat

; #FUNCTION# ====================================================================================================================
; Author ........: BrewManNH
; Modified ......:
; ===============================================================================================================================
Func _StringTitleCase($sString)
	Local $fCapNext = True, $sChr = "", $sReturn = ""
	For $i = 1 To StringLen($sString)
		$sChr = StringMid($sString, $i, 1)
		Select
			Case $fCapNext = True
				If StringRegExp($sChr, "[a-zA-Z\xC0-\xFF0-9]") Then
					$sChr = StringUpper($sChr)
					$fCapNext = False
				EndIf
			Case Not StringRegExp($sChr, "[a-zA-Z\xC0-\xFF'0-9]")
				$fCapNext = True
			Case Else
				$sChr = StringLower($sChr)
		EndSelect
		$sReturn &= $sChr
	Next
	Return $sReturn
EndFunc   ;==>_StringTitleCase

; #FUNCTION# ====================================================================================================================
; Author ........: Jarvis Stubblefield
; Modified.......: SmOke_N - (Re-write using StringToBinary for speed)
; ===============================================================================================================================
Func _StringToHex($sString)
	Return Hex(StringToBinary($sString))
EndFunc   ;==>_StringToHex
