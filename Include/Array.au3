#include-Once

#include "AutoItConstants.au3"
#include "MsgBoxConstants.au3"
#include "StringConstants.au3"

; #INDEX# =======================================================================================================================
; Title .........: Array
; AutoIt Version : 3.3.13.12
; Language ......: English
; Description ...: Functions for manipulating arrays.
; Author(s) .....: JdeB, Erik Pilsits, Ultima, Dale (Klaatu) Thompson, Cephas,randallc, Gary Frost, GEOSoft,
;                  Helias Gerassimou(hgeras), Brian Keene, Michael Michta, gcriaco, LazyCoder, Tylo, David Nuttall,
;                  Adam Moore (redndahead), SmOke_N, litlmike, Valik, Melba23
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _ArrayAdd
; _ArrayBinarySearch
; _ArrayColDelete
; _ArrayColInsert
; _ArrayCombinations
; _ArrayConcatenate
; _ArrayDelete
; _ArrayDisplay
; _ArrayExtract
; _ArrayFindAll
; _ArrayInsert
; _ArrayMax
; _ArrayMaxIndex
; _ArrayMin
; _ArrayMinIndex
; _ArrayPermute
; _ArrayPop
; _ArrayPush
; _ArrayReverse
; _ArraySearch
; _ArrayShuffle
; _ArraySort
; _ArrayToClip
; _ArrayToString
; _ArrayTranspose
; _ArrayTrim
; _ArrayUnique
; _Array1DToHistogram
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __Array_Combinations
; __Array_ExeterInternal
; __Array_GetNext
; __Array_GreaterThan
; __Array_LessThan
; __Array_MinMaxIndex
; __ArrayDualPivotSort
; __ArrayQuickSort1D
; __ArrayQuickSort2D
; ===============================================================================================================================

; #GLOBAL CONSTANTS# ============================================================================================================
Global Enum $ARRAYADD_FORCE_DEFAULT, $ARRAYADD_FORCE_SINGLEITEM, $ARRAYADD_FORCE_INT, $ARRAYADD_FORCE_NUMBER, $ARRAYADD_FORCE_PTR, $ARRAYADD_FORCE_HWND, $ARRAYADD_FORCE_STRING
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Author ........: Jos
; Modified.......: Ultima - code cleanup; Melba23 - added 2D support & multiple addition
; ===============================================================================================================================
Func _ArrayAdd(ByRef $avArray, $vValue, $iStart = 0, $sDelim_Item = "|", $sDelim_Row = @CRLF, $iForce = $ARRAYADD_FORCE_DEFAULT)

	If $iStart = Default Then $iStart = 0
	If $sDelim_Item = Default Then $sDelim_Item = "|"
	If $sDelim_Row = Default Then $sDelim_Row = @CRLF
	If $iForce = Default Then $iForce = $ARRAYADD_FORCE_DEFAULT
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS)
	Local $hDataType = 0
	Switch $iForce
		Case $ARRAYADD_FORCE_INT
			$hDataType = Int
		Case $ARRAYADD_FORCE_NUMBER
			$hDataType = Number
		Case $ARRAYADD_FORCE_PTR
			$hDataType = Ptr
		Case $ARRAYADD_FORCE_HWND
			$hDataType = Hwnd
		Case $ARRAYADD_FORCE_STRING
			$hDataType = String
	EndSwitch
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			If $iForce = $ARRAYADD_FORCE_SINGLEITEM Then
				ReDim $avArray[$iDim_1 + 1]
				$avArray[$iDim_1] = $vValue
				Return $iDim_1
			EndIf
			If IsArray($vValue) Then
				If UBound($vValue, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(5, 0, -1)
				$hDataType = 0
			Else
				Local $aTmp = StringSplit($vValue, $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
				If UBound($aTmp, $UBOUND_ROWS) = 1 Then
					$aTmp[0] = $vValue
				EndIf
				$vValue = $aTmp
			EndIf
			Local $iAdd = UBound($vValue, $UBOUND_ROWS)
			ReDim $avArray[$iDim_1 + $iAdd]
			For $i = 0 To $iAdd - 1
				If IsFunc($hDataType) Then
					$avArray[$iDim_1 + $i] = $hDataType($vValue[$i])
				Else
					$avArray[$iDim_1 + $i] = $vValue[$i]
				EndIf
			Next
			Return $iDim_1 + $iAdd - 1
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS)
			If $iStart < 0 Or $iStart > $iDim_2 - 1 Then Return SetError(4, 0, -1)
			Local $iValDim_1, $iValDim_2
			If IsArray($vValue) Then
				If UBound($vValue, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(5, 0, -1)
				$iValDim_1 = UBound($vValue, $UBOUND_ROWS)
				$iValDim_2 = UBound($vValue, $UBOUND_COLUMNS)
				$hDataType = 0
			Else
				; Convert string to 2D array
				Local $aSplit_1 = StringSplit($vValue, $sDelim_Row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
				$iValDim_1 = UBound($aSplit_1, $UBOUND_ROWS)
				StringReplace($aSplit_1[0], $sDelim_Item, "")
				$iValDim_2 = @extended + 1
				Local $aTmp[$iValDim_1][$iValDim_2], $aSplit_2
				For $i = 0 To $iValDim_1 - 1
					$aSplit_2 = StringSplit($aSplit_1[$i], $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
					For $j = 0 To $iValDim_2 - 1
						$aTmp[$i][$j] = $aSplit_2[$j]
					Next
				Next
				$vValue = $aTmp
			EndIf
			; Check if too many columns to fit
			If UBound($vValue, $UBOUND_COLUMNS) + $iStart > UBound($avArray, $UBOUND_COLUMNS) Then Return SetError(3, 0, -1)
			ReDim $avArray[$iDim_1 + $iValDim_1][$iDim_2]
			For $iWriteTo_Index = 0 To $iValDim_1 - 1
				For $j = 0 To $iDim_2 - 1
					If $j < $iStart Then
						$avArray[$iWriteTo_Index + $iDim_1][$j] = ""
					ElseIf $j - $iStart > $iValDim_2 - 1 Then
						$avArray[$iWriteTo_Index + $iDim_1][$j] = ""
					Else
						If IsFunc($hDataType) Then
							$avArray[$iWriteTo_Index + $iDim_1][$j] = $hDataType($vValue[$iWriteTo_Index][$j - $iStart])
						Else
							$avArray[$iWriteTo_Index + $iDim_1][$j] = $vValue[$iWriteTo_Index][$j - $iStart]
						EndIf
					EndIf
				Next
			Next
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch

	Return UBound($avArray, $UBOUND_ROWS) - 1

EndFunc   ;==>_ArrayAdd

; #FUNCTION# ====================================================================================================================
; Author ........: Jos
; Modified.......: Ultima - added $iEnd as parameter, code cleanup; Melba23 - added support for empty & 2D arrays
; ===============================================================================================================================
Func _ArrayBinarySearch(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0, $iColumn = 0)

	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If $iColumn = Default Then $iColumn = 0
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)

	; Bounds checking
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS)
	If $iDim_1 = 0 Then Return SetError(6, 0, -1)

	If $iEnd < 1 Or $iEnd > $iDim_1 - 1 Then $iEnd = $iDim_1 - 1
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(4, 0, -1)
	Local $iMid = Int(($iEnd + $iStart) / 2)

	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			If $avArray[$iStart] > $vValue Or $avArray[$iEnd] < $vValue Then Return SetError(2, 0, -1)
			; Search
			While $iStart <= $iMid And $vValue <> $avArray[$iMid]
				If $vValue < $avArray[$iMid] Then
					$iEnd = $iMid - 1
				Else
					$iStart = $iMid + 1
				EndIf
				$iMid = Int(($iEnd + $iStart) / 2)
			WEnd
			If $iStart > $iEnd Then Return SetError(3, 0, -1) ; Entry not found
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS) - 1
			If $iColumn < 0 Or $iColumn > $iDim_2 Then Return SetError(7, 0, -1)
			If $avArray[$iStart][$iColumn] > $vValue Or $avArray[$iEnd][$iColumn] < $vValue Then Return SetError(2, 0, -1)
			; Search
			While $iStart <= $iMid And $vValue <> $avArray[$iMid][$iColumn]
				If $vValue < $avArray[$iMid][$iColumn] Then
					$iEnd = $iMid - 1
				Else
					$iStart = $iMid + 1
				EndIf
				$iMid = Int(($iEnd + $iStart) / 2)
			WEnd
			If $iStart > $iEnd Then Return SetError(3, 0, -1) ; Entry not found
		Case Else
			Return SetError(5, 0, -1)
	EndSwitch

	Return $iMid
EndFunc   ;==>_ArrayBinarySearch

; #FUNCTION# ====================================================================================================================
; Author ........: Melba23
; Modified.......:
; ===============================================================================================================================
Func _ArrayColDelete(ByRef $avArray, $iColumn, $bConvert = False)

	If $bConvert = Default Then $bConvert = False
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS)
	If UBound($avArray, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(2, 0, -1)
	Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS)
	Switch $iDim_2
		Case 2
			If $iColumn < 0 Or $iColumn > 1 Then Return SetError(3, 0, -1)
			If $bConvert Then
				Local $aTempArray[$iDim_1]
				For $i = 0 To $iDim_1 - 1
					$aTempArray[$i] = $avArray[$i][(Not $iColumn)]
				Next
				$avArray = $aTempArray
			Else
				ContinueCase
			EndIf
		Case Else
			If $iColumn < 0 Or $iColumn > $iDim_2 - 1 Then Return SetError(3, 0, -1)
			For $i = 0 To $iDim_1 - 1
				For $j = $iColumn To $iDim_2 - 2
					$avArray[$i][$j] = $avArray[$i][$j + 1]
				Next
			Next
			ReDim $avArray[$iDim_1][$iDim_2 - 1]
	EndSwitch

	Return UBound($avArray, $UBOUND_COLUMNS)
EndFunc   ;==>_ArrayColDelete

; #FUNCTION# ====================================================================================================================
; Author ........: Melba23
; Modified.......:
; ===============================================================================================================================
Func _ArrayColInsert(ByRef $avArray, $iColumn)

	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS)
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			Local $aTempArray[$iDim_1][2]
			Switch $iColumn
				Case 0, 1
					For $i = 0 To $iDim_1 - 1
						$aTempArray[$i][(Not $iColumn)] = $avArray[$i]
					Next
				Case Else
					Return SetError(3, 0, -1)
			EndSwitch
			$avArray = $aTempArray
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS)
			If $iColumn < 0 Or $iColumn > $iDim_2 Then Return SetError(3, 0, -1)
			ReDim $avArray[$iDim_1][$iDim_2 + 1]
			For $i = 0 To $iDim_1 - 1
				For $j = $iDim_2 To $iColumn + 1 Step -1
					$avArray[$i][$j] = $avArray[$i][$j - 1]
				Next
				$avArray[$i][$iColumn] = ""
			Next
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch

	Return UBound($avArray, $UBOUND_COLUMNS)
EndFunc   ;==>_ArrayColInsert

; #FUNCTION# ====================================================================================================================
; Author ........: Erik Pilsits
; Modified.......: 07/08/2008
; ===============================================================================================================================
Func _ArrayCombinations(Const ByRef $avArray, $iSet, $sDelim = "")

	If $sDelim = Default Then $sDelim = ""
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(2, 0, 0)

	Local $iN = UBound($avArray)
	Local $iR = $iSet
	Local $aIdx[$iR]
	For $i = 0 To $iR - 1
		$aIdx[$i] = $i
	Next
	Local $iTotal = __Array_Combinations($iN, $iR)
	Local $iLeft = $iTotal
	Local $aResult[$iTotal + 1]
	$aResult[0] = $iTotal

	Local $iCount = 1
	While $iLeft > 0
		__Array_GetNext($iN, $iR, $iLeft, $iTotal, $aIdx)
		For $i = 0 To $iSet - 1
			$aResult[$iCount] &= $avArray[$aIdx[$i]] & $sDelim
		Next
		If $sDelim <> "" Then $aResult[$iCount] = StringTrimRight($aResult[$iCount], 1)
		$iCount += 1
	WEnd
	Return $aResult
EndFunc   ;==>_ArrayCombinations

; #FUNCTION# ====================================================================================================================
; Author ........: Ultima
; Modified.......: Partypooper - added target start index; Melba23 - add 2D support
; ===============================================================================================================================
Func _ArrayConcatenate(ByRef $avArray_Tgt, Const ByRef $avArray_Src, $iStart = 0)

	If $iStart = Default Then $iStart = 0
	If Not IsArray($avArray_Tgt) Then Return SetError(1, 0, -1)
	If Not IsArray($avArray_Src) Then Return SetError(2, 0, -1)
	Local $iDim_Total_Tgt = UBound($avArray_Tgt, $UBOUND_DIMENSIONS)
	Local $iDim_Total_Src = UBound($avArray_Src, $UBOUND_DIMENSIONS)
	Local $iDim_1_Tgt = UBound($avArray_Tgt, $UBOUND_ROWS)
	Local $iDim_1_Src = UBound($avArray_Src, $UBOUND_ROWS)
	If $iStart < 0 Or $iStart > $iDim_1_Src - 1 Then Return SetError(6, 0, -1)
	Switch $iDim_Total_Tgt
		Case 1
			If $iDim_Total_Src <> 1 Then Return SetError(4, 0, -1)
			ReDim $avArray_Tgt[$iDim_1_Tgt + $iDim_1_Src - $iStart]
			For $i = $iStart To $iDim_1_Src - 1
				$avArray_Tgt[$iDim_1_Tgt + $i - $iStart] = $avArray_Src[$i]
			Next
		Case 2
			If $iDim_Total_Src <> 2 Then Return SetError(4, 0, -1)
			Local $iDim_2_Tgt = UBound($avArray_Tgt, $UBOUND_COLUMNS)
			If UBound($avArray_Src, $UBOUND_COLUMNS) <> $iDim_2_Tgt Then Return SetError(5, 0, -1)
			ReDim $avArray_Tgt[$iDim_1_Tgt + $iDim_1_Src - $iStart][$iDim_2_Tgt]
			For $i = $iStart To $iDim_1_Src - 1
				For $j = 0 To $iDim_2_Tgt - 1
					$avArray_Tgt[$iDim_1_Tgt + $i - $iStart][$j] = $avArray_Src[$i][$j]
				Next
			Next
		Case Else
			Return SetError(3, 0, -1)
	EndSwitch
	Return UBound($avArray_Tgt, $UBOUND_ROWS)
