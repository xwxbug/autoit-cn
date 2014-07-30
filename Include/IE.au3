#include-once

#include "AutoItConstants.au3"
#include "FileConstants.au3"
#include "WinAPIError.au3"

; #INDEX# =======================================================================================================================
; Title .........: Internet Explorer Automation UDF Library for AutoIt3
; AutoIt Version : 3.3.13.12
; Language ......: English
; Description ...: A collection of functions for creating, attaching to, reading from and manipulating Internet Explorer.
; Author(s) .....: DaleHohm, big_daddy, jpm
; Dll ...........: user32.dll, ole32.dll, oleacc.dll
; ===============================================================================================================================

#Region Header
#cs
	Title:   Internet Explorer Automation UDF Library for AutoIt3
	Filename:  IE.au3
	Description: A collection of functions for creating, attaching to, reading from and manipulating Internet Explorer
	Author:   DaleHohm
	Modified: jpm
	Version:  T3.0-1
	Last Update: 13/06/02
	Requirements: AutoIt3 3.3.9 or higher

	Update History:
	===================================================
	T3.0-1 13/6/2

	Enhancements
	- Fixed _IE_Introduction, _IE_Examples generate HTML5
	- Added check in __IEComErrorUnrecoverable for COM error -2147023174, "RPC server not accessible."
	- Fixed check in __IEComErrorUnrecoverable for COM error -2147024891, "Access is denied."
	- Fixed check in __IEComErrorUnrecoverable for COM error  -2147352567, "an exception has occurred."
	- Fixed __IEIsObjType() not restoring _IEErrorNotify()
	- Fixed $b_mustUnlock on Error in _IECreate()
	- Fixed no timeout cheking if error in _IELoadWait()
	- Fixed HTML5 support in _IEImgClick(), _IEFormImageClick()
	- Fixed _IEHeadInsertEventScript() COM error return
	- Updated _IEErrorNotify() default keyword support
	- Updated rename __IENotify() to __IEConsoleWriteError() and restore calling  @error
	- Removed __IEInternalErrorHandler() (not used any more)
	- Updated Function Headers
	- Updated doc and splitting and checking examples

	T3.0-0 12/9/3

	Fixes
	- Removed _IEErrorHandlerRegister() and all internal calls to it.  Unneeded as COM errors are no longer fatal
	- Removed code deprecated in V2
	- Fixed _IELoadWait check for unrecoverable COM errors
	- Removed Vcard support from _IEPropertyGet (IE removed support in IE7)
	- Code cleanup with #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6

	New Features
	- Added "scrollIntoView" to _IEAction

	Enhancements
	- Added check in __IEComErrorUnrecoverable for COM error -2147023179, "The interface is unknown."
	- Added "Trap COM error, report and return" to functions that perform blind method calls (those without return values)

	===================================================
#ce
#EndRegion Header

; #VARIABLES# ===================================================================================================================
#Region Global Variables
Global $__g_iIELoadWaitTimeout = 300000 ; 5 Minutes
Global $__g_bIEAU3Debug = False
Global $__g_bIEErrorNotify = True
;~ Global $o__IEErrorHandler, $s__IEUserErrorHandler
;~ Global _; Com Error Handler Status Strings
;~ 		$IEComErrorNumber, _
;~ 		$IEComErrorNumberHex, _
;~ 		$IEComErrorDescription, _
;~ 		$IEComErrorScriptline, _
;~ 		$IEComErrorWinDescription, _
;~ 		$IEComErrorSource, _
;~ 		$IEComErrorHelpFile, _
;~ 		$IEComErrorHelpContext, _
;~ 		$IEComErrorLastDllError, _
;~ 		$IEComErrorComObj, _
;~ 		$IEComErrorOutput
#EndRegion Global Variables
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
#Region Global Constants
Global Const $__gaIEAU3VersionInfo[6] = ["T", 3, 0, 1, "20130601", "T3.0-1"]
Global Const $LSFW_LOCK = 1, $LSFW_UNLOCK = 2
;
; Enums
;
Global Enum _; Error Status Types
		$_IESTATUS_Success = 0, _
		$_IESTATUS_GeneralError, _
		$_IESTATUS_ComError, _
		$_IESTATUS_InvalidDataType, _
		$_IESTATUS_InvalidObjectType, _
		$_IESTATUS_InvalidValue, _
		$_IESTATUS_LoadWaitTimeout, _
		$_IESTATUS_NoMatch, _
		$_IESTATUS_AccessIsDenied, _
		$_IESTATUS_ClientDisconnected
;~ Global Enum Step * 2 _; NotificationLevel
;~ 		$_IENotifyLevel_None = 0, _
;~ 		$_IENotifyNotifyLevel_Warning = 1, _
;~ 		$_IENotifyNotifyLevel_Error, _
;~ 		$_IENotifyNotifyLevel_ComError
;~ Global Enum Step * 2 _; NotificationMethod
;~ 		$_IENotifyMethod_Silent = 0, _
;~ 		$_IENotifyMethod_Console = 1, _
;~ 		$_IENotifyMethod_ToolTip, _
;~ 		$_IENotifyMethod_MsgBox
#EndRegion Global Constants
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _IECreate
; _IECreateEmbedded
; _IENavigate
; _IEAttach
; _IELoadWait
; _IELoadWaitTimeout
;
; _IEIsFrameSet
; _IEFrameGetCollection
; _IEFrameGetObjByName
;
; _IELinkClickByText
; _IELinkClickByIndex
; _IELinkGetCollection
;
; _IEImgClick
; _IEImgGetCollection
;
; _IEFormGetCollection
; _IEFormGetObjByName
; _IEFormElementGetCollection
; _IEFormElementGetObjByName
; _IEFormElementGetValue
; _IEFormElementSetValue
; _IEFormElementOptionSelect
; _IEFormElementCheckBoxSelect
; _IEFormElementRadioSelect
; _IEFormImageClick
; _IEFormSubmit
; _IEFormReset
;
; _IETableGetCollection
; _IETableWriteToArray
;
; _IEBodyReadHTML
; _IEBodyReadText
; _IEBodyWriteHTML
; _IEDocReadHTML
; _IEDocWriteHTML
; _IEDocInsertText
; _IEDocInsertHTML
; _IEHeadInsertEventScript
;
; _IEDocGetObj
; _IETagNameGetCollection
; _IETagNameAllGetCollection
; _IEGetObjByName
; _IEGetObjById
; _IEAction
; _IEPropertyGet
; _IEPropertySet
; _IEErrorNotify
; _IEQuit
;
; _IE_Introduction
; _IE_Example
; _IE_VersionInfo
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __IELockSetForegroundWindow
; __IEControlGetObjFromHWND
; __IERegisterWindowMessage
; __IESendMessageTimeout
; __IEIsObjType
; __IEConsoleWriteError
; __IEComErrorUnrecoverable
;
; __IENavigate
; __IEStringToBstr
; __IEBstrToString
; __IECreateNewIE
; __IETempFile
; ===============================================================================================================================

#Region Core functions
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func _IECreate($sUrl = "about:blank", $iTryAttach = 0, $iVisible = 1, $iWait = 1, $iTakeFocus = 1)
	If Not $iVisible Then $iTakeFocus = 0 ; Force takeFocus to 0 for hidden window

	If $iTryAttach Then
		Local $oResult = _IEAttach($sUrl, "url")
		If IsObj($oResult) Then
			If $iTakeFocus Then WinActivate(HWnd($oResult.hWnd))
			Return SetError($_IESTATUS_Success, 1, $oResult)
		EndIf
	EndIf

	Local $iMustUnlock = 0
	If Not $iVisible And __IELockSetForegroundWindow($LSFW_LOCK) Then $iMustUnlock = 1

	Local $oObject = ObjCreate("InternetExplorer.Application")
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IECreate", "", "Browser Object Creation Failed")
		If $iMustUnlock Then __IELockSetForegroundWindow($LSFW_UNLOCK)
		Return SetError($_IESTATUS_GeneralError, 0, 0)
	EndIf

	$oObject.visible = $iVisible

	; If the unlock doesn't work we may have created an unwanted modal window
	If $iMustUnlock And Not __IELockSetForegroundWindow($LSFW_UNLOCK) Then __IEConsoleWriteError("Warning", "_IECreate", "", "Foreground Window Unlock Failed!")
	_IENavigate($oObject, $sUrl, $iWait)

	; Store @error after _IENavigate() so that it can be returned.
	Local $iError = @error

	; IE9 sets focus to the URL bar when an about: URI is displayed (such as about:blank).  This can cause
	; _IEAction(..., "focus") to work incorrectly.  It will give focus to the element (as shown by the elements's
	; appearance changing but) the input caret will not move.  The work-around for this "helpful" behavior is
	; to explicitly give focus to the document.  We should only do this for about: URIs and on successful
	; navigate.
	If Not $iError And StringLeft($sUrl, 6) = "about:" Then
		Local $oDocument = $oObject.document
		_IEAction($oDocument, "focus")
	EndIf

	Return SetError($iError, 0, $oObject)
EndFunc   ;==>_IECreate

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IECreateEmbedded()
	Local $oObject = ObjCreate("Shell.Explorer.2")

	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IECreateEmbedded", "", "WebBrowser Object Creation Failed")
		Return SetError($_IESTATUS_GeneralError, 0, 0)
	EndIf
	;
	Return SetError($_IESTATUS_Success, 0, $oObject)
