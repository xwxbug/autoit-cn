#include-once
#include <StructureConstants.au3>
#include <FontConstants.au3>

; #INDEX# =======================================================================================================================
; Title .........: Misc
; AutoIt Version: 3.1.1++
; Language:       English
; Description:    Functions that assist with Common Dialogs.
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global Const $__MISCCONSTANT_CC_ANYCOLOR = 0x100
Global Const $__MISCCONSTANT_CC_FULLOPEN = 0x2
Global Const $__MISCCONSTANT_CC_RGBINIT = 0x1

;==============================================================================================================================
; #CURRENT# =====================================================================================================================
;_ChooseColor
;_ChooseFont
;_ClipPutFile
;_Iif
;_MouseTrap
;_Singleton
;_IsPressed
;_VersionCompare
;==============================================================================================================================
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;_MISC_GetDC
;_MISC_GetDeviceCaps
;_MISC_ReleaseDC
;==============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _ChooseColor
; Description ...: Creates a Color dialog box that enables the user to select a color
; Syntax.........: _ChooseColor([$iReturnType = 0[, $iColorRef = 0[, $iRefType = 0[, $hWndOwnder = 0]]]])
; Parameters ....: $iReturnType - Determines return type, valid values:
;                  |0 - COLORREF rgbcolor
;                  |1 - BGR hex
;                  |2 - RGB hex
;                  $iColorRef   - Default selected Color
;                  $iRefType    - Type of $iColorRef passed in, valid values:
;                  |0 - COLORREF rgbcolor
;                  |1 - BGR hex
;                  |2 - RGB hex
;                  $hWndOwnder  - Handle to the window that owns the dialog box
; Return values .: Success      - Color returned
;                  Failure      - -1
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _ChooseColor($iReturnType = 0, $iColorRef = 0, $iRefType = 0, $hWndOwnder = 0)
	Local $custcolors = "int[16]", $tcc, $tChoose, $color_picked, $iResult

	$tChoose = DllStructCreate($tagCHOOSECOLOR)
	$tcc = DllStructCreate($custcolors)

	If ($iRefType == 1) Then ; BGR hex color to colorref
		$iColorRef = Int($iColorRef)
	ElseIf ($iRefType == 2) Then ; RGB hex color to colorref
		$iColorRef = Hex(String($iColorRef), 6)
		$iColorRef = '0x' & StringMid($iColorRef, 5, 2) & StringMid($iColorRef, 3, 2) & StringMid($iColorRef, 1, 2)
	EndIf

	DllStructSetData($tChoose, "Size", DllStructGetSize($tChoose))
	DllStructSetData($tChoose, "hWndOwnder", $hWndOwnder)
	DllStructSetData($tChoose, "rgbResult", $iColorRef)
	DllStructSetData($tChoose, "CustColors", DllStructGetPtr($tcc))
	DllStructSetData($tChoose, "Flags", BitOR($__MISCCONSTANT_CC_ANYCOLOR, $__MISCCONSTANT_CC_FULLOPEN, $__MISCCONSTANT_CC_RGBINIT))

	$iResult = DllCall("comdlg32.dll", "long", "ChooseColor", "ptr", DllStructGetPtr($tChoose))

	If ($iResult[0] == 0) Then Return SetError(-3, -3, -1) ; user selected cancel or struct settings incorrect

	$color_picked = DllStructGetData($tChoose, "rgbResult")

	If ($iReturnType == 1) Then ; return Hex BGR Color
		Return '0x' & Hex(String($color_picked), 6)
	ElseIf ($iReturnType == 2) Then ; return Hex RGB Color
		$color_picked = Hex(String($color_picked), 6)
		Return '0x' & StringMid($color_picked, 5, 2) & StringMid($color_picked, 3, 2) & StringMid($color_picked, 1, 2)
	ElseIf ($iReturnType == 0) Then ; return RGB COLORREF
		Return $color_picked
	Else
		Return SetError(-4, -4, -1)
	EndIf