EndFunc   ;==>_ArrayConcatenate

; #FUNCTION# ====================================================================================================================
; Author ........: Cephas <cephas at clergy dot net>
; Modified.......: Jos - array passed ByRef, jaberwocky6669, Melba23 - added 2D support & multiple deletion
; ===============================================================================================================================
Func _ArrayDelete(ByRef $avArray, $vRange)

	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS) - 1
	If IsArray($vRange) Then
		If UBound($vRange, $UBOUND_DIMENSIONS) <> 1 Or UBound($vRange, $UBOUND_ROWS) < 2 Then Return SetError(4, 0, -1)
	Else
		; Expand range
		Local $iNumber, $aSplit_1, $aSplit_2
		$vRange = StringStripWS($vRange, 8)
		$aSplit_1 = StringSplit($vRange, ";")
		$vRange = ""
		For $i = 1 To $aSplit_1[0]
			; Check for correct range syntax
			If Not StringRegExp($aSplit_1[$i], "^\d+(-\d+)?$") Then Return SetError(3, 0, -1)
			$aSplit_2 = StringSplit($aSplit_1[$i], "-")
			Switch $aSplit_2[0]
				Case 1
					$vRange &= $aSplit_2[1] & ";"
				Case 2
					If Number($aSplit_2[2]) >= Number($aSplit_2[1]) Then
						$iNumber = $aSplit_2[1] - 1
						Do
							$iNumber += 1
							$vRange &= $iNumber & ";"
						Until $iNumber = $aSplit_2[2]
					EndIf
			EndSwitch
		Next
		$vRange = StringSplit(StringTrimRight($vRange, 1), ";")
	EndIf
	If $vRange[1] < 0 Or $vRange[$vRange[0]] > $iDim_1 Then Return SetError(5, 0, -1)
	; Remove rows
	Local $iCopyTo_Index = 0
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			; Loop through array flagging elements to be deleted
			For $i = 1 To $vRange[0]
				$avArray[$vRange[$i]] = ChrW(0xFAB1)
			Next
			; Now copy rows to keep to fill deleted rows
			For $iReadFrom_Index = 0 To $iDim_1
				If $avArray[$iReadFrom_Index] == ChrW(0xFAB1) Then
					ContinueLoop
				Else
					If $iReadFrom_Index <> $iCopyTo_Index Then
						$avArray[$iCopyTo_Index] = $avArray[$iReadFrom_Index]
					EndIf
					$iCopyTo_Index += 1
				EndIf
			Next
			ReDim $avArray[$iDim_1 - $vRange[0] + 1]
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS) - 1
			; Loop through array flagging elements to be deleted
			For $i = 1 To $vRange[0]
				$avArray[$vRange[$i]][0] = ChrW(0xFAB1)
			Next
			; Now copy rows to keep to fill deleted rows
			For $iReadFrom_Index = 0 To $iDim_1
				If $avArray[$iReadFrom_Index][0] == ChrW(0xFAB1) Then
					ContinueLoop
				Else
					If $iReadFrom_Index <> $iCopyTo_Index Then
						For $j = 0 To $iDim_2
							$avArray[$iCopyTo_Index][$j] = $avArray[$iReadFrom_Index][$j]
						Next
					EndIf
					$iCopyTo_Index += 1
				EndIf
			Next
			ReDim $avArray[$iDim_1 - $vRange[0] + 1][$iDim_2 + 1]
		Case Else
			Return SetError(2, 0, False)
	EndSwitch

	Return UBound($avArray, $UBOUND_ROWS)

EndFunc   ;==>_ArrayDelete

