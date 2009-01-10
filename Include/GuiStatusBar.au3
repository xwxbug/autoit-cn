#include-once
#include <Memory.au3>
#include <WinAPI.au3>
#include <StatusBarConstants.au3>
#include <SendMessage.au3>
#include <UDFGlobalID.au3>

; #INDEX# =======================================================================================================================
; Title .........: StatusBar
; AutoIt Version: 3.2.3++
; Language:       English
; Description:    A status bar is a horizontal window at the bottom of a parent window in which an application can display
;                 various kinds of status information.  The status bar can be divided into parts to display more than one type
;                 of information
;
; Added Functions by Paul Campbell (PaulIA) from Auto3Lib project
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $__ghSBLastWnd
Global $Debug_SB = False
Global Const $__STATUSBARCONSTANT_ClassName = "msctls_statusbar32"
Global Const $__STATUSBARCONSTANT_WS_VISIBLE = 0x10000000
Global Const $__STATUSBARCONSTANT_WS_CHILD = 0x40000000
Global Const $__STATUSBARCONSTANT_WM_SIZE = 0x05
Global Const $__STATUSBARCONSTANT_CLR_DEFAULT = 0xFF000000
; ===============================================================================================================================

;===============================================================================
;===============================================================================
; depricated functions will no longer work
;===============================================================================
; #OLD_FUNCTIONS#================================================================================================================
; Old Function/Name                      ; --> New Function/Name/Replacement(s)
; ===============================================================================================================================
;_GUICtrlStatusBarCreate                ; --> _GUICtrlStatusBar_Create
;_GUICtrlStatusBarCreateProgress        ; --> for backward compatibilty only (won't be documented)
;_GUICtrlStatusBarDelete                ; --> _GUICtrlStatusBar_Destroy
;_GUICtrlStatusBarGetBorders            ; --> _GUICtrlStatusBar_GetBorders
;_GUICtrlStatusBarGetIcon               ; --> _GUICtrlStatusBar_GetIcon
;_GUICtrlStatusBarGetParts              ; --> _GUICtrlStatusBar_GetCount
;_GUICtrlStatusBarGetRect               ; --> _GUICtrlStatusBar_GetRect
;_GUICtrlStatusBarGetText               ; --> _GUICtrlStatusBar_GetText
;_GUICtrlStatusBarGetTextLength         ; --> _GUICtrlStatusBar_GetTextLength
;_GUICtrlStatusBarGetTip                ; --> _GUICtrlStatusBar_GetTipText
;_GUICtrlStatusBarGetUnicode            ; --> _GUICtrlStatusBar_GetUnicodeFormat
;_GUICtrlStatusBarIsSimple              ; --> _GUICtrlStatusBar_IsSimple
;_GUICtrlStatusBarResize                ; --> _GUICtrlStatusBar_Resize
;_GUICtrlStatusBarSetBKColor            ; --> _GUICtrlStatusBar_SetBKColor
;_GUICtrlStatusBarSetIcon               ; --> _GUICtrlStatusBar_SetIcon
;_GUICtrlStatusBarSetMinHeight          ; --> _GUICtrlStatusBar_SetMinHeight
;_GUICtrlStatusBarSetParts              ; --> _GUICtrlStatusBar_SetParts
;_GUICtrlStatusBarSetSimple             ; --> _GUICtrlStatusBar_SetSimple
;_GUICtrlStatusBarSetText               ; --> _GUICtrlStatusBar_SetText
;_GUICtrlStatusBarSetTip                ; --> _GUICtrlStatusBar_SetTipText
;_GUICtrlStatusBarSetUnicode            ; --> _GUICtrlStatusBar_SetUnicodeFormat
;_GUICtrlStatusBarShowHide              ; --> _GUICtrlStatusBar_ShowHide
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_GUICtrlStatusBar_Create
;_GUICtrlStatusBar_Destroy
;_GUICtrlStatusBar_EmbedControl
;_GUICtrlStatusBar_GetBorders
;_GUICtrlStatusBar_GetBordersHorz
;_GUICtrlStatusBar_GetBordersRect
;_GUICtrlStatusBar_GetBordersVert
;_GUICtrlStatusBar_GetCount
;_GUICtrlStatusBar_GetHeight
;_GUICtrlStatusBar_GetIcon
;_GUICtrlStatusBar_GetParts
;_GUICtrlStatusBar_GetRect
;_GUICtrlStatusBar_GetRectEx
;_GUICtrlStatusBar_GetText
;_GUICtrlStatusBar_GetTextFlags
;_GUICtrlStatusBar_GetTextLength
;_GUICtrlStatusBar_GetTextLengthEx
;_GUICtrlStatusBar_GetTipText
;_GUICtrlStatusBar_GetUnicodeFormat
;_GUICtrlStatusBar_GetWidth
;_GUICtrlStatusBar_IsSimple
;_GUICtrlStatusBar_Resize
;_GUICtrlStatusBar_SetBKColor
;_GUICtrlStatusBar_SetIcon
;_GUICtrlStatusBar_SetMinHeight
;_GUICtrlStatusBar_SetParts
;_GUICtrlStatusBar_SetSimple
;_GUICtrlStatusBar_SetText
;_GUICtrlStatusBar_SetTipText
;_GUICtrlStatusBar_SetUnicodeFormat
;_GUICtrlStatusBar_ShowHide
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;_GUICtrlStatusBar_DebugPrint
;_GUICtrlStatusBar_ValidateClassName
;==============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_Create
; Description ...: Create a statusbar
; Syntax.........: _GUICtrlStatusBar_Create($hWnd[, $vPartEdge = -1[, $vPartText = ""[, $iStyles = -1[, $iExStyles = 0x00000000]]]])
; Parameters ....: $hWnd        - Handle to parent window
;                  $vPartEdge  - Width of part or parts, for more than 1 part pass in zero based array in the following format:
;                  |$vPartEdge[0] - Right edge of part #1
;                  |$vPartEdge[1] - Right edge of part #2
;                  |$vPartEdge[n] - Right edeg of part n
;                  $vPartText   - Text of part or parts, for more than 1 part pass in zero based array in the following format:
;                  |$vPartText[0] - First part
;                  |$vPartText[1] - Second part
;                  |$vPartText[n] - Last part
;                  $iStyles     - Control styles:
;                  |$SBARS_SIZEGRIP - The status bar control will include a sizing grip at the right end of the status bar
;                  |$SBARS_TOOLTIPS - The status bar will have tooltips
;                  -
;                  |Forced: $WS_CHILD, $WS_VISIBLE
;                  $iExStyles   - Control extended style
; Return values .: Success      - Handle to the control
;                  Failure      - 0
; Author ........: Gary Frost, Steve Podhajecki <gehossafats at netmdc dot com>
; Modified.......: Gary Frost
; Remarks .......: If using GUICtrlCreateMenu then use _GUICtrlStatusBar_Create after GUICtrlCreateMenu
; Related .......: _GUICtrlStatusBar_Destroy
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_Create($hWnd, $vPartEdge = -1, $vPartText = "", $iStyles = -1, $iExStyles = 0x00000000)
	If Not IsHWnd($hWnd) Then _WinAPI_ShowError("Invalid Window handle for _GUICtrlStatusBar_Create 1st parameter")

	Local $aPartWidth[1], $aPartText[1], $hWndSBar, $x, $iStyle = BitOR($__STATUSBARCONSTANT_WS_CHILD, $__STATUSBARCONSTANT_WS_VISIBLE)
	Local $iExStyle, $iLast, $nCtrlID

	If $iStyles = -1 Then $iStyles = 0x00000000
	If $iExStyle = -1 Then $iExStyle = 0x00000000

	If @NumParams > 1 Then ; more than param passed in
		; setting up arrays
		If IsArray($vPartEdge) Then ; setup part width array
			$aPartWidth = $vPartEdge
		Else
			$aPartWidth[0] = $vPartEdge
		EndIf
		If @NumParams = 2 Then ; part text was not passed in so set array to same size as part width array
			ReDim $aPartText[UBound($aPartWidth)]
		Else
			If IsArray($vPartText) Then ; setup part text array
				$aPartText = $vPartText
			Else
				$aPartText[0] = $vPartText
			EndIf
			; if partwidth array is not same size as parttext array use larger sized array for size
			If UBound($aPartWidth) <> UBound($aPartText) Then
				If UBound($aPartWidth) > UBound($aPartText) Then ; width array is larger
					$iLast = UBound($aPartText)
					ReDim $aPartText[UBound($aPartWidth)]
					For $x = $iLast To UBound($aPartText) - 1
						$aPartWidth[$x] = ""
					Next
				Else ; text array is larger
					$iLast = UBound($aPartWidth)
					ReDim $aPartWidth[UBound($aPartText)]
					For $x = $iLast To UBound($aPartWidth) - 1
						$aPartWidth[$x] = $aPartWidth[$x - 1] + 75
					Next
					$aPartWidth[UBound($aPartText) - 1] = -1
				EndIf
			EndIf
		EndIf
		If Not IsHWnd($hWnd) Then $hWnd = HWnd($hWnd)
		If @NumParams > 3 Then $iStyle = BitOR($iStyle, $iStyles)
		$iExStyle = $iExStyles
	EndIf

	$nCtrlID = _UDF_GetNextGlobalID($hWnd)
	If @error Then Return SetError(@error, @extended, 0)

	If @OSTYPE = "WIN32_WINDOWS" Then ; not sure if we want this in here for older systems
		$hWndSBar = DllCall("comctl32.dll", "hwnd", "CreateStatusWindow", "long", $iStyle, "str", "", "hwnd", $hWnd, "int", $nCtrlID)
		$hWndSBar = HWnd($hWndSBar[0])
	Else
		$hWndSBar = _WinAPI_CreateWindowEx($iExStyle, $__STATUSBARCONSTANT_ClassName, "", $iStyle, 0, 0, 0, 0, $hWnd, $nCtrlID)
	EndIf
	If @error Then Return SetError(1, 1, 0)
	If @NumParams > 1 Then ; set the parts/text
		_GUICtrlStatusBar_SetParts($hWndSBar, UBound($aPartWidth), $aPartWidth)
		For $x = 0 To UBound($aPartText) - 1
			_GUICtrlStatusBar_SetText($hWndSBar, $aPartText[$x], $x)
		Next
	EndIf
	Return $hWndSBar
EndFunc   ;==>_GUICtrlStatusBar_Create

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _GUICtrlStatusBar_DebugPrint
; Description ...: Used for debugging when creating examples
; Syntax.........: _GUICtrlStatusBar_DebugPrint($hWnd[, $iLine = @ScriptLineNumber])
; Parameters ....: $sText       - String to printed to console
;                  $iLine       - Line number function was called from
; Return values .: None
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......: For Internal Use Only
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _GUICtrlStatusBar_DebugPrint($sText, $iLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @LF & _
			"+======================================================" & @LF & _
			"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @LF & _
			"+======================================================" & @LF)
EndFunc   ;==>_GUICtrlStatusBar_DebugPrint

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_Destroy
; Description ...: Delete the control
; Syntax.........: _GUICtrlStatusBar_Destroy(ByRef $hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - True, Handle is set to 0
;                  Failure      - False
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......: Restricted to only be used on StatusBar created with _GUICtrlStatusBar_Create
; Related .......: _GUICtrlStatusBar_Create
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_Destroy(ByRef $hWnd)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $Destroyed, $iResult

	If _WinAPI_IsClassName($hWnd, $__STATUSBARCONSTANT_ClassName) Then
		If IsHWnd($hWnd) Then
			If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
				Local $nCtrlID = _WinAPI_GetDlgCtrlID($hWnd)
				Local $hParent = _WinAPI_GetParent($hWnd)
				$Destroyed = _WinAPI_DestroyWindow($hWnd)
				$iResult = _UDF_FreeGlobalID($hParent, $nCtrlID)
				If Not $iResult Then
					; can check for errors here if needed, for debug
				EndIf
			Else
				_WinAPI_ShowMsg("Not Allowed to Destroy Other Applications Control(s)")
				Return SetError(1, 1, False)
			EndIf
		EndIf
		If $Destroyed Then $hWnd = 0
		Return $Destroyed <> 0
	EndIf
	Return SetError(2, 2, False)
EndFunc   ;==>_GUICtrlStatusBar_Destroy

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_EmbedControl
; Description ...: Embeds a child control in the control
; Syntax.........: _GUICtrlStatusBar_EmbedControl($hWnd, $iPart, $hControl[, $iFit = 4])
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
;                  $hControl    - Handle of control to embed in panel
;                  $iFit        - Determines how to fit the control. Can be a combination of:
;                  |1 - Center the control horizontally
;                  |2 - Center the control vertically
;                  |4 - Fit the control to the status bar part
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: You can embed ANY control in the status bar, not just the usual Progress Bar
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_EmbedControl($hWnd, $iPart, $hControl, $iFit = 4)
	Local $aRect, $iBarX, $iBarY, $iBarW, $iBarH, $iConX, $iConY, $iConW, $iConH, $iPadX, $iPadY

	$aRect = _GUICtrlStatusBar_GetRect($hWnd, $iPart)
	$iBarX = $aRect[0]
	$iBarY = $aRect[1]
	$iBarW = $aRect[2] - $iBarX
	$iBarH = $aRect[3] - $iBarY

	$iConX = $iBarX
	$iConY = $iBarY
	$iConW = _WinAPI_GetWindowWidth($hControl)
	$iConH = _WinAPI_GetWindowHeight($hControl)

	If $iConW > $iBarW Then $iConW = $iBarW
	If $iConH > $iBarH Then $iConH = $iBarH
	$iPadX = ($iBarW - $iConW) / 2
	$iPadY = ($iBarH - $iConH) / 2
	If $iPadX < 0 Then $iPadX = 0
	If $iPadY < 0 Then $iPadY = 0

	If BitAND($iFit, 1) = 1 Then $iConX = $iBarX + $iPadX
	If BitAND($iFit, 2) = 2 Then $iConY = $iBarY + $iPadY
	If BitAND($iFit, 4) = 4 Then
		$iPadX = _GUICtrlStatusBar_GetBordersRect($hWnd)
		$iPadY = _GUICtrlStatusBar_GetBordersVert($hWnd)
		$iConX = $iBarX
		If _GUICtrlStatusBar_IsSimple($hWnd) Then $iConX += $iPadX
		$iConY = $iBarY + $iPadY
		$iConW = $iBarW - ($iPadX * 2)
		$iConH = $iBarH - ($iPadY * 2)
	EndIf

	_WinAPI_SetParent($hControl, $hWnd)
	_WinAPI_MoveWindow($hControl, $iConX, $iConY, $iConW, $iConH)
EndFunc   ;==>_GUICtrlStatusBar_EmbedControl

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetBorders
; Description ...: Retrieves the current widths of the horizontal and vertical borders
; Syntax.........: _GUICtrlStatusBar_GetBorders($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - Array with the following format:
;                  |$aBorders[0] - Width of the horizontal border
;                  |$aBorders[1] - Width of the vertical border
;                  |$aBorders[2] - Width of the border between rectangles
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetBordersHorz, _GUICtrlStatusBar_GetBordersRect, _GUICtrlStatusBar_GetBordersVert
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetBorders($hWnd)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $ret, $borders_struct, $borders_struct_pointer, $struct_MemMap, $Memory_pointer, $iSize, $aBorders[3]

	$borders_struct = DllStructCreate($tagBORDERS)
	$borders_struct_pointer = DllStructGetPtr($borders_struct)
	If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
		$ret = _SendMessage($hWnd, $SB_GETBORDERS, 0, $borders_struct_pointer, 0, "wparam", "ptr")
	Else
		$iSize = DllStructGetSize($borders_struct)
		$Memory_pointer = _MemInit($hWnd, $iSize, $struct_MemMap)
		$ret = _SendMessage($hWnd, $SB_GETBORDERS, 0, $Memory_pointer, 0, "wparam", "ptr")
		_MemRead($struct_MemMap, $Memory_pointer, $borders_struct_pointer, $iSize)
		_MemFree($struct_MemMap)
	EndIf
	If (Not $ret) Then
		Return SetError(-1, -1, $aBorders)
	Else
		$aBorders[0] = DllStructGetData($borders_struct, "BX")
		$aBorders[1] = DllStructGetData($borders_struct, "BY")
		$aBorders[2] = DllStructGetData($borders_struct, "RX")
		Return $aBorders
	EndIf
EndFunc   ;==>_GUICtrlStatusBar_GetBorders

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetBordersHorz
; Description ...: Retrieves the current width of the horizontal border
; Syntax.........: _GUICtrlStatusBar_GetBordersHorz($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - Width of the horizontal border
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetBorders, _GUICtrlStatusBar_GetBordersRect, _GUICtrlStatusBar_GetBordersVert
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetBordersHorz($hWnd)
	Local $aBorders

	$aBorders = _GUICtrlStatusBar_GetBorders($hWnd)
	Return $aBorders[0]
EndFunc   ;==>_GUICtrlStatusBar_GetBordersHorz

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetBordersRect
; Description ...: Retrieves the current width of the rectangle border
; Syntax.........: _GUICtrlStatusBar_GetBordersRect($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - Width of the rectangle border
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetBorders, _GUICtrlStatusBar_GetBordersHorz, _GUICtrlStatusBar_GetBordersVert
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetBordersRect($hWnd)
	Local $aBorders

	$aBorders = _GUICtrlStatusBar_GetBorders($hWnd)
	Return $aBorders[2]
EndFunc   ;==>_GUICtrlStatusBar_GetBordersRect

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetBordersVert
; Description ...: Retrieves the current width of the vertical border
; Syntax.........: _GUICtrlStatusBar_GetBordersVert($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - Width of the vertical border
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetBorders, _GUICtrlStatusBar_GetBordersHorz, _GUICtrlStatusBar_GetBordersRect
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetBordersVert($hWnd)
	Local $aBorders

	$aBorders = _GUICtrlStatusBar_GetBorders($hWnd)
	Return $aBorders[1]
EndFunc   ;==>_GUICtrlStatusBar_GetBordersVert

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetCount
; Description ...: Retrieves the number of parts
; Syntax.........: _GUICtrlStatusBar_GetCount($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - Number of status bar parts
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetCount($hWnd)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Return _SendMessage($hWnd, $SB_GETPARTS)
EndFunc   ;==>_GUICtrlStatusBar_GetCount

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetHeight
; Description ...: Retrieves the height of a part
; Syntax.........: _GUICtrlStatusBar_GetHeight($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - Height of the parts
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost) Removed dot notation
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetWidth
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetHeight($hWnd)
	Local $tRect

	$tRect = _GUICtrlStatusBar_GetRectEx($hWnd, 0)
	Return DllStructGetData($tRect, "Bottom") - DllStructGetData($tRect, "Top") - (_GUICtrlStatusBar_GetBordersVert($hWnd) * 2)
EndFunc   ;==>_GUICtrlStatusBar_GetHeight

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetIcon
; Description ...: Retrieves the icon for a part
; Syntax.........: _GUICtrlStatusBar_GetIcon($hWnd[, $iIndex = 0])
; Parameters ....: $hWnd        - Handle to the control
;                  $iIndex      - Zero based index of the part that contains the icon to be retrieved.  If this parameter is  -1,
;                  +the status bar is assumed to be a Simple Mode status bar.
; Return values .: Success      - The handle to the icon
;                  Failure      - 0
; Author ........: Steve Podhajecki <gehossafats at netmdc dotcom>
; Modified.......: Gary Frost (GaryFrost)
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetIcon($hWnd, $iIndex = 0)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Return _SendMessage($hWnd, $SB_GETICON, $iIndex, 0, 0, "wparam", "lparam", "hwnd")
EndFunc   ;==>_GUICtrlStatusBar_GetIcon

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetParts
; Description ...: Retrieves the number of parts and the part edges
; Syntax.........: _GUICtrlStatusBar_GetParts($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - Array with the following format:
;                  |$aParts[0] - Number of parts
;                  |$aParts[1] - Right edge of part #1
;                  |$aParts[2] - Right edge of part #2
;                  |$aParts[n] - Right edge of part n
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_SetParts
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetParts($hWnd)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $iI, $iCount, $iParts, $pParts, $tParts, $pMemory, $tMemMap

	$iCount = _GUICtrlStatusBar_GetCount($hWnd)
	$tParts = DllStructCreate("int[" & $iCount & "]")
	$pParts = DllStructGetPtr($tParts)
	Local $aParts[$iCount + 1]
	If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
		$aParts[0] = _SendMessage($hWnd, $SB_GETPARTS, $iCount, $pParts, 0, "wparam", "ptr")
	Else
		$iParts = DllStructGetSize($tParts)
		$pMemory = _MemInit($hWnd, $iParts, $tMemMap)
		$aParts[0] = _SendMessage($hWnd, $SB_GETPARTS, $iCount, $pMemory, 0, "wparam", "ptr")
		_MemRead($tMemMap, $pMemory, $pParts, $iParts)
		_MemFree($tMemMap)
	EndIf
	For $iI = 1 To $iCount
		$aParts[$iI] = DllStructGetData($tParts, 1, $iI)
	Next
	Return $aParts
EndFunc   ;==>_GUICtrlStatusBar_GetParts

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetRect
; Description ...: Retrieves the bounding rectangle of a part
; Syntax.........: _GUICtrlStatusBar_GetRect($hWnd, $iPart)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
; Return values .: Success      - Array with the following format:
;                  |$aRect[0] = X coordinate of the upper left corner of the rectangle
;                  |$aRect[1] = Y coordinate of the upper left corner of the rectangle
;                  |$aRect[2] = X coordinate of the lower right corner of the rectangle
;                  |$aRect[3] = Y coordinate of the lower right corner of the rectangle
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetRectEx
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetRect($hWnd, $iPart)
	Local $tRect, $aRect[4]

	$tRect = _GUICtrlStatusBar_GetRectEx($hWnd, $iPart)
	$aRect[0] = DllStructGetData($tRect, "Left")
	$aRect[1] = DllStructGetData($tRect, "Top")
	$aRect[2] = DllStructGetData($tRect, "Right")
	$aRect[3] = DllStructGetData($tRect, "Bottom")
	Return SetError(@error, 0, $aRect)
EndFunc   ;==>_GUICtrlStatusBar_GetRect

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetRectEx
; Description ...: Retrieves the bounding rectangle of a part
; Syntax.........: _GUICtrlStatusBar_GetRectEx($hWnd, $iPart)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index. If the control is in simple mode this field is ignored and the rectangle
;                  +of the status bar is returned.
; Return values .: Success      - $tagRECT structure that receives the bounding rectangle
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetRect, $tagRECT
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetRectEx($hWnd, $iPart)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $iRect, $pRect, $tRect, $pMemory, $tMemMap, $iResult

	$tRect = DllStructCreate($tagRECT)
	$pRect = DllStructGetPtr($tRect)
	If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
		$iResult = _SendMessage($hWnd, $SB_GETRECT, $iPart, $pRect, 0, "wparam", "ptr")
	Else
		$iRect = DllStructGetSize($tRect)
		$pMemory = _MemInit($hWnd, $iRect, $tMemMap)
		$iResult = _SendMessage($hWnd, $SB_GETRECT, $iPart, $pMemory, 0, "wparam", "ptr")
		_MemRead($tMemMap, $pMemory, $pRect, $iRect)
		_MemFree($tMemMap)
	EndIf
	Return SetError($iResult, 0, $tRect)
EndFunc   ;==>_GUICtrlStatusBar_GetRectEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetText
; Description ...: Retrieves the text from the specified part
; Syntax.........: _GUICtrlStatusBar_GetText($hWnd, $iPart)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
; Return values .: Success      - Part text
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_SetText
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetText($hWnd, $iPart)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $iBuffer, $pBuffer, $tBuffer, $pMemory, $tMemMap
	Local $fUnicode = _GUICtrlStatusBar_GetUnicodeFormat($hWnd)

	$iBuffer = _GUICtrlStatusBar_GetTextLength($hWnd, $iPart)
	If $iBuffer = 0 Then Return ""

	If $fUnicode Then
		$iBuffer *= 2
		$tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
	Else
		$tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
	EndIf
	$pBuffer = DllStructGetPtr($tBuffer)
	If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
		If $fUnicode Then
			_SendMessage($hWnd, $SB_GETTEXTW, $iPart, $pBuffer, 0, "wparam", "ptr")
		Else
			_SendMessage($hWnd, $SB_GETTEXT, $iPart, $pBuffer, 0, "wparam", "ptr")
		EndIf
	Else
		$pMemory = _MemInit($hWnd, $iBuffer, $tMemMap)
		If $fUnicode Then
			_SendMessage($hWnd, $SB_GETTEXTW, $iPart, $pMemory, 0, "wparam", "ptr")
		Else
			_SendMessage($hWnd, $SB_GETTEXT, $iPart, $pMemory, 0, "wparam", "ptr")
		EndIf
		_MemRead($tMemMap, $pMemory, $pBuffer, $iBuffer)
		_MemFree($tMemMap)
	EndIf
	Return DllStructGetData($tBuffer, "Text")
EndFunc   ;==>_GUICtrlStatusBar_GetText

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetTextFlags
; Description ...: Retrieves the text length flags for a part
; Syntax.........: _GUICtrlStatusBar_GetTextFlags($hWnd, $iPart)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
; Return values .: Success      - The low word specifies the length, in characters, of the text. The high word specifies the type
;                  +of operation used to draw the text. The type can be one of the following values:
;                  |0               - The text is drawn with a border to appear lower than the plane of the window
;                  |$SBT_NOBORDERS  - The text is drawn without borders
;                  |$SBT_OWNERDRAW  - The text is drawn by the parent window
;                  |$SBT_POPOUT     - The text is drawn with a border to appear higher than the plane of the window
;                  |$SBT_RTLREADING - The text will be displayed in the opposite direction to the text in the parent window
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetTextLength
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetTextFlags($hWnd, $iPart)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	If _GUICtrlStatusBar_GetUnicodeFormat($hWnd) Then
		Return _SendMessage($hWnd, $SB_GETTEXTLENGTHW, $iPart)
	Else
		Return _SendMessage($hWnd, $SB_GETTEXTLENGTH, $iPart)
	EndIf
EndFunc   ;==>_GUICtrlStatusBar_GetTextFlags

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetTextLength
; Description ...: Retrieves the length of a part text
; Syntax.........: _GUICtrlStatusBar_GetTextLength($hWnd, $iPart)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
; Return values .: Success      - Length of part text
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetTextLengthEx
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetTextLength($hWnd, $iPart)
	Return _WinAPI_LoWord(_GUICtrlStatusBar_GetTextFlags($hWnd, $iPart))
EndFunc   ;==>_GUICtrlStatusBar_GetTextLength

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetTextLengthEx
; Description ...: Retrieves the uFlag of a part
; Syntax.........: _GUICtrlStatusBar_GetTextLengthEx($hwnd, $iPart)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
; Return values .: Success      - Type of drawing operation. The type can be one of the following values:
;                  |0               - The text is drawn with a border to appear lower than the plane of the window
;                  |$SBT_NOBORDERS  - The text is drawn without borders
;                  |$SBT_OWNERDRAW  - The text is drawn by the parent window
;                  |$SBT_POPOUT     - The text is drawn with a border to appear higher than the plane of the window
;                  |$SBT_RTLREADING - The text will be displayed in the opposite direction to the text in the parent window
; Author ........: Gary Frost (gafrost
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetTextFlags, _GUICtrlStatusBar_GetTextLength
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetTextLengthEx($hWnd, $iPart)
	Return _WinAPI_HiWord(_GUICtrlStatusBar_GetTextFlags($hWnd, $iPart))
EndFunc   ;==>_GUICtrlStatusBar_GetTextLengthEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetTipText
; Description ...: Retrieves the ToolTip text for a part
; Syntax.........: _GUICtrlStatusBar_GetTipText($hWnd, $iPart)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
; Return values .: Success      - Part text
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (GaryFrost)
; Remarks .......: The status bar must be created with the $SBARS_TOOLTIPS style to enable ToolTips
; Related .......: _GUICtrlStatusBar_SetTipText
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetTipText($hWnd, $iPart)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $pBuffer, $tBuffer, $pMemory, $tMemMap
	Local $fUnicode = _GUICtrlStatusBar_GetUnicodeFormat($hWnd)

	If $fUnicode Then
		$tBuffer = DllStructCreate("wchar Text[4096]")
	Else
		$tBuffer = DllStructCreate("char Text[4096]")
	EndIf
	$pBuffer = DllStructGetPtr($tBuffer)
	If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
		If $fUnicode Then
			_SendMessage($hWnd, $SB_GETTIPTEXTW, _WinAPI_MakeLong($iPart, 4096), $pBuffer, 0, "wparam", "ptr")
		Else
			_SendMessage($hWnd, $SB_GETTIPTEXT, _WinAPI_MakeLong($iPart, 4096), $pBuffer, 0, "wparam", "ptr")
		EndIf
	Else
		$pMemory = _MemInit($hWnd, 4096, $tMemMap)
		If $fUnicode Then
			_SendMessage($hWnd, $SB_GETTIPTEXTW, _WinAPI_MakeLong($iPart, 4096), $pMemory, 0, "wparam", "ptr")
		Else
			_SendMessage($hWnd, $SB_GETTIPTEXT, _WinAPI_MakeLong($iPart, 4096), $pMemory, 0, "wparam", "ptr")
		EndIf
		_MemRead($tMemMap, $pMemory, $pBuffer, 4096)
		_MemFree($tMemMap)
	EndIf
	Return DllStructGetData($tBuffer, "Text")
EndFunc   ;==>_GUICtrlStatusBar_GetTipText

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetUnicodeFormat
; Description ...: Retrieves the Unicode character format flag
; Syntax.........: _GUICtrlStatusBar_GetUnicodeFormat($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: True         - Control is using Unicode characters
;                  False        - Control is using ANSI characters
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_SetUnicodeFormat
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetUnicodeFormat($hWnd)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Return _SendMessage($hWnd, $SB_GETUNICODEFORMAT) <> 0
EndFunc   ;==>_GUICtrlStatusBar_GetUnicodeFormat

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_GetWidth
; Description ...: Retrieves the width of a part
; Syntax.........: _GUICtrlStatusBar_GetWidth($hWnd, $iPart)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
; Return values .: Success      - Height of the parts
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost) Removed dot notation
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetHeight
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_GetWidth($hWnd, $iPart)
	Local $tRect

	$tRect = _GUICtrlStatusBar_GetRectEx($hWnd, $iPart)
	Return DllStructGetData($tRect, "Right") - DllStructGetData($tRect, "Left") - (_GUICtrlStatusBar_GetBordersHorz($hWnd) * 2)
EndFunc   ;==>_GUICtrlStatusBar_GetWidth

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_IsSimple
; Description ...: Checks a status bar control to determine if it is in simple mode
; Syntax.........: _GUICtrlStatusBar_IsSimple($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: True         - Status bar is in simple mode
;                  False        - Status bar is not in simple mode
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_SetSimple
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_IsSimple($hWnd)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Return _SendMessage($hWnd, $SB_ISSIMPLE) <> 0
EndFunc   ;==>_GUICtrlStatusBar_IsSimple

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_Resize
; Description ...: Causes the status bar to resize itself
; Syntax.........: _GUICtrlStatusBar_Resize($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_Resize($hWnd)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	_SendMessage($hWnd, $__STATUSBARCONSTANT_WM_SIZE)
EndFunc   ;==>_GUICtrlStatusBar_Resize

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_SetBkColor
; Description ...: Sets the background color
; Syntax.........: _GUICtrlStatusBar_SetBkColor($hWnd, $iColor)
; Parameters ....: $hWnd        - Handle to the control
;                  $iColor      - New background color.  Specify the CLR_DEFAULT value to cause the status bar to use its default
;                  +background color.
; Return values .: Success      - The previous background color, or CLR_DEFAULT if the background color is the default color
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: Returns RGB COLORREF color, color passed in must be BGR Hex color or RGB COLORREF
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_SetBkColor($hWnd, $iColor)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	$iColor = _SendMessage($hWnd, $SB_SETBKCOLOR, 0, $iColor)
	If $iColor = $__STATUSBARCONSTANT_CLR_DEFAULT Then Return '0x' & Hex($__STATUSBARCONSTANT_CLR_DEFAULT)
	Return $iColor
EndFunc   ;==>_GUICtrlStatusBar_SetBkColor

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_SetIcon
; Description ...: Sets the icon for a part
; Syntax.........: _GUICtrlStatusBar_SetIcon($hWnd, $iPart[, $hIcon = -1[, $sIconFile = ""]])
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index. If the control is in simple mode, this field is ignored.
;                  $hIcon       - Handle to the icon. If this value is -1, the icon is removed.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetIcon
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_SetIcon($hWnd, $iPart, $hIcon = -1, $sIconFile = "")
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $tIcon, $result
	If $hIcon = -1 Then ; Remove Icon
		Return _SendMessage($hWnd, $SB_SETICON, $iPart, $hIcon, 0, "wparam", "hwnd") <> 0
	ElseIf StringLen($sIconFile) > 0 Then ; set icon from file
		$tIcon = DllStructCreate("int")
		$result = DllCall("shell32.dll", "int", "ExtractIconEx", "str", $sIconFile, "int", $hIcon, "hwnd", 0, "ptr", DllStructGetPtr($tIcon), "int", 1)
		$result = $result[0]
		If $result > 0 Then $result = _SendMessage($hWnd, $SB_SETICON, $iPart, DllStructGetData($tIcon, 1), 0, "wparam", "ptr")
		DllCall("user32.dll", "int", "DestroyIcon", "hwnd", DllStructGetData($tIcon, 1))
		Return $result <> 0
	Else ; set icon from icon handle
		Return _SendMessage($hWnd, $SB_SETICON, $iPart, $hIcon) <> 0
	EndIf
EndFunc   ;==>_GUICtrlStatusBar_SetIcon

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_SetMinHeight
; Description ...: Sets the minimum height of a status window's drawing area
; Syntax.........: _GUICtrlStatusBar_SetMinHeight($hWnd, $iMinHeight)
; Parameters ....: $hWnd        - Handle to the control
;                  $iMinHeight  - Minimum height, in pixels, of the window
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetHeight
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_SetMinHeight($hWnd, $iMinHeight)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	_SendMessage($hWnd, $SB_SETMINHEIGHT, $iMinHeight)
	_GUICtrlStatusBar_Resize($hWnd)
EndFunc   ;==>_GUICtrlStatusBar_SetMinHeight

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_SetParts
; Description ...: Sets the number of parts and the part edges
; Syntax.........: _GUICtrlStatusBar_SetParts($hWnd[, $iaParts = -1[, $iaPartWidth = 25]])
; Parameters ....: $hWnd        - Handle to the control
;                  $iaParts     - Number of parts, can be an zero based array of ints in the following format:
;                  |$iaParts[0] - Right edge of part #1
;                  |$iaParts[1] - Right edge of part #2
;                  |$iaParts[n] - Right edge of parn n
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......: If an element is -1, the right edge of the corresponding part extends to the border of the window.
; Related .......: _GUICtrlStatusBar_GetParts
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_SetParts($hWnd, $iaParts = -1, $iaPartWidth = 25)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $struct_parts, $iParts = 1
	Local $struct_parts_pointer, $struct_MemMap, $iSize, $Memory_pointer

	;== start sizing parts
	If IsArray($iaParts) <> 0 Then ; adding array of parts (contains widths)
		$iaParts[UBound($iaParts) - 1] = -1
		$iParts = UBound($iaParts)
		$struct_parts = DllStructCreate("int[" & $iParts & "]")
		For $x = 0 To $iParts - 2
			DllStructSetData($struct_parts, 1, $iaParts[$x], $x + 1)
		Next
		DllStructSetData($struct_parts, 1, -1, $iParts)
	ElseIf IsArray($iaPartWidth) <> 0 Then ; adding array of part widths (make parts an array)
		$iParts = UBound($iaPartWidth)
		$struct_parts = DllStructCreate("int[" & $iParts & "]")
		For $x = 0 To $iParts - 2
			DllStructSetData($struct_parts, 1, $iaPartWidth[$x], $x + 1)
		Next
		DllStructSetData($struct_parts, 1, -1, $iParts)
	ElseIf $iaParts > 1 Then ; adding parts with default width
		$iParts = $iaParts
		$struct_parts = DllStructCreate("int[" & $iParts & "]")
		For $x = 1 To $iParts - 1
			DllStructSetData($struct_parts, 1, $iaPartWidth * $x, $x)
		Next
		DllStructSetData($struct_parts, 1, -1, $iParts)
	Else ; defaulting to 1 part
		$struct_parts = DllStructCreate("int")
		DllStructSetData($struct_parts, $iParts, -1)
	EndIf
	;== end set sizing
	$struct_parts_pointer = DllStructGetPtr($struct_parts)
	If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
		_SendMessage($hWnd, $SB_SETPARTS, $iParts, $struct_parts_pointer, 0, "wparam", "ptr")
	Else
		$iSize = DllStructGetSize($struct_parts)
		$Memory_pointer = _MemInit($hWnd, $iSize, $struct_MemMap)
		_MemWrite($struct_MemMap, $struct_parts_pointer)
		_SendMessage($hWnd, $SB_SETPARTS, $iParts, $Memory_pointer, 0, "wparam", "ptr")
		_MemFree($struct_MemMap)
	EndIf
	_GUICtrlStatusBar_Resize($hWnd)
	Return 1
EndFunc   ;==>_GUICtrlStatusBar_SetParts

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_SetSimple
; Description ...: Specifies whether a status window displays simple text or displays all window parts
; Syntax.........: _GUICtrlStatusBar_SetSimple($hWnd, $fSimple = True)
; Parameters ....: $hWnd        - Handle to the control
;                  $fSimple     - Sets the display of the windows
;                  | True       - The window displays simple text
;                  |False       - The window displays multiple parts
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_IsSimple
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_SetSimple($hWnd, $fSimple = True)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	_SendMessage($hWnd, $SB_SIMPLE, $fSimple)
EndFunc   ;==>_GUICtrlStatusBar_SetSimple

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_SetText
; Description ...: Sets the text in the specified part of a status window
; Syntax.........: _GUICtrlStatusBar_SetText($hWnd, $sText = "", $iPart = 0, $iUFlag = 0)
; Parameters ....: $hWnd        - Handle to the control
;                  $sText       - The text to display in the part
;                  $iPart       - The part to hold the text
;                  $iUFlag      - Type of drawing operation. The type can be one of the following values:
;                  |0               - The text is drawn with a border to appear lower than the plane of the window
;                  |$SBT_NOBORDERS  - The text is drawn without borders
;                  |$SBT_OWNERDRAW  - The text is drawn by the parent window
;                  |$SBT_POPOUT     - The text is drawn with a border to appear higher than the plane of the window
;                  |$SBT_RTLREADING - The text will be displayed in the opposite direction to the text in the parent window
; Return values .: Success      - True
;                  Failure      - False
; Author ........: rysiora, JdeB, tonedef, Gary Frost (gafrost)
; Modified.......: Gary Frost (gafrost) re-written also added $iUFlag
; Remarks .......: Set $iPart to $SB_SIMPLEID for simple statusbar
; Related .......: _GUICtrlStatusBar_GetText
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_SetText($hWnd, $sText = "", $iPart = 0, $iUFlag = 0)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $ret, $struct_String, $sBuffer_pointer, $struct_MemMap, $Memory_pointer, $iBuffer
	Local $fUnicode = _GUICtrlStatusBar_GetUnicodeFormat($hWnd)

	$iBuffer = StringLen($sText) + 1
	If $fUnicode Then
		$iBuffer *= 2
		$struct_String = DllStructCreate("wchar Text[" & $iBuffer & "]")
	Else
		$struct_String = DllStructCreate("char Text[" & $iBuffer & "]")
	EndIf
	$sBuffer_pointer = DllStructGetPtr($struct_String)
	DllStructSetData($struct_String, "Text", $sText)
	If _GUICtrlStatusBar_IsSimple($hWnd) Then $iPart = $SB_SIMPLEID
	If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
		If $fUnicode Then
			$ret = _SendMessage($hWnd, $SB_SETTEXTW, BitOR($iPart, $iUFlag), $sBuffer_pointer, 0, "wparam", "ptr")
		Else
			$ret = _SendMessage($hWnd, $SB_SETTEXT, BitOR($iPart, $iUFlag), $sBuffer_pointer, 0, "wparam", "ptr")
		EndIf
	Else
		$Memory_pointer = _MemInit($hWnd, $iBuffer, $struct_MemMap)
		_MemWrite($struct_MemMap, $sBuffer_pointer)
		If $fUnicode Then
			$ret = _SendMessage($hWnd, $SB_SETTEXTW, BitOR($iPart, $iUFlag), $Memory_pointer, 0, "wparam", "ptr")
		Else
			$ret = _SendMessage($hWnd, $SB_SETTEXT, BitOR($iPart, $iUFlag), $Memory_pointer, 0, "wparam", "ptr")
		EndIf
		_MemFree($struct_MemMap)
	EndIf
	Return $ret <> 0
EndFunc   ;==>_GUICtrlStatusBar_SetText

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_SetTipText
; Description ...: Sets the ToolTip text for a part
; Syntax.........: _GUICtrlStatusBar_SetTipText($hWnd, $iPart, $sText)
; Parameters ....: $hWnd        - Handle to the control
;                  $iPart       - Zero based part index
;                  $sText    -
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......: The status bar must have been created with the $SBARS_TOOLTIPS style to enable ToolTips
; Related .......: _GUICtrlStatusBar_GetTipText
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_SetTipText($hWnd, $iPart, $sText)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Local $struct_String, $sBuffer_pointer, $struct_MemMap, $Memory_pointer, $iBuffer
	Local $fUnicode = _GUICtrlStatusBar_GetUnicodeFormat($hWnd)

	$iBuffer = StringLen($sText) + 1
	If $fUnicode Then
		$iBuffer *= 2
		$struct_String = DllStructCreate("wchar TipText[" & $iBuffer & "]")
	Else
		$struct_String = DllStructCreate("char TipText[" & $iBuffer & "]")
	EndIf
	$sBuffer_pointer = DllStructGetPtr($struct_String)
	DllStructSetData($struct_String, "TipText", $sText)
	If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
		If $fUnicode Then
			_SendMessage($hWnd, $SB_SETTIPTEXTW, $iPart, $sBuffer_pointer, 0, "wparam", "ptr")
		Else
			_SendMessage($hWnd, $SB_SETTIPTEXT, $iPart, $sBuffer_pointer, 0, "wparam", "ptr")
		EndIf
	Else
		$Memory_pointer = _MemInit($hWnd, $iBuffer, $struct_MemMap)
		_MemWrite($struct_MemMap, $sBuffer_pointer, $Memory_pointer, $iBuffer)
		If $fUnicode Then
			_SendMessage($hWnd, $SB_SETTIPTEXTW, $iPart, $Memory_pointer, 0, "wparam", "ptr")
		Else
			_SendMessage($hWnd, $SB_SETTIPTEXT, $iPart, $Memory_pointer, 0, "wparam", "ptr")
		EndIf
		_MemFree($struct_MemMap)
	EndIf
EndFunc   ;==>_GUICtrlStatusBar_SetTipText

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_SetUnicodeFormat
; Description ...: Sets the Unicode character format flag
; Syntax.........: _GUICtrlStatusBar_SetUnicodeFormat($hWnd[, $fUnicode = True])
; Parameters ....: $hWnd        - Handle to the control
;                  $fUnicode    - Unicode character format flag:
;                  | True - Control uses Unicode characters
;                  |False - Control uses ANSI characters
; Return values .: Success      - Previous character format flag setting
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlStatusBar_GetUnicodeFormat
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_SetUnicodeFormat($hWnd, $fUnicode = True)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	Return _SendMessage($hWnd, $SB_SETUNICODEFORMAT, $fUnicode)
EndFunc   ;==>_GUICtrlStatusBar_SetUnicodeFormat

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlStatusBar_ShowHide
; Description ...: Show/Hide the StatusBar control
; Syntax.........: _GUICtrlStatusBar_ShowHide($hWnd, $iState)
; Parameters ....: $hWnd        - Handle to the control
;                  $iState      - State of the StatusBar, can be the following values:
;                 |@SW_SHOW
;                 |@SW_HIDE
; Return values .: True         - The control was previously visible
;                  False        - The control was previously hidden
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlStatusBar_ShowHide($hWnd, $iState)
	If $Debug_SB Then _GUICtrlStatusBar_ValidateClassName($hWnd)
	If $iState <> @SW_HIDE And $iState <> @SW_SHOW Then Return SetError(1, 1, 0)
	Local $v_ret = DllCall("user32.dll", "int", "ShowWindow", "hwnd", HWnd($hWnd), "int", $iState)
	If Not @error And IsArray($v_ret) Then Return $v_ret[0]
	Return SetError(2, 2, 0)
EndFunc   ;==>_GUICtrlStatusBar_ShowHide

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _GUICtrlStatusBar_ValidateClassName
; Description ...: Used for debugging when creating examples
; Syntax.........: _GUICtrlStatusBar_ValidateClassName($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: None
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......: For Internal Use Only
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _GUICtrlStatusBar_ValidateClassName($hWnd)
	_GUICtrlStatusBar_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
	_WinAPI_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
EndFunc   ;==>_GUICtrlStatusBar_ValidateClassName
