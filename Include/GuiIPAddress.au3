#include-once
#include <WinAPI.au3>
#include <Memory.au3>
#include <IPAddressConstants.au3>
#include <StructureConstants.au3>
#include <SendMessage.au3>
#include <UDFGlobalID.au3>

; #INDEX# =======================================================================================================================
; Title .........: IP Address
;
; AutoIt Version: 3.2.3++
; Language:       English
; Description:    Functions that assist with SysIPAddress32.
;
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $_ip_ghIPLastWnd
Global $Debug_IP = False
Global Const $__IPADDRESSCONSTANT_ClassName = "SysIPAddress32"
Global Const $__IPADDRESSCONSTANT_WS_VISIBLE = 0x10000000
Global Const $__IPADDRESSCONSTANT_WS_CHILD = 0x40000000
Global Const $__IPADDRESSCONSTANT_WS_TABSTOP = 0x00010000
Global Const $__IPADDRESSCONSTANT_DEFAULT_GUI_FONT = 17
Global Const $__IPADDRESSCONSTANT_LOGPIXELSX = 88
Global Const $__IPADDRESSCONSTANT_PROOF_QUALITY = 2

; ------------------------------------------------------------------------------
; function list
;===============================================================================
;===============================================================================
; depricated functions will no longer work
; #OLD_FUNCTIONS#================================================================================================================
; Old Function/Name                      ; --> New Function/Name/Replacement(s)
; ===============================================================================================================================
;_GUICtrlIpAddressCreate                  ; --> _GUICtrlIpAddress_Create
;_GUICtrlIpAddressClear                   ; --> _GUICtrlIpAddress_ClearAddress
;_GUICtrlIpAddressDelete                  ; --> _GUICtrlIpAddress_Destroy
;_GUICtrlIpAddressGet                     ; --> _GUICtrlIpAddress_Get
;_GUICtrlIpAddressIsBlank                 ; --> _GUICtrlIpAddress_IsBlank
;_GUICtrlIpAddressSet                     ; --> _GUICtrlIpAddress_Set
;_GUICtrlIpAddressSetFocus                ; --> _GUICtrlIpAddress_SetFocus
;_GUICtrlIpAddressSetFont                 ; --> _GUICtrlIpAddress_SetFont
;_GUICtrlIpAddressSetRange                ; --> _GUICtrlIpAddress_SetRange
;_GUICtrlIpAddressShowHide                ; --> _GUICtrlIpAddress_ShowHide
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_GUICtrlIpAddress_Create
;_GUICtrlIpAddress_ClearAddress
;_GUICtrlIpAddress_Destroy
;_GUICtrlIpAddress_Get
;_GUICtrlIpAddress_GetArray
;_GUICtrlIpAddress_GetEx
;_GUICtrlIpAddress_IsBlank
;_GUICtrlIpAddress_Set
;_GUICtrlIpAddress_SetArray
;_GUICtrlIpAddress_SetEx
;_GUICtrlIpAddress_SetFocus
;_GUICtrlIpAddress_SetFont
;_GUICtrlIpAddress_SetRange
;_GUICtrlIpAddress_ShowHide
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
; For internal use only
; ===============================================================================================================================
;==============================================================================================================================


; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_Create
; Description ...: Create a GUI IP Address Control
; Syntax.........: _GUICtrlIpAddress_Create($hWnd, $iX, $iY[, $iWidth = 125[, $iHeigth = 25[, $iStyles = 0x00000000[, $iExstyles = 0x00000000]]]])
; Parameters ....: $hWnd        - Handle to parent or owner window
;                  $iX          - Horizontal position of the control
;                  $iY          - Vertical position of the control
;                  $iWidth      - Control width
;                  $iHeight     - Control height
;                  $iStyle      - Control styles:
;                  |Forced : $WS_CHILD, $WS_VISIBLE, $WS_TABSTOP
;                  $iExStyle    - Extended control styles
; Return values .: Success      - Handle to the IP Address control
;                  Failure      - 0
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_Destroy
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_Create($hWnd, $iX, $iY, $iWidth = 125, $iHeigth = 25, $iStyles = 0x00000000, $iExstyles = 0x00000000)
	If Not IsHWnd($hWnd) Then _WinAPI_ShowError("Invalid Window handle for _GUICtrlIpAddress_Create 1st parameter")

	Local $hIPAddress, $iStyle, $nCtrlID

	If $iStyles = -1 Then $iStyles = 0x00000000
	If $iExstyles = -1 Then $iExstyles = 0x00000000

	$iStyle = BitOR($__IPADDRESSCONSTANT_WS_CHILD, $__IPADDRESSCONSTANT_WS_VISIBLE, $__IPADDRESSCONSTANT_WS_TABSTOP, $iStyles)

	Local Const $ICC_INTERNET_CLASSES = 0x800
	Local $stICCE = DllStructCreate('dword;dword')
	DllStructSetData($stICCE, 1, DllStructGetSize($stICCE))
	DllStructSetData($stICCE, 2, $ICC_INTERNET_CLASSES)
	DllCall('comctl32.dll', 'int', 'InitCommonControlsEx', 'ptr', DllStructGetPtr($stICCE))

	$nCtrlID = _UDF_GetNextGlobalID($hWnd)
	If @error Then Return SetError(@error, @extended, 0)

	$hIPAddress = _WinAPI_CreateWindowEx($iExstyles, $__IPADDRESSCONSTANT_ClassName, "", $iStyle, $iX, $iY, $iWidth, $iHeigth, $hWnd, $nCtrlID)
	_WinAPI_SetFont($hIPAddress, _WinAPI_GetStockObject($__IPADDRESSCONSTANT_DEFAULT_GUI_FONT))

	Return $hIPAddress