EndFunc   ;==>_IECreateEmbedded

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IENavigate(ByRef $oObject, $sUrl, $iWait = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IENavigate", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "documentContainer") Then
		__IEConsoleWriteError("Error", "_IENavigate", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$oObject.navigate($sUrl)
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IENavigate", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	If $iWait Then
		_IELoadWait($oObject)
		Return SetError(@error, 0, -1)
	EndIf

	Return SetError($_IESTATUS_Success, 0, -1)
EndFunc   ;==>_IENavigate

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEAttach($sString, $sMode = "Title", $iInstance = 1)
	$sMode = StringLower($sMode)

	$iInstance = Int($iInstance)
	If $iInstance < 1 Then
		__IEConsoleWriteError("Error", "_IEAttach", "$_IESTATUS_InvalidValue", "$iInstance < 1")
		Return SetError($_IESTATUS_InvalidValue, 3, 0)
	EndIf

	If $sMode = "embedded" Or $sMode = "dialogbox" Then
		Local $iWinTitleMatchMode = Opt("WinTitleMatchMode", $OPT_MATCHANY)
		If $sMode = "dialogbox" And $iInstance > 1 Then
			If IsHWnd($sString) Then
				$iInstance = 1
				__IEConsoleWriteError("Warning", "_IEAttach", "$_IESTATUS_GeneralError", "$iInstance > 1 invalid with HWnd and DialogBox.  Setting to 1.")
			Else
				Local $aWinlist = WinList($sString, "")
				If $iInstance <= $aWinlist[0][0] Then
					$sString = $aWinlist[$iInstance][1]
					$iInstance = 1
				Else
					__IEConsoleWriteError("Warning", "_IEAttach", "$_IESTATUS_NoMatch")
					Opt("WinTitleMatchMode", $iWinTitleMatchMode)
					Return SetError($_IESTATUS_NoMatch, 1, 0)
				EndIf
			EndIf
		EndIf
		Local $hControl = ControlGetHandle($sString, "", "[CLASS:Internet Explorer_Server; INSTANCE:" & $iInstance & "]")
		Local $oResult = __IEControlGetObjFromHWND($hControl)
		Opt("WinTitleMatchMode", $iWinTitleMatchMode)
		If IsObj($oResult) Then
			Return SetError($_IESTATUS_Success, 0, $oResult)
		Else
			__IEConsoleWriteError("Warning", "_IEAttach", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 1, 0)
		EndIf
	EndIf

	Local $oShell = ObjCreate("Shell.Application")
	Local $oShellWindows = $oShell.Windows(); collection of all ShellWindows (IE and File Explorer)
	Local $iTmp = 1
	Local $iNotifyStatus, $bIsBrowser, $sTmp
	For $oWindow In $oShellWindows
		;------------------------------------------------------------------------------------------
		; Check to verify that the window object is a valid browser, if not, skip it
		;
		; Setup internal error handler to Trap COM errors, turn off error notification,
		;     check object property validity, set a flag and reset error handler and notification
		;
		$bIsBrowser = True

		; Turn off error notification for internal processing
		$iNotifyStatus = _IEErrorNotify() ; save current error notify status
		_IEErrorNotify(False)

		; Check conditions to verify that the object is a browser
		If $bIsBrowser Then
			$sTmp = $oWindow.type ; Is .type a valid property?
			If @error Then $bIsBrowser = False
		EndIf
		If $bIsBrowser Then
			$sTmp = $oWindow.document.title ; Does object have a .document and .title property?
			If @error Then $bIsBrowser = False
		EndIf

		; restore error notify
		_IEErrorNotify($iNotifyStatus) ; restore notification status
		;------------------------------------------------------------------------------------------

		If $bIsBrowser Then
			Switch $sMode
				Case "title"
					If StringInStr($oWindow.document.title, $sString) > 0 Then
						If $iInstance = $iTmp Then
							Return SetError($_IESTATUS_Success, 0, $oWindow)
						Else
							$iTmp += 1
						EndIf
					EndIf
				Case "instance"
					If $iInstance = $iTmp Then
						Return SetError($_IESTATUS_Success, 0, $oWindow)
					Else
						$iTmp += 1
					EndIf
				Case "windowtitle"
					Local $bFound = False
					$sTmp = RegRead("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\", "Window Title")
					If Not @error Then
						If StringInStr($oWindow.document.title & " - " & $sTmp, $sString) Then $bFound = True
					Else
						If StringInStr($oWindow.document.title & " - Microsoft Internet Explorer", $sString) Then $bFound = True
						If StringInStr($oWindow.document.title & " - Windows Internet Explorer", $sString) Then $bFound = True
					EndIf
					If $bFound Then
						If $iInstance = $iTmp Then
							Return SetError($_IESTATUS_Success, 0, $oWindow)
						Else
							$iTmp += 1
						EndIf
					EndIf
				Case "url"
					If StringInStr($oWindow.LocationURL, $sString) > 0 Then
						If $iInstance = $iTmp Then
							Return SetError($_IESTATUS_Success, 0, $oWindow)
						Else
							$iTmp += 1
						EndIf
					EndIf
				Case "text"
					If StringInStr($oWindow.document.body.innerText, $sString) > 0 Then
						If $iInstance = $iTmp Then
							Return SetError($_IESTATUS_Success, 0, $oWindow)
						Else
							$iTmp += 1
						EndIf
					EndIf
				Case "html"
					If StringInStr($oWindow.document.body.innerHTML, $sString) > 0 Then
						If $iInstance = $iTmp Then
							Return SetError($_IESTATUS_Success, 0, $oWindow)
						Else
							$iTmp += 1
						EndIf
					EndIf
				Case "hwnd"
					If $iInstance > 1 Then
						$iInstance = 1
						__IEConsoleWriteError("Warning", "_IEAttach", "$_IESTATUS_GeneralError", "$iInstance > 1 invalid with HWnd.  Setting to 1.")
					EndIf
					If _IEPropertyGet($oWindow, "hwnd") = $sString Then
						Return SetError($_IESTATUS_Success, 0, $oWindow)
					EndIf
				Case Else
					; Invalid Mode
					__IEConsoleWriteError("Error", "_IEAttach", "$_IESTATUS_InvalidValue", "Invalid Mode Specified")
					Return SetError($_IESTATUS_InvalidValue, 2, 0)
			EndSwitch
		EndIf
	Next
	__IEConsoleWriteError("Warning", "_IEAttach", "$_IESTATUS_NoMatch")
	Return SetError($_IESTATUS_NoMatch, 1, 0)
EndFunc   ;==>_IEAttach

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func _IELoadWait(ByRef $oObject, $iDelay = 0, $iTimeout = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IELoadWait", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf

	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IELoadWait", "$_IESTATUS_InvalidObjectType", ObjName($oObject))
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf

	Local $oTemp, $bAbort = False, $iErrorStatusCode = $_IESTATUS_Success

	; Turn off error notification for internal processing
	Local $iNotifyStatus = _IEErrorNotify() ; save current error notify status
	_IEErrorNotify(False)

	Sleep($iDelay)
	;
	Local $iError
	Local $hIELoadWaitTimer = TimerInit()
	If $iTimeout = -1 Then $iTimeout = $__g_iIELoadWaitTimeout

	Select
		Case __IEIsObjType($oObject, "browser"); Internet Explorer
			While Not (String($oObject.readyState) = "complete" Or $oObject.readyState = 4 Or $bAbort)
				; Trap unrecoverable COM errors
				If @error Then
					$iError = @error
					If __IEComErrorUnrecoverable($iError) Then
						$iErrorStatusCode = __IEComErrorUnrecoverable($iError)
						$bAbort = True
					EndIf
				ElseIf (TimerDiff($hIELoadWaitTimer) > $iTimeout) Then
					$iErrorStatusCode = $_IESTATUS_LoadWaitTimeout
					$bAbort = True
				EndIf
				Sleep(100)
			WEnd
			While Not (String($oObject.document.readyState) = "complete" Or $oObject.document.readyState = 4 Or $bAbort)
				; Trap unrecoverable COM errors
				If @error Then
					$iError = @error
					If __IEComErrorUnrecoverable($iError) Then
						$iErrorStatusCode = __IEComErrorUnrecoverable($iError)
						$bAbort = True
					EndIf
				ElseIf (TimerDiff($hIELoadWaitTimer) > $iTimeout) Then
					$iErrorStatusCode = $_IESTATUS_LoadWaitTimeout
					$bAbort = True
				EndIf
				Sleep(100)
			WEnd
		Case __IEIsObjType($oObject, "window") ; Window, Frame, iFrame
			While Not (String($oObject.document.readyState) = "complete" Or $oObject.document.readyState = 4 Or $bAbort)
				; Trap unrecoverable COM errors
				If @error Then
					$iError = @error
					If __IEComErrorUnrecoverable($iError) Then
						$iErrorStatusCode = __IEComErrorUnrecoverable($iError)
						$bAbort = True
					EndIf
				ElseIf (TimerDiff($hIELoadWaitTimer) > $iTimeout) Then
					$iErrorStatusCode = $_IESTATUS_LoadWaitTimeout
					$bAbort = True
				EndIf
				Sleep(100)
			WEnd
			While Not (String($oObject.top.document.readyState) = "complete" Or $oObject.top.document.readyState = 4 Or $bAbort)
				; Trap unrecoverable COM errors
				If @error Then
					$iError = @error
					If __IEComErrorUnrecoverable($iError) Then
						$iErrorStatusCode = __IEComErrorUnrecoverable($iError)
						$bAbort = True
					EndIf
				ElseIf (TimerDiff($hIELoadWaitTimer) > $iTimeout) Then
					$iErrorStatusCode = $_IESTATUS_LoadWaitTimeout
					$bAbort = True
				EndIf
				Sleep(100)
			WEnd
		Case __IEIsObjType($oObject, "document") ; Document
			$oTemp = $oObject.parentWindow
			While Not (String($oTemp.document.readyState) = "complete" Or $oTemp.document.readyState = 4 Or $bAbort)
				; Trap unrecoverable COM errors
				If @error Then
					$iError = @error
					If __IEComErrorUnrecoverable($iError) Then
						$iErrorStatusCode = __IEComErrorUnrecoverable($iError)
						$bAbort = True
					EndIf
				ElseIf (TimerDiff($hIELoadWaitTimer) > $iTimeout) Then
					$iErrorStatusCode = $_IESTATUS_LoadWaitTimeout
					$bAbort = True
				EndIf
				Sleep(100)
			WEnd
			While Not (String($oTemp.top.document.readyState) = "complete" Or $oTemp.top.document.readyState = 4 Or $bAbort)
				; Trap unrecoverable COM errors
				If @error Then
					$iError = @error
					If __IEComErrorUnrecoverable($iError) Then
						$iErrorStatusCode = __IEComErrorUnrecoverable($iError)
						$bAbort = True
					EndIf
				ElseIf (TimerDiff($hIELoadWaitTimer) > $iTimeout) Then
					$iErrorStatusCode = $_IESTATUS_LoadWaitTimeout
					$bAbort = True
				EndIf
				Sleep(100)
			WEnd
		Case Else ; this should work with any other DOM object
			$oTemp = $oObject.document.parentWindow
			While Not (String($oTemp.document.readyState) = "complete" Or $oTemp.document.readyState = 4 Or $bAbort)
				; Trap unrecoverable COM errors
				If @error Then
					$iError = @error
					If __IEComErrorUnrecoverable($iError) Then
						$iErrorStatusCode = __IEComErrorUnrecoverable($iError)
						$bAbort = True
					EndIf
				ElseIf (TimerDiff($hIELoadWaitTimer) > $iTimeout) Then
					$iErrorStatusCode = $_IESTATUS_LoadWaitTimeout
					$bAbort = True
				EndIf
				Sleep(100)
			WEnd
			While Not (String($oTemp.top.document.readyState) = "complete" Or $oObject.top.document.readyState = 4 Or $bAbort)
				; Trap unrecoverable COM errors
				If @error Then
					$iError = @error
					If __IEComErrorUnrecoverable($iError) Then
						$iErrorStatusCode = __IEComErrorUnrecoverable($iError)
						$bAbort = True
					EndIf
				ElseIf (TimerDiff($hIELoadWaitTimer) > $iTimeout) Then
					$iErrorStatusCode = $_IESTATUS_LoadWaitTimeout
					$bAbort = True
				EndIf
				Sleep(100)
			WEnd
	EndSelect

	; restore error notify
	_IEErrorNotify($iNotifyStatus) ; restore notification status

	Switch $iErrorStatusCode
		Case $_IESTATUS_Success
			Return SetError($_IESTATUS_Success, 0, 1)
		Case $_IESTATUS_LoadWaitTimeout
			__IEConsoleWriteError("Warning", "_IELoadWait", "$_IESTATUS_LoadWaitTimeout")
			Return SetError($_IESTATUS_LoadWaitTimeout, 3, 0)
		Case $_IESTATUS_AccessIsDenied
			__IEConsoleWriteError("Warning", "_IELoadWait", "$_IESTATUS_AccessIsDenied", _
					"Cannot verify readyState.  Likely casue: cross-domain scripting security restriction. (" & $iError & ")")
			Return SetError($_IESTATUS_AccessIsDenied, 0, 0)
		Case $_IESTATUS_ClientDisconnected
			__IEConsoleWriteError("Error", "_IELoadWait", "$_IESTATUS_ClientDisconnected", _
					$iError & ", Browser has been deleted prior to operation.")
			Return SetError($_IESTATUS_ClientDisconnected, 0, 0)
		Case Else
			__IEConsoleWriteError("Error", "_IELoadWait", "$_IESTATUS_GeneralError", "Invalid Error Status - Notify IE.au3 developer")
			Return SetError($_IESTATUS_GeneralError, 0, 0)
	EndSwitch
EndFunc   ;==>_IELoadWait

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IELoadWaitTimeout($iTimeout = -1)
	If $iTimeout = -1 Then
		Return SetError($_IESTATUS_Success, 0, $__g_iIELoadWaitTimeout)
	Else
		$__g_iIELoadWaitTimeout = $iTimeout
		Return SetError($_IESTATUS_Success, 0, 1)
	EndIf
EndFunc   ;==>_IELoadWaitTimeout

#EndRegion Core functions

#Region Frame Functions
; Security Note on Frame functions:
; Note that security restriction in Internet Explorer related to cross-site scripting
; between frames can cause serious problems with the frame functions.  Functions that
; work connected to one site will fail when connected to another depending on the sites
; referenced in the frames.  In general, if all the referenced pages are on the same
; webserver these functions should work as described; if not, unexpected COM failures
; can occur.
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEIsFrameSet(ByRef $oObject)
	; Note: this is more reliable test for a FrameSet than checking the
	; number of frames (document.frames.length) because iFrames embedded on a normal
	; page are included in the frame collection even though it is not a FrameSet
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEIsFrameSet", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If String($oObject.document.body.tagName) = "frameset" Then
		Return SetError($_IESTATUS_Success, 0, 1)
	Else
		If @error Then ; Trap COM error, report and return
			__IEConsoleWriteError("Error", "_IEIsFrameSet", "$_IESTATUS_COMError", @error)
			Return SetError($_IESTATUS_ComError, @error, 0)
		EndIf
		Return SetError($_IESTATUS_Success, 0, 0)
	EndIf
EndFunc   ;==>_IEIsFrameSet

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFrameGetCollection(ByRef $oObject, $iIndex = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFrameGetCollection", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	$iIndex = Number($iIndex)
	Select
		Case $iIndex = -1
			Return SetError($_IESTATUS_Success, $oObject.document.parentwindow.frames.length, _
					$oObject.document.parentwindow.frames)
		Case $iIndex > -1 And $iIndex < $oObject.document.parentwindow.frames.length
			Return SetError($_IESTATUS_Success, $oObject.document.parentwindow.frames.length, _
					$oObject.document.parentwindow.frames.item($iIndex))
		Case $iIndex < -1
			__IEConsoleWriteError("Error", "_IEFrameGetCollection", "$_IESTATUS_InvalidValue", "$iIndex < -1")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
		Case Else
			__IEConsoleWriteError("Warning", "_IEFrameGetCollection", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 2, 0)
	EndSelect
EndFunc   ;==>_IEFrameGetCollection

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFrameGetObjByName(ByRef $oObject, $sName)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFrameGetObjByName", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Local $oTemp, $oFrames

	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IEFrameGetObjByName", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf

	If __IEIsObjType($oObject, "document") Then
		$oTemp = $oObject.parentWindow
	Else
		$oTemp = $oObject.document.parentWindow
	EndIf

	If _IEIsFrameSet($oTemp) Then
		$oFrames = _IETagNameGetCollection($oTemp, "frame")
	Else
		$oFrames = _IETagNameGetCollection($oTemp, "iframe")
	EndIf

	If $oFrames.length Then
		For $oFrame In $oFrames
			If String($oFrame.name) = $sName Then Return SetError($_IESTATUS_Success, 0, $oTemp.frames($sName))
		Next
		__IEConsoleWriteError("Warning", "_IEFrameGetObjByName", "$_IESTATUS_NoMatch", "No frames matching name")
		Return SetError($_IESTATUS_NoMatch, 2, 0)
	Else
		__IEConsoleWriteError("Warning", "_IEFrameGetObjByName", "$_IESTATUS_NoMatch", "No Frames found")
		Return SetError($_IESTATUS_NoMatch, 2, 0)
	EndIf
EndFunc   ;==>_IEFrameGetObjByName

#EndRegion Frame Functions

#Region Link functions
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IELinkClickByText(ByRef $oObject, $sLinkText, $iIndex = 0, $iWait = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IELinkClickByText", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Local $iFound = 0, $sModeLinktext, $oLinks = $oObject.document.links
	$iIndex = Number($iIndex)
	For $oLink In $oLinks
		$sModeLinktext = String($oLink.outerText)
		If $sModeLinktext = $sLinkText Then
			If ($iFound = $iIndex) Then
				$oLink.click()
				If @error Then ; Trap COM error, report and return
					__IEConsoleWriteError("Error", "_IELinkClickByText", "$_IESTATUS_COMError", @error)
					Return SetError($_IESTATUS_ComError, @error, 0)
				EndIf
				If $iWait Then
					_IELoadWait($oObject)
					Return SetError(@error, 0, -1)
				EndIf
				Return SetError($_IESTATUS_Success, 0, -1)
			EndIf
			$iFound = $iFound + 1
		EndIf
	Next
	__IEConsoleWriteError("Warning", "_IELinkClickByText", "$_IESTATUS_NoMatch")
	Return SetError($_IESTATUS_NoMatch, 0, 0) ; Could be caused by parameter 2, 3 or both
EndFunc   ;==>_IELinkClickByText

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IELinkClickByIndex(ByRef $oObject, $iIndex, $iWait = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IELinkClickByIndex", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Local $oLinks = $oObject.document.links, $oLink
	$iIndex = Number($iIndex)
	If ($iIndex >= 0) And ($iIndex <= $oLinks.length - 1) Then
		$oLink = $oLinks($iIndex)
		$oLink.click()
		If @error Then ; Trap COM error, report and return
			__IEConsoleWriteError("Error", "_IELinkClickByIndex", "$_IESTATUS_COMError", @error)
			Return SetError($_IESTATUS_ComError, @error, 0)
		EndIf
		If $iWait Then
			_IELoadWait($oObject)
			Return SetError(@error, 0, -1)
		EndIf
		Return SetError($_IESTATUS_Success, 0, -1)
	Else
		__IEConsoleWriteError("Warning", "_IELinkClickByIndex", "$_IESTATUS_NoMatch")
		Return SetError($_IESTATUS_NoMatch, 2, 0)
	EndIf
EndFunc   ;==>_IELinkClickByIndex

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IELinkGetCollection(ByRef $oObject, $iIndex = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IELinkGetCollection", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	$iIndex = Number($iIndex)
	Select
		Case $iIndex = -1
			Return SetError($_IESTATUS_Success, $oObject.document.links.length, _
					$oObject.document.links)
		Case $iIndex > -1 And $iIndex < $oObject.document.links.length
			Return SetError($_IESTATUS_Success, $oObject.document.links.length, _
					$oObject.document.links.item($iIndex))
		Case $iIndex < -1
			__IEConsoleWriteError("Error", "_IELinkGetCollection", "$_IESTATUS_InvalidValue")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
		Case Else
			__IEConsoleWriteError("Warning", "_IELinkGetCollection", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 2, 0)
	EndSelect
EndFunc   ;==>_IELinkGetCollection
#EndRegion Link functions

#Region Image functions
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func _IEImgClick(ByRef $oObject, $sLinkText, $sMode = "src", $iIndex = 0, $iWait = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEImgClick", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Local $sModeLinktext, $iFound = 0, $oImgs = $oObject.document.images
	$sMode = StringLower($sMode)
	$iIndex = Number($iIndex)
	For $oImg In $oImgs
		Select
			Case $sMode = "alt"
				$sModeLinktext = $oImg.alt
			Case $sMode = "name"
				$sModeLinktext = $oImg.name
				If Not IsString($sModeLinktext) Then $sModeLinktext = $oImg.id ; html5 support
			Case $sMode = "id"
				$sModeLinktext = $oImg.id
			Case $sMode = "src"
				$sModeLinktext = $oImg.src
			Case Else
				__IEConsoleWriteError("Error", "_IEImgClick", "$_IESTATUS_InvalidValue", "Invalid mode: " & $sMode)
				Return SetError($_IESTATUS_InvalidValue, 3, 0)
		EndSelect
		If StringInStr($sModeLinktext, $sLinkText) Then
			If ($iFound = $iIndex) Then
				$oImg.click()
				If @error Then ; Trap COM error, report and return
					__IEConsoleWriteError("Error", "_IEImgClick", "$_IESTATUS_COMError", @error)
					Return SetError($_IESTATUS_ComError, @error, 0)
				EndIf
				If $iWait Then
					_IELoadWait($oObject)
					Return SetError(@error, 0, -1)
				EndIf
				Return SetError($_IESTATUS_Success, 0, -1)
			EndIf
			$iFound = $iFound + 1
		EndIf
	Next
	__IEConsoleWriteError("Warning", "_IEImgClick", "$_IESTATUS_NoMatch")
	Return SetError($_IESTATUS_NoMatch, 0, 0) ; Could be caused by parameter 2, 4 or both
EndFunc   ;==>_IEImgClick

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEImgGetCollection(ByRef $oObject, $iIndex = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEImgGetCollection", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Local $oTemp = _IEDocGetObj($oObject)
	$iIndex = Number($iIndex)
	Select
		Case $iIndex = -1
			Return SetError($_IESTATUS_Success, $oTemp.images.length, $oTemp.images)
		Case $iIndex > -1 And $iIndex < $oTemp.images.length
			Return SetError($_IESTATUS_Success, $oTemp.images.length, $oTemp.images.item($iIndex))
		Case $iIndex < -1
			__IEConsoleWriteError("Error", "_IEImgGetCollection", "$_IESTATUS_InvalidValue", "$iIndex < -1")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
		Case Else
			__IEConsoleWriteError("Warning", "_IEImgGetCollection", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 1, 0)
	EndSelect
EndFunc   ;==>_IEImgGetCollection

#EndRegion Image functions

#Region Form functions
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormGetCollection(ByRef $oObject, $iIndex = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormGetCollection", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Local $oTemp = _IEDocGetObj($oObject)
	$iIndex = Number($iIndex)
	Select
		Case $iIndex = -1
			Return SetError($_IESTATUS_Success, $oTemp.forms.length, $oTemp.forms)
		Case $iIndex > -1 And $iIndex < $oTemp.forms.length
			Return SetError($_IESTATUS_Success, $oTemp.forms.length, $oTemp.forms.item($iIndex))
		Case $iIndex < -1
			__IEConsoleWriteError("Error", "_IEFormGetCollection", "$_IESTATUS_InvalidValue", "$iIndex < -1")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
		Case Else
			__IEConsoleWriteError("Warning", "_IEFormGetCollection", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 1, 0)
	EndSelect
EndFunc   ;==>_IEFormGetCollection

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormGetObjByName(ByRef $oObject, $sName, $iIndex = 0)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormGetObjByName", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	;----- Determine valid collection length
	Local $iLength = 0
	Local $oCol = $oObject.document.forms.item($sName)
	If IsObj($oCol) Then
		If __IEIsObjType($oCol, "elementcollection") Then
			$iLength = $oCol.length
		Else
			$iLength = 1
		EndIf
	EndIf
	;-----
	$iIndex = Number($iIndex)
	If $iIndex = -1 Then
		Return SetError($_IESTATUS_Success, $iLength, $oObject.document.forms.item($sName))
	Else
		If IsObj($oObject.document.forms.item($sName, $iIndex)) Then
			Return SetError($_IESTATUS_Success, $iLength, $oObject.document.forms.item($sName, $iIndex))
		Else
			__IEConsoleWriteError("Warning", "_IEFormGetObjByName", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 0, 0) ; Could be caused by parameter 2, 3 or both
		EndIf
	EndIf
EndFunc   ;==>_IEFormGetObjByName

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormElementGetCollection(ByRef $oObject, $iIndex = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormElementGetCollection", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "form") Then
		__IEConsoleWriteError("Error", "_IEFormElementGetCollection", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$iIndex = Number($iIndex)
	Select
		Case $iIndex = -1
			Return SetError($_IESTATUS_Success, $oObject.elements.length, $oObject.elements)
		Case $iIndex > -1 And $iIndex < $oObject.elements.length
			Return SetError($_IESTATUS_Success, $oObject.elements.length, $oObject.elements.item($iIndex))
		Case $iIndex < -1
			__IEConsoleWriteError("Error", "_IEFormElementGetCollection", "$_IESTATUS_InvalidValue", "$iIndex < -1")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
		Case Else
			Return SetError($_IESTATUS_NoMatch, 1, 0)
	EndSelect
EndFunc   ;==>_IEFormElementGetCollection

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormElementGetObjByName(ByRef $oObject, $sName, $iIndex = 0)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormElementGetObjByName", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "form") Then
		__IEConsoleWriteError("Error", "_IEFormElementGetObjByName", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	;----- Determine valid collection length
	Local $iLength = 0
	Local $oCol = $oObject.elements.item($sName)
	If IsObj($oCol) Then
		If __IEIsObjType($oCol, "elementcollection") Then
			$iLength = $oCol.length
		Else
			$iLength = 1
		EndIf
	EndIf
	;-----
	$iIndex = Number($iIndex)
	If $iIndex = -1 Then
		Return SetError($_IESTATUS_Success, $iLength, $oObject.elements.item($sName))
	Else
		If IsObj($oObject.elements.item($sName, $iIndex)) Then
			Return SetError($_IESTATUS_Success, $iLength, $oObject.elements.item($sName, $iIndex))
		Else
			__IEConsoleWriteError("Warning", "_IEFormElementGetObjByName", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 0, 0) ; Could be caused by parameter 2, 3 or both
		EndIf
	EndIf
EndFunc   ;==>_IEFormElementGetObjByName

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormElementGetValue(ByRef $oObject)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormElementGetValue", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "forminputelement") Then
		__IEConsoleWriteError("Error", "_IEFormElementGetValue", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	Local $sReturn = String($oObject.value)
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEFormElementGetValue", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	SetError($_IESTATUS_Success)
	Return $sReturn
EndFunc   ;==>_IEFormElementGetValue

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormElementSetValue(ByRef $oObject, $sNewvalue, $iFireEvent = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormElementSetValue", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "forminputelement") Then
		__IEConsoleWriteError("Error", "_IEFormElementSetValue", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	If String($oObject.type) = "file" Then
		__IEConsoleWriteError("Error", "_IEFormElementSetValue", "$_IESTATUS_InvalidObjectType", "Browser securuty prevents SetValue of TYPE=FILE")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$oObject.value = $sNewvalue
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEFormElementSetValue", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	If $iFireEvent Then
		$oObject.fireEvent("OnChange")
		$oObject.fireEvent("OnClick")
	EndIf
	Return SetError($_IESTATUS_Success, 0, 1)
EndFunc   ;==>_IEFormElementSetValue

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormElementOptionSelect(ByRef $oObject, $sString, $iSelect = 1, $sMode = "byValue", $iFireEvent = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "formselectelement") Then
		__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	Local $oItem, $oItems = $oObject.options, $iNumItems = $oObject.options.length, $bIsMultiple = $oObject.multiple

	Switch $sMode
		Case "byValue"
			For $oItem In $oItems
				If $oItem.value = $sString Then
					Switch $iSelect
						Case -1
							Return SetError($_IESTATUS_Success, 0, $oItem.selected)
						Case 0
							If Not $bIsMultiple Then
								__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidValue", _
										"$iSelect=0 only valid for type=select multiple")
								SetError($_IESTATUS_InvalidValue, 3)
							EndIf
							If $oItem.selected Then
								$oItem.selected = False
								If $iFireEvent Then
									$oObject.fireEvent("onChange")
									$oObject.fireEvent("OnClick")
								EndIf
							EndIf
							Return SetError($_IESTATUS_Success, 0, 1)
						Case 1
							If Not $oItem.selected Then
								$oItem.selected = True
								If $iFireEvent Then
									$oObject.fireEvent("onChange")
									$oObject.fireEvent("OnClick")
								EndIf
							EndIf
							Return SetError($_IESTATUS_Success, 0, 1)
						Case Else
							__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidValue", "Invalid $iSelect value")
							Return SetError($_IESTATUS_InvalidValue, 3, 0)
					EndSwitch
					__IEConsoleWriteError("Warning", "_IEFormElementOptionSelect", "$_IESTATUS_NoMatch", "Value not matched")
					Return SetError($_IESTATUS_NoMatch, 2, 0)
				EndIf
			Next
		Case "byText"
			For $oItem In $oItems
				If String($oItem.text) = $sString Then
					Switch $iSelect
						Case -1
							Return SetError($_IESTATUS_Success, 0, $oItem.selected)
						Case 0
							If Not $bIsMultiple Then
								__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidValue", _
										"$iSelect=0 only valid for type=select multiple")
								SetError($_IESTATUS_InvalidValue, 3)
							EndIf
							If $oItem.selected Then
								$oItem.selected = False
								If $iFireEvent Then
									$oObject.fireEvent("onChange")
									$oObject.fireEvent("OnClick")
								EndIf
							EndIf
							Return SetError($_IESTATUS_Success, 0, 1)
						Case 1
							If Not $oItem.selected Then
								$oItem.selected = True
								If $iFireEvent Then
									$oObject.fireEvent("onChange")
									$oObject.fireEvent("OnClick")
								EndIf
							EndIf
							Return SetError($_IESTATUS_Success, 0, 1)
						Case Else
							__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidValue", "Invalid $iSelect value")
							Return SetError($_IESTATUS_InvalidValue, 3, 0)
					EndSwitch
					__IEConsoleWriteError("Warning", "_IEFormElementOptionSelect", "$_IESTATUS_NoMatch", "Text not matched")
					Return SetError($_IESTATUS_NoMatch, 2, 0)
				EndIf
			Next
		Case "byIndex"
			Local $iIndex = Number($sString)
			If $iIndex < 0 Or $iIndex >= $iNumItems Then
				__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidValue", "Invalid index value, " & $iIndex)
				Return SetError($_IESTATUS_InvalidValue, 2, 0)
			EndIf
			$oItem = $oItems.item($iIndex)
			Switch $iSelect
				Case -1
					Return SetError($_IESTATUS_Success, 0, $oItems.item($iIndex).selected)
				Case 0
					If Not $bIsMultiple Then
						__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidValue", _
								"$iSelect=0 only valid for type=select multiple")
						SetError($_IESTATUS_InvalidValue, 3)
					EndIf
					If $oItem.selected Then
						$oItems.item($iIndex).selected = False
						If $iFireEvent Then
							$oObject.fireEvent("onChange")
							$oObject.fireEvent("OnClick")
						EndIf
					EndIf
					Return SetError($_IESTATUS_Success, 0, 1)
				Case 1
					If Not $oItem.selected Then
						$oItems.item($iIndex).selected = True
						If $iFireEvent Then
							$oObject.fireEvent("onChange")
							$oObject.fireEvent("OnClick")
						EndIf
					EndIf
					Return SetError($_IESTATUS_Success, 0, 1)
				Case Else
					__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidValue", "Invalid $iSelect value")
					Return SetError($_IESTATUS_InvalidValue, 3, 0)
			EndSwitch
		Case Else
			__IEConsoleWriteError("Error", "_IEFormElementOptionSelect", "$_IESTATUS_InvalidValue", "Invalid Mode")
			Return SetError($_IESTATUS_InvalidValue, 4, 0)
	EndSwitch
EndFunc   ;==>_IEFormElementOptionSelect

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormElementCheckBoxSelect(ByRef $oObject, $sString, $sName = "", $iSelect = 1, $sMode = "byValue", $iFireEvent = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormElementCheckBoxSelect", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "form") Then
		__IEConsoleWriteError("Error", "_IEFormElementCheckBoxSelect", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$sString = String($sString)
	$sName = String($sName)

	Local $oItems
	If $sName = "" Then
		$oItems = _IETagNameGetCollection($oObject, "input")
	Else
		$oItems = Execute("$oObject.elements('" & $sName & "')")
	EndIf

	If Not IsObj($oItems) Then
		__IEConsoleWriteError("Warning", "_IEFormElementCheckBoxSelect", "$_IESTATUS_NoMatch")
		Return SetError($_IESTATUS_NoMatch, 3, 0)
	EndIf

	Local $oItem, $bFound = False
	Switch $sMode
		Case "byValue"
			If __IEIsObjType($oItems, "forminputelement") Then
				$oItem = $oItems
				If String($oItem.type) = "checkbox" And String($oItem.value) = $sString Then $bFound = True
			Else
				For $oItem In $oItems
					If String($oItem.type) = "checkbox" And String($oItem.value) = $sString Then
						$bFound = True
						ExitLoop
					EndIf
				Next
			EndIf
		Case "byIndex"
			If __IEIsObjType($oItems, "forminputelement") Then
				$oItem = $oItems
				If String($oItem.type) = "checkbox" And Number($sString) = 0 Then $bFound = True
			Else
				Local $iCount = 0
				For $oItem In $oItems
					If String($oItem.type) = "checkbox" And Number($sString) = $iCount Then
						$bFound = True
						ExitLoop
					Else
						If String($oItem.type) = "checkbox" Then $iCount += 1
					EndIf
				Next
			EndIf
		Case Else
			__IEConsoleWriteError("Error", "_IEFormElementCheckBoxSelect", "$_IESTATUS_InvalidValue", "Invalid Mode")
			Return SetError($_IESTATUS_InvalidValue, 5, 0)
	EndSwitch

	If Not $bFound Then
		__IEConsoleWriteError("Warning", "_IEFormElementCheckBoxSelect", "$_IESTATUS_NoMatch")
		Return SetError($_IESTATUS_NoMatch, 2, 0)
	EndIf

	Switch $iSelect
		Case -1
			Return SetError($_IESTATUS_Success, 0, $oItem.checked)
		Case 0
			If $oItem.checked Then
				$oItem.checked = False
				If $iFireEvent Then
					$oItem.fireEvent("onChange")
					$oItem.fireEvent("OnClick")
				EndIf
			EndIf
			Return SetError($_IESTATUS_Success, 0, 1)
		Case 1
			If Not $oItem.checked Then
				$oItem.checked = True
				If $iFireEvent Then
					$oItem.fireEvent("onChange")
					$oItem.fireEvent("OnClick")
				EndIf
			EndIf
			Return SetError($_IESTATUS_Success, 0, 1)
		Case Else
			__IEConsoleWriteError("Error", "_IEFormElementCheckBoxSelect", "$_IESTATUS_InvalidValue", "Invalid $iSelect value")
			Return SetError($_IESTATUS_InvalidValue, 3, 0)
	EndSwitch
EndFunc   ;==>_IEFormElementCheckBoxSelect

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormElementRadioSelect(ByRef $oObject, $sString, $sName, $iSelect = 1, $sMode = "byValue", $iFireEvent = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormElementRadioSelect", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "form") Then
		__IEConsoleWriteError("Error", "_IEFormElementRadioSelect", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$sString = String($sString)
	$sName = String($sName)

	Local $oItems = Execute("$oObject.elements('" & $sName & "')")
	If Not IsObj($oItems) Then
		__IEConsoleWriteError("Warning", "_IEFormElementRadioSelect", "$_IESTATUS_NoMatch")
		Return SetError($_IESTATUS_NoMatch, 3, 0)
	EndIf

	Local $oItem, $bFound = False
	Switch $sMode
		Case "byValue"
			If __IEIsObjType($oItems, "forminputelement") Then
				$oItem = $oItems
				If String($oItem.type) = "radio" And String($oItem.value) = $sString Then $bFound = True
			Else
				For $oItem In $oItems
					If String($oItem.type) = "radio" And String($oItem.value) = $sString Then
						$bFound = True
						ExitLoop
					EndIf
				Next
			EndIf
		Case "byIndex"
			If __IEIsObjType($oItems, "forminputelement") Then
				$oItem = $oItems
				If String($oItem.type) = "radio" And Number($sString) = 0 Then $bFound = True
			Else
				Local $iCount = 0
				For $oItem In $oItems
					If String($oItem.type) = "radio" And Number($sString) = $iCount Then
						$bFound = True
						ExitLoop
					Else
						$iCount += 1
					EndIf
				Next
			EndIf
		Case Else
			__IEConsoleWriteError("Error", "_IEFormElementRadioSelect", "$_IESTATUS_InvalidValue", "Invalid Mode")
			Return SetError($_IESTATUS_InvalidValue, 5, 0)
	EndSwitch

	If Not $bFound Then
		__IEConsoleWriteError("Warning", "_IEFormElementRadioSelect", "$_IESTATUS_NoMatch")
		Return SetError($_IESTATUS_NoMatch, 2, 0)
	EndIf

	Switch $iSelect
		Case -1
			Return SetError($_IESTATUS_Success, 0, $oItem.checked)
		Case 0
			If $oItem.checked Then
				$oItem.checked = False
				If $iFireEvent Then
					$oItem.fireEvent("onChange")
					$oItem.fireEvent("OnClick")
				EndIf
			EndIf
			Return SetError($_IESTATUS_Success, 0, 1)
		Case 1
			If Not $oItem.checked Then
				$oItem.checked = True
				If $iFireEvent Then
					$oItem.fireEvent("onChange")
					$oItem.fireEvent("OnClick")
				EndIf
			EndIf
			Return SetError($_IESTATUS_Success, 0, 1)
		Case Else
			__IEConsoleWriteError("Error", "_IEFormElementRadioSelect", "$_IESTATUS_InvalidValue", "$iSelect value invalid")
			Return SetError($_IESTATUS_InvalidValue, 4, 0)
	EndSwitch
EndFunc   ;==>_IEFormElementRadioSelect

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func _IEFormImageClick(ByRef $oObject, $sLinkText, $sMode = "src", $iIndex = 0, $iWait = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormImageClick", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Local $sModeLinktext, $iFound = 0
	Local $oTemp = _IEDocGetObj($oObject)
	Local $oImgs = _IETagNameGetCollection($oTemp, "input")
	$sMode = StringLower($sMode)
	$iIndex = Number($iIndex)
	For $oImg In $oImgs
		If String($oImg.type) = "image" Then
			Select
				Case $sMode = "alt"
					$sModeLinktext = $oImg.alt
				Case $sMode = "name"
					$sModeLinktext = $oImg.name
					If Not IsString($sModeLinktext) Then $sModeLinktext = $oImg.id ; html5 support
				Case $sMode = "id"
					$sModeLinktext = $oImg.id
				Case $sMode = "src"
					$sModeLinktext = $oImg.src
				Case Else
					__IEConsoleWriteError("Error", "_IEFormImageClick", "$_IESTATUS_InvalidValue", "Invalid mode: " & $sMode)
					Return SetError($_IESTATUS_InvalidValue, 3, 0)
			EndSelect
			If StringInStr($sModeLinktext, $sLinkText) Then
				If ($iFound = $iIndex) Then
					$oImg.click()
					If @error Then ; Trap COM error, report and return
						__IEConsoleWriteError("Error", "_IEFormImageClick", "$_IESTATUS_COMError", @error)
						Return SetError($_IESTATUS_ComError, @error, 0)
					EndIf
					If $iWait Then
						_IELoadWait($oObject)
						Return SetError(@error, 0, -1)
					EndIf
					Return SetError($_IESTATUS_Success, 0, -1)
				EndIf
				$iFound = $iFound + 1
			EndIf
		EndIf
	Next
	__IEConsoleWriteError("Warning", "_IEFormImageClick", "$_IESTATUS_NoMatch")
	Return SetError($_IESTATUS_NoMatch, 2, 0)
EndFunc   ;==>_IEFormImageClick

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormSubmit(ByRef $oObject, $iWait = 1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormSubmit", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "form") Then
		__IEConsoleWriteError("Error", "_IEFormSubmit", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;

	Local $oWindow = $oObject.document.parentWindow
	$oObject.submit()
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEFormSubmit", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	If $iWait Then
		_IELoadWait($oWindow)
		Return SetError(@error, 0, -1)
	EndIf
	Return SetError($_IESTATUS_Success, 0, -1)
EndFunc   ;==>_IEFormSubmit

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEFormReset(ByRef $oObject)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEFormReset", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "form") Then
		__IEConsoleWriteError("Error", "_IEFormReset", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$oObject.reset()
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEFormReset", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	Return SetError($_IESTATUS_Success, 0, 1)
EndFunc   ;==>_IEFormReset
#EndRegion Form functions

#Region Table functions
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IETableGetCollection(ByRef $oObject, $iIndex = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IETableGetCollection", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	$iIndex = Number($iIndex)
	Select
		Case $iIndex = -1
			Return SetError($_IESTATUS_Success, $oObject.document.GetElementsByTagName("table").length, _
					$oObject.document.GetElementsByTagName("table"))
		Case $iIndex > -1 And $iIndex < $oObject.document.GetElementsByTagName("table").length
			Return SetError($_IESTATUS_Success, $oObject.document.GetElementsByTagName("table").length, _
					$oObject.document.GetElementsByTagName("table").item($iIndex))
		Case $iIndex < -1
			__IEConsoleWriteError("Error", "_IETableGetCollection", "$_IESTATUS_InvalidValue", "$iIndex < -1")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
		Case Else
			__IEConsoleWriteError("Warning", "_IETableGetCollection", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 1, 0)
	EndSelect
EndFunc   ;==>_IETableGetCollection

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IETableWriteToArray(ByRef $oObject, $bTranspose = False)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IETableWriteToArray", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "table") Then
		__IEConsoleWriteError("Error", "_IETableWriteToArray", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	Local $iCols = 0, $oTds, $iCol
	Local $oTrs = $oObject.rows
	For $oTr In $oTrs
		$oTds = $oTr.cells
		$iCol = 0
		For $oTd In $oTds
			$iCol = $iCol + $oTd.colSpan
		Next
		If $iCol > $iCols Then $iCols = $iCol
	Next
	Local $iRows = $oTrs.length
	Local $aTableCells[$iCols][$iRows]
	Local $iRow = 0
	For $oTr In $oTrs
		$oTds = $oTr.cells
		$iCol = 0
		For $oTd In $oTds
			$aTableCells[$iCol][$iRow] = String($oTd.innerText)
			If @error Then ; Trap COM error, report and return
				__IEConsoleWriteError("Error", "_IETableWriteToArray", "$_IESTATUS_COMError", @error)
				Return SetError($_IESTATUS_ComError, @error, 0)
			EndIf
			$iCol = $iCol + $oTd.colSpan
		Next
		$iRow = $iRow + 1
	Next
	If $bTranspose Then
		Local $iD1 = UBound($aTableCells, $UBOUND_ROWS), $iD2 = UBound($aTableCells, $UBOUND_COLUMNS), $aTmp[$iD2][$iD1]
		For $i = 0 To $iD2 - 1
			For $j = 0 To $iD1 - 1
				$aTmp[$i][$j] = $aTableCells[$j][$i]
			Next
		Next
		$aTableCells = $aTmp
	EndIf
	Return SetError($_IESTATUS_Success, 0, $aTableCells)
EndFunc   ;==>_IETableWriteToArray
#EndRegion Table functions

#Region Read/Write functions
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEBodyReadHTML(ByRef $oObject)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEBodyReadHTML", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Return SetError($_IESTATUS_Success, 0, $oObject.document.body.innerHTML)
EndFunc   ;==>_IEBodyReadHTML

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEBodyReadText(ByRef $oObject)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEBodyReadText", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IEBodyReadText", "$_IESTATUS_InvalidObjectType", "Expected document element")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	Return SetError($_IESTATUS_Success, 0, $oObject.document.body.innerText)
EndFunc   ;==>_IEBodyReadText

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEBodyWriteHTML(ByRef $oObject, $sHtml)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEBodyWriteHTML", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IEBodyWriteHTML", "$_IESTATUS_InvalidObjectType", "Expected document element")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$oObject.document.body.innerHTML = $sHtml
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEBodyWriteHTML", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	Local $oTemp = $oObject.document
	_IELoadWait($oTemp)
	Return SetError(@error, 0, -1)
EndFunc   ;==>_IEBodyWriteHTML

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEDocReadHTML(ByRef $oObject)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEDocReadHTML", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IEDocReadHTML", "$_IESTATUS_InvalidObjectType", "Expected document element")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	Return SetError($_IESTATUS_Success, 0, $oObject.document.documentElement.outerHTML)
EndFunc   ;==>_IEDocReadHTML

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEDocWriteHTML(ByRef $oObject, $sHtml)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEDocWriteHTML", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IEDocWriteHTML", "$_IESTATUS_InvalidObjectType", "Expected document element")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$oObject.document.Write($sHtml)
	$oObject.document.close()
	Local $oTemp = $oObject.document
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEDocWriteHTML", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	_IELoadWait($oTemp)
	Return SetError(@error, 0, -1)
EndFunc   ;==>_IEDocWriteHTML

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEDocInsertText(ByRef $oObject, $sString, $sWhere = "beforeend")
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEDocInsertText", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	If Not __IEIsObjType($oObject, "browserdom") Or __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
		__IEConsoleWriteError("Error", "_IEDocInsertText", "$_IESTATUS_InvalidObjectType", "Expected document element")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf

	$sWhere = StringLower($sWhere)
	Select
		Case $sWhere = "beforebegin"
			$oObject.insertAdjacentText($sWhere, $sString)
		Case $sWhere = "afterbegin"
			$oObject.insertAdjacentText($sWhere, $sString)
		Case $sWhere = "beforeend"
			$oObject.insertAdjacentText($sWhere, $sString)
		Case $sWhere = "afterend"
			$oObject.insertAdjacentText($sWhere, $sString)
		Case Else
			; Unsupported Where
			__IEConsoleWriteError("Error", "_IEDocInsertText", "$_IESTATUS_InvalidValue", "Invalid where value")
			Return SetError($_IESTATUS_InvalidValue, 3, 0)
	EndSelect

	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEDocInsertText", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	Return SetError($_IESTATUS_Success, 0, 1)
EndFunc   ;==>_IEDocInsertText

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEDocInsertHTML(ByRef $oObject, $sString, $sWhere = "beforeend")
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEDocInsertHTML", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	If Not __IEIsObjType($oObject, "browserdom") Or __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
		__IEConsoleWriteError("Error", "_IEDocInsertHTML", "$_IESTATUS_InvalidObjectType", "Expected document element")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf

	$sWhere = StringLower($sWhere)
	Select
		Case $sWhere = "beforebegin"
			$oObject.insertAdjacentHTML($sWhere, $sString)
		Case $sWhere = "afterbegin"
			$oObject.insertAdjacentHTML($sWhere, $sString)
		Case $sWhere = "beforeend"
			$oObject.insertAdjacentHTML($sWhere, $sString)
		Case $sWhere = "afterend"
			$oObject.insertAdjacentHTML($sWhere, $sString)
		Case Else
			; Unsupported Where
			__IEConsoleWriteError("Error", "_IEDocInsertHTML", "$_IESTATUS_InvalidValue", "Invalid where value")
			Return SetError($_IESTATUS_InvalidValue, 3, 0)
	EndSelect

	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEDocInsertHTML", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	Return SetError($_IESTATUS_Success, 0, 1)
EndFunc   ;==>_IEDocInsertHTML

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func _IEHeadInsertEventScript(ByRef $oObject, $sHtmlFor, $sEvent, $sScript)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEHeadInsertEventScript", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf

	Local $oHead = $oObject.document.all.tags("HEAD").Item(0)
	Local $oScript = $oObject.document.createElement("script")
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEHeadInsertEventScript(script)", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	With $oScript
		.defer = True
		.language = "jscript"
		.type = "text/javascript"
		.htmlFor = $sHtmlFor
		.event = $sEvent
		.text = $sScript
	EndWith
	$oHead.appendChild($oScript)
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEHeadInsertEventScript", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	Return SetError($_IESTATUS_Success, 0, 1)
EndFunc   ;==>_IEHeadInsertEventScript
#EndRegion Read/Write functions

#Region Utility functions
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEDocGetObj(ByRef $oObject)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEDocGetObj", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If __IEIsObjType($oObject, "document") Then
		Return SetError($_IESTATUS_Success, 0, $oObject)
	EndIf

	Return SetError($_IESTATUS_Success, 0, $oObject.document)
EndFunc   ;==>_IEDocGetObj

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IETagNameGetCollection(ByRef $oObject, $sTagName, $iIndex = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IETagNameGetCollection", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IETagNameGetCollection", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf

	Local $oTemp
	If __IEIsObjType($oObject, "documentcontainer") Then
		$oTemp = _IEDocGetObj($oObject)
	Else
		$oTemp = $oObject
	EndIf

	$iIndex = Number($iIndex)
	Select
		Case $iIndex = -1
			Return SetError($_IESTATUS_Success, $oTemp.GetElementsByTagName($sTagName).length, _
					$oTemp.GetElementsByTagName($sTagName))
		Case $iIndex > -1 And $iIndex < $oTemp.GetElementsByTagName($sTagName).length
			Return SetError($_IESTATUS_Success, $oTemp.GetElementsByTagName($sTagName).length, _
					$oTemp.GetElementsByTagName($sTagName).item($iIndex))
		Case $iIndex < -1
			__IEConsoleWriteError("Error", "_IETagNameGetCollection", "$_IESTATUS_InvalidValue", "$iIndex < -1")
			Return SetError($_IESTATUS_InvalidValue, 3, 0)
		Case Else
			__IEConsoleWriteError("Error", "_IETagNameGetCollection", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 0, 0) ; Could be caused by parameter 2, 3 or both
	EndSelect
EndFunc   ;==>_IETagNameGetCollection

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IETagNameAllGetCollection(ByRef $oObject, $iIndex = -1)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IETagNameAllGetCollection", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IETagNameAllGetCollection", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf

	Local $oTemp
	If __IEIsObjType($oObject, "documentcontainer") Then
		$oTemp = _IEDocGetObj($oObject)
	Else
		$oTemp = $oObject
	EndIf

	$iIndex = Number($iIndex)
	Select
		Case $iIndex = -1
			Return SetError($_IESTATUS_Success, $oTemp.all.length, $oTemp.all)
		Case $iIndex > -1 And $iIndex < $oTemp.all.length
			Return SetError($_IESTATUS_Success, $oTemp.all.length, $oTemp.all.item($iIndex))
		Case $iIndex < -1
			__IEConsoleWriteError("Error", "_IETagNameAllGetCollection", "$_IESTATUS_InvalidValue", "$iIndex < -1")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
		Case Else
			__IEConsoleWriteError("Error", "_IETagNameAllGetCollection", "$_IESTATUS_NoMatch")
			Return SetError($_IESTATUS_NoMatch, 1, 0)
	EndSelect
EndFunc   ;==>_IETagNameAllGetCollection

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEGetObjByName(ByRef $oObject, $sName, $iIndex = 0)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEGetObjByName", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	$iIndex = Number($iIndex)
	If $iIndex = -1 Then
		Return SetError($_IESTATUS_Success, $oObject.document.GetElementsByName($sName).length, _
				$oObject.document.GetElementsByName($sName))
	Else
		If IsObj($oObject.document.GetElementsByName($sName).item($iIndex)) Then
			Return SetError($_IESTATUS_Success, $oObject.document.GetElementsByName($sName).length, _
					$oObject.document.GetElementsByName($sName).item($iIndex))
		Else
			__IEConsoleWriteError("Warning", "_IEGetObjByName", "$_IESTATUS_NoMatch", "Name: " & $sName & ", Index: " & $iIndex)
			Return SetError($_IESTATUS_NoMatch, 0, 0) ; Could be caused by parameter 2, 3 or both
		EndIf
	EndIf
EndFunc   ;==>_IEGetObjByName

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEGetObjById(ByRef $oObject, $sId)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEGetObjById", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IEGetObById", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	If IsObj($oObject.document.getElementById($sId)) Then
		Return SetError($_IESTATUS_Success, 0, $oObject.document.getElementById($sId))
	Else
		__IEConsoleWriteError("Warning", "_IEGetObjById", "$_IESTATUS_NoMatch", $sId)
		Return SetError($_IESTATUS_NoMatch, 2, 0)
	EndIf
EndFunc   ;==>_IEGetObjById

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEAction(ByRef $oObject, $sAction)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEAction(" & $sAction & ")", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	$sAction = StringLower($sAction)
	Select
		; DOM objects
		Case $sAction = "click"
			If __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(click)", " $_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Click()
		Case $sAction = "disable"
			If __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(disable)", " $_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.disabled = True
		Case $sAction = "enable"
			If __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(enable)", " $_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.disabled = False
		Case $sAction = "focus"
			If __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(focus)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Focus()
		Case $sAction = "scrollintoview"
			If __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(scrollintoview)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.scrollIntoView()
			; Browser Object
		Case $sAction = "copy"
			$oObject.document.execCommand("Copy")
		Case $sAction = "cut"
			$oObject.document.execCommand("Cut")
		Case $sAction = "paste"
			$oObject.document.execCommand("Paste")
		Case $sAction = "delete"
			$oObject.document.execCommand("Delete")
		Case $sAction = "saveas"
			$oObject.document.execCommand("SaveAs")
		Case $sAction = "refresh"
			$oObject.document.execCommand("Refresh")
			If @error Then ; Trap COM error, report and return
				__IEConsoleWriteError("Error", "_IEAction(refresh)", "$_IESTATUS_COMError", @error)
				Return SetError($_IESTATUS_ComError, @error, 0)
			EndIf
			_IELoadWait($oObject)
		Case $sAction = "selectall"
			$oObject.document.execCommand("SelectAll")
		Case $sAction = "unselect"
			$oObject.document.execCommand("Unselect")
		Case $sAction = "print"
			$oObject.document.parentwindow.Print()
		Case $sAction = "printdefault"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEAction(printdefault)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.execWB(6, 2)
		Case $sAction = "back"
			If Not __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(back)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.GoBack()
		Case $sAction = "blur"
			$oObject.Blur()
		Case $sAction = "forward"
			If Not __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(forward)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.GoForward()
		Case $sAction = "home"
			If Not __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(home)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.GoHome()
		Case $sAction = "invisible"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEAction(invisible)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.visible = 0
		Case $sAction = "visible"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEAction(visible)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.visible = 1
		Case $sAction = "search"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEAction(search)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.GoSearch()
		Case $sAction = "stop"
			If Not __IEIsObjType($oObject, "documentContainer") Then
				__IEConsoleWriteError("Error", "_IEAction(stop)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Stop()
		Case $sAction = "quit"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEAction(quit)", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Quit()
			If @error Then ; Trap COM error, report and return
				__IEConsoleWriteError("Error", "_IEAction(" & $sAction & ")", "$_IESTATUS_COMError", @error)
				Return SetError($_IESTATUS_ComError, @error, 0)
			EndIf
			$oObject = 0
			Return SetError($_IESTATUS_Success, 0, 1)
		Case Else
			; Unsupported Action
			__IEConsoleWriteError("Error", "_IEAction(" & $sAction & ")", "$_IESTATUS_InvalidValue", "Invalid Action")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
	EndSelect

	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEAction(" & $sAction & ")", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	Return SetError($_IESTATUS_Success, 0, 1)
EndFunc   ;==>_IEAction

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEPropertyGet(ByRef $oObject, $sProperty)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	If Not __IEIsObjType($oObject, "browserdom") Then
		__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	Local $oTemp, $iTemp
	$sProperty = StringLower($sProperty)
	Select
		Case $sProperty = "browserx"
			If __IEIsObjType($oObject, "browsercontainer") Or __IEIsObjType($oObject, "document") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oTemp = $oObject
			$iTemp = 0
			While IsObj($oTemp)
				$iTemp += $oTemp.offsetLeft
				$oTemp = $oTemp.offsetParent
			WEnd
			Return SetError($_IESTATUS_Success, 0, $iTemp)
		Case $sProperty = "browsery"
			If __IEIsObjType($oObject, "browsercontainer") Or __IEIsObjType($oObject, "document") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oTemp = $oObject
			$iTemp = 0
			While IsObj($oTemp)
				$iTemp += $oTemp.offsetTop
				$oTemp = $oTemp.offsetParent
			WEnd
			Return SetError($_IESTATUS_Success, 0, $iTemp)
		Case $sProperty = "screenx"
			If __IEIsObjType($oObject, "window") Or __IEIsObjType($oObject, "document") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			If __IEIsObjType($oObject, "browser") Then
				Return SetError($_IESTATUS_Success, 0, $oObject.left())
			Else
				$oTemp = $oObject
				$iTemp = 0
				While IsObj($oTemp)
					$iTemp += $oTemp.offsetLeft
					$oTemp = $oTemp.offsetParent
				WEnd
			EndIf
			Return SetError($_IESTATUS_Success, 0, _
					$iTemp + $oObject.document.parentWindow.screenLeft)
		Case $sProperty = "screeny"
			If __IEIsObjType($oObject, "window") Or __IEIsObjType($oObject, "document") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			If __IEIsObjType($oObject, "browser") Then
				Return SetError($_IESTATUS_Success, 0, $oObject.top())
			Else
				$oTemp = $oObject
				$iTemp = 0
				While IsObj($oTemp)
					$iTemp += $oTemp.offsetTop
					$oTemp = $oTemp.offsetParent
				WEnd
			EndIf
			Return SetError($_IESTATUS_Success, 0, _
					$iTemp + $oObject.document.parentWindow.screenTop)
		Case $sProperty = "height"
			If __IEIsObjType($oObject, "window") Or __IEIsObjType($oObject, "document") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			If __IEIsObjType($oObject, "browser") Then
				Return SetError($_IESTATUS_Success, 0, $oObject.Height())
			Else
				Return SetError($_IESTATUS_Success, 0, $oObject.offsetHeight)
			EndIf
		Case $sProperty = "width"
			If __IEIsObjType($oObject, "window") Or __IEIsObjType($oObject, "document") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			If __IEIsObjType($oObject, "browser") Then
				Return SetError($_IESTATUS_Success, 0, $oObject.Width())
			Else
				Return SetError($_IESTATUS_Success, 0, $oObject.offsetWidth)
			EndIf
		Case $sProperty = "isdisabled"
			Return SetError($_IESTATUS_Success, 0, $oObject.isDisabled())
		Case $sProperty = "addressbar"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.AddressBar())
		Case $sProperty = "busy"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.Busy())
		Case $sProperty = "fullscreen"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.fullScreen())
		Case $sProperty = "hwnd"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, HWnd($oObject.HWnd()))
		Case $sProperty = "left"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.Left())
		Case $sProperty = "locationname"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.LocationName())
		Case $sProperty = "locationurl"
			If __IEIsObjType($oObject, "browser") Then
				Return SetError($_IESTATUS_Success, 0, $oObject.locationURL())
			EndIf
			If __IEIsObjType($oObject, "window") Then
				Return SetError($_IESTATUS_Success, 0, $oObject.location.href())
			EndIf
			If __IEIsObjType($oObject, "document") Then
				Return SetError($_IESTATUS_Success, 0, $oObject.parentwindow.location.href())
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentwindow.location.href())
		Case $sProperty = "menubar"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.MenuBar())
		Case $sProperty = "offline"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.OffLine())
		Case $sProperty = "readystate"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.ReadyState())
		Case $sProperty = "resizable"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.Resizable())
		Case $sProperty = "silent"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.Silent())
		Case $sProperty = "statusbar"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.StatusBar())
		Case $sProperty = "statustext"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.StatusText())
		Case $sProperty = "top"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.Top())
		Case $sProperty = "visible"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.Visible())
		Case $sProperty = "appcodename"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.appCodeName())
		Case $sProperty = "appminorversion"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.appMinorVersion())
		Case $sProperty = "appname"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.appName())
		Case $sProperty = "appversion"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.appVersion())
		Case $sProperty = "browserlanguage"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.browserLanguage())
		Case $sProperty = "cookieenabled"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.cookieEnabled())
		Case $sProperty = "cpuclass"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.cpuClass())
		Case $sProperty = "javaenabled"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.javaEnabled())
		Case $sProperty = "online"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.onLine())
		Case $sProperty = "platform"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.platform())
		Case $sProperty = "systemlanguage"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.systemLanguage())
		Case $sProperty = "useragent"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.userAgent())
		Case $sProperty = "userlanguage"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.parentWindow.top.navigator.userLanguage())
		Case $sProperty = "referrer"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.referrer)
		Case $sProperty = "theatermode"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.TheaterMode)
		Case $sProperty = "toolbar"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oObject.ToolBar)
		Case $sProperty = "contenteditable"
			If __IEIsObjType($oObject, "browser") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oTemp.isContentEditable)
		Case $sProperty = "innertext"
			If __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oTemp.innerText)
		Case $sProperty = "outertext"
			If __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oTemp.outerText)
		Case $sProperty = "innerhtml"
			If __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oTemp.innerHTML)
		Case $sProperty = "outerhtml"
			If __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			Return SetError($_IESTATUS_Success, 0, $oTemp.outerHTML)
		Case $sProperty = "title"
			Return SetError($_IESTATUS_Success, 0, $oObject.document.title)
		Case $sProperty = "uniqueid"
			If __IEIsObjType($oObject, "window") Then
				__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			Else
				Return SetError($_IESTATUS_Success, 0, $oObject.uniqueID)
			EndIf
		Case Else
			; Unsupported Property
			__IEConsoleWriteError("Error", "_IEPropertyGet", "$_IESTATUS_InvalidValue", "Invalid Property")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
	EndSelect