EndFunc   ;==>_ChooseColor

; #FUNCTION# ====================================================================================================================
; Name...........: _ChooseFont
; Description ...: Creates a Font dialog box that enables the user to choose attributes for a logical font.
; Syntax.........: _ChooseFont([$sFontName = "Courier New"[, $iPointSize = 10[, $iColorRef = 0[, $iFontWeight = 0[, $iItalic = False[, $iUnderline = False[, $iStrikethru = False[, $hWndOwner = 0]]]]]]]])
; Parameters ....: $sFontName   - Default font name
;                  $iPointSize  - Pointsize of font
;                  $iColorRef   - COLORREF rgbColors
;                  $iFontWeight - Font Weight
;                  $iItalic     - Italic
;                  $iUnderline  - Underline
;                  $iStrikethru - Optional: Strikethru
;                  $hWndOwnder  - Handle to the window that owns the dialog box
; Return values .: Success      - Array in the following format:
;                  |[0] - contains the number of elements
;                  |[1] - attributes = BitOr of italic:2, undeline:4, strikeout:8
;                  |[2] - fontname
;                  |[3] - font size = point size
;                  |[4] - font weight = = 0-1000
;                  |[5] - COLORREF rgbColors
;                  |[6] - Hex BGR Color
;                  |[7] - Hex RGB Color
;                  Failure      - -1
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _ChooseFont($sFontName = "Courier New", $iPointSize = 10, $iColorRef = 0, $iFontWeight = 0, $iItalic = False, $iUnderline = False, $iStrikethru = False, $hWndOwner = 0)
	Local $tLogFont, $tChooseFont, $lngDC, $lfHeight, $iResult
	Local $fontname, $italic = 0, $underline = 0, $strikeout = 0
	Local $attributes, $size, $weight, $colorref, $color_picked


	$lngDC = _MISC_GetDC(0)
	$lfHeight = Round(($iPointSize * _MISC_GetDeviceCaps($lngDC, $LOGPIXELSX)) / 72, 0)
	_MISC_ReleaseDC(0, $lngDC)

	$tChooseFont = DllStructCreate($tagCHOOSEFONT)
	$tLogFont = DllStructCreate($tagLOGFONT)

	DllStructSetData($tChooseFont, "Size", DllStructGetSize($tChooseFont))
	DllStructSetData($tChooseFont, "hWndOwner", $hWndOwner)
	DllStructSetData($tChooseFont, "LogFont", DllStructGetPtr($tLogFont))
	DllStructSetData($tChooseFont, "PointSize", $iPointSize)
	DllStructSetData($tChooseFont, "Flags", BitOR($CF_SCREENFONTS, $CF_PRINTERFONTS, $CF_EFFECTS, $CF_INITTOLOGFONTSTRUCT, $CF_NOSCRIPTSEL))
	DllStructSetData($tChooseFont, "rgbColors", $iColorRef)
	DllStructSetData($tChooseFont, "FontType", 0)

	DllStructSetData($tLogFont, "Height", $lfHeight)
	DllStructSetData($tLogFont, "Weight", $iFontWeight)
	DllStructSetData($tLogFont, "Italic", $iItalic)
	DllStructSetData($tLogFont, "Underline", $iUnderline)
	DllStructSetData($tLogFont, "Strikeout", $iStrikethru)
	DllStructSetData($tLogFont, "FaceName", $sFontName)

	$iResult = DllCall("comdlg32.dll", "long", "ChooseFont", "ptr", DllStructGetPtr($tChooseFont))
	If ($iResult[0] == 0) Then Return SetError(-3, -3, -1) ; user selected cancel or struct settings incorrect

	$fontname = DllStructGetData($tLogFont, "FaceName")
	If (StringLen($fontname) == 0 And StringLen($sFontName) > 0) Then $fontname = $sFontName

	If (DllStructGetData($tLogFont, "Italic")) Then $italic = 2
	If (DllStructGetData($tLogFont, "Underline")) Then $underline = 4
	If (DllStructGetData($tLogFont, "Strikeout")) Then $strikeout = 8

	$attributes = BitOR($italic, $underline, $strikeout)
	$size = DllStructGetData($tChooseFont, "PointSize") / 10
	$colorref = DllStructGetData($tChooseFont, "rgbColors")
	$weight = DllStructGetData($tLogFont, "Weight")

	$color_picked = Hex(String($colorref), 6)

	Return StringSplit($attributes & "," & $fontname & "," & $size & "," & $weight & "," & $colorref & "," & '0x' & $color_picked & "," & '0x' & StringMid($color_picked, 5, 2) & StringMid($color_picked, 3, 2) & StringMid($color_picked, 1, 2), ",")