; #FUNCTION# ====================================================================================================================
; Author ........: randallc, Ultima
; Modified.......: Gary Frost (gafrost), Ultima, Zedna, jpm, Melba23, AZJIO, UEZ
; ===============================================================================================================================
Func _ArrayDisplay(Const ByRef $avArray, $sTitle = Default, $sArray_Range = Default, $iFlags = Default, $vUser_Separator = Default, $sHeader = Default, $iMax_ColWidth = Default, $iAlt_Color = Default, $hUser_Func = Default)

	; Default values
	If $sTitle = Default Then $sTitle = "ArrayDisplay"
	If $sArray_Range = Default Then $sArray_Range = ""
	If $iFlags = Default Then $iFlags = 0
	If $vUser_Separator = Default Then $vUser_Separator = ""
	If $sHeader = Default Then $sHeader = ""
	If $iMax_ColWidth = Default Then $iMax_ColWidth = 350
	If $iAlt_Color = Default Then $iAlt_Color = 0
	If $hUser_Func = Default Then $hUser_Func = 0

	; Check for transpose, column align, verbosity and button and "Row" column visibility
	Local $iTranspose = BitAND($iFlags, 1)
	Local $iColAlign = BitAND($iFlags, 6) ; 0 = Left (default); 2 = Right; 4 = Center
	Local $iVerbose = BitAND($iFlags, 8)
	Local $iButtonMargin = ((BitAND($iFlags, 32)) ? (0) : ((BitAND($iFlags, 16)) ? (20) : (40))) ; Flag 32 = 0; flag 16 = 20; neither flag = 40
	Local $iNoRow = BitAND($iFlags, 64)

	; Check valid array
	Local $sMsg = "", $iRet = 1
	If IsArray($avArray) Then
		; Dimension checking
		Local $iDimension = UBound($avArray, $UBOUND_DIMENSIONS), $iRowCount = UBound($avArray, $UBOUND_ROWS), $iColCount = UBound($avArray, $UBOUND_COLUMNS)
		If $iDimension > 2 Then
			$sMsg = "Larger than 2D array passed to function"
			$iRet = 2
		EndIf
	Else
		$sMsg = "No array variable passed to function"
	EndIf
	If $sMsg Then
		If $iVerbose And MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR + $MB_YESNO, _
				"ArrayDisplay Error: " & $sTitle, $sMsg & @CRLF & @CRLF & "Exit the script?") = $IDYES Then
			Exit
		Else
			Return SetError($iRet, 0, "")
		EndIf
	EndIf

	; Determine copy separator
	Local $iCW_ColWidth = Number($vUser_Separator)

	; Separator handling
	Local $sAD_Separator = ChrW(0xFAB1)
	; Set separator to use in this UDF and store existing one
	Local $sCurr_Separator = Opt("GUIDataSeparatorChar", $sAD_Separator)
	; Set default user separator if required
	If $vUser_Separator = "" Then $vUser_Separator = $sCurr_Separator

	; Declare variables
	Local $vTmp, $iRowLimit = 65525, $iColLimit = 250 ; Row = AutoIt 64k limit minus UDF controls; Column - arbitrary limit

	; Set original dimensions for data display
	Local $iDataRow = $iRowCount
	Local $iDataCol = $iColCount

	; Set display limits for dimensions - column value only set for 2D arrays
	Local $iItem_Start = 0, $iItem_End = $iRowCount - 1, $iSubItem_Start = 0, $iSubItem_End = (($iDimension = 2) ? ($iColCount - 1) : (0))
	; Flag to determine if range set
	Local $bRange_Flag = False
	; Check for range settings
	If $sArray_Range Then
		; Split into separate dimension sections
		Local $aArray_Range = StringRegExp($sArray_Range & "||", "(?U)(.*)\|", 3)
		; Dimension 1
		Local $avRangeSplit = StringSplit($aArray_Range[0], ":")
		If @error Then
			If Number($avRangeSplit[1]) Then
				$iItem_End = Number($avRangeSplit[1])
			EndIf
		Else
			$iItem_Start = Number($avRangeSplit[1])
			If Number($avRangeSplit[2]) Then
				$iItem_End = Number($avRangeSplit[2])
			EndIf
		EndIf
		; Ckeck row bounds
		If $iItem_Start > $iItem_End Then
			$vTmp = $iItem_Start
			$iItem_Start = $iItem_End
			$iItem_End = $vTmp
		EndIf
		If $iItem_Start < 0 Then $iItem_Start = 0
		If $iItem_End > $iRowCount - 1 Then $iItem_End = $iRowCount - 1
		; Check if range set
		If $iItem_Start <> 0 Or $iItem_End <> $iRowCount - 1 Then $bRange_Flag = True
		; Dimension 2
		If $iDimension = 2 Then
			$avRangeSplit = StringSplit($aArray_Range[1], ":")
			If @error Then
				If Number($avRangeSplit[1]) Then
					$iSubItem_End = Number($avRangeSplit[1])
				EndIf
			Else
				$iSubItem_Start = Number($avRangeSplit[1])
				If Number($avRangeSplit[2]) Then
					$iSubItem_End = Number($avRangeSplit[2])
				EndIf
			EndIf
			; Check column bounds
			If $iSubItem_Start > $iSubItem_End Then
				$vTmp = $iSubItem_Start
				$iSubItem_Start = $iSubItem_End
				$iSubItem_End = $vTmp
			EndIf
			If $iSubItem_Start < 0 Then $iSubItem_Start = 0
			If $iSubItem_End > $iColCount - 1 Then $iSubItem_End = $iColCount - 1
			; Check if range set
			If $iSubItem_Start <> 0 Or $iSubItem_End <> $iColCount - 1 Then $bRange_Flag = True
		EndIf
	EndIf

	; Create data display
	Local $sDisplayData = "[" & $iDataRow
	; Check if rows will be truncated
	Local $bTruncated = False
	If $iTranspose Then
		If $iItem_End - $iItem_Start > $iColLimit Then
			$bTruncated = True
			$iItem_End = $iItem_Start + $iColLimit - 1
		EndIf
	Else
		If $iItem_End - $iItem_Start > $iRowLimit Then
			$bTruncated = True
			$iItem_End = $iItem_Start + $iRowLimit - 1
		EndIf
	EndIf
	If $bTruncated Then
		$sDisplayData &= "*]"
	Else
		$sDisplayData &= "]"
	EndIf
	If $iDimension = 2 Then
		$sDisplayData &= " [" & $iDataCol
		If $iTranspose Then
			If $iSubItem_End - $iSubItem_Start > $iRowLimit Then
				$bTruncated = True
				$iSubItem_End = $iSubItem_Start + $iRowLimit - 1
			EndIf
		Else
			If $iSubItem_End - $iSubItem_Start > $iColLimit Then
				$bTruncated = True
				$iSubItem_End = $iSubItem_Start + $iColLimit - 1
			EndIf
		EndIf
		If $bTruncated Then
			$sDisplayData &= "*]"
		Else
			$sDisplayData &= "]"
		EndIf
	EndIf
	; Create tooltip data
	Local $sTipData = ""
	If $bTruncated Then $sTipData &= "Truncated"
	If $bRange_Flag Then
		If $sTipData Then $sTipData &= " - "
		$sTipData &= "Range set"
	EndIf
	If $iTranspose Then
		If $sTipData Then $sTipData &= " - "
		$sTipData &= "Transposed"
	EndIf

	; Split custom header on separator
	Local $asHeader = StringSplit($sHeader, $sCurr_Separator, $STR_NOCOUNT) ; No count element
	If UBound($asHeader) = 0 Then Local $asHeader[1] = [""]
	$sHeader = "Row"
	Local $iIndex = $iSubItem_Start
	If $iTranspose Then
		; All default headers
		For $j = $iItem_Start To $iItem_End
			$sHeader &= $sAD_Separator & "Col " & $j
		Next
	Else
		; Create custom header with available items
		If $asHeader[0] Then
			; Set as many as available
			For $iIndex = $iSubItem_Start To $iSubItem_End
				; Check custom header available
				If $iIndex >= UBound($asHeader) Then ExitLoop
				$sHeader &= $sAD_Separator & $asHeader[$iIndex]
			Next
		EndIf
		; Add default headers to fill to end
		For $j = $iIndex To $iSubItem_End
			$sHeader &= $sAD_Separator & "Col " & $j
		Next
	EndIf
	; Remove "Row" header if not needed
	If $iNoRow Then $sHeader = StringTrimLeft($sHeader, 4)

	; Display splash dialog if required
	If $iVerbose And ($iItem_End - $iItem_Start + 1) * ($iSubItem_End - $iSubItem_Start + 1) > 10000 Then
		SplashTextOn("ArrayDisplay", "Preparing display" & @CRLF & @CRLF & "Please be patient", 300, 100)
	EndIf

	; Convert array into ListViewItem compatible lines
	Local $iBuffer = 4094 ; Max characters a ListView will display (Windows limitation)
	If $iTranspose Then
		; Swap dimensions
		$vTmp = $iItem_Start
		$iItem_Start = $iSubItem_Start
		$iSubItem_Start = $vTmp
		$vTmp = $iItem_End
		$iItem_End = $iSubItem_End
		$iSubItem_End = $vTmp
	EndIf
	Local $avArrayText[$iItem_End - $iItem_Start + 1]
	For $i = $iItem_Start To $iItem_End
		; Add row number if required
		If Not $iNoRow Then $avArrayText[$i - $iItem_Start] = "[" & $i & "]"
		For $j = $iSubItem_Start To $iSubItem_End
			If $iDimension = 1 Then
				If $iTranspose Then
					$vTmp = $avArray[$j]
				Else
					$vTmp = $avArray[$i]
				EndIf
			Else
				If $iTranspose Then
					$vTmp = $avArray[$j][$i]
				Else
					$vTmp = $avArray[$i][$j]
				EndIf
			EndIf
			; Truncate if required so ListView will display
			If StringLen($vTmp) > $iBuffer Then $vTmp = StringLeft($vTmp, $iBuffer)
			$avArrayText[$i - $iItem_Start] &= $sAD_Separator & $vTmp
		Next
		; Remove leading delimiter if no "Row" column
		If $iNoRow Then $avArrayText[$i - $iItem_Start] = StringTrimLeft($avArrayText[$i - $iItem_Start], 1)
	Next

	; GUI Constants
	Local Const $_ARRAYCONSTANT_GUI_DOCKBOTTOM = 64
	Local Const $_ARRAYCONSTANT_GUI_DOCKBORDERS = 102
	Local Const $_ARRAYCONSTANT_GUI_DOCKHEIGHT = 512
	Local Const $_ARRAYCONSTANT_GUI_DOCKLEFT = 2
	Local Const $_ARRAYCONSTANT_GUI_DOCKRIGHT = 4
	Local Const $_ARRAYCONSTANT_GUI_DOCKHCENTER = 8
	Local Const $_ARRAYCONSTANT_GUI_EVENT_CLOSE = -3
	Local Const $_ARRAYCONSTANT_GUI_FOCUS = 256
	Local Const $_ARRAYCONSTANT_GUI_BKCOLOR_LV_ALTERNATE = 0xFE000000
	Local Const $_ARRAYCONSTANT_SS_CENTER = 0x1
	Local Const $_ARRAYCONSTANT_SS_CENTERIMAGE = 0x0200
	Local Const $_ARRAYCONSTANT_LVM_GETITEMCOUNT = (0x1000 + 4)
	Local Const $_ARRAYCONSTANT_LVM_GETITEMRECT = (0x1000 + 14)
	Local Const $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH = (0x1000 + 29)
	Local Const $_ARRAYCONSTANT_LVM_SETCOLUMNWIDTH = (0x1000 + 30)
	Local Const $_ARRAYCONSTANT_LVM_GETITEMSTATE = (0x1000 + 44)
	Local Const $_ARRAYCONSTANT_LVM_GETSELECTEDCOUNT = (0x1000 + 50)
	Local Const $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE = (0x1000 + 54)
	Local Const $_ARRAYCONSTANT_LVS_EX_GRIDLINES = 0x1
	Local Const $_ARRAYCONSTANT_LVIS_SELECTED = 0x2
	Local Const $_ARRAYCONSTANT_LVS_SHOWSELALWAYS = 0x8
	Local Const $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT = 0x20
	Local Const $_ARRAYCONSTANT_WS_EX_CLIENTEDGE = 0x0200
	Local Const $_ARRAYCONSTANT_WS_MAXIMIZEBOX = 0x00010000
	Local Const $_ARRAYCONSTANT_WS_MINIMIZEBOX = 0x00020000
	Local Const $_ARRAYCONSTANT_WS_SIZEBOX = 0x00040000
	Local Const $_ARRAYCONSTANT_WM_SETREDRAW = 11
	Local Const $_ARRAYCONSTANT_LVSCW_AUTOSIZE = -1

	; Create GUI
	Local $iOrgWidth = 210, $iHeight = 200, $iMinSize = 250
	Local $hGUI = GUICreate($sTitle, $iOrgWidth, $iHeight, Default, Default, BitOR($_ARRAYCONSTANT_WS_SIZEBOX, $_ARRAYCONSTANT_WS_MINIMIZEBOX, $_ARRAYCONSTANT_WS_MAXIMIZEBOX))
	Local $aiGUISize = WinGetClientSize($hGUI)
	Local $iButtonWidth_2 = $aiGUISize[0] / 2
	Local $iButtonWidth_3 = $aiGUISize[0] / 3
	; Create ListView
	Local $idListView = GUICtrlCreateListView($sHeader, 0, 0, $aiGUISize[0], $aiGUISize[1] - $iButtonMargin, $_ARRAYCONSTANT_LVS_SHOWSELALWAYS)
	GUICtrlSetBkColor($idListView, $_ARRAYCONSTANT_GUI_BKCOLOR_LV_ALTERNATE)
	GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_GRIDLINES, $_ARRAYCONSTANT_LVS_EX_GRIDLINES)
	GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT)
	GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE)
	Local $idCopy_ID = 9999, $idCopy_Data = 99999, $idData_Label = 99999, $idUser_Func = 99999, $idExit_Script = 99999
	; Check if any buttons required
	If $iButtonMargin Then
		; Create Copy buttons
		$idCopy_ID = GUICtrlCreateButton("Copy Data && Hdr/Row", 0, $aiGUISize[1] - $iButtonMargin, $iButtonWidth_2, 20)
		$idCopy_Data = GUICtrlCreateButton("Copy Data Only", $iButtonWidth_2, $aiGUISize[1] - $iButtonMargin, $iButtonWidth_2, 20)
		; Check if other buttons are required
		If $iButtonMargin = 40 Then
			Local $iButtonWidth_Var = $iButtonWidth_2
			Local $iOffset = $iButtonWidth_2
			If IsFunc($hUser_Func) Then
				; Create UserFunc button if function passed
				$idUser_Func = GUICtrlCreateButton("Run User Func", $iButtonWidth_3, $aiGUISize[1] - 20, $iButtonWidth_3, 20)
				$iButtonWidth_Var = $iButtonWidth_3
				$iOffset = $iButtonWidth_3 * 2
			EndIf
			; Create Exit button and data label
			$idExit_Script = GUICtrlCreateButton("Exit Script", $iOffset, $aiGUISize[1] - 20, $iButtonWidth_Var, 20)
			$idData_Label = GUICtrlCreateLabel($sDisplayData, 0, $aiGUISize[1] - 20, $iButtonWidth_Var, 18, BitOR($_ARRAYCONSTANT_SS_CENTER, $_ARRAYCONSTANT_SS_CENTERIMAGE))
			; Change label colour and create tooltip if required
			Select
				Case $bTruncated Or $iTranspose Or $bRange_Flag
					GUICtrlSetColor($idData_Label, 0xFF0000)
					GUICtrlSetTip($idData_Label, $sTipData)
			EndSelect
		EndIf
	EndIf
	; Set resizing
	GUICtrlSetResizing($idListView, $_ARRAYCONSTANT_GUI_DOCKBORDERS)
	GUICtrlSetResizing($idCopy_ID, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
	GUICtrlSetResizing($idCopy_Data, $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
	GUICtrlSetResizing($idData_Label, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
	GUICtrlSetResizing($idUser_Func, $_ARRAYCONSTANT_GUI_DOCKHCENTER + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
	GUICtrlSetResizing($idExit_Script, $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)

	; Start ListView update
	GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_WM_SETREDRAW, 0, 0)

	; Fill listview
	Local $idItem
	For $i = 0 To UBound($avArrayText) - 1
		$idItem = GUICtrlCreateListViewItem($avArrayText[$i], $idListView)
		If $iAlt_Color Then
			GUICtrlSetBkColor($idItem, $iAlt_Color)
		EndIf
	Next

	; Align columns if required - $iColAlign = 2 for Right and 4 for Center
	If $iColAlign Then
		Local Const $_ARRAYCONSTANT_LVCF_FMT = 0x01
		Local Const $_ARRAYCONSTANT_LVM_SETCOLUMNW = (0x1000 + 96)
		Local $tColumn = DllStructCreate("uint Mask;int Fmt;int CX;ptr Text;int TextMax;int SubItem;int Image;int Order;int cxMin;int cxDefault;int cxIdeal")
		DllStructSetData($tColumn, "Mask", $_ARRAYCONSTANT_LVCF_FMT)
		DllStructSetData($tColumn, "Fmt", $iColAlign / 2) ; Left = 0; Right = 1; Center = 2
		Local $pColumn = DllStructGetPtr($tColumn)
		; Loop through columns
		For $i = 1 To $iSubItem_End - $iSubItem_Start + 1
			GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETCOLUMNW, $i, $pColumn)
		Next
	EndIf

	; End ListView update
	GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_WM_SETREDRAW, 1, 0)

	; Allow for borders with and without vertical scrollbar
	Local $iBorder = 45
	If UBound($avArrayText) > 20 Then
		$iBorder += 20
	EndIf
	; Adjust dialog width
	Local $iWidth = $iBorder, $iColWidth = 0, $aiColWidth[$iSubItem_End - $iSubItem_Start + 2], $iMin_ColWidth = 55
	; Get required column widths to fit items
	For $i = 0 To $iSubItem_End - $iSubItem_Start + 1
		GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETCOLUMNWIDTH, $i, $_ARRAYCONSTANT_LVSCW_AUTOSIZE)
		$iColWidth = GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH, $i, 0)
		; Set minimum if required
		If $iColWidth < $iMin_ColWidth Then
			GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETCOLUMNWIDTH, $i, $iMin_ColWidth)
			$iColWidth = $iMin_ColWidth
		EndIf
		; Add to total width
		$iWidth += $iColWidth
		; Store  value
		$aiColWidth[$i] = $iColWidth
	Next
	; Reduce width if no "Row" colukm
	If $iNoRow Then $iWidth -= 55
	; Now check max size
	If $iWidth > @DesktopWidth - 100 Then
		; Apply max col width limit to reduce width
		$iWidth = $iBorder
		For $i = 0 To $iSubItem_End - $iSubItem_Start + 1
			If $aiColWidth[$i] > $iMax_ColWidth Then
				; Reset width
				GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETCOLUMNWIDTH, $i, $iMax_ColWidth)
				$iWidth += $iMax_ColWidth
			Else
				; Retain width
				$iWidth += $aiColWidth[$i]
			EndIf
		Next
	EndIf
	; Check max/min width
	If $iWidth > @DesktopWidth - 100 Then
		$iWidth = @DesktopWidth - 100
	ElseIf $iWidth < $iMinSize Then
		$iWidth = $iMinSize
	EndIf

	; Get row height
	Local $tRECT = DllStructCreate("struct; long Left;long Top;long Right;long Bottom; endstruct") ; $tagRECT
	DllCall("user32.dll", "struct*", "SendMessageW", "hwnd", GUICtrlGetHandle($idListView), "uint", $_ARRAYCONSTANT_LVM_GETITEMRECT, "wparam", 0, "struct*", $tRECT)
	; Set required GUI height
	Local $aiWin_Pos = WinGetPos($hGUI)
	Local $aiLV_Pos = ControlGetPos($hGUI, "", $idListView)
	$iHeight = ((UBound($avArrayText) + 2) * (DllStructGetData($tRECT, "Bottom") - DllStructGetData($tRECT, "Top"))) + $aiWin_Pos[3] - $aiLV_Pos[3]
	; Check min/max height
	If $iHeight > @DesktopHeight - 100 Then
		$iHeight = @DesktopHeight - 100
	ElseIf $iHeight < $iMinSize Then
		$iHeight = $iMinSize
	EndIf

	SplashOff()

	; Display and resize dialog
	GUISetState(@SW_HIDE, $hGUI)
	WinMove($hGUI, "", (@DesktopWidth - $iWidth) / 2, (@DesktopHeight - $iHeight) / 2, $iWidth, $iHeight)
	GUISetState(@SW_SHOW, $hGUI)

	; Switch to GetMessage mode
	Local $iOnEventMode = Opt("GUIOnEventMode", 0), $iMsg

	While 1

		$iMsg = GUIGetMsg() ; Variable needed to check which "Copy" button was pressed
		Switch $iMsg
			Case $_ARRAYCONSTANT_GUI_EVENT_CLOSE
				ExitLoop

			Case $idCopy_ID, $idCopy_Data
				; Count selected rows
				Local $iSel_Count = GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETSELECTEDCOUNT, 0, 0)
				; Display splash dialog if required
				If $iVerbose And (Not $iSel_Count) And ($iItem_End - $iItem_Start) * ($iSubItem_End - $iSubItem_Start) > 10000 Then
					SplashTextOn("ArrayDisplay", "Copying data" & @CRLF & @CRLF & "Please be patient", 300, 100)
				EndIf
				; Generate clipboard text
				Local $sClip = "", $sItem, $aSplit
				; Add items
				For $i = 0 To $iItem_End - $iItem_Start
					; Skip if copying selected rows and item not selected
					If $iSel_Count And Not (GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, $_ARRAYCONSTANT_LVIS_SELECTED)) Then
						ContinueLoop
					EndIf
					$sItem = $avArrayText[$i]
					If $iMsg = $idCopy_Data Then
						; Remove row ID if required
						$sItem = StringRegExpReplace($sItem, "^\[\d+\].(.*)$", "$1")
					EndIf
					If $iCW_ColWidth Then
						; Expand columns
						$aSplit = StringSplit($sItem, $sAD_Separator)
						$sItem = ""
						For $j = 1 To $aSplit[0]
							$sItem &= StringFormat("%-" & $iCW_ColWidth + 1 & "s", StringLeft($aSplit[$j], $iCW_ColWidth))
						Next
					Else
						; Use defined separator
						$sItem = StringReplace($sItem, $sAD_Separator, $vUser_Separator)
					EndIf
					$sClip &= $sItem & @CRLF
				Next
				; Add header line if required
				If $iMsg = $idCopy_ID Then
					If $iCW_ColWidth Then
						$aSplit = StringSplit($sHeader, $sAD_Separator)
						$sItem = ""
						For $j = 1 To $aSplit[0]
							$sItem &= StringFormat("%-" & $iCW_ColWidth + 1 & "s", StringLeft($aSplit[$j], $iCW_ColWidth))
						Next
					Else
						$sItem = StringReplace($sHeader, $sAD_Separator, $vUser_Separator)
					EndIf
					$sClip = $sItem & @CRLF & $sClip
				EndIf
				;Send to clipboard
				ClipPut($sClip)
				; Remove splash if used
				SplashOff()
				; Refocus ListView
				GUICtrlSetState($idListView, $_ARRAYCONSTANT_GUI_FOCUS)

			Case $idUser_Func
				; Get selected indices
				Local $aiSelItems[$iRowLimit] = [0]
				For $i = 0 To GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETITEMCOUNT, 0, 0)
					If GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, $_ARRAYCONSTANT_LVIS_SELECTED) Then
						$aiSelItems[0] += 1
						$aiSelItems[$aiSelItems[0]] = $i + $iItem_Start
					EndIf
				Next
				ReDim $aiSelItems[$aiSelItems[0] + 1]
				; Pass array and selection to user function
				$hUser_Func($avArray, $aiSelItems)
				GUICtrlSetState($idListView, $_ARRAYCONSTANT_GUI_FOCUS)

			Case $idExit_Script
				; Clear up
				GUIDelete($hGUI)
				Exit
		EndSwitch
	WEnd

	; Clear up
	GUIDelete($hGUI)
	Opt("GUIOnEventMode", $iOnEventMode) ; Reset original GUI mode
	Opt("GUIDataSeparatorChar", $sCurr_Separator) ; Reset original separator

	Return 1

