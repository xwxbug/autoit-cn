#include <Constants.au3>

; Regular Expression test using VBScript.RegExp object
;
; Requirements:
; AutoItCOM    Version 3.1.0
; VBscript.DLL version 5.0 or higher.
;
; Source: http://msdn.microsoft.com/library/en-us/script56/html/vsobjregexp.asp

Func RegExpTest($patrn, $strng)
	Local $Retstr = ""

	Local $regEx = ObjCreate("VBScript.RegExp") ; Create a regular expression.

	$regEx.Pattern = $patrn ; Set pattern.
	$regEx.IgnoreCase = 1 ; Set case insensitivity: True.
	$regEx.Global = 1 ; Set global applicability: True.
	Local $Matches = $regEx.Execute($strng) ; Execute search.

	For $Match In $Matches ; Iterate Matches collection.
		$Retstr = $Retstr & "Match found at position "
		$Retstr = $Retstr & $Match.FirstIndex & ". Match Value is '"
		$Retstr = $Retstr & $Match.Value & "'." & @CRLF
	Next

	$regEx = ""

	Return $Retstr
EndFunc   ;==>RegExpTest

MsgBox($MB_SYSTEMMODAL, "Test RegExp", RegExpTest("is.", "IS1 is2 IS3 is4"))