EndFunc   ;==>_ChooseFont

; #FUNCTION# ====================================================================================================================
; Name...........: _ClipPutFile
; Description ...: Copy Files to Clipboard Like Explorer does
; Syntax.........: _ClipPutFile($sFile[, $sSeperator = "|"])
; Parameters ....: $sFile       - Full Path to File(s)
;                  $sSeperator  - Seperator for multiple Files, Default = '|'
; Return values .: Success      - True
;                  Failure      - False and Sets @ERROR to:
;                  |1 - Unable to Open Clipboard
;                  |2 - Unable to Empty Cipboard
;                  |3 - GlobalAlloc Failed
;                  |4 - GlobalLock Failed
;                  |5 - Unable to Create H_DROP
;                  |6 - Unable to Update Clipboard
;                  |7 - Unable to Close Clipboard
;                  |8 - GlobalUnlock Failed
; Author ........: Piccaso (Florian Fida)
; Modified.......: Gary Frost (gafrost)
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _ClipPutFile($sFile, $sSeperator = "|")
	Local $vDllCallTmp, $nGlobMemSize, $hGlobal, $DROPFILES, $i, $hLock
	Local $GMEM_MOVEABLE = 0x0002, $CF_HDROP = 15

	$sFile &= $sSeperator & $sSeperator
	$nGlobMemSize = (StringLen($sFile) + 20)
	$vDllCallTmp = DllCall("user32.dll", "int", "OpenClipboard", "hwnd", 0)

	If @error Or $vDllCallTmp[0] = 0 Then Return SetError(1, 1, False)

	$vDllCallTmp = DllCall("user32.dll", "int", "EmptyClipboard")
	If @error Or $vDllCallTmp[0] = 0 Then Return SetError(2, 2, False)

	$vDllCallTmp = DllCall("kernel32.dll", "hwnd", "GlobalAlloc", "int", $GMEM_MOVEABLE, "int", $nGlobMemSize)
	If @error Or $vDllCallTmp[0] < 1 Then Return SetError(3, 3, False)

	$hGlobal = $vDllCallTmp[0]
	$vDllCallTmp = DllCall("kernel32.dll", "hwnd", "GlobalLock", "long", $hGlobal)
	If @error Or $vDllCallTmp[0] < 1 Then Return SetError(4, 4, False)

	$hLock = $vDllCallTmp[0]
	$DROPFILES = DllStructCreate("dword;ptr;int;int;int;char[" & StringLen($sFile) + 1 & "]", $hLock)
	If @error Then Return SetError(5, 6, False)

	Local $tempStruct = DllStructCreate("dword;ptr;int;int;int")

	DllStructSetData($DROPFILES, 1, DllStructGetSize($tempStruct))
	DllStructSetData($DROPFILES, 2, 0)
	DllStructSetData($DROPFILES, 3, 0)
	DllStructSetData($DROPFILES, 4, 0)
	DllStructSetData($DROPFILES, 5, 0)
	DllStructSetData($DROPFILES, 6, $sFile)
	For $i = 1 To StringLen($sFile)
		If DllStructGetData($DROPFILES, 6, $i) = $sSeperator Then DllStructSetData($DROPFILES, 6, Chr(0), $i)
	Next

	$vDllCallTmp = DllCall("user32.dll", "long", "SetClipboardData", "int", $CF_HDROP, "long", $hGlobal)
	If @error Or $vDllCallTmp[0] < 1 Then Return SetError(6, 6, False)
	$vDllCallTmp = DllCall("user32.dll", "int", "CloseClipboard")
	If @error Or $vDllCallTmp[0] = 0 Then Return SetError(7, 7, False)
	$vDllCallTmp = DllCall("kernel32.dll", "int", "GlobalUnlock", "long", $hGlobal)
	If @error Then Return SetError(8, 8, False)
	$vDllCallTmp = DllCall("kernel32.dll", "int", "GetLastError")
	If $vDllCallTmp = 0 Then Return SetError(8, 9, False)
	Return True