EndFunc   ;==>_ArrayDisplay

; #FUNCTION# ====================================================================================================================
; Author ........: Melba23
; Modified.......:
; ===============================================================================================================================
Func _ArrayExtract(Const ByRef $avArray, $iStart_Row = 0, $iEnd_Row = 0, $iStart_Col = 0, $iEnd_Col = 0)

	If $iStart_Row = Default Then $iStart_Row = -1
	If $iEnd_Row = Default Then $iEnd_Row = -1
	If $iStart_Col = Default Then $iStart_Col = -1
	If $iEnd_Col = Default Then $iEnd_Col = -1
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS) - 1
	If $iEnd_Row = -1 Then $iEnd_Row = $iDim_1
	If $iStart_Row = -1 Then $iStart_Row = 0
	If $iStart_Row < 0 Or $iEnd_Row < 0 Then Return SetError(3, 0, -1)
	If $iStart_Row > $iDim_1 Or $iEnd_Row > $iDim_1 Then Return SetError(3, 0, -1)
	If $iStart_Row > $iEnd_Row Then Return SetError(4, 0, -1)
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			Local $aRetArray[$iEnd_Row - $iStart_Row + 1]
			For $i = 0 To $iEnd_Row - $iStart_Row
				$aRetArray[$i] = $avArray[$i + $iStart_Row]
			Next
			Return $aRetArray
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS) - 1
			If $iEnd_Col = -1 Then $iEnd_Col = $iDim_2
			If $iStart_Col = -1 Then $iStart_Col = 0
			If $iStart_Col < 0 Or $iEnd_Col < 0 Then Return SetError(5, 0, -1)
			If $iStart_Col > $iDim_2 Or $iEnd_Col > $iDim_2 Then Return SetError(5, 0, -1)
			If $iStart_Col > $iEnd_Col Then Return SetError(6, 0, -1)
			If $iStart_Col = $iEnd_Col Then
				Local $aRetArray[$iEnd_Row - $iStart_Row + 1]
			Else
				Local $aRetArray[$iEnd_Row - $iStart_Row + 1][$iEnd_Col - $iStart_Col + 1]
			EndIf
			For $i = 0 To $iEnd_Row - $iStart_Row
				For $j = 0 To $iEnd_Col - $iStart_Col
					If $iStart_Col = $iEnd_Col Then
						$aRetArray[$i] = $avArray[$i + $iStart_Row][$j + $iStart_Col]
					Else
						$aRetArray[$i][$j] = $avArray[$i + $iStart_Row][$j + $iStart_Col]
					EndIf
				Next
			Next
			Return $aRetArray
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch

	Return 1

EndFunc   ;==>_ArrayExtract

; #FUNCTION# ====================================================================================================================
; Author ........: GEOSoft, Ultima
; Modified.......:
; ===============================================================================================================================
Func _ArrayFindAll(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iCompare = 0, $iSubItem = 0, $bRow = False)

	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If $iCase = Default Then $iCase = 0
	If $iCompare = Default Then $iCompare = 0
	If $iSubItem = Default Then $iSubItem = 0
	If $bRow = Default Then $bRow = False

	$iStart = _ArraySearch($avArray, $vValue, $iStart, $iEnd, $iCase, $iCompare, 1, $iSubItem, $bRow)
	If @error Then Return SetError(@error, 0, -1)

	Local $iIndex = 0, $avResult[UBound($avArray)]
	Do
		$avResult[$iIndex] = $iStart
		$iIndex += 1
		$iStart = _ArraySearch($avArray, $vValue, $iStart + 1, $iEnd, $iCase, $iCompare, 1, $iSubItem, $bRow)
	Until @error

	ReDim $avResult[$iIndex]
	Return $avResult
EndFunc   ;==>_ArrayFindAll