EndFunc   ;==>_IEPropertyGet

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEPropertySet(ByRef $oObject, $sProperty, $sNewvalue)
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	Local $oTemp
	#forceref $oTemp
	$sProperty = StringLower($sProperty)
	Select
		Case $sProperty = "addressbar"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.AddressBar = $sNewvalue
		Case $sProperty = "height"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Height = $sNewvalue
		Case $sProperty = "left"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Left = $sNewvalue
		Case $sProperty = "menubar"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.MenuBar = $sNewvalue
		Case $sProperty = "offline"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.OffLine = $sNewvalue
		Case $sProperty = "resizable"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Resizable = $sNewvalue
		Case $sProperty = "statusbar"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.StatusBar = $sNewvalue
		Case $sProperty = "statustext"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.StatusText = $sNewvalue
		Case $sProperty = "top"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Top = $sNewvalue
		Case $sProperty = "width"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			$oObject.Width = $sNewvalue
		Case $sProperty = "theatermode"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			If $sNewvalue Then
				$oObject.TheaterMode = True
			Else
				$oObject.TheaterMode = False
			EndIf
		Case $sProperty = "toolbar"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			If $sNewvalue Then
				$oObject.ToolBar = True
			Else
				$oObject.ToolBar = False
			EndIf
		Case $sProperty = "contenteditable"
			If __IEIsObjType($oObject, "browser") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			If $sNewvalue Then
				$oTemp.contentEditable = "true"
			Else
				$oTemp.contentEditable = "false"
			EndIf
		Case $sProperty = "innertext"
			If __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			$oTemp.innerText = $sNewvalue
		Case $sProperty = "outertext"
			If __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			$oTemp.outerText = $sNewvalue
		Case $sProperty = "innerhtml"
			If __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			$oTemp.innerHTML = $sNewvalue
		Case $sProperty = "outerhtml"
			If __IEIsObjType($oObject, "documentcontainer") Or __IEIsObjType($oObject, "document") Then
				$oTemp = $oObject.document.body
			Else
				$oTemp = $oObject
			EndIf
			$oTemp.outerHTML = $sNewvalue
		Case $sProperty = "title"
			$oObject.document.title = $sNewvalue
		Case $sProperty = "silent"
			If Not __IEIsObjType($oObject, "browser") Then
				__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidObjectType")
				Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
			EndIf
			If $sNewvalue Then
				$oObject.silent = True
			Else
				$oObject.silent = False
			EndIf
		Case Else
			; Unsupported Property
			__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_InvalidValue", "Invalid Property")
			Return SetError($_IESTATUS_InvalidValue, 2, 0)
	EndSelect

	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEPropertySet", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	Return SetError($_IESTATUS_Success, 0, 0)