EndFunc   ;==>_ClipPutFile

; #FUNCTION# ====================================================================================================================
; Name...........: _Iif
; Description ...: Perform a boolean test within an expression.
; Syntax.........: _Iif($fTest, $vTrueVal, $vFalseVal)
; Parameters ....: $fTest     - Boolean test.
;                  $vTrueVal  - Value to return if $fTest is true.
;                  $vFalseVal - Value to return if $fTest is false.
; Return values .: True         - $vTrueVal
;                  False        - $vFalseVal
; Author ........: Dale (Klaatu) Thompson
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Iif($fTest, $vTrueVal, $vFalseVal)
	If $fTest Then
		Return $vTrueVal
	Else
		Return $vFalseVal
	EndIf
EndFunc   ;==>_Iif

; #FUNCTION# ====================================================================================================================
; Name...........: _MouseTrap
; Description ...: Confine the Mouse Cursor to specified coords.
; Syntax.........: _MouseTrap([$iLeft = 0[, $iTop = 0[, $iRight = 0[, $iBottom = 0]]]])
; Parameters ....: $iLeft   - Left coord
;                  $iTop    - Top coord
;                  $iRight  - Right coord
;                  $iBottom - Bottom coord
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......: Use _MouseTrap() with no params to release the Mouse Cursor
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _MouseTrap($iLeft = 0, $iTop = 0, $iRight = 0, $iBottom = 0)
	Local $iResult, $tRect
	If @NumParams == 0 Then
		$iResult = DllCall("user32.dll", "int", "ClipCursor", "int", 0)
	Else
		If @NumParams == 2 Then
			$iRight = $iLeft + 1
			$iBottom = $iTop + 1
		EndIf
		$tRect = DllStructCreate($tagRect)
		If @error Then Return 0
		DllStructSetData($tRect, "Left", $iLeft)
		DllStructSetData($tRect, "Top", $iTop)
		DllStructSetData($tRect, "Right", $iRight)
		DllStructSetData($tRect, "Bottom", $iBottom)
		$iResult = DllCall("user32.dll", "int", "ClipCursor", "ptr", DllStructGetPtr($tRect))
	EndIf
	Return $iResult[0] <> 0
EndFunc   ;==>_MouseTrap