; #FUNCTION# ====================================================================================================================
; Author ........: Jos
; Modified.......: Ultima - code cleanup; Melba23 - element position check, 2D support & multiple insertions
; ===============================================================================================================================
Func _ArrayInsert(ByRef $avArray, $vRange, $vValue = "", $iStart = 0, $sDelim_Item = "|", $sDelim_Row = @CRLF, $hDataType = 0)

	If $vValue = Default Then $vValue = ""
	If $iStart = Default Then $iStart = 0
	If $sDelim_Item = Default Then $sDelim_Item = "|"
	If $sDelim_Row = Default Then $sDelim_Row = @CRLF
	If $hDataType = Default Then $hDataType = 0
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS) - 1
	Local $aSplit_1, $aSplit_2
	If IsArray($vRange) Then
		If UBound($vRange, $UBOUND_DIMENSIONS) <> 1 Or UBound($vRange, $UBOUND_ROWS) < 2 Then Return SetError(4, 0, -1)
	Else
		; Expand range
		Local $iNumber
		$vRange = StringStripWS($vRange, 8)
		$aSplit_1 = StringSplit($vRange, ";")
		$vRange = ""
		For $i = 1 To $aSplit_1[0]
			; Check for correct range syntax
			If Not StringRegExp($aSplit_1[$i], "^\d+(-\d+)?$") Then Return SetError(3, 0, -1)
			$aSplit_2 = StringSplit($aSplit_1[$i], "-")
			Switch $aSplit_2[0]
				Case 1
					$vRange &= $aSplit_2[1] & ";"
				Case 2
					If Number($aSplit_2[2]) >= Number($aSplit_2[1]) Then
						$iNumber = $aSplit_2[1] - 1
						Do
							$iNumber += 1
							$vRange &= $iNumber & ";"
						Until $iNumber = $aSplit_2[2]
					EndIf
			EndSwitch
		Next
		$vRange = StringSplit(StringTrimRight($vRange, 1), ";")
	EndIf
	If $vRange[1] < 0 Or $vRange[$vRange[0]] > $iDim_1 Then Return SetError(5, 0, -1)
	For $i = 2 To $vRange[0]
		If $vRange[$i] < $vRange[$i - 1] Then Return SetError(3, 0, -1)
	Next
	Local $iCopyTo_Index = $iDim_1 + $vRange[0]
	Local $iInsertPoint_Index = $vRange[0]
	; Get lowest insert point
	Local $iInsert_Index = $vRange[$iInsertPoint_Index]

	; Insert lines
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			ReDim $avArray[$iDim_1 + $vRange[0] + 1]
			If IsArray($vValue) Then
				If UBound($vValue, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(5, 0, -1)
				$hDataType = 0
			Else
				Local $aTmp = StringSplit($vValue, $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
				If UBound($aTmp, $UBOUND_ROWS) = 1 Then
					$aTmp[0] = $vValue
					$hDataType = 0
				EndIf
				$vValue = $aTmp
			EndIf
			For $iReadFromIndex = $iDim_1 To 0 Step -1
				; Copy existing elements
				$avArray[$iCopyTo_Index] = $avArray[$iReadFromIndex]
				; Move up array
				$iCopyTo_Index -= 1
				; Get next insert point
				$iInsert_Index = $vRange[$iInsertPoint_Index]
				While $iReadFromIndex = $iInsert_Index
					; Insert new item
					If $iInsertPoint_Index <= UBound($vValue, $UBOUND_ROWS) Then
						If IsFunc($hDataType) Then
							$avArray[$iCopyTo_Index] = $hDataType($vValue[$iInsertPoint_Index - 1])
						Else
							$avArray[$iCopyTo_Index] = $vValue[$iInsertPoint_Index - 1]
						EndIf
					Else
						$avArray[$iCopyTo_Index] = ""
					EndIf
					; Move up array
					$iCopyTo_Index -= 1
					; Reset insert index
					$iInsertPoint_Index -= 1
					If $iInsertPoint_Index = 0 Then ExitLoop 2
					; Get next insert point
					$iInsert_Index = $vRange[$iInsertPoint_Index]
				WEnd
			Next
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS)
			If $iStart < 0 Or $iStart > $iDim_2 - 1 Then Return SetError(6, 0, -1)
			Local $iValDim_1, $iValDim_2
			If IsArray($vValue) Then
				If UBound($vValue, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(7, 0, -1)
				$iValDim_1 = UBound($vValue, $UBOUND_ROWS)
				$iValDim_2 = UBound($vValue, $UBOUND_COLUMNS)
				$hDataType = 0
			Else
				; Convert string to 2D array
				$aSplit_1 = StringSplit($vValue, $sDelim_Row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
				$iValDim_1 = UBound($aSplit_1, $UBOUND_ROWS)
				StringReplace($aSplit_1[0], $sDelim_Item, "")
				$iValDim_2 = @extended + 1
				Local $aTmp[$iValDim_1][$iValDim_2]
				For $i = 0 To $iValDim_1 - 1
					$aSplit_2 = StringSplit($aSplit_1[$i], $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
					For $j = 0 To $iValDim_2 - 1
						$aTmp[$i][$j] = $aSplit_2[$j]
					Next
				Next
				$vValue = $aTmp
			EndIf
			; Check if too many columns to fit
			If UBound($vValue, $UBOUND_COLUMNS) + $iStart > UBound($avArray, $UBOUND_COLUMNS) Then Return SetError(8, 0, -1)
			ReDim $avArray[$iDim_1 + $vRange[0] + 1][$iDim_2]
			For $iReadFromIndex = $iDim_1 To 0 Step -1
				; Copy existing elements
				For $j = 0 To $iDim_2 - 1
					$avArray[$iCopyTo_Index][$j] = $avArray[$iReadFromIndex][$j]
				Next
				; Move up array
				$iCopyTo_Index -= 1
				; Get next insert point
				$iInsert_Index = $vRange[$iInsertPoint_Index]
				While $iReadFromIndex = $iInsert_Index
					; Insert new item
					For $j = 0 To $iDim_2 - 1
						If $j < $iStart Then
							$avArray[$iCopyTo_Index][$j] = ""
						ElseIf $j - $iStart > $iValDim_2 - 1 Then
							$avArray[$iCopyTo_Index][$j] = ""
						Else
							If $iInsertPoint_Index - 1 < $iValDim_1 Then
								If IsFunc($hDataType) Then
									$avArray[$iCopyTo_Index][$j] = $hDataType($vValue[$iInsertPoint_Index - 1][$j - $iStart])
								Else
									$avArray[$iCopyTo_Index][$j] = $vValue[$iInsertPoint_Index - 1][$j - $iStart]
								EndIf
							Else
								$avArray[$iCopyTo_Index][$j] = ""
							EndIf
						EndIf
					Next
					; Move up array
					$iCopyTo_Index -= 1
					; Reset insert index
					$iInsertPoint_Index -= 1
					If $iInsertPoint_Index = 0 Then ExitLoop 2
					; Get next insert point
					$iInsert_Index = $vRange[$iInsertPoint_Index]
				WEnd
			Next
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch

	Return UBound($avArray, $UBOUND_ROWS)
EndFunc   ;==>_ArrayInsert

; #FUNCTION# ====================================================================================================================
; Author ........: Cephas <cephas at clergy dot net>
; Modified.......: Jos - Added $iCompNumeric and $iStart parameters and logic, Ultima - added $iEnd parameter, code cleanup; Melba23 - Added 2D support
; ===============================================================================================================================
Func _ArrayMax(Const ByRef $avArray, $iCompNumeric = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)

	If $iCompNumeric = Default Then $iCompNumeric = 0
	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If $iSubItem = Default Then $iSubItem = 0
	Local $iResult = _ArrayMaxIndex($avArray, $iCompNumeric, $iStart, $iEnd, $iSubItem)
	If @error Then Return SetError(@error, 0, "")
	If UBound($avArray, $UBOUND_DIMENSIONS) = 1 Then
		Return $avArray[$iResult]
	Else
		Return $avArray[$iResult][$iSubItem]
	EndIf
EndFunc   ;==>_ArrayMax

; #FUNCTION# ====================================================================================================================
; Author ........: Cephas <cephas at clergy dot net>
; Modified.......: Jos - Added $iCompNumeric and $iStart parameters and logic; Melba23 - Added 2D support; guinness - Reduced duplicate code.
; ===============================================================================================================================
Func _ArrayMaxIndex(Const ByRef $avArray, $iCompNumeric = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)
	Return __Array_MinMaxIndex($avArray, $iCompNumeric, $iStart, $iEnd, $iSubItem, __Array_GreaterThan) ; Pass a delegate function to check if value1 > value2.
EndFunc   ;==>_ArrayMaxIndex

; #FUNCTION# ====================================================================================================================
; Author ........: Cephas <cephas at clergy dot net>
; Modified.......: Jos - Added $iCompNumeric and $iStart parameters and logic, Ultima - added $iEnd parameter, code cleanup; Melba23 - Added 2D support
; ===============================================================================================================================
Func _ArrayMin(Const ByRef $avArray, $iCompNumeric = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)

	If $iCompNumeric = Default Then $iCompNumeric = 0
	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If $iSubItem = Default Then $iSubItem = 0
	Local $iResult = _ArrayMinIndex($avArray, $iCompNumeric, $iStart, $iEnd, $iSubItem)
	If @error Then Return SetError(@error, 0, "")
	If UBound($avArray, $UBOUND_DIMENSIONS) = 1 Then
		Return $avArray[$iResult]
	Else
		Return $avArray[$iResult][$iSubItem]
	EndIf
EndFunc   ;==>_ArrayMin

; #FUNCTION# ====================================================================================================================
; Author ........: Cephas <cephas at clergy dot net>
; Modified.......: Jos - Added $iCompNumeric and $iStart parameters and logic; Melba23 - Added 2D support; guinness - Reduced duplicate code.
; ===============================================================================================================================
Func _ArrayMinIndex(Const ByRef $avArray, $iCompNumeric = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)
	Return __Array_MinMaxIndex($avArray, $iCompNumeric, $iStart, $iEnd, $iSubItem, __Array_LessThan) ; Pass a delegate function to check if value1 < value2.
EndFunc   ;==>_ArrayMinIndex

; #FUNCTION# ====================================================================================================================
; Author ........: Erik Pilsits
; Modified.......: Melba23 - added support for empty arrays
; ===============================================================================================================================
Func _ArrayPermute(ByRef $avArray, $sDelim = "")

	If $sDelim = Default Then $sDelim = ""
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(2, 0, 0)
	Local $iSize = UBound($avArray), $iFactorial = 1, $aIdx[$iSize], $aResult[1], $iCount = 1

	If UBound($avArray) Then
		For $i = 0 To $iSize - 1
			$aIdx[$i] = $i
		Next
		For $i = $iSize To 1 Step -1
			$iFactorial *= $i
		Next
		ReDim $aResult[$iFactorial + 1]
		$aResult[0] = $iFactorial
		__Array_ExeterInternal($avArray, 0, $iSize, $sDelim, $aIdx, $aResult, $iCount)
	Else
		$aResult[0] = 0
	EndIf
	Return $aResult
EndFunc   ;==>_ArrayPermute

; #FUNCTION# ====================================================================================================================
; Author ........: Cephas <cephas at clergy dot net>
; Modified.......: Ultima - code cleanup; Melba23 - added support for empty arrays
; ===============================================================================================================================
Func _ArrayPop(ByRef $avArray)
	If (Not IsArray($avArray)) Then Return SetError(1, 0, "")
	If UBound($avArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(2, 0, "")

	Local $iUBound = UBound($avArray) - 1
	If $iUBound = -1 Then Return SetError(3, 0, "")
	Local $sLastVal = $avArray[$iUBound]

	; Remove last item
	If $iUBound > -1 Then
		ReDim $avArray[$iUBound]
	EndIf

	; Return last item
	Return $sLastVal
EndFunc   ;==>_ArrayPop

; #FUNCTION# ====================================================================================================================
; Author ........: Helias Gerassimou(hgeras), Ultima - code cleanup/rewrite (major optimization), fixed support for $vValue as an array
; Modified.......:
; ===============================================================================================================================
Func _ArrayPush(ByRef $avArray, $vValue, $iDirection = 0)

	If $iDirection = Default Then $iDirection = 0
	If (Not IsArray($avArray)) Then Return SetError(1, 0, 0)
	If UBound($avArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(3, 0, 0)
	Local $iUBound = UBound($avArray) - 1

	If IsArray($vValue) Then ; $vValue is an array
		Local $iUBoundS = UBound($vValue)
		If ($iUBoundS - 1) > $iUBound Then Return SetError(2, 0, 0)

		; $vValue is an array smaller than $avArray
		If $iDirection Then ; slide right, add to front
			For $i = $iUBound To $iUBoundS Step -1
				$avArray[$i] = $avArray[$i - $iUBoundS]
			Next
			For $i = 0 To $iUBoundS - 1
				$avArray[$i] = $vValue[$i]
			Next
		Else ; slide left, add to end
			For $i = 0 To $iUBound - $iUBoundS
				$avArray[$i] = $avArray[$i + $iUBoundS]
			Next
			For $i = 0 To $iUBoundS - 1
				$avArray[$i + $iUBound - $iUBoundS + 1] = $vValue[$i]
			Next
		EndIf
	Else
		; Check for empty array
		If $iUBound > -1 Then
			If $iDirection Then ; slide right, add to front
				For $i = $iUBound To 1 Step -1
					$avArray[$i] = $avArray[$i - 1]
				Next
				$avArray[0] = $vValue
			Else ; slide left, add to end
				For $i = 0 To $iUBound - 1
					$avArray[$i] = $avArray[$i + 1]
				Next
				$avArray[$iUBound] = $vValue
			EndIf
		EndIf
	EndIf

	Return 1
EndFunc   ;==>_ArrayPush

; #FUNCTION# ====================================================================================================================
; Author ........: Brian Keene
; Modified.......: Jos - added $iStart parameter and logic; Tylo - added $iEnd parameter and rewrote it for speed
; ===============================================================================================================================
Func _ArrayReverse(ByRef $avArray, $iStart = 0, $iEnd = 0)

	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(3, 0, 0)
	If Not UBound($avArray) Then Return SetError(4, 0, 0)

	Local $vTmp, $iUBound = UBound($avArray) - 1

	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, 0)

	; Reverse
	For $i = $iStart To Int(($iStart + $iEnd - 1) / 2)
		$vTmp = $avArray[$i]
		$avArray[$i] = $avArray[$iEnd]
		$avArray[$iEnd] = $vTmp
		$iEnd -= 1
	Next

	Return 1
EndFunc   ;==>_ArrayReverse

; #FUNCTION# ====================================================================================================================
; Author ........: Michael Michta <MetalGX91 at GMail dot com>
; Modified.......: gcriaco <gcriaco at gmail dot com>; Ultima - 2D arrays supported, directional search, code cleanup, optimization; Melba23 - added support for empty arrays and row search; BrunoJ - Added compare option 3 to use a regex pattern
; ===============================================================================================================================
Func _ArraySearch(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iCompare = 0, $iForward = 1, $iSubItem = -1, $bRow = False)

	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If $iCase = Default Then $iCase = 0
	If $iCompare = Default Then $iCompare = 0
	If $iForward = Default Then $iForward = 1
	If $iSubItem = Default Then $iSubItem = -1
	If $bRow = Default Then $bRow = False

	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray) - 1
	If $iDim_1 = -1 Then Return SetError(3, 0, -1)
	Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS) - 1

	; Same var Type of comparison
	Local $bCompType = False
	If $iCompare = 2 Then
		$iCompare = 0
		$bCompType = True
	EndIf
	; Bounds checking
	If $bRow Then
		If UBound($avArray, $UBOUND_DIMENSIONS) = 1 Then Return SetError(5, 0, -1)
		If $iEnd < 1 Or $iEnd > $iDim_2 Then $iEnd = $iDim_2
		If $iStart < 0 Then $iStart = 0
		If $iStart > $iEnd Then Return SetError(4, 0, -1)
	Else
		If $iEnd < 1 Or $iEnd > $iDim_1 Then $iEnd = $iDim_1
		If $iStart < 0 Then $iStart = 0
		If $iStart > $iEnd Then Return SetError(4, 0, -1)
	EndIf
	; Direction (flip if $iForward = 0)
	Local $iStep = 1
	If Not $iForward Then
		Local $iTmp = $iStart
		$iStart = $iEnd
		$iEnd = $iTmp
		$iStep = -1
	EndIf

	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1 ; 1D array search
			If Not $iCompare Then
				If Not $iCase Then
					For $i = $iStart To $iEnd Step $iStep
						If $bCompType And VarGetType($avArray[$i]) <> VarGetType($vValue) Then ContinueLoop
						If $avArray[$i] = $vValue Then Return $i
					Next
				Else
					For $i = $iStart To $iEnd Step $iStep
						If $bCompType And VarGetType($avArray[$i]) <> VarGetType($vValue) Then ContinueLoop
						If $avArray[$i] == $vValue Then Return $i
					Next
				EndIf
			Else
				For $i = $iStart To $iEnd Step $iStep
					If $iCompare = 3 Then
						If StringRegExp($avArray[$i], $vValue) Then Return $i
					Else
						If StringInStr($avArray[$i], $vValue, $iCase) > 0 Then Return $i
					EndIf
				Next
			EndIf
		Case 2 ; 2D array search
			Local $iDim_Sub
			If $bRow Then
				; Search rows
				$iDim_Sub = $iDim_1
				If $iSubItem > $iDim_Sub Then $iSubItem = $iDim_Sub
				If $iSubItem < 0 Then
					; will search for all Col
					$iSubItem = 0
				Else
					$iDim_Sub = $iSubItem
				EndIf
			Else
				; Search columns
				$iDim_Sub = $iDim_2
				If $iSubItem > $iDim_Sub Then $iSubItem = $iDim_Sub
				If $iSubItem < 0 Then
					; will search for all Col
					$iSubItem = 0
				Else
					$iDim_Sub = $iSubItem
				EndIf
			EndIf
			; Now do the search
			For $j = $iSubItem To $iDim_Sub
				If Not $iCompare Then
					If Not $iCase Then
						For $i = $iStart To $iEnd Step $iStep
							If $bRow Then
								If $bCompType And VarGetType($avArray[$j][$j]) <> VarGetType($vValue) Then ContinueLoop
								If $avArray[$j][$i] = $vValue Then Return $i
							Else
								If $bCompType And VarGetType($avArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
								If $avArray[$i][$j] = $vValue Then Return $i
							EndIf
						Next
					Else
						For $i = $iStart To $iEnd Step $iStep
							If $bRow Then
								If $bCompType And VarGetType($avArray[$j][$i]) <> VarGetType($vValue) Then ContinueLoop
								If $avArray[$j][$i] == $vValue Then Return $i
							Else
								If $bCompType And VarGetType($avArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
								If $avArray[$i][$j] == $vValue Then Return $i
							EndIf
						Next
					EndIf
				Else
					For $i = $iStart To $iEnd Step $iStep
						If $iCompare = 3 Then
							If $bRow Then
								If StringRegExp($avArray[$j][$i], $vValue) Then Return $i
							Else
								If StringRegExp($avArray[$i][$j], $vValue) Then Return $i
							EndIf
						Else
							If $bRow Then
								If StringInStr($avArray[$j][$i], $vValue, $iCase) > 0 Then Return $i
							Else
								If StringInStr($avArray[$i][$j], $vValue, $iCase) > 0 Then Return $i
							EndIf
						EndIf
					Next
				EndIf
			Next
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch
	Return SetError(6, 0, -1)
EndFunc   ;==>_ArraySearch

; #FUNCTION# ====================================================================================================================
; Author ........: Melba23
; Modified.......:
; ===============================================================================================================================
Func _ArrayShuffle(ByRef $avArray, $iStart_Row = 0, $iEnd_Row = 0, $iCol = -1)

	; Fisher–Yates algorithm

	If $iStart_Row = Default Then $iStart_Row = 0
	If $iEnd_Row = Default Then $iEnd_Row = 0
	If $iCol = Default Then $iCol = -1

	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS)
	If $iEnd_Row = 0 Then $iEnd_Row = $iDim_1 - 1
	If $iStart_Row < 0 Or $iStart_Row > $iDim_1 - 1 Then Return SetError(3, 0, -1)
	If $iEnd_Row < 1 Or $iEnd_Row > $iDim_1 - 1 Then Return SetError(3, 0, -1)
	If $iStart_Row > $iEnd_Row Then Return SetError(4, 0, -1)

	Local $vTmp, $iRand
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			For $i = $iEnd_Row To $iStart_Row + 1 Step -1
				$iRand = Random($iStart_Row, $i, 1)
				$vTmp = $avArray[$i]
				$avArray[$i] = $avArray[$iRand]
				$avArray[$iRand] = $vTmp
			Next
			Return 1
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS)
			If $iCol < -1 Or $iCol > $iDim_2 - 1 Then Return SetError(5, 0, -1)
			Local $iCol_Start, $iCol_End
			If $iCol = -1 Then
				$iCol_Start = 0
				$iCol_End = $iDim_2 - 1
			Else
				$iCol_Start = $iCol
				$iCol_End = $iCol
			EndIf
			For $i = $iEnd_Row To $iStart_Row + 1 Step -1
				$iRand = Random($iStart_Row, $i, 1)
				For $j = $iCol_Start To $iCol_End
					$vTmp = $avArray[$i][$j]
					$avArray[$i][$j] = $avArray[$iRand][$j]
					$avArray[$iRand][$j] = $vTmp
				Next
			Next
			Return 1
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch

EndFunc   ;==>_ArrayShuffle

; #FUNCTION# ====================================================================================================================
; Author ........: Jos
; Modified.......: LazyCoder - added $iSubItem option; Tylo - implemented stable QuickSort algo; Jos - changed logic to correctly Sort arrays with mixed Values and Strings; Melba23 - implemented stable pivot algo
; ===============================================================================================================================
Func _ArraySort(ByRef $avArray, $iDescending = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0, $iPivot = 0)

	If $iDescending = Default Then $iDescending = 0
	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If $iSubItem = Default Then $iSubItem = 0
	If $iPivot = Default Then $iPivot = 0
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)

	Local $iUBound = UBound($avArray) - 1
	If $iUBound = -1 Then Return SetError(5, 0, 0)

	; Bounds checking
	If $iEnd = Default Then $iEnd = 0
	If $iEnd < 1 Or $iEnd > $iUBound Or $iEnd = Default Then $iEnd = $iUBound
	If $iStart < 0 Or $iStart = Default Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, 0)

	If $iDescending = Default Then $iDescending = 0
	If $iPivot = Default Then $iPivot = 0
	If $iSubItem = Default Then $iSubItem = 0

	; Sort
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			If $iPivot Then ; Switch algorithms as required
				__ArrayDualPivotSort($avArray, $iStart, $iEnd)
			Else
				__ArrayQuickSort1D($avArray, $iStart, $iEnd)
			EndIf
			If $iDescending Then _ArrayReverse($avArray, $iStart, $iEnd)
		Case 2
			If $iPivot Then Return SetError(6, 0, 0) ; Error if 2D array and $iPivot
			Local $iSubMax = UBound($avArray, $UBOUND_COLUMNS) - 1
			If $iSubItem > $iSubMax Then Return SetError(3, 0, 0)

			If $iDescending Then
				$iDescending = -1
			Else
				$iDescending = 1
			EndIf

			__ArrayQuickSort2D($avArray, $iDescending, $iStart, $iEnd, $iSubItem, $iSubMax)
		Case Else
			Return SetError(4, 0, 0)
	EndSwitch

	Return 1
EndFunc   ;==>_ArraySort

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __ArrayQuickSort1D
; Description ...: Helper function for sorting 1D arrays
; Syntax.........: __ArrayQuickSort1D ( ByRef $avArray, ByRef $iStart, ByRef $iEnd )
; Parameters ....: $avArray - Array to sort
;                  $iStart  - Index of array to start sorting at
;                  $iEnd    - Index of array to stop sorting at
; Return values .: None
; Author ........: Jos van der Zande, LazyCoder, Tylo, Ultima
; Modified.......:
; Remarks .......: For Internal Use Only
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __ArrayQuickSort1D(ByRef $avArray, Const ByRef $iStart, Const ByRef $iEnd)
	If $iEnd <= $iStart Then Return

	Local $vTmp

	; InsertionSort (faster for smaller segments)
	If ($iEnd - $iStart) < 15 Then
		Local $vCur
		For $i = $iStart + 1 To $iEnd
			$vTmp = $avArray[$i]

			If IsNumber($vTmp) Then
				For $j = $i - 1 To $iStart Step -1
					$vCur = $avArray[$j]
					; If $vTmp >= $vCur Then ExitLoop
					If ($vTmp >= $vCur And IsNumber($vCur)) Or (Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
					$avArray[$j + 1] = $vCur
				Next
			Else
				For $j = $i - 1 To $iStart Step -1
					If (StringCompare($vTmp, $avArray[$j]) >= 0) Then ExitLoop
					$avArray[$j + 1] = $avArray[$j]
				Next
			EndIf

			$avArray[$j + 1] = $vTmp
		Next
		Return
	EndIf

	; QuickSort
	Local $L = $iStart, $R = $iEnd, $vPivot = $avArray[Int(($iStart + $iEnd) / 2)], $bNum = IsNumber($vPivot)
	Do
		If $bNum Then
			; While $avArray[$L] < $vPivot
			While ($avArray[$L] < $vPivot And IsNumber($avArray[$L])) Or (Not IsNumber($avArray[$L]) And StringCompare($avArray[$L], $vPivot) < 0)
				$L += 1
			WEnd
			; While $avArray[$R] > $vPivot
			While ($avArray[$R] > $vPivot And IsNumber($avArray[$R])) Or (Not IsNumber($avArray[$R]) And StringCompare($avArray[$R], $vPivot) > 0)
				$R -= 1
			WEnd
		Else
			While (StringCompare($avArray[$L], $vPivot) < 0)
				$L += 1
			WEnd
			While (StringCompare($avArray[$R], $vPivot) > 0)
				$R -= 1
			WEnd
		EndIf

		; Swap
		If $L <= $R Then
			$vTmp = $avArray[$L]
			$avArray[$L] = $avArray[$R]
			$avArray[$R] = $vTmp
			$L += 1
			$R -= 1
		EndIf
	Until $L > $R

	__ArrayQuickSort1D($avArray, $iStart, $R)
	__ArrayQuickSort1D($avArray, $L, $iEnd)
EndFunc   ;==>__ArrayQuickSort1D

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __ArrayQuickSort2D
; Description ...: Helper function for sorting 2D arrays
; Syntax.........: __ArrayQuickSort2D ( ByRef $avArray, ByRef $iStep, ByRef $iStart, ByRef $iEnd, ByRef $iSubItem, ByRef $iSubMax )
; Parameters ....: $avArray  - Array to sort
;                  $iStep    - Step size (should be 1 to sort ascending, -1 to sort descending!)
;                  $iStart   - Index of array to start sorting at
;                  $iEnd     - Index of array to stop sorting at
;                  $iSubItem - Sub-index to sort on in 2D arrays
;                  $iSubMax  - Maximum sub-index that array has
; Return values .: None
; Author ........: Jos van der Zande, LazyCoder, Tylo, Ultima
; Modified.......:
; Remarks .......: For Internal Use Only
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __ArrayQuickSort2D(ByRef $avArray, Const ByRef $iStep, Const ByRef $iStart, Const ByRef $iEnd, Const ByRef $iSubItem, Const ByRef $iSubMax)
	If $iEnd <= $iStart Then Return

	; QuickSort
	Local $vTmp, $L = $iStart, $R = $iEnd, $vPivot = $avArray[Int(($iStart + $iEnd) / 2)][$iSubItem], $bNum = IsNumber($vPivot)
	Do
		If $bNum Then
			; While $avArray[$L][$iSubItem] < $vPivot
			While ($iStep * ($avArray[$L][$iSubItem] - $vPivot) < 0 And IsNumber($avArray[$L][$iSubItem])) Or (Not IsNumber($avArray[$L][$iSubItem]) And $iStep * StringCompare($avArray[$L][$iSubItem], $vPivot) < 0)
				$L += 1
			WEnd
			; While $avArray[$R][$iSubItem] > $vPivot
			While ($iStep * ($avArray[$R][$iSubItem] - $vPivot) > 0 And IsNumber($avArray[$R][$iSubItem])) Or (Not IsNumber($avArray[$R][$iSubItem]) And $iStep * StringCompare($avArray[$R][$iSubItem], $vPivot) > 0)
				$R -= 1
			WEnd
		Else
			While ($iStep * StringCompare($avArray[$L][$iSubItem], $vPivot) < 0)
				$L += 1
			WEnd
			While ($iStep * StringCompare($avArray[$R][$iSubItem], $vPivot) > 0)
				$R -= 1
			WEnd
		EndIf

		; Swap
		If $L <= $R Then
			For $i = 0 To $iSubMax
				$vTmp = $avArray[$L][$i]
				$avArray[$L][$i] = $avArray[$R][$i]
				$avArray[$R][$i] = $vTmp
			Next
			$L += 1
			$R -= 1
		EndIf
	Until $L > $R

	__ArrayQuickSort2D($avArray, $iStep, $iStart, $R, $iSubItem, $iSubMax)
	__ArrayQuickSort2D($avArray, $iStep, $L, $iEnd, $iSubItem, $iSubMax)
EndFunc   ;==>__ArrayQuickSort2D

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __ArrayDualPivotSort
; Description ...: Helper function for sorting 1D arrays
; Syntax.........: __ArrayDualPivotSort ( ByRef $aArray, $iPivot_Left, $iPivot_Right [, $bLeftMost = True ] )
; Parameters ....: $avArray  - Array to sort
;                  $iPivot_Left  - Index of the array to start sorting at
;                  $iPivot_Right - Index of the array to stop sorting at
;                  $bLeftMost    - Indicates if this part is the leftmost in the range
; Return values .: None
; Author ........: Erik Pilsits
; Modified.......: Melba23
; Remarks .......: For Internal Use Only
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __ArrayDualPivotSort(ByRef $aArray, $iPivot_Left, $iPivot_Right, $bLeftMost = True)
	If $iPivot_Left > $iPivot_Right Then Return
	Local $iLength = $iPivot_Right - $iPivot_Left + 1
	Local $i, $j, $k, $iAi, $iAk, $iA1, $iA2, $iLast
	If $iLength < 45 Then ; Use insertion sort for small arrays - value chosen empirically
		If $bLeftMost Then
			$i = $iPivot_Left
			While $i < $iPivot_Right
				$j = $i
				$iAi = $aArray[$i + 1]
				While $iAi < $aArray[$j]
					$aArray[$j + 1] = $aArray[$j]
					$j -= 1
					If $j + 1 = $iPivot_Left Then ExitLoop
				WEnd
				$aArray[$j + 1] = $iAi
				$i += 1
			WEnd
		Else
			While 1
				If $iPivot_Left >= $iPivot_Right Then Return 1
				$iPivot_Left += 1
				If $aArray[$iPivot_Left] < $aArray[$iPivot_Left - 1] Then ExitLoop
			WEnd
			While 1
				$k = $iPivot_Left
				$iPivot_Left += 1
				If $iPivot_Left > $iPivot_Right Then ExitLoop
				$iA1 = $aArray[$k]
				$iA2 = $aArray[$iPivot_Left]
				If $iA1 < $iA2 Then
					$iA2 = $iA1
					$iA1 = $aArray[$iPivot_Left]
				EndIf
				$k -= 1
				While $iA1 < $aArray[$k]
					$aArray[$k + 2] = $aArray[$k]
					$k -= 1
				WEnd
				$aArray[$k + 2] = $iA1
				While $iA2 < $aArray[$k]
					$aArray[$k + 1] = $aArray[$k]
					$k -= 1
				WEnd
				$aArray[$k + 1] = $iA2
				$iPivot_Left += 1
			WEnd
			$iLast = $aArray[$iPivot_Right]
			$iPivot_Right -= 1
			While $iLast < $aArray[$iPivot_Right]
				$aArray[$iPivot_Right + 1] = $aArray[$iPivot_Right]
				$iPivot_Right -= 1
			WEnd
			$aArray[$iPivot_Right + 1] = $iLast
		EndIf
		Return 1
	EndIf
	Local $iSeventh = BitShift($iLength, 3) + BitShift($iLength, 6) + 1
	Local $iE1, $iE2, $iE3, $iE4, $iE5, $t
	$iE3 = Ceiling(($iPivot_Left + $iPivot_Right) / 2)
	$iE2 = $iE3 - $iSeventh
	$iE1 = $iE2 - $iSeventh
	$iE4 = $iE3 + $iSeventh
	$iE5 = $iE4 + $iSeventh
	If $aArray[$iE2] < $aArray[$iE1] Then
		$t = $aArray[$iE2]
		$aArray[$iE2] = $aArray[$iE1]
		$aArray[$iE1] = $t
	EndIf
	If $aArray[$iE3] < $aArray[$iE2] Then
		$t = $aArray[$iE3]
		$aArray[$iE3] = $aArray[$iE2]
		$aArray[$iE2] = $t
		If $t < $aArray[$iE1] Then
			$aArray[$iE2] = $aArray[$iE1]
			$aArray[$iE1] = $t
		EndIf
	EndIf
	If $aArray[$iE4] < $aArray[$iE3] Then
		$t = $aArray[$iE4]
		$aArray[$iE4] = $aArray[$iE3]
		$aArray[$iE3] = $t
		If $t < $aArray[$iE2] Then
			$aArray[$iE3] = $aArray[$iE2]
			$aArray[$iE2] = $t
			If $t < $aArray[$iE1] Then
				$aArray[$iE2] = $aArray[$iE1]
				$aArray[$iE1] = $t
			EndIf
		EndIf
	EndIf
	If $aArray[$iE5] < $aArray[$iE4] Then
		$t = $aArray[$iE5]
		$aArray[$iE5] = $aArray[$iE4]
		$aArray[$iE4] = $t
		If $t < $aArray[$iE3] Then
			$aArray[$iE4] = $aArray[$iE3]
			$aArray[$iE3] = $t
			If $t < $aArray[$iE2] Then
				$aArray[$iE3] = $aArray[$iE2]
				$aArray[$iE2] = $t
				If $t < $aArray[$iE1] Then
					$aArray[$iE2] = $aArray[$iE1]
					$aArray[$iE1] = $t
				EndIf
			EndIf
		EndIf
	EndIf
	Local $iLess = $iPivot_Left
	Local $iGreater = $iPivot_Right
	If (($aArray[$iE1] <> $aArray[$iE2]) And ($aArray[$iE2] <> $aArray[$iE3]) And ($aArray[$iE3] <> $aArray[$iE4]) And ($aArray[$iE4] <> $aArray[$iE5])) Then
		Local $iPivot_1 = $aArray[$iE2]
		Local $iPivot_2 = $aArray[$iE4]
		$aArray[$iE2] = $aArray[$iPivot_Left]
		$aArray[$iE4] = $aArray[$iPivot_Right]
		Do
			$iLess += 1
		Until $aArray[$iLess] >= $iPivot_1
		Do
			$iGreater -= 1
		Until $aArray[$iGreater] <= $iPivot_2
		$k = $iLess
		While $k <= $iGreater
			$iAk = $aArray[$k]
			If $iAk < $iPivot_1 Then
				$aArray[$k] = $aArray[$iLess]
				$aArray[$iLess] = $iAk
				$iLess += 1
			ElseIf $iAk > $iPivot_2 Then
				While $aArray[$iGreater] > $iPivot_2
					$iGreater -= 1
					If $iGreater + 1 = $k Then ExitLoop 2
				WEnd
				If $aArray[$iGreater] < $iPivot_1 Then
					$aArray[$k] = $aArray[$iLess]
					$aArray[$iLess] = $aArray[$iGreater]
					$iLess += 1
				Else
					$aArray[$k] = $aArray[$iGreater]
				EndIf
				$aArray[$iGreater] = $iAk
				$iGreater -= 1
			EndIf
			$k += 1
		WEnd
		$aArray[$iPivot_Left] = $aArray[$iLess - 1]
		$aArray[$iLess - 1] = $iPivot_1
		$aArray[$iPivot_Right] = $aArray[$iGreater + 1]
		$aArray[$iGreater + 1] = $iPivot_2
		__ArrayDualPivotSort($aArray, $iPivot_Left, $iLess - 2, True)
		__ArrayDualPivotSort($aArray, $iGreater + 2, $iPivot_Right, False)
		If ($iLess < $iE1) And ($iE5 < $iGreater) Then
			While $aArray[$iLess] = $iPivot_1
				$iLess += 1
			WEnd
			While $aArray[$iGreater] = $iPivot_2
				$iGreater -= 1
			WEnd
			$k = $iLess
			While $k <= $iGreater
				$iAk = $aArray[$k]
				If $iAk = $iPivot_1 Then
					$aArray[$k] = $aArray[$iLess]
					$aArray[$iLess] = $iAk
					$iLess += 1
				ElseIf $iAk = $iPivot_2 Then
					While $aArray[$iGreater] = $iPivot_2
						$iGreater -= 1
						If $iGreater + 1 = $k Then ExitLoop 2
					WEnd
					If $aArray[$iGreater] = $iPivot_1 Then
						$aArray[$k] = $aArray[$iLess]
						$aArray[$iLess] = $iPivot_1
						$iLess += 1
					Else
						$aArray[$k] = $aArray[$iGreater]
					EndIf
					$aArray[$iGreater] = $iAk
					$iGreater -= 1
				EndIf
				$k += 1
			WEnd
		EndIf
		__ArrayDualPivotSort($aArray, $iLess, $iGreater, False)
	Else
		Local $iPivot = $aArray[$iE3]
		$k = $iLess
		While $k <= $iGreater
			If $aArray[$k] = $iPivot Then
				$k += 1
				ContinueLoop
			EndIf
			$iAk = $aArray[$k]
			If $iAk < $iPivot Then
				$aArray[$k] = $aArray[$iLess]
				$aArray[$iLess] = $iAk
				$iLess += 1
			Else
				While $aArray[$iGreater] > $iPivot
					$iGreater -= 1
				WEnd
				If $aArray[$iGreater] < $iPivot Then
					$aArray[$k] = $aArray[$iLess]
					$aArray[$iLess] = $aArray[$iGreater]
					$iLess += 1
				Else
					$aArray[$k] = $iPivot
				EndIf
				$aArray[$iGreater] = $iAk
				$iGreater -= 1
			EndIf
			$k += 1
		WEnd
		__ArrayDualPivotSort($aArray, $iPivot_Left, $iLess - 1, True)
		__ArrayDualPivotSort($aArray, $iGreater + 1, $iPivot_Right, False)
	EndIf
EndFunc   ;==>__ArrayDualPivotSort

; #FUNCTION# ====================================================================================================================
; Author ........: Melba23
; Modified.......:
; ===============================================================================================================================
Func _ArraySwap(ByRef $avArray, $iIndex_1, $iIndex_2, $bRow = True, $iStart = 0, $iEnd = 0)

	If $bRow = Default Then $bRow = True
	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS) - 1
	Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS) - 1

	; Bounds checking
	If $iStart < 0 Or $iEnd < 0 Then Return SetError(4, 0, -1)
	If $iStart > $iEnd Then Return SetError(5, 0, -1)
	If $bRow Then
		If $iIndex_1 < 0 Or $iIndex_1 > $iDim_1 Then Return SetError(4, 0, -1)
		If $iEnd = 0 Then $iEnd = $iDim_2
		If $iStart > $iDim_1 Or $iEnd > $iDim_1 Then Return SetError(4, 0, -1)
	Else
		If $iIndex_1 < 0 Or $iIndex_1 > $iDim_2 Then Return SetError(4, 0, -1)
		If $iEnd = 0 Then $iEnd = $iDim_1
		If $iStart > $iDim_2 Or $iEnd > $iDim_2 Then Return SetError(4, 0, -1)
	EndIf
	Local $vTmp
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			$vTmp = $avArray[$iIndex_1]
			$avArray[$iIndex_1] = $avArray[$iIndex_2]
			$avArray[$iIndex_2] = $vTmp
		Case 2
			If $bRow Then
				For $j = $iStart To $iEnd
					$vTmp = $avArray[$iIndex_1][$j]
					$avArray[$iIndex_1][$j] = $avArray[$iIndex_2][$j]
					$avArray[$iIndex_2][$j] = $vTmp
				Next
			Else
				For $j = $iStart To $iEnd
					$vTmp = $avArray[$j][$iIndex_1]
					$avArray[$j][$iIndex_1] = $avArray[$j][$iIndex_2]
					$avArray[$j][$iIndex_2] = $vTmp
				Next
			EndIf
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch

	Return 1