EndFunc   ;==>_IEPropertySet

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func _IEErrorNotify($vNotify = Default)
	If $vNotify = Default Then Return $__g_bIEErrorNotify

	If $vNotify Then
		$__g_bIEErrorNotify = True
	Else
		$__g_bIEErrorNotify = False
	EndIf
	Return 1
EndFunc   ;==>_IEErrorNotify

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IEQuit(ByRef $oObject)
;~ 	Local $sName_IEQuit = String(ObjName($oObject))
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "_IEQuit", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "browser") Then
		__IEConsoleWriteError("Error", "_IEQuit", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$oObject.quit()
	If @error Then ; Trap COM error, report and return
		__IEConsoleWriteError("Error", "_IEQuit", "$_IESTATUS_COMError", @error)
		Return SetError($_IESTATUS_ComError, @error, 0)
	EndIf
	$oObject = 0
	Return SetError($_IESTATUS_Success, 0, 1)
EndFunc   ;==>_IEQuit

#EndRegion Utility functions

#Region General
; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func _IE_Introduction($sModule = "basic")
	Local $sHtml = ""
	Switch $sModule
		Case "basic"
			$sHtml &= '<!DOCTYPE html>' & @CR
			$sHtml &= '<html>' & @CR
			$sHtml &= '<head>' & @CR
			$sHtml &= '<meta content="text/html; charset=UTF-8" http-equiv="content-type">' & @CR
			$sHtml &= '<title>_IE_Introduction ("basic")</title>' & @CR
			$sHtml &= '<style>body {font-family: Arial}' & @CR
			$sHtml &= 'td {padding:6px}</style>' & @CR
			$sHtml &= '</head>' & @CR
			$sHtml &= '<body>' & @CR
			$sHtml &= '<table border=1 id="table1" style="width:600px;border-spacing:6px;">' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<h1>Welcome to IE.au3</h1>' & @CR
			$sHtml &= 'IE.au3 is a UDF (User Defined Function) library for the ' & @CR
			$sHtml &= '<a href="http://www.autoitscript.com">AutoIt</a> scripting language.' & @CR
			$sHtml &= '<br>  ' & @CR
			$sHtml &= 'IE.au3 allows you to either create or attach to an Internet Explorer browser and do ' & @CR
			$sHtml &= 'just about anything you could do with it interactively with the mouse and ' & @CR
			$sHtml &= 'keyboard, but do it through script.' & @CR
			$sHtml &= '<br>' & @CR
			$sHtml &= 'You can navigate to pages, click links, fill and submit forms etc. You can ' & @CR
			$sHtml &= 'also do things you cannot do interactively like change or rewrite page ' & @CR
			$sHtml &= 'content and JavaScripts, read, parse and save page content and monitor and act ' & @CR
			$sHtml &= 'upon browser "events".<br>' & @CR
			$sHtml &= 'IE.au3 uses the COM interface in AutoIt to interact with the Internet Explorer ' & @CR
			$sHtml &= 'object model and the DOM (Document Object Model) supported by the browser.' & @CR
			$sHtml &= '<br>' & @CR
			$sHtml &= 'Here are some links for more information and helpful tools:<br>' & @CR
			$sHtml &= 'Reference Material: ' & @CR
			$sHtml &= '<ul>' & @CR
			$sHtml &= '<li><a href="http://msdn1.microsoft.com/">MSDN (Microsoft Developer Network)</a></li>' & @CR
			$sHtml &= '<li><a href="http://msdn2.microsoft.com/en-us/library/aa752084.aspx" target="_blank">InternetExplorer Object</a></li>' & @CR
			$sHtml &= '<li><a href="http://msdn2.microsoft.com/en-us/library/ms531073.aspx" target="_blank">Document Object</a></li>' & @CR
			$sHtml &= '<li><a href="http://msdn2.microsoft.com/en-us/ie/aa740473.aspx" target="_blank">Overviews and Tutorials</a></li>' & @CR
			$sHtml &= '<li><a href="http://msdn2.microsoft.com/en-us/library/ms533029.aspx" target="_blank">DHTML Objects</a></li>' & @CR
			$sHtml &= '<li><a href="http://msdn2.microsoft.com/en-us/library/ms533051.aspx" target="_blank">DHTML Events</a></li>' & @CR
			$sHtml &= '</ul><br>' & @CR
			$sHtml &= 'Helpful Tools: ' & @CR
			$sHtml &= '<ul>' & @CR
			$sHtml &= '<li><a href="http://www.autoitscript.com/forum/index.php?showtopic=19368" target="_blank">AutoIt IE Builder</a> (build IE scripts interactively)</li>' & @CR
			$sHtml &= '<li><a href="http://www.debugbar.com/" target="_blank">DebugBar</a> (DOM inspector, HTTP inspector, HTML validator and more - free for personal use) Recommended</li>' & @CR
			$sHtml &= '<li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=e59c3964-672d-4511-bb3e-2d5e1db91038&amp;displaylang=en" target="_blank">IE Developer Toolbar</a> (comprehensive DOM analysis tool)</li>' & @CR
			$sHtml &= '<li><a href="http://slayeroffice.com/tools/modi/v2.0/modi_help.html" target="_blank">MODIV2</a> (view the DOM of a web page by mousing around)</li>' & @CR
			$sHtml &= '<li><a href="http://validator.w3.org/" target="_blank">HTML Validator</a> (verify HTML follows format rules)</li>' & @CR
			$sHtml &= '<li><a href="http://www.fiddlertool.com/fiddler/" target="_blank">Fiddler</a> (examine HTTP traffic)</li>' & @CR
			$sHtml &= '</ul>' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '</table>' & @CR
			$sHtml &= '</body>' & @CR
			$sHtml &= '</html>'
		Case Else
			__IEConsoleWriteError("Error", "_IE_Introduction", "$_IESTATUS_InvalidValue")
			Return SetError($_IESTATUS_InvalidValue, 1, 0)
	EndSwitch
	Local $oObject = _IECreate()
	_IEDocWriteHTML($oObject, $sHtml)
	Return SetError($_IESTATUS_Success, 0, $oObject)
EndFunc   ;==>_IE_Introduction

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func _IE_Example($sModule = "basic")
	Local $sHtml = "", $oObject
	Switch $sModule
		Case "basic"
			$sHtml &= '<!DOCTYPE html>' & @CR
			$sHtml &= '<html>' & @CR
			$sHtml &= '<head>' & @CR
			$sHtml &= '<meta content="text/html; charset=UTF-8" http-equiv="content-type">' & @CR
			$sHtml &= '<title>_IE_Example("basic")</title>' & @CR
			$sHtml &= '<style>body {font-family: Arial}</style>' & @CR
			$sHtml &= '</head>' & @CR
			$sHtml &= '<body>' & @CR
			$sHtml &= '<a href="http://www.autoitscript.com"><img src="http://www.autoitscript.com/images/autoit_6_240x100.jpg" id="AutoItImage" alt="AutoIt Homepage Image"></a>' & @CR
			$sHtml &= '<p></p>' & @CR
			$sHtml &= '<div id="line1">This is a simple HTML page with text, links and images.</div>' & @CR
			$sHtml &= '<br>' & @CR
			$sHtml &= '<div id="line2"><a href="http://www.autoitscript.com">AutoIt</a> is a wonderful automation scripting language.</div>' & @CR
			$sHtml &= '<br>' & @CR
			$sHtml &= '<div id="line3">It is supported by a very active and supporting <a href="http://www.autoitscript.com/forum/">user forum</a>.</div>' & @CR
			$sHtml &= '<br>' & @CR
			$sHtml &= '<div id="IEAu3Data"></div>' & @CR
			$sHtml &= '</body>' & @CR
			$sHtml &= '</html>'
			$oObject = _IECreate()
			_IEDocWriteHTML($oObject, $sHtml)
		Case "table"
			$sHtml &= '<!DOCTYPE html>' & @CR
			$sHtml &= '<html>' & @CR
			$sHtml &= '<head>' & @CR
			$sHtml &= '<meta content="text/html; charset=utf-8" http-equiv="content-type">' & @CR
			$sHtml &= '<title>_IE_Example("table")</title>' & @CR
			$sHtml &= '<style>body {font-family: Arial}</style>' & @CR
			$sHtml &= '</head>' & @CR
			$sHtml &= '<body>' & @CR
			$sHtml &= '$oTableOne = _IETableGetObjByName($oIE, "tableOne")<br>' & @CR
			$sHtml &= '&lt;table border=1 id="tableOne"&gt;<br>' & @CR
			$sHtml &= '<table border=1 id="tableOne">' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>AutoIt</td>' & @CR
			$sHtml &= '		<td>is</td>' & @CR
			$sHtml &= '		<td>really</td>' & @CR
			$sHtml &= '		<td>great</td>' & @CR
			$sHtml &= '		<td>with</td>' & @CR
			$sHtml &= '		<td>IE.au3</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>1</td>' & @CR
			$sHtml &= '		<td>2</td>' & @CR
			$sHtml &= '		<td>3</td>' & @CR
			$sHtml &= '		<td>4</td>' & @CR
			$sHtml &= '		<td>5</td>' & @CR
			$sHtml &= '		<td>6</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>the</td>' & @CR
			$sHtml &= '		<td>quick</td>' & @CR
			$sHtml &= '		<td>red</td>' & @CR
			$sHtml &= '		<td>fox</td>' & @CR
			$sHtml &= '		<td>jumped</td>' & @CR
			$sHtml &= '		<td>over</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>the</td>' & @CR
			$sHtml &= '		<td>lazy</td>' & @CR
			$sHtml &= '		<td>brown</td>' & @CR
			$sHtml &= '		<td>dog</td>' & @CR
			$sHtml &= '		<td>the</td>' & @CR
			$sHtml &= '		<td>time</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>has</td>' & @CR
			$sHtml &= '		<td>come</td>' & @CR
			$sHtml &= '		<td>for</td>' & @CR
			$sHtml &= '		<td>all</td>' & @CR
			$sHtml &= '		<td>good</td>' & @CR
			$sHtml &= '		<td>men</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>to</td>' & @CR
			$sHtml &= '		<td>come</td>' & @CR
			$sHtml &= '		<td>to</td>' & @CR
			$sHtml &= '		<td>the</td>' & @CR
			$sHtml &= '		<td>aid</td>' & @CR
			$sHtml &= '		<td>of</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '</table>' & @CR
			$sHtml &= '<br>' & @CR
			$sHtml &= '$oTableTwo = _IETableGetObjByName($oIE, "tableTwo")<br>' & @CR
			$sHtml &= '&lt;table border="1" id="tableTwo"&gt;<br>' & @CR
			$sHtml &= '<table border=1 id="tableTwo">' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td colspan="4">Table Top</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>One</td>' & @CR
			$sHtml &= '		<td colspan="3">Two</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>Three</td>' & @CR
			$sHtml &= '		<td>Four</td>' & @CR
			$sHtml &= '		<td colspan="2">Five</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>Six</td>' & @CR
			$sHtml &= '		<td colspan="3">Seven</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '	<tr>' & @CR
			$sHtml &= '		<td>Eight</td>' & @CR
			$sHtml &= '		<td>Nine</td>' & @CR
			$sHtml &= '		<td>Ten</td>' & @CR
			$sHtml &= '		<td>Eleven</td>' & @CR
			$sHtml &= '	</tr>' & @CR
			$sHtml &= '</table>' & @CR
			$sHtml &= '</body>' & @CR
			$sHtml &= '</html>'
			$oObject = _IECreate()
			_IEDocWriteHTML($oObject, $sHtml)
		Case "form"
			$sHtml &= '<!DOCTYPE html>' & @CR
			$sHtml &= '<html>' & @CR
			$sHtml &= '<head>' & @CR
			$sHtml &= '<meta content="text/html; charset=UTF-8" http-equiv="content-type">' & @CR
			$sHtml &= '<title>_IE_Example("form")</title>' & @CR
			$sHtml &= '<style>body {font-family: Arial}' & @CR
			$sHtml &= 'td {padding:6px}</style>' & @CR
			$sHtml &= '</head>' & @CR
			$sHtml &= '<body>' & @CR
			$sHtml &= '<form name="ExampleForm" onSubmit="javascript:alert(''ExampleFormSubmitted'');" method="post">' & @CR
			$sHtml &= '<table style="border-spacing:6px 6px;" border=1>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>ExampleForm</td>' & @CR
			$sHtml &= '<td>&lt;form name="ExampleForm" onSubmit="javascript:alert(''ExampleFormSubmitted'');" method="post"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>Hidden Input Element<input type="hidden" name="hiddenExample" value="secret value"></td>' & @CR
			$sHtml &= '<td>&lt;input type="hidden" name="hiddenExample" value="secret value"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<input type="text" name="textExample" value="http://" size="20" maxlength="30">' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;input type="text" name="textExample" value="http://" size="20" maxlength="30"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<input type="password" name="passwordExample" size="10">' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;input type="password" name="passwordExample" size="10"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<input type="file" name="fileExample">' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;input type="file" name="fileExample"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<input type="image" name="imageExample" alt="AutoIt Homepage" src="http://www.autoitscript.com/images/autoit_6_240x100.jpg">' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;input type="image" name="imageExample" alt="AutoIt Homepage" src="http://www.autoitscript.com/images/autoit_6_240x100.jpg"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<textarea name="textareaExample" rows="5" cols="15">Hello!</textarea>' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;textarea name="textareaExample" rows="5" cols="15"&gt;Hello!&lt;/textarea&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<input type="checkbox" name="checkboxG1Example" value="gameBasketball">Basketball<br>' & @CR
			$sHtml &= '<input type="checkbox" name="checkboxG1Example" value="gameFootball">Football<br>' & @CR
			$sHtml &= '<input type="checkbox" name="checkboxG2Example" value="gameTennis" checked>Tennis<br>' & @CR
			$sHtml &= '<input type="checkbox" name="checkboxG2Example" value="gameBaseball">Baseball' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;input type="checkbox" name="checkboxG1Example" value="gameBasketball"&gt;Basketball&lt;br&gt;<br>' & @CR
			$sHtml &= '&lt;input type="checkbox" name="checkboxG1Example" value="gameFootball"&gt;Football&lt;br&gt;<br>' & @CR
			$sHtml &= '&lt;input type="checkbox" name="checkboxG2Example" value="gameTennis" checked&gt;Tennis&lt;br&gt;<br>' & @CR
			$sHtml &= '&lt;input type="checkbox" name="checkboxG2Example" value="gameBaseball"&gt;Baseball</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<input type="radio" name="radioExample" value="vehicleAirplane">Airplane<br>' & @CR
			$sHtml &= '<input type="radio" name="radioExample" value="vehicleTrain" checked>Train<br>' & @CR
			$sHtml &= '<input type="radio" name="radioExample" value="vehicleBoat">Boat<br>' & @CR
			$sHtml &= '<input type="radio" name="radioExample" value="vehicleCar">Car</td>' & @CR
			$sHtml &= '<td>&lt;input type="radio" name="radioExample" value="vehicleAirplane"&gt;Airplane&lt;br&gt;<br>' & @CR
			$sHtml &= '&lt;input type="radio" name="radioExample" value="vehicleTrain" checked&gt;Train&lt;br&gt;<br>' & @CR
			$sHtml &= '&lt;input type="radio" name="radioExample" value="vehicleBoat"&gt;Boat&lt;br&gt;<br>' & @CR
			$sHtml &= '&lt;input type="radio" name="radioExample" value="vehicleCar"&gt;Car&lt;br&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<select name="selectExample">' & @CR
			$sHtml &= '<option value="homepage.html">Homepage' & @CR
			$sHtml &= '<option value="midipage.html">Midipage' & @CR
			$sHtml &= '<option value="freepage.html">Freepage' & @CR
			$sHtml &= '</select>' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;select name="selectExample"&gt;<br>' & @CR
			$sHtml &= '&lt;option value="homepage.html"&gt;Homepage<br>' & @CR
			$sHtml &= '&lt;option value="midipage.html"&gt;Midipage<br>' & @CR
			$sHtml &= '&lt;option value="freepage.html"&gt;Freepage<br>' & @CR
			$sHtml &= '&lt;/select&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<select name="multipleSelectExample" size="6" multiple>' & @CR
			$sHtml &= '<option value="Name1">Aaron' & @CR
			$sHtml &= '<option value="Name2">Bruce' & @CR
			$sHtml &= '<option value="Name3">Carlos' & @CR
			$sHtml &= '<option value="Name4">Denis' & @CR
			$sHtml &= '<option value="Name5">Ed' & @CR
			$sHtml &= '<option value="Name6">Freddy' & @CR
			$sHtml &= '</select>' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;select name="multipleSelectExample" size="6" multiple&gt;<br>' & @CR
			$sHtml &= '&lt;option value="Name1"&gt;Aaron<br>' & @CR
			$sHtml &= '&lt;option value="Name2"&gt;Bruce<br>' & @CR
			$sHtml &= '&lt;option value="Name3"&gt;Carlos<br>' & @CR
			$sHtml &= '&lt;option value="Name4"&gt;Denis<br>' & @CR
			$sHtml &= '&lt;option value="Name5"&gt;Ed<br>' & @CR
			$sHtml &= '&lt;option value="Name6"&gt;Freddy<br>' & @CR
			$sHtml &= '&lt;/select&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td>' & @CR
			$sHtml &= '<input name="submitExample" type="submit" value="Submit">' & @CR
			$sHtml &= '<input name="resetExample" type="reset" value="Reset">' & @CR
			$sHtml &= '</td>' & @CR
			$sHtml &= '<td>&lt;input name="submitExample" type="submit" value="Submit"&gt;<br>' & @CR
			$sHtml &= '&lt;input name="resetExample" type="reset" value="Reset"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '</table>' & @CR
			$sHtml &= '<input type="hidden" name="hiddenExample" value="secret value">' & @CR
			$sHtml &= '</form>' & @CR
			$sHtml &= '</body>' & @CR
			$sHtml &= '</html>'
			$oObject = _IECreate()
			_IEDocWriteHTML($oObject, $sHtml)
		Case "frameset"
			$sHtml &= '<!DOCTYPE html>' & @CR
			$sHtml &= '<html>' & @CR
			$sHtml &= '<head>' & @CR
			$sHtml &= '<meta content="text/html; charset=UTF-8" http-equiv="content-type">' & @CR
			$sHtml &= '<title>_IE_Example("frameset")</title>' & @CR
			$sHtml &= '</head>' & @CR
			$sHtml &= '<frameset rows="25,200">' & @CR
			$sHtml &= '	<frame name=Top SRC=about:blank>' & @CR
			$sHtml &= '	<frameset cols="100,500">' & @CR
			$sHtml &= '		<frame name=Menu SRC=about:blank>' & @CR
			$sHtml &= '		<frame name=Main SRC=about:blank>' & @CR
			$sHtml &= '	</frameset>' & @CR
			$sHtml &= '</frameset>' & @CR
			$sHtml &= '</html>'
			$oObject = _IECreate()
			_IEDocWriteHTML($oObject, $sHtml)
			_IEAction($oObject, "refresh")
			Local $oFrameTop = _IEFrameGetObjByName($oObject, "Top")
			Local $oFrameMenu = _IEFrameGetObjByName($oObject, "Menu")
			Local $oFrameMain = _IEFrameGetObjByName($oObject, "Main")
			_IEBodyWriteHTML($oFrameTop, '$oFrameTop = _IEFrameGetObjByName($oIE, "Top")')
			_IEBodyWriteHTML($oFrameMenu, '$oFrameMenu = _IEFrameGetObjByName($oIE, "Menu")')
			_IEBodyWriteHTML($oFrameMain, '$oFrameMain = _IEFrameGetObjByName($oIE, "Main")')
		Case "iframe"
			$sHtml &= '<!DOCTYPE html>' & @CR
			$sHtml &= '<html>' & @CR
			$sHtml &= '<head>' & @CR
			$sHtml &= '<meta content="text/html; charset=UTF-8" http-equiv="content-type">' & @CR
			$sHtml &= '<title>_IE_Example("iframe")</title>' & @CR
			$sHtml &= '<style>td {padding:6px}</style>' & @CR
			$sHtml &= '</head>' & @CR
			$sHtml &= '<body>' & @CR
			$sHtml &= '<table style="border-spacing:6px" border=1>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td><iframe name="iFrameOne" src="about:blank" title="iFrameOne"></iframe></td>' & @CR
			$sHtml &= '<td>&lt;iframe name="iFrameOne" src="about:blank" title="iFrameOne"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '<tr>' & @CR
			$sHtml &= '<td><iframe name="iFrameTwo" src="about:blank" title="iFrameTwo"></iframe></td>' & @CR
			$sHtml &= '<td>&lt;iframe name="iFrameTwo" src="about:blank" title="iFrameTwo"&gt;</td>' & @CR
			$sHtml &= '</tr>' & @CR
			$sHtml &= '</table>' & @CR
			$sHtml &= '</body>' & @CR
			$sHtml &= '</html>'
			$oObject = _IECreate()
			_IEDocWriteHTML($oObject, $sHtml)
			_IEAction($oObject, "refresh")
			Local $oIFrameOne = _IEFrameGetObjByName($oObject, "iFrameOne")
			Local $oIFrameTwo = _IEFrameGetObjByName($oObject, "iFrameTwo")
			_IEBodyWriteHTML($oIFrameOne, '$oIFrameOne = _IEFrameGetObjByName($oIE, "iFrameOne")')
			_IEBodyWriteHTML($oIFrameTwo, '$oIFrameTwo = _IEFrameGetObjByName($oIE, "iFrameTwo")')
		Case Else
			__IEConsoleWriteError("Error", "_IE_Example", "$_IESTATUS_InvalidValue")
			Return SetError($_IESTATUS_InvalidValue, 1, 0)
	EndSwitch

	;	at least under IE10 some delay is needed to have functions as _IEPropertySet() working
	;	value can depend of processor speed ...
	Sleep(500)
	Return SetError($_IESTATUS_Success, 0, $oObject)
EndFunc   ;==>_IE_Example

; #FUNCTION# ====================================================================================================================
; Author ........: Dale Hohm
; ===============================================================================================================================
Func _IE_VersionInfo()
	__IEConsoleWriteError("Information", "_IE_VersionInfo", "version " & _
			$__gaIEAU3VersionInfo[0] & _
			$__gaIEAU3VersionInfo[1] & "." & _
			$__gaIEAU3VersionInfo[2] & "-" & _
			$__gaIEAU3VersionInfo[3], "Release date: " & $__gaIEAU3VersionInfo[4])
	Return SetError($_IESTATUS_Success, 0, $__gaIEAU3VersionInfo)
EndFunc   ;==>_IE_VersionInfo

#EndRegion General

#Region Internal functions
;
; Internal Functions with names starting with two underscores will not be documented
; as user functions
;
; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IELockSetForegroundWindow
; Description ...: Locks (and Unlocks) current Foregrouns Window focus to prevent a new window
; 					from stealing it (e.g. when creating invisible IE browser)
; Parameters ....: $iLockCode	- 1 Lock Foreground Window Focus, 2 Unlock Foreground Window Focus
; Return values .: On Success 	- 1
;                   On Failure 	- 0  and sets @error and @extended to non-zero values
; Author ........: Valik
; ===============================================================================================================================
Func __IELockSetForegroundWindow($iLockCode)
	Local $aRet = DllCall("user32.dll", "bool", "LockSetForegroundWindow", "uint", $iLockCode)
	If @error Or Not $aRet[0] Then Return SetError(1, _WinAPI_GetLastError(), 0)
	Return $aRet[0]
EndFunc   ;==>__IELockSetForegroundWindow

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IEControlGetObjFromHWND
; Description ...: Returns a COM Object Window reference to an embebedded Webbrowser control
; Parameters ....: $hWin		- HWND of a Internet Explorer_Server1 control obtained for example:
; 					$hwnd = ControlGetHandle("MyApp","","Internet Explorer_Server1")
; Return values .: On Success 	- Returns DOM Window object
;                   On Failure 	- 0  and sets @error = 1
; Author ........: Larry with thanks to Valik
; Remarks .......:
; ===============================================================================================================================
Func __IEControlGetObjFromHWND(ByRef $hWin)
	; The code assumes CoInitialize() succeeded due to the number of different
	; yet successful return values it has.
	DllCall("ole32.dll", "long", "CoInitialize", "ptr", 0)
	If @error Then Return SetError(2, @error, 0)

	Local Const $WM_HTML_GETOBJECT = __IERegisterWindowMessage("WM_HTML_GETOBJECT")
	Local Const $SMTO_ABORTIFHUNG = 0x0002
	Local $iResult

	__IESendMessageTimeout($hWin, $WM_HTML_GETOBJECT, 0, 0, $SMTO_ABORTIFHUNG, 1000, $iResult)

	Local $tUUID = DllStructCreate("int;short;short;byte[8]")
	DllStructSetData($tUUID, 1, 0x626FC520)
	DllStructSetData($tUUID, 2, 0xA41E)
	DllStructSetData($tUUID, 3, 0x11CF)
	DllStructSetData($tUUID, 4, 0xA7, 1)
	DllStructSetData($tUUID, 4, 0x31, 2)
	DllStructSetData($tUUID, 4, 0x0, 3)
	DllStructSetData($tUUID, 4, 0xA0, 4)
	DllStructSetData($tUUID, 4, 0xC9, 5)
	DllStructSetData($tUUID, 4, 0x8, 6)
	DllStructSetData($tUUID, 4, 0x26, 7)
	DllStructSetData($tUUID, 4, 0x37, 8)

	Local $aRet = DllCall("oleacc.dll", "long", "ObjectFromLresult", "lresult", $iResult, "struct*", $tUUID, _
			"wparam", 0, "idispatch*", 0)
	If @error Then Return SetError(3, @error, 0)

	If IsObj($aRet[4]) Then
		Local $oIE = $aRet[4].Script()
		; $oIE is now a valid IDispatch object
		Return $oIE.Document.parentwindow
	Else
		Return SetError(1, $aRet[0], 0)
	EndIf
EndFunc   ;==>__IEControlGetObjFromHWND

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IERegisterWindowMessage
; Description ...: Required by __IEControlGetObjFromHWND()
; Author ........: Larry with thanks to Valik
; ===============================================================================================================================
Func __IERegisterWindowMessage($sMsg)
	Local $aRet = DllCall("user32.dll", "uint", "RegisterWindowMessageW", "wstr", $sMsg)
	If @error Then Return SetError(@error, @extended, 0)
	If $aRet[0] = 0 Then Return SetError(10, _WinAPI_GetLastError(), 0)
	Return $aRet[0]
EndFunc   ;==>__IERegisterWindowMessage

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IESendMessageTimeout
; Description ...: Required by __IEControlGetObjFromHWND()
; Author ........: Larry with thanks to Valik
; ===============================================================================================================================
Func __IESendMessageTimeout($hWnd, $iMsg, $wParam, $lParam, $iFlags, $iTimeout, ByRef $vOut, $r = 0, $sT1 = "int", $sT2 = "int")
	Local $aRet = DllCall("user32.dll", "lresult", "SendMessageTimeout", "hwnd", $hWnd, "uint", $iMsg, $sT1, $wParam, _
			$sT2, $lParam, "uint", $iFlags, "uint", $iTimeout, "dword_ptr*", "")
	If @error Or $aRet[0] = 0 Then
		$vOut = 0
		Return SetError(1, _WinAPI_GetLastError(), 0)
	EndIf
	$vOut = $aRet[7]
	If $r >= 0 And $r <= 4 Then Return $aRet[$r]
	Return $aRet
EndFunc   ;==>__IESendMessageTimeout

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IEIsObjType
; Description ...: Check to see if an object variable is of a specific type
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func __IEIsObjType(ByRef $oObject, $sType)
;~ 	Local $Name_IEIsObjType = String(ObjName($oObject))
	If Not IsObj($oObject) Then
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf

	; Turn off error notification for internal processing
	Local $iNotifyStatus = _IEErrorNotify() ; save current error notify status
	_IEErrorNotify(False)
	;
	Local $sName = String(ObjName($oObject)), $iErrorStatus = $_IESTATUS_InvalidObjectType

	Switch $sType
		Case "browserdom"
			If __IEIsObjType($oObject, "documentcontainer") Then
				$iErrorStatus = $_IESTATUS_Success
			ElseIf __IEIsObjType($oObject, "document") Then
				$iErrorStatus = $_IESTATUS_Success
			Else
				Local $oTemp = $oObject.document
				If __IEIsObjType($oTemp, "document") Then
					$iErrorStatus = $_IESTATUS_Success
				EndIf
			EndIf
		Case "browser"
			If ($sName = "IWebBrowser2") Or ($sName = "IWebBrowser") Or ($sName = "WebBrowser") Then $iErrorStatus = $_IESTATUS_Success
		Case "window"
			If $sName = "HTMLWindow2" Then $iErrorStatus = $_IESTATUS_Success
		Case "documentContainer"
			If __IEIsObjType($oObject, "window") Or __IEIsObjType($oObject, "browser") Then $iErrorStatus = $_IESTATUS_Success
		Case "document"
			If $sName = "HTMLDocument" Then $iErrorStatus = $_IESTATUS_Success
		Case "table"
			If $sName = "HTMLTable" Then $iErrorStatus = $_IESTATUS_Success
		Case "form"
			If $sName = "HTMLFormElement" Then $iErrorStatus = $_IESTATUS_Success
		Case "forminputelement"
			If ($sName = "HTMLInputElement") Or ($sName = "HTMLSelectElement") Or ($sName = "HTMLTextAreaElement") Then $iErrorStatus = $_IESTATUS_Success
		Case "elementcollection"
			If ($sName = "HTMLElementCollection") Then $iErrorStatus = $_IESTATUS_Success
		Case "formselectelement"
			If $sName = "HTMLSelectElement" Then $iErrorStatus = $_IESTATUS_Success
		Case Else
			; Unsupported ObjType specified
			$iErrorStatus = $_IESTATUS_InvalidValue
	EndSwitch

	; restore error notify
	_IEErrorNotify($iNotifyStatus) ; restore notification status

	If $iErrorStatus = $_IESTATUS_Success Then
		Return SetError($_IESTATUS_Success, 0, 1)
	Else
		Return SetError($iErrorStatus, 1, 0)
	EndIf
EndFunc   ;==>__IEIsObjType

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IEConsoleWriteError
; Description ...: ConsoleWrite an error message if required
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func __IEConsoleWriteError($sSeverity, $sFunc, $sMessage = Default, $sStatus = Default)
	If $__g_bIEErrorNotify Or $__g_bIEAU3Debug Then
		Local $sStr = "--> IE.au3 " & $__gaIEAU3VersionInfo[5] & " " & $sSeverity & " from function " & $sFunc
		If Not ($sMessage = Default) Then $sStr &= ", " & $sMessage
		If Not ($sStatus = Default) Then $sStr &= " (" & $sStatus & ")"
		ConsoleWrite($sStr & @CRLF)
	EndIf
	Return SetError($sStatus, 0, 1) ; restore calling @error
EndFunc   ;==>__IEConsoleWriteError

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IEComErrorUnrecoverable
; Description ...: Internal function to test a COM error condition and determine if it is considered unrecoverable
; Parameters ....: Error number
; Return values .: Unrecoverable: True, Else: False
; Author ........: Dale Hohm
; Modified ......: jpm
; ===============================================================================================================================
Func __IEComErrorUnrecoverable($iError)
	Switch $iError
		; Cross-domain scripting security error
		Case -2147352567 ; "an exception has occurred."
			Return $_IESTATUS_AccessIsDenied
		Case -2147024891 ; "Access is denied."
			Return $_IESTATUS_AccessIsDenied
			;
			; Browser object is destroyed before we try to operate upon it
		Case -2147417848 ; "The object invoked has disconnected from its clients."
			Return $_IESTATUS_ClientDisconnected
		Case -2147023174 ; "RPC server not accessible."
			Return $_IESTATUS_ClientDisconnected
		Case -2147023179 ; "The interface is unknown."
			Return $_IESTATUS_ClientDisconnected
			;
		Case Else
			Return $_IESTATUS_Success
	EndSwitch
EndFunc   ;==>__IEComErrorUnrecoverable

#EndRegion Internal functions

#Region ProtoType Functions
; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IENavigate
; Description ...: ** Unsupported version of _IENavigate (note second underscore in function name)
; 					** Last 4 parameters insufficiently tested.
; 					**    - Flags and Target can create new windows and new browser object - causing confusion
; 					**    - Postdata needs SAFEARRAY and we have no way to create one
; 					Directs an existing browser window to navigate to the specified URL
; Parameters ....: $oObject 		- Object variable of an InternetExplorer.Application, Window or Frame object
; 				   $sUrl 			- URL to navigate to (e.g. "http://www.autoitscript.com")
; 				   $iWait 		- Optional: specifies whether to wait for page to load before returning
; 										0 = Return immediately, not waiting for page to load
; 										1 = (Default) Wait for page load to complete before returning
; 				   $iFags		- URL to navigate to (e.g. "http://www.autoitscript.com")
; 				   $sTarget	- target frame
; 				   $spostdata	- data for form method="POST", non-functional - requires safearray
; 				   $sHeaders	- additional headers to be passed
; Return values .: On Success 	- Returns -1
;                  On Failure	- Returns 0 and sets @error
; 					@error		- 1 ($_IESTATUS_GeneralError) = General Error
; 								- 3 ($_IESTATUS_InvalidDataType) = Invalid Data Type
; 								- 4 ($_IESTATUS_InvalidObjectType) = Invalid Object Type
; 								- 6 ($_IESTATUS_LoadWaitTimeout) = Load Wait Timeout
; 								- 8 ($_IESTATUS_AccessIsDenied) = Access Is Denied
; 								- 9 ($_IESTATUS_ClientDisconnected) = Client Disconnected
; 					@extended	- Contains invalid parameter number
; Author ........: Dale Hohm
; Remarks .......:  AutoIt3 V3.2 or higher, flags for Tabs require IE7 or higher
; 					Additional information on the navigate2 method here: http://msdn.microsoft.com/en-us/library/aa752134.aspx
;
; Flags:
;    navOpenInNewWindow = 0x1,
;    navNoHistory = 0x2,
;    navNoReadFromCache = 0x4,
;    navNoWriteToCache = 0x8,
;    navAllowAutosearch = 0x10,
;    navBrowserBar = 0x20,
;    navHyperlink = 0x40,
;    navEnforceRestricted = 0x80,
;    navNewWindowsManaged = 0x0100,
;    navUntrustedForDownload = 0x0200,
;    navTrustedForActiveX = 0x0400,
;    navOpenInNewTab = 0x0800,
;    navOpenInBackgroundTab = 0x1000,
;    navKeepWordWheelText = 0x2000
;
; Additional documentation on the flags can be found here:
;    http://msdn.microsoft.com/en-us/library/aa768360.aspx
; ===============================================================================================================================
Func __IENavigate(ByRef $oObject, $sUrl, $iWait = 1, $iFags = 0, $sTarget = "", $sPostdata = "", $sHeaders = "")
	__IEConsoleWriteError("Warning", "__IENavigate", "Unsupported function called. Not fully tested.")
	If Not IsObj($oObject) Then
		__IEConsoleWriteError("Error", "__IENavigate", "$_IESTATUS_InvalidDataType")
		Return SetError($_IESTATUS_InvalidDataType, 1, 0)
	EndIf
	;
	If Not __IEIsObjType($oObject, "documentContainer") Then
		__IEConsoleWriteError("Error", "__IENavigate", "$_IESTATUS_InvalidObjectType")
		Return SetError($_IESTATUS_InvalidObjectType, 1, 0)
	EndIf
	;
	$oObject.navigate($sUrl, $iFags, $sTarget, $sPostdata, $sHeaders)
	If $iWait Then
		_IELoadWait($oObject)
		Return SetError(@error, 0, $oObject)
	EndIf
	Return SetError($_IESTATUS_Success, 0, $oObject)
EndFunc   ;==>__IENavigate

#cs
	#include <IE.au3>
	; Simulates the submission of the form from the page:
	;
	;    http://www.autoitscript.com/forum/index.php?act=Search
	;
	; searches for the string safearray and returns the results as posts

	$sFormAction = "http://www.autoitscript.com/forum/index.php?act=Search&CODE=01"
	$sHeader = "Content-Type: application/x-www-form-urlencoded"

	$sDataToPost = "keywords=safearray&namesearch=&forums%5B%5D=all&searchsubs=1&prune=0&prune_type=newer&sort_key=last_post&sort_order=desc&search_in=posts&result_type=posts"
	$oDataToPostBstr = __IEStringToBstr($sDataToPost) ; convert string to BSTR
	ConsoleWrite(__IEBstrToString($oDataToPostBstr) & @CRLF) ; prove we can convert it back to a string

	$oIE = _IECreate()
	$oIE.Navigate( $sFormAction, Default, Default, $oDataToPostBstr, $sHeader)
	; or
	;__IENavigate($oIE, $sFormAction, 1, 0, "", $oDataToPostBstr, $sHeader)
#ce

Func __IEStringToBstr($sString, $sCharSet = "us-ascii")
	Local Const $iTypeBinary = 1, $iTypeText = 2

	Local $oStream = ObjCreate("ADODB.Stream")

	$oStream.type = $iTypeText
	$oStream.CharSet = $sCharSet
	$oStream.Open
	$oStream.WriteText($sString)
	$oStream.Position = 0

	$oStream.type = $iTypeBinary
	$oStream.Position = 0

	Return $oStream.Read()
EndFunc   ;==>__IEStringToBstr

Func __IEBstrToString($oBstr, $sCharSet = "us-ascii")
	Local Const $iTypeBinary = 1, $iTypeText = 2

	Local $oStream = ObjCreate("ADODB.Stream")

	$oStream.type = $iTypeBinary
	$oStream.Open
	$oStream.Write($oBstr)
	$oStream.Position = 0

	$oStream.type = $iTypeText
	$oStream.CharSet = $sCharSet
	$oStream.Position = 0

	Return $oStream.ReadText()
EndFunc   ;==>__IEBstrToString

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IECreateNewIE
; Description ...: Create a Webbrowser in a seperate process
; Parameters ....: None
; Return values .: On Success	- Returns a Webbrowser object reference
;                  On Failure	- Returns 0 and sets @error
; 					@error		- 0 ($_IESTATUS_Success) = No Error
; 								- 1 ($_IESTATUS_GeneralError) = General Error
; Author ........: Dale Hohm
; Modified ......: jpm
; Remarks .......: http://msdn2.microsoft.com/en-us/library/ms536471(vs.85).aspx
; ===============================================================================================================================
Func __IECreateNewIE($sTitle, $sHead = "", $sBody = "")
	Local $sTemp = __IETempFile("", "~IE~", ".htm")
	If @error Then
		__IEConsoleWriteError("Error", "_IECreateHTA", "", "Error creating temporary file in @TempDir or @ScriptDir")
		Return SetError($_IESTATUS_GeneralError, 1, 0)
	EndIf

	Local $sHtml = ''
	$sHtml &= '<!DOCTYPE html>' & @CR
	$sHtml &= '<html>' & @CR
	$sHtml &= '<head>' & @CR
	$sHtml &= '<meta content="text/html; charset=UTF-8" http-equiv="content-type">' & @CR
	$sHtml &= '<title>' & $sTemp & '</title>' & @CR & $sHead & @CR
	$sHtml &= '</head>' & @CR
	$sHtml &= '<body>' & @CR & $sBody & @CR
	$sHtml &= '</body>' & @CR
	$sHtml &= '</html>'

	Local $hFile = FileOpen($sTemp, $FO_OVERWRITE)
	FileWrite($hFile, $sHtml)
	FileClose($hFile)
	If @error Then
		__IEConsoleWriteError("Error", "_IECreateNewIE", "", "Error creating temporary file in @TempDir or @ScriptDir")
		Return SetError($_IESTATUS_GeneralError, 2, 0)
	EndIf
	Run(@ProgramFilesDir & "\Internet Explorer\iexplore.exe " & $sTemp)

	Local $iPID
	If WinWait($sTemp, "", 60) Then
		$iPID = WinGetProcess($sTemp)
	Else
		__IEConsoleWriteError("Error", "_IECreateNewIE", "", "Timeout waiting for new IE window creation")
		Return SetError($_IESTATUS_GeneralError, 3, 0)
	EndIf

	If Not FileDelete($sTemp) Then
		__IEConsoleWriteError("Warning", "_IECreateNewIE", "", "Could not delete temporary file " & FileGetLongName($sTemp))
	EndIf

	Local $oObject = _IEAttach($sTemp)
	_IELoadWait($oObject)
	_IEPropertySet($oObject, "title", $sTitle)

	Return SetError($_IESTATUS_Success, $iPID, $oObject)
EndFunc   ;==>__IECreateNewIE

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __IETempFile
; Description ...: Generate a name for a temporary file. The file is guaranteed not to already exist.
; Parameters ....: $sDirectoryName    optional  Name of directory for filename, defaults to @TempDir
;                  $sFilePrefix       optional  File prefixname, defaults to "~"
;                  $sFileExtension    optional  File extenstion, defaults to ".tmp"
;                  $iRandomLength     optional  Number of characters to use to generate a unique name, defaults to 7
; Return values .: Filename of a temporary file which does not exist.
; Author ........: Dale (Klaatu) Thompson
; Modified.......: Hans Harder - Added Optional parameters
;
; Adapted from excellent _TempFile() in File.au3 for IE.au3 by Dale Hohm
; ===============================================================================================================================
Func __IETempFile($sDirectoryName = @TempDir, $sFilePrefix = "~", $sFileExtension = ".tmp", $iRandomLength = 7)
	Local $sTempName, $iTmp = 0
	; Check parameters
	If Not FileExists($sDirectoryName) Then $sDirectoryName = @TempDir ; First reset to default temp dir
	If Not FileExists($sDirectoryName) Then $sDirectoryName = @ScriptDir ; Still wrong then set to Scriptdir
	; add trailing \ for directory name
	If StringRight($sDirectoryName, 1) <> "\" Then $sDirectoryName = $sDirectoryName & "\"
	;
	Do
		$sTempName = ""
		While StringLen($sTempName) < $iRandomLength
			$sTempName = $sTempName & Chr(Random(97, 122, 1))
		WEnd
		$sTempName = $sDirectoryName & $sFilePrefix & $sTempName & $sFileExtension
		$iTmp += 1
		If $iTmp > 200 Then ; If we fail over 200 times, there is something wrong
			Return SetError($_IESTATUS_GeneralError, 1, 0)
		EndIf
	Until Not FileExists($sTempName)

	Return $sTempName
EndFunc   ;==>__IETempFile

#EndRegion ProtoType Functions