EndFunc   ;==>_GUICtrlIpAddress_Create

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_ClearAddress
; Description ...: Clears the contents of the IP address control
; Syntax.........: _GUICtrlIpAddress_ClearAddress($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_IsBlank, _GUICtrlIpAddress_Set
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_ClearAddress($hWnd)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	_SendMessage($hWnd, $IPM_CLEARADDRESS)
EndFunc   ;==>_GUICtrlIpAddress_ClearAddress

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _GUICtrlIpAddress_DebugPrint
; Description ...: Used for debugging when creating examples
; Syntax.........: _GUICtrlIpAddress_DebugPrint($hWnd[, $iLine = @ScriptLineNumber])
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
Func _GUICtrlIpAddress_DebugPrint($sText, $iLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @LF & _
			"+======================================================" & @LF & _
			"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @LF & _
			"+======================================================" & @LF)
EndFunc   ;==>_GUICtrlIpAddress_DebugPrint

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_Destroy
; Description ...: Delete the control
; Syntax.........: _GUICtrlIpAddress_Destroy(ByRef $hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - True, Handle is set to 0
;                  Failure      - False
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......: Restricted to only be used on IP Address Controlr created with _GUICtrlIpAddress_Create
; Related .......: _GUICtrlIpAddress_Create
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_Destroy($hWnd)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	Local $Destroyed, $iResult

	If _WinAPI_IsClassName($hWnd, $__IPADDRESSCONSTANT_ClassName) Then
		If _WinAPI_InProcess($hWnd, $_ip_ghIPLastWnd) Then
			Local $nCtrlID = _WinAPI_GetDlgCtrlID($hWnd)
			Local $hParent = _WinAPI_GetParent($hWnd)
			$Destroyed = _WinAPI_DestroyWindow($hWnd)
			$iResult = _UDF_FreeGlobalID($hParent, $nCtrlID)
			If Not $iResult Then
				; can check for errors here if needed, for debug
			EndIf
		Else
			_WinAPI_ShowMsg("Not Allowed to Delete Other Applications IPAddress Control(s)")
			Return SetError(1, 1, False)
		EndIf
		If $Destroyed Then $hWnd = 0
		Return $Destroyed <> 0
	EndIf
	Return SetError(2, 2, False)
EndFunc   ;==>_GUICtrlIpAddress_Destroy

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_Get
; Description ...: Retrieves the address from the IP address control
; Syntax.........: _GUICtrlIpAddress_Get($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - IP address string
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_Set
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_Get($hWnd)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	Local $tIP
	$tIP = _GUICtrlIpAddress_GetEx($hWnd)

	If @error Then Return SetError(2, 2, "")
	Return StringFormat("%d.%d.%d.%d", DllStructGetData($tIP, "Field1"), _
			DllStructGetData($tIP, "Field2"), _
			DllStructGetData($tIP, "Field3"), _
			DllStructGetData($tIP, "Field4"))
EndFunc   ;==>_GUICtrlIpAddress_Get

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_GetArray
; Description ...: Retrieves the address from the IP address control
; Syntax.........: _GUICtrlIpAddress_GetArray($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - Array formatted as follows:
;                  |[0] - 1st address field
;                  |[1] - 2nd address field
;                  |[2] - 3rd address field
;                  |[3] - 4th address field
; Author ........: Gary Frost
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_SetArray
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_GetArray($hWnd)
	Local $tIP, $aIP[4]

	$tIP = _GUICtrlIpAddress_GetEx($hWnd)
	$aIP[0] = DllStructGetData($tIP, "Field1")
	$aIP[1] = DllStructGetData($tIP, "Field2")
	$aIP[2] = DllStructGetData($tIP, "Field3")
	$aIP[3] = DllStructGetData($tIP, "Field4")
	Return $aIP
EndFunc   ;==>_GUICtrlIpAddress_GetArray

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_GetEx
; Description ...: Retrieves the address from the IP address control
; Syntax.........: _GUICtrlIpAddress_GetEx($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: Success      - $tagGetIPAddress structure that recieves the ip address
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_Get, _GUICtrlIpAddress_GetArray
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_GetEx($hWnd)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	Local $tIP, $iIP, $pIP, $Memory_pointer, $struct_MemMap

	$tIP = DllStructCreate($tagGETIPAddress)
	$pIP = DllStructGetPtr($tIP)
	If @error Then Return SetError(1, 1, "")
	If _WinAPI_InProcess($hWnd, $_ip_ghIPLastWnd) Then
		_SendMessage($hWnd, $IPM_GETADDRESS, 0, $pIP, 0, "wparam", "ptr")
	Else
		$iIP = DllStructGetSize($tIP)
		$Memory_pointer = _MemInit($hWnd, $iIP, $struct_MemMap)
		_SendMessage($hWnd, $IPM_GETADDRESS, 0, $Memory_pointer, 0, "wparam", "ptr")
		_MemRead($struct_MemMap, $Memory_pointer, $pIP, $iIP)
		_MemFree($struct_MemMap)
	EndIf
	Return $tIP
EndFunc   ;==>_GUICtrlIpAddress_GetEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_IsBlank
; Description ...: Determines if all fields in the IP address control are blank
; Syntax.........: _GUICtrlIpAddress_IsBlank($hWnd)
; Parameters ....: $hWnd        - Handle to the control
; Return values .: True         - IP address is blank
;                  False        - IP address is not blank
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_ClearAddress
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_IsBlank($hWnd)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	Return _SendMessage($hWnd, $IPM_ISBLANK) <> 0
EndFunc   ;==>_GUICtrlIpAddress_IsBlank

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_Set
; Description ...: Sets the address in the IP address control
; Syntax.........: _GUICtrlIpAddress_Set($hWnd, $sAddress)
; Parameters ....: $hWnd        - Handle to the control
;                  $sAddress    - IP Address string
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_Get
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_Set($hWnd, $sAddress)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	Local $aAddress = StringSplit($sAddress, ".")
	If $aAddress[0] = 4 Then
		Local $tIP = DllStructCreate($tagGETIPAddress)
		For $x = 1 To 4
			DllStructSetData($tIP, "Field" & $x, $aAddress[$x])
		Next
		_GUICtrlIpAddress_SetEx($hWnd, $tIP)
	EndIf
EndFunc   ;==>_GUICtrlIpAddress_Set

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_SetArray
; Description ...: Sets the address in the IP address control
; Syntax.........: _GUICtrlIpAddress_SetArray($hWnd, $aAddress)
; Parameters ....: $hWnd        - Handle to the control
;                  $aAddress    - Array formatted as follows:
;                  |[0] - 1st address field
;                  |[1] - 2nd address field
;                  |[2] - 3rd address field
;                  |[3] - 4th address field
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_GetArray
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_SetArray($hWnd, $aAddress)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	If UBound($aAddress) = 4 Then
		Local $tIP = DllStructCreate($tagGETIPAddress)
		For $x = 0 To 3
			DllStructSetData($tIP, "Field" & $x + 1, $aAddress[$x])
		Next
		_GUICtrlIpAddress_SetEx($hWnd, $tIP)
	EndIf
EndFunc   ;==>_GUICtrlIpAddress_SetArray

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_SetEx
; Description ...: Sets the address in the IP address control
; Syntax.........: _GUICtrlIpAddress_SetEx($hWnd, $tIP)
; Parameters ....: $hWnd        - Handle to the control
;                  $tIP         - $tagGetIPAddress structure containing new ip address for the control
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......: _GUICtrlIpAddress_GetEx, $tagGetIPAddress
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_SetEx($hWnd, $tIP)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	_SendMessage($hWnd, $IPM_SETADDRESS, 0, _
			_WinAPI_MakeDWord(BitOR(DllStructGetData($tIP, "Field4"), 0x100 * DllStructGetData($tIP, "Field3")), _
			BitOR(DllStructGetData($tIP, "Field2"), 0x100 * DllStructGetData($tIP, "Field1"))))
EndFunc   ;==>_GUICtrlIpAddress_SetEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_SetFocus
; Description ...: Sets the keyboard focus to the specified field in the IP address control
; Syntax.........: _GUICtrlIpAddress_SetFocus($hWnd, $iIndex)
; Parameters ....: $hWnd        - Handle to the control
;                  $iIndex      - Zero-based field index to which the focus should be set.
;                  +If this value is greater than the number of fields,
;                  +focus is set to the first blank field. If all fields are nonblank,
;                  +focus is set to the first field.
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_SetFocus($hWnd, $iIndex)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	_SendMessage($hWnd, $IPM_SETFOCUS, $iIndex)
EndFunc   ;==>_GUICtrlIpAddress_SetFocus

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_SetFont
; Description ...: Set font of the control
; Syntax.........: _GUICtrlIpAddress_SetFont($hWnd[, $sFaceName = "Arial"[, $iFontSize = 12[, $iFontWeight = 400[, $fFontItalic = False]]]])
; Parameters ....: $hWnd        - Handle to the control
;                  $sFaceName   - The Font Name of the font to use
;                  $iFontSize   - The Font Size
;                  $iFontWeight - The Font Weight
;                  $fFontItalic - Use Italic Attribute
; Return values .:
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_SetFont($hWnd, $sFaceName = "Arial", $iFontSize = 12, $iFontWeight = 400, $fFontItalic = False)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	Local $font, $tfont, $lfHeight, $lngDC

	$lngDC = _WinAPI_GetDC(0)
	$lfHeight = Round(($iFontSize * _WinAPI_GetDeviceCaps($lngDC, $__IPADDRESSCONSTANT_LOGPIXELSX)) / 72, 0)
	_WinAPI_ReleaseDC(0, $lngDC)

	$tfont = DllStructCreate($tagLOGFONT)
	DllStructSetData($tfont, "Height", $lfHeight)
	DllStructSetData($tfont, "Weight", $iFontWeight)
	DllStructSetData($tfont, "Italic", $fFontItalic)
	DllStructSetData($tfont, "Underline", False) ; font underline
	DllStructSetData($tfont, "Strikeout", False) ; font strikethru
	DllStructSetData($tfont, "Quality", $__IPADDRESSCONSTANT_PROOF_QUALITY)
	DllStructSetData($tfont, "FaceName", $sFaceName)

	$font = _WinAPI_CreateFontIndirect($tfont)
	_WinAPI_SetFont($hWnd, $font)

EndFunc   ;==>_GUICtrlIpAddress_SetFont

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_SetRange
; Description ...: Sets the valid range for the specified field in the IP address control
; Syntax.........: _GUICtrlIpAddress_SetRange($hWnd, $iIndex[, $iLowRange = 0[, $iHighRange = 255]])
; Parameters ....: $hWnd        - Handle to the control
;                  $iIndex      - Zero-based field index to which the range will be applied
;                  $iLowRange   - Lower limit of the range
;                  $iHighRange  - Upper limit of the range
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _GUICtrlIpAddress_SetRange($hWnd, $iIndex, $iLowRange = 0, $iHighRange = 255)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	If ($iLowRange < 0 Or $iLowRange > $iHighRange) Or $iHighRange > 255 Or ($iIndex < 0 Or $iIndex > 3) Then Return SetError(-1, -1, False)
	Return _SendMessage($hWnd, $IPM_SETRANGE, $iIndex, BitOR($iLowRange, 0x100 * $iHighRange)) <> 0
EndFunc   ;==>_GUICtrlIpAddress_SetRange

; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlIpAddress_ShowHide
; Description ...: Shows/Hides the IP address control
; Syntax.........: _GUICtrlIpAddress_ShowHide($hWnd, $iState)
; Parameters ....: $hWnd        - Handle to the control
;                  $iState      - State of the IP Address control, can be the following values:
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
Func _GUICtrlIpAddress_ShowHide($hWnd, $iState)
	If $Debug_IP Then _GUICtrlIpAddress_ValidateClassName($hWnd)
	If $iState <> @SW_HIDE And $iState <> @SW_SHOW Then Return SetError(1, 1, 0)
	Return _WinAPI_ShowWindow($hWnd, $iState) <> 0
EndFunc   ;==>_GUICtrlIpAddress_ShowHide

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _GUICtrlIpAddress_ValidateClassName
; Description ...: Used for debugging when creating examples
; Syntax.........: _GUICtrlIpAddress_ValidateClassName($hWnd[, $iLine = @ScriptLineNumber])
; Parameters ....: $hWnd        - Handle to the control
; Return values .: None
; Author ........: Gary Frost (gafrost)
; Modified.......:
; Remarks .......: For Internal Use Only
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _GUICtrlIpAddress_ValidateClassName($hWnd)
	_GUICtrlIpAddress_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
	_WinAPI_ValidateClassName($hWnd, $__IPADDRESSCONSTANT_ClassName)
EndFunc   ;==>_GUICtrlIpAddress_ValidateClassName