EndFunc   ;==>_ArraySwap

; #FUNCTION# ====================================================================================================================
; Author ........: Cephas <cephas at clergy dot net>
; Modified.......: Jos - added $iStart parameter and logic, Ultima - added $iEnd parameter, make use of _ArrayToString() instead of duplicating efforts; Melba23 - added 2D support
; ===============================================================================================================================
Func _ArrayToClip(Const ByRef $avArray, $sDelim_Item = "|", $iStart_Row = 0, $iEnd_Row = 0, $sDelim_Row = @CRLF, $iStart_Col = 0, $iEnd_Col = 0)
	Local $sResult = _ArrayToString($avArray, $sDelim_Item, $iStart_Row, $iEnd_Row, $sDelim_Row, $iStart_Col, $iEnd_Col)
	If @error Then Return SetError(@error, 0, 0)
	If ClipPut($sResult) Then Return 1
	Return SetError(-1, 0, 0)
EndFunc   ;==>_ArrayToClip

; #FUNCTION# ====================================================================================================================
; Author ........: Brian Keene <brian_keene at yahoo dot com>, Valik - rewritten
; Modified.......: Ultima - code cleanup; Melba23 - added support for empty and 2D arrays
; ===============================================================================================================================
Func _ArrayToString(Const ByRef $avArray, $sDelim_Item = "|", $iStart_Row = 0, $iEnd_Row = 0, $sDelim_Row = @CRLF, $iStart_Col = 0, $iEnd_Col = 0)

	If $sDelim_Item = Default Then $sDelim_Item = "|"
	If $sDelim_Row = Default Then $sDelim_Row = @CRLF
	If $iStart_Row = Default Then $iStart_Row = 0
	If $iEnd_Row = Default Then $iEnd_Row = 0
	If $iStart_Col = Default Then $iStart_Col = 0
	If $iEnd_Col = Default Then $iEnd_Col = 0
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS) - 1
	If $iEnd_Row = 0 Then $iEnd_Row = $iDim_1
	If $iStart_Row < 0 Or $iEnd_Row < 0 Then Return SetError(3, 0, -1)
	If $iStart_Row > $iDim_1 Or $iEnd_Row > $iDim_1 Then Return SetError(3, 0, "")
	If $iStart_Row > $iEnd_Row Then Return SetError(4, 0, -1)
	Local $sRet = ""
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			For $i = $iStart_Row To $iEnd_Row
				$sRet &= $avArray[$i] & $sDelim_Item
			Next
			Return StringTrimRight($sRet, StringLen($sDelim_Item))
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS) - 1
			If $iEnd_Col = 0 Then $iEnd_Col = $iDim_2
			If $iStart_Col < 0 Or $iEnd_Col < 0 Then Return SetError(5, 0, -1)
			If $iStart_Col > $iDim_2 Or $iEnd_Col > $iDim_2 Then Return SetError(5, 0, -1)
			If $iStart_Col > $iEnd_Col Then Return SetError(6, 0, -1)
			For $i = $iStart_Row To $iEnd_Row
				For $j = $iStart_Col To $iEnd_Col
					$sRet &= $avArray[$i][$j] & $sDelim_Item
				Next
				$sRet = StringTrimRight($sRet, StringLen($sDelim_Item)) & $sDelim_Row
			Next
			Return StringTrimRight($sRet, StringLen($sDelim_Row))
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch
	Return 1