; #FUNCTION# ====================================================================================================================
; Name...........: _Singleton
; Description ...: Enforce a design paradigm where only one instance of the script may be running.
; Syntax.........: _Singleton($sOccurenceName[, $iFlag = 0])
; Parameters ....: $sOccurenceName - String to identify the occurrence of the script.  This string may not contain the \ character unless you are placing the object in a namespace (See Remarks).
;                  $iFlag          - Behavior options.
;                  |0 - Exit the script with the exit code -1 if another instance already exists.
;                  |1 - Return from the function without exiting the script.
;                  |2 - Allow the object to be accessed by anybody in the system. This is useful if specifying a "Global\" object in a multi-user environment.
; Return values .: Success      - The handle to the object used for synchronization (a mutex).
;                  Failure      - 0
; Author ........: Valik
; Modified.......:
; Remarks .......: You can place the object in a namespace by prefixing your object name with either "Global\" or "Local\".  "Global\" objects combined with the flag 2 are useful in multi-user environments.
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Singleton($sOccurenceName, $iFlag = 0)
	Local Const $ERROR_ALREADY_EXISTS = 183
	Local Const $SECURITY_DESCRIPTOR_REVISION = 1
	Local $handle, $lastError, $pSecurityAttributes = 0

	If BitAND($iFlag, 2) Then
		; The size of SECURITY_DESCRIPTOR is 20 bytes.  We just
		; need a block of memory the right size, we aren't going to
		; access any members directly so it's not important what
		; the members are, just that the total size is correct.
		Local $structSecurityDescriptor = DllStructCreate("dword[5]")
		Local $pSecurityDescriptor = DllStructGetPtr($structSecurityDescriptor)
		; Initialize the security descriptor.
		Local $aRet = DllCall("advapi32.dll", "int", "InitializeSecurityDescriptor", _
				"ptr", $pSecurityDescriptor, "dword", $SECURITY_DESCRIPTOR_REVISION)
		If Not @error And $aRet[0] Then
			; Add the NULL DACL specifying access to everybody.
			$aRet = DllCall("advapi32.dll", "int", "SetSecurityDescriptorDacl", _
					"ptr", $pSecurityDescriptor, "int", 1, "ptr", 0, "int", 0)
			If Not @error And $aRet[0] Then
				; Create a SECURITY_ATTRIBUTES structure.
				Local $structSecurityAttributes = DllStructCreate("dword;ptr;int")
				; Assign the members.
				DllStructSetData($structSecurityAttributes, 1, DllStructGetSize($structSecurityAttributes))
				DllStructSetData($structSecurityAttributes, 2, $pSecurityDescriptor)
				DllStructSetData($structSecurityAttributes, 3, 0)
				; Everything went okay so update our pointer to point to our structure.
				$pSecurityAttributes = DllStructGetPtr($structSecurityAttributes)
			EndIf
		EndIf
	EndIf

	$handle = DllCall("kernel32.dll", "int", "CreateMutex", "ptr", $pSecurityAttributes, "long", 1, "str", $sOccurenceName)
	$lastError = DllCall("kernel32.dll", "int", "GetLastError")
	If $lastError[0] = $ERROR_ALREADY_EXISTS Then
		If BitAND($iFlag, 1) Then
			Return SetError($lastError[0], $lastError[0], 0)
		Else
			Exit -1
		EndIf
	EndIf
	Return $handle[0]
EndFunc   ;==>_Singleton

