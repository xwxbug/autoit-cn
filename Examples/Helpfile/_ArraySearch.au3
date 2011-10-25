#include <Array.au3>

;===============================================================================
; 示例 1 (使用一维数组)
;===============================================================================
Local $avArray[6] = [ _
		" String0 , SubString0 ", _
		" String1 , SubString1 ", _
		" String2 , SubString2 ", _
		" String3 , SubString3 ", _
		" String4 , SubString4 ", _
		" String5 , SubString5 "]

_ArrayDisplay($avArray, "$avArray ")

$sSearch = InputBox(" _ArraySearch() demo ", "String to find? ")
If @error Then Exit

$iIndex = _ArraySearch($avArray, $sSearch, 0, 0, 0, 1)
If @error Then
	msgbox(0, "Not Found ",'"'& $sSearch & ' " was not found in the array.')
Else
	msgbox(0, "Found ",'"'& $sSearch & ' " was found in the array at position' & $iIndex & " . ")
EndIf

;===============================================================================
; 示例 2 (使用二维数组)
;===============================================================================
Local $avArray[6] = [ _
		" String0 , SubString0 ", _
		" String1 , SubString1 ", _
		" String2 , SubString2 ", _
		" String3 , SubString3 ", _
		" String4 , SubString4 ", _
		" String5 , SubString5 "]

_ArrayDisplay($avArray, "$avArray ")

$sSearch = InputBox(" _ArraySearch() demo ", "String to find? ")
If @error Then Exit

$sColumn = InputBox(" _ArraySearch() demo ", "Column to search? ")
If @error > Then Exit
$sColumn = Int($sColumn)

$iIndex = _ArraySearch($avArray, $sSearch, 0, 0, 0, 1, $sColumn)
If @error Then
	msgbox(0, "Not Found ",'"'& $sSearch & ' " was not found on column' & $sColumn & ' .')
Else
	msgbox(0, "Found ",'"'& $sSearch & ' " was found in the array at position' & $iIndex & '  on column' & $sColumn & ' .')
EndIf