EndFunc   ;==>_ArrayToString

; #FUNCTION# ====================================================================================================================
; Author ........: jchd
; Modified.......: jpm
; ===============================================================================================================================
Func _ArrayTranspose(ByRef $avArray)
	Switch UBound($avArray, 0)
		Case 0
			Return SetError(2, 0, 0)
		Case 1
			Local $aTemp[1][UBound($avArray)]
			For $i = 0 To UBound($avArray) - 1
				$aTemp[0][$i] = $avArray[$i]
			Next
			$avArray = $aTemp
			Return 1
		Case 2
			Local $vElement, $iDim_1 = UBound($avArray, 1), $iDim_2 = UBound($avArray, 2), $iDim_Max = ($iDim_1 > $iDim_2) ? $iDim_1 : $iDim_2
			If $iDim_Max <= 4096 Then
				ReDim $avArray[$iDim_Max][$iDim_Max]
				For $i = 0 To $iDim_Max - 2
					For $j = $i + 1 To $iDim_Max - 1
						$vElement = $avArray[$i][$j]
						$avArray[$i][$j] = $avArray[$j][$i]
						$avArray[$j][$i] = $vElement
					Next
				Next
				If $iDim_1 = 1 Then
					Local $aTemp[$iDim_2]
					For $i = 0 To $iDim_2 - 1
						$aTemp[$i] = $avArray[$i][0]
					Next
					$avArray = $aTemp
				Else
					ReDim $avArray[$iDim_2][$iDim_1]
				EndIf
			Else
				Local $aTemp[$iDim_2][$iDim_1]
				For $i = 0 To $iDim_1 - 1
					For $j = 0 To $iDim_2 - 1
						$aTemp[$j][$i] = $avArray[$i][$j]
					Next
				Next
				ReDim $avArray[$iDim_2][$iDim_1]
				$avArray = $aTemp
			EndIf
			Return 1
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
EndFunc   ;==>_ArrayTranspose

