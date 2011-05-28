; ===================================================================
; Project: OutputLib Library
; Description: Provides an interface for creating a two-pane window useful for displaying build and
;	progress output.
; Author: Jason Boggs <vampire DOT valik AT gmail DOT com>
; ===================================================================
#include-once

#Region Members Exported
#cs
_OutputWindowCreate() - Creates the output window and both output panes.
_OutputWaitClosed() - When called in the same process as the window exists, waits for the window to be closed,	otherwise returns immediately.
_OutputProgressWrite($sData) - Writes data to the progress pane.
_OutputBuildWrite($sData) - Writes data to the build pane.
_OutputWindowSetState($nState) - Changes the state of the output window.
#ce
#EndRegion Members Exported

#Region Includes
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#EndRegion Includes

#Region Global Variables
Global Enum $OUTPUT_PROGRESS, $OUTPUT_BUILD
If Not IsDeclared("WM_COPYDATA") Then Assign("WM_COPYDATA", 0x4A, 2)
Global Const $COPYDATASTRUCT = "uint;dword;ptr"
Global Const $g_sOutputWindowTitle = "AutoIt Build Script Output"
Global Const $g_sOutputWindowText = "This is hidden text"
Global $g_hWndOutputWindow = 0, $g_idEditProgress, $g_idEditBuild
#EndRegion Global Variables

#Region Public Members

#Region _OutputWindowCreate()
; ===================================================================
; _OutputWindowCreate()
;
; Creates the output window and both output panes.
; Parameters:
;	None.
; Returns:
;	HWND to the window.
; ===================================================================
Func _OutputWindowCreate()
	Local $nOld = Opt("WinDetectHiddenText", True)
	Local $bExists = WinExists($g_sOutputWindowTitle, $g_sOutputWindowText)
	Opt("WinDetectHiddenText", $nOld)
	If $bExists Then Return 0

	; Variables used to control different aspects of the GUI.
	Local $w = 600, $h = 480
	Local $nFontSize = Default, $nFontWeight = 600
	Local $nEditColor = 0xFFFFFF, $nEditStyle = BitOR($WS_HSCROLL, $WS_VSCROLL, $ES_READONLY)

	$g_hWndOutputWindow = GUICreate($g_sOutputWindowTitle, $w, $h)
	; We use a hidden label with unique test so we can reliably identify the window.
	Local $idLabelHidden = GUICtrlCreateLabel($g_sOutputWindowText, 0, 0, 1, 1)
	GUICtrlSetState($idLabelHidden, $GUI_HIDE)
	Local $idLabelProgress = GUICtrlCreateLabel("Progress Output:", 4, 4, $w - 8, 20)
	GUICtrlSetFont($idLabelProgress, $nFontSize, $nFontWeight)
	$g_idEditProgress = GUICtrlCreateEdit("", 4, 28, $w - 8, 150, $nEditStyle)
	GUICtrlSetBkColor($g_idEditProgress, $nEditColor)
	__OutputSetEditLimit($g_idEditProgress)	; Max the size of the edit control.

	Local $idLabelBuild = GUICtrlCreateLabel("Build Output:", 4, 186, $w - 8, 20)
	GUICtrlSetFont($idLabelBuild, $nFontSize, $nFontWeight)

	; We define $y explicitly because it's used both for the y position and the height calculation.
	Local $y = 210
	$g_idEditBuild = GUICtrlCreateEdit("", 4, $y, $w - 8, $h - (4 + $y), $nEditStyle)
	GUICtrlSetBkColor($g_idEditBuild, $nEditColor)
	__OutputSetEditLimit($g_idEditBuild)	; Max the size of the edit control.

	GUIRegisterMsg($WM_COPYDATA, "_OutputOnWM_COPYDATA")
	GUISetState(@SW_SHOWNORMAL, $g_hWndOutputWindow)
	Return $g_hWndOutputWindow
EndFunc	; _OutputWindowCreate()
#EndRegion _OutputWindowCreate()

#Region _OutputWaitClosed()
; ===================================================================
; _OutputWaitClosed()
;
; When called in the same process as the window exists, waits for the window to be closed,
;	otherwise returns immediately.
; Parameters:
;	None.
; Returns:
;	None.
; ===================================================================
Func _OutputWaitClosed()
	While WinExists(HWND($g_hWndOutputWindow))
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then GUIDelete($g_hWndOutputWindow)
	WEnd
EndFunc	; _OutputWaitClosed()
#EndRegion _OutputWaitClosed()

#Region _OutputProgressWrite()
; ===================================================================
; _OutputProgressWrite($sData)
;
; Writes data to the progress pane.
; Parameters:
;	$sData - IN - The data to write.
; Returns:
;	True if successful, False otherwise.
; ===================================================================
Func _OutputProgressWrite($sData)
	Return __OutputWrite($OUTPUT_PROGRESS, $sData)
EndFunc	; _OutputProgressWrite()
#EndRegion _OutputProgressWrite()