; #FUNCTION# ====================================================================================================================
; Name...........: _IsPressed
; Description ...: Check if key has been pressed
; Syntax.........: _IsPressed($sHexKey[, $vDLL = 'user32.dll'])
; Parameters ....: $sHexKey     - Key to check for
;                  $vDLL        - Handle to dll or default to user32.dll
; Return values .: True         - 1
;                  False        - 0
; Author ........: ezzetabi and Jon
; Modified.......:
; Remarks .......: If calling this function repeatidly, should open 'user32.dll' and pass in handle.
;                  Make sure to close at end of script
;                  01 Left mouse button
;                  02 Right mouse button
;                  04 Middle mouse button (three-button mouse)
;                  05 Windows 2000/XP: X1 mouse button
;                  06 Windows 2000/XP: X2 mouse button
;                  08 BACKSPACE key
;                  09 TAB key
;                  0C CLEAR key
;                  0D ENTER key
;                  10 SHIFT key
;                  11 CTRL key
;                  12 ALT key
;                  13 PAUSE key
;                  14 CAPS LOCK key
;                  1B ESC key
;                  20 SPACEBAR
;                  21 PAGE UP key
;                  22 PAGE DOWN key
;                  23 END key
;                  24 HOME key
;                  25 LEFT ARROW key
;                  26 UP ARROW key
;                  27 RIGHT ARROW key
;                  28 DOWN ARROW key
;                  29 SELECT key
;                  2A PRINT key
;                  2B EXECUTE key
;                  2C PRINT SCREEN key
;                  2D INS key
;                  2E DEL key
;                  30 0 key
;                  31 1 key
;                  32 2 key
;                  33 3 key
;                  34 4 key
;                  35 5 key
;                  36 6 key
;                  37 7 key
;                  38 8 key
;                  39 9 key
;                  41 A key
;                  42 B key
;                  43 C key
;                  44 D key
;                  45 E key
;                  46 F key
;                  47 G key
;                  48 H key
;                  49 I key
;                  4A J key
;                  4B K key
;                  4C L key
;                  4D M key
;                  4E N key
;                  4F O key
;                  50 P key
;                  51 Q key
;                  52 R key
;                  53 S key
;                  54 T key
;                  55 U key
;                  56 V key
;                  57 W key
;                  58 X key
;                  59 Y key
;                  5A Z key
;                  5B Left Windows key
;                  5C Right Windows key
;                  60 Numeric keypad 0 key
;                  61 Numeric keypad 1 key
;                  62 Numeric keypad 2 key
;                  63 Numeric keypad 3 key
;                  64 Numeric keypad 4 key
;                  65 Numeric keypad 5 key
;                  66 Numeric keypad 6 key
;                  67 Numeric keypad 7 key
;                  68 Numeric keypad 8 key
;                  69 Numeric keypad 9 key
;                  6A Multiply key
;                  6B Add key
;                  6C Separator key
;                  6D Subtract key
;                  6E Decimal key
;                  6F Divide key
;                  70 F1 key
;                  71 F2 key
;                  72 F3 key
;                  73 F4 key
;                  74 F5 key
;                  75 F6 key
;                  76 F7 key
;                  77 F8 key
;                  78 F9 key
;                  79 F10 key
;                  7A F11 key
;                  7B F12 key
;                  7C-7F F13 key - F16 key
;                  80H-87H F17 key - F24 key
;                  90 NUM LOCK key
;                  91 SCROLL LOCK key
;                  A0 Left SHIFT key
;                  A1 Right SHIFT key
;                  A2 Left CONTROL key
;                  A3 Right CONTROL key
;                  A4 Left MENU key
;                  A5 Right MENU key
;                  BA ;
;                  BB =
;                  BC ,
;                  BD -
;                  BE .
;                  BF /
;                  C0 `
;                  DB [
;                  DC \
;                  DD ]
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _IsPressed($sHexKey, $vDLL = 'user32.dll')
	; $hexKey must be the value of one of the keys.
	; _Is_Key_Pressed will return 0 if the key is not pressed, 1 if it is.
	Local $a_R = DllCall($vDLL, "int", "GetAsyncKeyState", "int", '0x' & $sHexKey)
	If Not @error And BitAND($a_R[0], 0x8000) = 0x8000 Then Return 1
	Return 0
EndFunc   ;==>_IsPressed

; #FUNCTION# ====================================================================================================================
; Name...........: _VersionCompare
; Description ...: Compares two file versions for equality
; Syntax.........: _VersionCompare($sVersion1, $sVersion2)
; Parameters ....: $sVersion1   - IN - The first version
;                  $sVersion2   - IN - The second version
; Return values .: Success      - Following Values:
;                  | 0          - Both versions equal
;                  | 1          - Version 1 greater
;                  |-1          - Version 2 greater
;                  Failure      - @error will be set in the event of a catasrophic error
; Author ........: Valik
; Modified.......:
; Remarks .......: This will try to use a numerical comparison but fall back on a lexicographical comparison.
;                  See @extended for details about which type was performed.
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _VersionCompare($sVersion1, $sVersion2)
	If $sVersion1 = $sVersion2 Then Return 0
	Local $sep = "."
	If StringInStr($sVersion1, $sep) = 0 Then $sep = ","
	Local $aVersion1 = StringSplit($sVersion1, $sep)
	Local $aVersion2 = StringSplit($sVersion2, $sep)
	If UBound($aVersion1) <> UBound($aVersion2) Or UBound($aVersion1) = 0 Then
		; Compare as strings
		SetExtended(1)
		If $sVersion1 > $sVersion2 Then
			Return 1
		ElseIf $sVersion1 < $sVersion2 Then
			Return -1
		EndIf
	Else
		For $i = 1 To UBound($aVersion1) - 1
			; Compare this segment as numbers
			If StringIsDigit($aVersion1[$i]) And StringIsDigit($aVersion2[$i]) Then
				If Number($aVersion1[$i]) > Number($aVersion2[$i]) Then
					Return 1
				ElseIf Number($aVersion1[$i]) < Number($aVersion2[$i]) Then
					Return -1
				EndIf
			Else ; Compare the segment as strings
				SetExtended(1)
				If $aVersion1[$i] > $aVersion2[$i] Then
					Return 1
				ElseIf $aVersion1[$i] < $aVersion2[$i] Then
					Return -1
				EndIf
			EndIf
		Next
	EndIf
	; This point should never be reached
	SetError(2)
	Return 0
EndFunc   ;==>_VersionCompare

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _MISC_GetDC
; Description ...: Retrieves a handle of a display device context for the client area a window
; Syntax.........: _MISC_GetDC($hWnd)
; Parameters ....: $hWnd        - Handle of window
; Return values .: Success      - The device context for the given window's client area
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: After painting with a common device context, the _MISC_ReleaseDC function must be called to release the DC
; Related .......:
; Link ..........; @@MsdnLink@@ GetDC
; Example .......;
; ===============================================================================================================================
Func _MISC_GetDC($hWnd)
	Local $aResult

	$aResult = DllCall("User32.dll", "hwnd", "GetDC", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_MISC_GetDC

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _MISC_GetDeviceCaps
; Description ...: Retrieves device specific information about a specified device
; Syntax.........: _MISC_GetDeviceCaps($hDC, $iIndex)
; Parameters ....: $hDC         - Identifies the device context
;                  $iIndex      - Specifies the item to return
; Return values .: Success      - The value of the desired item
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetDeviceCaps
; Example .......;
; ===============================================================================================================================
Func _MISC_GetDeviceCaps($hDC, $iIndex)
	Local $aResult

	$aResult = DllCall("GDI32.dll", "int", "GetDeviceCaps", "hwnd", $hDC, "int", $iIndex)
	Return $aResult[0]
EndFunc   ;==>_MISC_GetDeviceCaps

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _MISC_ReleaseDC
; Description ...: Releases a device context
; Syntax.........: _MISC_ReleaseDC($hWnd, $hDC)
; Parameters ....: $hWnd        - Handle of window
;                  $hDC         - Identifies the device context to be released
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: The application must call the _MISC_ReleaseDC function for each call to the _WinAPI_GetWindowDC function  and  for
;                  each call to the _WinAPI_GetDC function that retrieves a common device context.
; Related .......: _WinAPI_GetDC, _WinAPI_GetWindowDC
; Link ..........; @@MsdnLink@@ ReleaseDC
; Example .......;
; ===============================================================================================================================
Func _MISC_ReleaseDC($hWnd, $hDC)
	Local $aResult

	$aResult = DllCall("User32.dll", "int", "ReleaseDC", "hwnd", $hWnd, "hwnd", $hDC)
	Return $aResult[0] <> 0
EndFunc   ;==>_MISC_ReleaseDC