; #FUNCTION# ====================================================================================================================
; Author ........: Adam Moore (redndahead)
; Modified.......: Ultima - code cleanup, optimization; Melba23 - added 2D support
; ===============================================================================================================================
Func _ArrayTrim(ByRef $avArray, $iTrimNum, $iDirection = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)

	If $iDirection = Default Then $iDirection = 0
	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If $iSubItem = Default Then $iSubItem = 0
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)

	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS) - 1
	If $iEnd = 0 Then $iEnd = $iDim_1
	If $iStart > $iEnd Then Return SetError(3, 0, -1)
	If $iStart < 0 Or $iEnd < 0 Then Return SetError(3, 0, -1)
	If $iStart > $iDim_1 Or $iEnd > $iDim_1 Then Return SetError(3, 0, -1)
	If $iStart > $iEnd Then Return SetError(4, 0, -1)

	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			If $iDirection Then
				For $i = $iStart To $iEnd
					$avArray[$i] = StringTrimRight($avArray[$i], $iTrimNum)
				Next
			Else
				For $i = $iStart To $iEnd
					$avArray[$i] = StringTrimLeft($avArray[$i], $iTrimNum)
				Next
			EndIf
		Case 2
			Local $iDim_2 = UBound($avArray, $UBOUND_COLUMNS) - 1
			If $iSubItem < 0 Or $iSubItem > $iDim_2 Then Return SetError(5, 0, -1)
			If $iDirection Then
				For $i = $iStart To $iEnd
					$avArray[$i][$iSubItem] = StringTrimRight($avArray[$i][$iSubItem], $iTrimNum)
				Next
			Else
				For $i = $iStart To $iEnd
					$avArray[$i][$iSubItem] = StringTrimLeft($avArray[$i][$iSubItem], $iTrimNum)
				Next
			EndIf
		Case Else
			Return SetError(2, 0, 0)
	EndSwitch

	Return 1
EndFunc   ;==>_ArrayTrim

; #FUNCTION# ====================================================================================================================
; Author ........: SmOke_N
; Modified.......: litlmike, Erik Pilsits, BrewManNH, Melba23
; ===============================================================================================================================
Func _ArrayUnique(Const ByRef $aArray, $iColumn = 0, $iBase = 0, $iCase = 0, $iFlags = 1)

	If $iColumn = Default Then $iColumn = 0
	If $iBase = Default Then $iBase = 0
	If $iCase = Default Then $iCase = 0
	If $iFlags = Default Then $iFlags = 1
	; Start bounds checking
	If UBound($aArray, $UBOUND_ROWS) = 0 Then Return SetError(1, 0, 0) ; Check if array is empty, or not an array
	; Parameters can only be 0 or 1, if anything else return with an error
	If $iBase < 0 Or $iBase > 1 Or (Not IsInt($iBase)) Then Return SetError(3, 0, 0)
	If $iCase < 0 Or $iCase > 1 Or (Not IsInt($iCase)) Then Return SetError(3, 0, 0)
	If $iFlags < 0 Or $iFlags > 1 Or (Not IsInt($iFlags)) Then Return SetError(4, 0, 0)
	Local $iDims = UBound($aArray, $UBOUND_DIMENSIONS), $iNumColumns = UBound($aArray, $UBOUND_COLUMNS)
	If $iDims > 2 Then Return SetError(2, 0, 0)
	; Checks the given dimension is valid
	If $iColumn < 0 Or ($iNumColumns = 0 And $iColumn > 0) Or ($iNumColumns > 0 And $iColumn >= $iNumColumns) Then Return SetError(5, 0, 0)
	; create dictionary
	Local $oDictionary = ObjCreate("Scripting.Dictionary")
	; compare mode for strings
	; 0 = binary, which is case sensitive
	; 1 = text, which is case insensitive
	; this expression forces either 1 or 0
	$oDictionary.CompareMode = Number(Not $iCase)
	Local $vElem = 0
	; walk the input array
	For $i = $iBase To UBound($aArray) - 1
		If $iDims = 1 Then
			; 1D array
			$vElem = $aArray[$i]
		Else
			; 2D array
			$vElem = $aArray[$i][$iColumn]
		EndIf
		; add key to dictionary
		; NOTE: accessing the value (.Item property) of a key that doesn't exist creates the key :)
		; keys are guaranteed to be unique
		$oDictionary.Item($vElem)
	Next
	; return the array of unique keys
	If BitAND($iFlags, 1) = 1 Then
		Local $aTemp = $oDictionary.Keys()
		_ArrayInsert($aTemp, 0, $oDictionary.Count)
		Return $aTemp
	Else
		Return $oDictionary.Keys()
	EndIf
EndFunc   ;==>_ArrayUnique

; #FUNCTION# ====================================================================================================================
; Author ........: jchd, jpm
; Modified.......:
; ===============================================================================================================================
Func _Array1DToHistogram($aArray, $iSizing = 100)
	If UBound($aArray, 0) > 1 Then Return SetError(1, 0, "")
	$iSizing = $iSizing * 8
	Local $t, $n, $iMin = 0, $iMax = 0, $iOffset = 0
	For $i = 0 To UBound($aArray) - 1
		$t = $aArray[$i]
		$t = IsNumber($t) ? Round($t) : 0
		If $t < $iMin Then $iMin = $t
		If $t > $iMax Then $iMax = $t
	Next
	Local $iRange = Int(Round(($iMax - $iMin) / 8)) * 8
	Local $iSpaceRatio = 4
	For $i = 0 To UBound($aArray) - 1
		$t = $aArray[$i]
		If $t Then
			$n = Abs(Round(($iSizing * $t) / $iRange) / 8)

			$aArray[$i] = ""
			If $t > 0 Then
				If $iMin Then
					$iOffset = Int(Abs(Round(($iSizing * $iMin) / $iRange) / 8) / 8 * $iSpaceRatio)
					$aArray[$i] = __Array_StringRepeat(ChrW(0x20), $iOffset)
				EndIf
			Else
				If $iMin <> $t Then
					$iOffset = Int(Abs(Round(($iSizing * ($t - $iMin)) / $iRange) / 8) / 8 * $iSpaceRatio)
					$aArray[$i] = __Array_StringRepeat(ChrW(0x20), $iOffset)
				EndIf
			EndIf
			$aArray[$i] &= __Array_StringRepeat(ChrW(0x2588), Int($n / 8))

			$n = Mod($n, 8)
			If $n > 0 Then $aArray[$i] &= ChrW(0x2588 + 8 - $n)
			$aArray[$i] &= ' ' & $t
		Else
			$aArray[$i] = ""
		EndIf
	Next

	Return $aArray
EndFunc   ;==>_Array1DToHistogram

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __Array_StringRepeat
; Description ...: Repeats a string a specified number of times
; Syntax.........: __Array_StringRepeat ( $sString, $iRepeatCount )
; Parameters ....: $sString - String to repeat
;                  $iRepeatCount - Number of times to repeat the string
; Return values .: a string with specified number of repeats.
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......: jpm
; Remarks .......: This function is used internally. similar to _StringRepeat() but if $iRepeatCount = 0 returns ""
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __Array_StringRepeat($sString, $iRepeatCount)
	; Casting Int() takes care of String/Int, Numbers.
	$iRepeatCount = Int($iRepeatCount)
	; Zero is a valid repeat integer.
	If StringLen($sString) < 1 Or $iRepeatCount <= 0 Then Return SetError(1, 0, "")
	Local $sResult = ""
	While $iRepeatCount > 1
		If BitAND($iRepeatCount, 1) Then $sResult &= $sString
		$sString &= $sString
		$iRepeatCount = BitShift($iRepeatCount, 1)
	WEnd
	Return $sString & $sResult
EndFunc   ;==>__Array_StringRepeat

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __Array_ExeterInternal
; Description ...: Permute Function based on an algorithm from Exeter University.
; Syntax.........: __Array_ExeterInternal ( ByRef $avArray, $iStart, $iSize, $sDelim, ByRef $aIdx, ByRef $aResult )
; Parameters ....: $avArray - The Array to get Permutations
;                  $iStart - Starting Point for Loop
;                  $iSize - End Point for Loop
;                  $sDelim - String result separator
;                  $aIdx - Array Used in Rotations
;                  $aResult - Resulting Array
; Return values .: Success      - Computer name
; Author ........: Erik Pilsits
; Modified.......: 07/08/2008
; Remarks .......: This function is used internally. Permute Function based on an algorithm from Exeter University.
; +
;                   http://www.bearcave.com/random_hacks/permute.html
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __Array_ExeterInternal(ByRef $avArray, $iStart, $iSize, $sDelim, ByRef $aIdx, ByRef $aResult, ByRef $iCount)
	If $iStart == $iSize - 1 Then
		For $i = 0 To $iSize - 1
			$aResult[$iCount] &= $avArray[$aIdx[$i]] & $sDelim
		Next
		If $sDelim <> "" Then $aResult[$iCount] = StringTrimRight($aResult[$iCount], StringLen($sDelim))
		$iCount += 1
	Else
		Local $iTemp
		For $i = $iStart To $iSize - 1
			$iTemp = $aIdx[$i]

			$aIdx[$i] = $aIdx[$iStart]
			$aIdx[$iStart] = $iTemp
			__Array_ExeterInternal($avArray, $iStart + 1, $iSize, $sDelim, $aIdx, $aResult, $iCount)
			$aIdx[$iStart] = $aIdx[$i]
			$aIdx[$i] = $iTemp
		Next
	EndIf
EndFunc   ;==>__Array_ExeterInternal

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __Array_Combinations
; Description ...: Creates Combination
; Syntax.........: __Array_Combinations ( $iN, $iR )
; Parameters ....: $iN - Value passed on from UBound($avArray)
;                  $iR - Size of the combinations set
; Return values .: Integer value of the number of combinations
; Author ........: Erik Pilsits
; Modified.......: 07/08/2008
; Remarks .......: This function is used internally. PBased on an algorithm by Kenneth H. Rosen.
; +
;                   http://www.bearcave.com/random_hacks/permute.html
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __Array_Combinations($iN, $iR)
	Local $i_Total = 1

	For $i = $iR To 1 Step -1
		$i_Total *= ($iN / $i)
		$iN -= 1
	Next
	Return Round($i_Total)
EndFunc   ;==>__Array_Combinations

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __Array_GetNext
; Description ...: Creates Combination
; Syntax.........: __Array_GetNext ( $iN, $iR, ByRef $iLeft, $iTotal, ByRef $aIdx )
; Parameters ....: $iN - Value passed on from UBound($avArray)
;                  $iR - Size of the combinations set
;                  $iLeft - Remaining number of combinations
;                  $iTotal - Total number of combinations
;                  $aIdx - Array containing combinations
; Return values .: Function only changes values ByRef
; Author ........: Erik Pilsits
; Modified.......: 07/08/2008
; Remarks .......: This function is used internally. PBased on an algorithm by Kenneth H. Rosen.
; +
;                   http://www.bearcave.com/random_hacks/permute.html
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __Array_GetNext($iN, $iR, ByRef $iLeft, $iTotal, ByRef $aIdx)
	If $iLeft == $iTotal Then
		$iLeft -= 1
		Return
	EndIf

	Local $i = $iR - 1
	While $aIdx[$i] == $iN - $iR + $i
		$i -= 1
	WEnd

	$aIdx[$i] += 1
	For $j = $i + 1 To $iR - 1
		$aIdx[$j] = $aIdx[$i] + $j - $i
	Next

	$iLeft -= 1
EndFunc   ;==>__Array_GetNext

Func __Array_MinMaxIndex(Const ByRef $avArray, $iCompNumeric, $iStart, $iEnd, $iSubItem, $fuComparison) ; Always swapped the comparison params around e.g. it was for min 100 > 1000 whereas 1000 < 100 makes more sense in a min function.
	If $iCompNumeric = Default Then $iCompNumeric = 0
	If $iCompNumeric <> 1 Then $iCompNumeric = 0
	If $iStart = Default Then $iStart = 0
	If $iEnd = Default Then $iEnd = 0
	If $iSubItem = Default Then $iSubItem = 0
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($avArray, $UBOUND_ROWS) - 1
	If $iEnd = 0 Then $iEnd = $iDim_1
	If $iStart < 0 Or $iEnd < 0 Then Return SetError(3, 0, -1)
	If $iStart > $iDim_1 Or $iEnd > $iDim_1 Then Return SetError(3, 0, -1)
	If $iStart > $iEnd Then Return SetError(4, 0, -1)
	If $iDim_1 < 0 Then Return SetError(5, 0, -1)
	Local $iMaxMinIndex = $iStart
	Switch UBound($avArray, $UBOUND_DIMENSIONS)
		Case 1
			If $iCompNumeric Then
				For $i = $iStart To $iEnd
					If $fuComparison(Number($avArray[$i]), Number($avArray[$iMaxMinIndex])) Then $iMaxMinIndex = $i
				Next
			Else
				For $i = $iStart To $iEnd
					If $fuComparison($avArray[$i], $avArray[$iMaxMinIndex]) Then $iMaxMinIndex = $i
				Next
			EndIf
		Case 2
			If $iSubItem < 0 Or $iSubItem > UBound($avArray, $UBOUND_COLUMNS) - 1 Then Return SetError(6, 0, -1)
			If $iCompNumeric Then
				For $i = $iStart To $iEnd
					If $fuComparison(Number($avArray[$i][$iSubItem]), Number($avArray[$iMaxMinIndex][$iSubItem])) Then $iMaxMinIndex = $i
				Next
			Else
				For $i = $iStart To $iEnd
					If $fuComparison($avArray[$i][$iSubItem], $avArray[$iMaxMinIndex][$iSubItem]) Then $iMaxMinIndex = $i
				Next
			EndIf
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch

	Return $iMaxMinIndex
EndFunc   ;==>__Array_MinMaxIndex

Func __Array_GreaterThan($vValue1, $vValue2)
	Return $vValue1 > $vValue2
EndFunc   ;==>__Array_GreaterThan

Func __Array_LessThan($vValue1, $vValue2)
	Return $vValue1 < $vValue2
EndFunc   ;==>__Array_LessThan