#Region _OutputBuildWrite()
; ===================================================================
; _OutputBuildWrite($sData)
;
; Writes data to the build pane.
; Parameters:
;	$sData - IN - The data to write.
; Returns:
;	True if successful, False otherwise.
; ===================================================================
Func _OutputBuildWrite($sData)
	Return __OutputWrite($OUTPUT_BUILD, $sData)
EndFunc	; _OutputBuildWrite()
#EndRegion _OutputBuildWrite()

#Region _OutputWindowSetState()
; ===================================================================
; _OutputWindowSetState($nState)
;
; Changes the state of the output window.
; Parameters:
;	$nState - IN - An @SW_ state flag to use.
; Returns:
;	None.
; ===================================================================
Func _OutputWindowSetState($nState)
	Local $nOld = Opt("WinDetectHiddenText", True)
	WinSetState($g_sOutputWindowTitle, $g_sOutputWindowText, $nState)
	Opt("WinDetectHiddenText", $nOld)
EndFunc	; _OutputWindowSetState()
#EndRegion _OutputWindowSetState()

#EndRegion Public Members

#Region Callback Functions

#Region _OutputOnWM_COPYDATA()
; ===================================================================
; _OutputOnWM_COPYDATA($hWnd, $nMsg, $wParam, $lParam)
;
; Message handler for WM_COPYDATA which is called when new output needs written.
; Parameters:
;	$hWnd - IN - UNUSED.
;	$nMsg - IN - UNUSED.
;	$wParam - IN - UNUSED.
;	$lParam - IN - Pointer to the $COPYDATASTRUCT.
; Returns:
;	Non-zero if handled, 0 otherwise.
; ===================================================================
Func _OutputOnWM_COPYDATA($hWnd, $nMsg, $wParam, $lParam)
	#ForceRef $hWnd, $nMsg, $wParam
	Local $cds = DllStructCreate($COPYDATASTRUCT, $lParam)
	Local $string = DllStructCreate("char[" & DllStructGetData($cds, 2) & "]", DllStructGetData($cds, 3))
	Local $sData = DllStructGetData($string, 1)
	Local $nID
	Switch DllStructGetData($cds, 1)
		Case $OUTPUT_PROGRESS
			$nID = $g_idEditProgress
		Case $OUTPUT_BUILD
			$nID = $g_idEditBuild
		Case Else
			Return 0
	EndSwitch
	Local $nLen = GUICtrlSendMsg($nID, $WM_GETTEXTLENGTH, 0, 0)
	GUICtrlSendMsg($nID, $EM_SETSEL, $nLen, $nLen)
	GUICtrlSetData($nID, $sData, True)
	Return 1
EndFunc	; _OutputOnWM_COPYDATA()
#EndRegion _OutputOnWM_COPYDATA()

#EndRegion Callback Functions

#Region Private Members

#Region __OutputSetEditLimit()
; ===================================================================
; __OutputSetEditLimit($idControl)
;
; Sets an edit control's text limit.
; Parameters:
;	$idControl - IN - The handle to the control.
; Returns:
;	None.
; ===================================================================
Func __OutputSetEditLimit($idControl)
	Local Const $EM_LIMITTEXT = 0xC5
	GUICtrlSendMsg($idControl, $EM_LIMITTEXT, 0, 0)
EndFunc	; __OutputSetEditLimit()
#EndRegion __OutputSetEditLimit()

#Region __OutputWrite()
; ===================================================================
; __OutputWrite($nOutput, Const ByRef $sData)
;
; Handles writing to an output pane by taking care of the necessary communication logic.
; Parameters:
;	$nOutput - IN - An $OUTPUT_ flag.
;	$sData - IN - The data to write.
; Returns:
;	True if successful, False otherwise.
; ===================================================================
Func __OutputWrite($nOutput, Const ByRef $sData)
	; Find the target window.
	Local $nOld = Opt("WinDetectHiddenText", True)
	Local $hTarget = WinGetHandle($g_sOutputWindowTitle, $g_sOutputWindowText)
	Opt("WinDetectHiddenText", $nOld)
	If Not $hTarget Then Return False

	; Use the hidden window as the source.
	Local $hSource = WinGetHandle(AutoItWinGetTitle())

	; Create the structures
	Local $cds = DllStructCreate($COPYDATASTRUCT)
	Local $nSize = StringLen($sData) + 1
	Local $string = DllStructCreate("char[" & $nSize & "]")

	; Fill the structures
	DllStructSetData($string, 1, $sData)
	DllStructSetData($cds, 1, $nOutput)
	DllStructSetData($cds, 2, $nSize)
	DllStructSetData($cds, 3, DllStructGetPtr($string))

	; Send the message.
	Local $aRet = DllCall("user32.dll", "int", "SendMessage", "hwnd", $hTarget, "int", $WM_COPYDATA, _
		"hwnd", $hSource, "ptr", DllStructGetPtr($cds))
	If @error Then
		Return False
	Else
		Return $aRet[0] = 1
	EndIf
EndFunc	; __OutputWrite()
#EndRegion __OutputWrite()

#EndRegion Private Members
