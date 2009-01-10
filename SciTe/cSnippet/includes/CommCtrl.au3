#include-once
#include <StructureConstants.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#include <WinAPI.au3>
#include <SendMessage.au3>

Global Const $DebugIt = 1
Global $dll_mem = ""

Global $hl_hwnd[1], $hToolTip
Global Const $ICC_LINK_CLASS = 0x8000
Global Const $LIF_ITEMINDEX = 0x1
Global Const $LIF_STATE = 0x2
Global Const $LIF_URL = 0x8
Global Const $LIF_ITEMID = 0x4
Global Const $LIS_ENABLED = 0x2
Global Const $LIS_FOCUSED = 0x1
Global Const $LIS_VISITED = 0x4
Global Const $MAX_LINKID_TEXT = 48
Global Const $L_MAX_URL_LENGTH = (2048 + 32 + StringLen("://"))
Global Const $WC_LINK = "SysLink"

Global $tagLITEM = "uint mask;int iLink;uint state;uint stateMask;wchar szID[" & $MAX_LINKID_TEXT & "];wchar szUrl[" & $L_MAX_URL_LENGTH & "]"
Global $tagNMLINK = $tagNMHDR & ";" & $tagLITEM

Global Const $COINIT_MULTITHREADED = 0x0
Global Const $COINIT_APARTMENTTHREADED = 0x2
Global Const $COINIT_DISABLE_OLE1DDE = 0x4
Global Const $COINIT_SPEED_OVER_MEMORY = 0x8

Global Const $S_OK = 0x0
Global Const $S_FALSE = 0x1
Global Const $OLE_E_WRONGCOMPOBJ = 0x8004000E
Global Const $RPC_E_CHANGED_MODE = 0x80010106

Global Const $LM_SETITEM = ($WM_USER + 0x302)
Global Const $LM_GETIDEALHEIGHT = ($WM_USER + 0x301)
Global Const $LM_GETITEM = ($WM_USER + 0x303)
Global Const $LM_HITTEST = ($WM_USER + 0x300)

; Globals for Messages
Global $Scite_WM_COPYDATA
Global Const $SIZE_MAXHIDE = 4;Message is sent to all pop-up windows when some other window is maximized.
Global Const $SIZE_MAXIMIZED = 2;The window has been maximized.
Global Const $SIZE_MAXSHOW = 3;Message is sent to all pop-up windows when some other window has been restored to its former size.
Global Const $SIZE_MINIMIZED = 1;The window has been minimized.
Global Const $SIZE_RESTORED = 0;The window has been resized, but neither the SIZE_MINIMIZED nor SIZE_MAXIMIZED value applies.

; handle for using clipboard
Global $origHWND, $main_GUI, $Clip_Text, $ib_search, $chk_ToolTips
Global $file = @ScriptDir & "\Snippets.ini", $StatusBar, $GUI_Edit, $DockItPos = 1, $Dock = 0, $x1, $x2, $y1, $y2

Global Const $ILD_BLEND = 0x0004

;===========================================================================================================
;===========================================================================================================
Global $ListView = -999
Global $TreeView = -999
Global $h_ToolBar

Global $hMenuFont, $menuItemExit
Global $menuTreeViewBKColor, $menuTreeViewFGColor, $menuTreeViewLineColor, $BackColor, $LineColor, $ForeColor

Global $iItem ; Command identifier of the button associated with the notification.
Global Enum $IDM_NEW = 2001, $IDM_PASTE, $IDM_COPY, $IDM_SAVE, $IDM_ABOUT, $IDM_EXIT

;===========================================================================================================
;===========================================================================================================
Global $iMenuItems = -1
;===========================================================================================================
;===========================================================================================================

;===========================================================================================================
;===========================================================================================================
Func OnAutoItExit()
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then _DebugPrint("OnAutoItExit")
	;----------------------------------------------------------------------------------------------
	If ProcessExists("SciTe.exe") Then
		If Not BitAND(WinGetState("SciTE", "Source"), 2) Then WinSetState("SciTE", "Source", @SW_RESTORE)
		WinActivate("SciTE", "Source")
	EndIf
	_WinAPI_DeleteObject($hMenuFont)
	If $dll_mem <> "" And $dll_mem <> -1 Then DllClose($dll_mem)
	If $origHWND <> "" Then
		; send notification that we no longer will be in clipboard hook queue
		DllCall("user32.dll", "int", "ChangeClipboardChain", "hwnd", $main_GUI, "hwnd", $origHWND)
	EndIf
	
EndFunc   ;==>OnAutoItExit

;
; WM_NOTIFY event handler
Func WM_Notify_Events($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $hWndGUI, $MsgID, $wParam
	Local $tNMHDR, $hwndFrom, $code
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hwndFrom = DllStructGetData($tNMHDR, "hWndFrom")
	$code = DllStructGetData($tNMHDR, "Code")
	Switch $hwndFrom
		Case $h_ToolBar
			;----------------------------------------------------------------------------------------------
			;----------------------------------------------------------------------------------------------
			Local $tNMTOOLBAR
			;----------------------------------------------------------------------------------------------
			
			Switch $code
				;----------------------------------------------------------------------------------------------
				; NMHDR STRUCTURED
				;----------------------------------------------------------------------------------------------
				Case $NM_LDOWN
					;----------------------------------------------------------------------------------------------
					If $DebugIt Then _DebugPrint("$NM_LDOWN")
					;----------------------------------------------------------------------------------------------
					If $iItem = $IDM_NEW Or $iItem = $IDM_SAVE Or $iItem = $IDM_COPY Or _
							$iItem = $IDM_PASTE Or $iItem = $IDM_ABOUT Or $iItem = $IDM_EXIT Then _
							ToolBar_Click(_SendMessage($h_ToolBar, $TB_COMMANDTOINDEX, $iItem))
					;----------------------------------------------------------------------------------------------
					; NMTOOLBAR STRUCTURED
					;----------------------------------------------------------------------------------------------
				Case $TBN_BEGINDRAG, $TBN_DELETINGBUTTON, $TBN_DRAGOUT, $TBN_DROPDOWN, $TBN_ENDDRAG, _
						$TBN_GETBUTTONINFO, $TBN_GETBUTTONINFOW, $TBN_QUERYDELETE, $TBN_QUERYINSERT
					$tNMTOOLBAR = DllStructCreate($tagNMTOOLBAR, $lParam)
					$iItem = DllStructGetData($tNMTOOLBAR, "iItem")
			EndSwitch
		Case $hToolTip
			Local $tInfo = DllStructCreate($tagNMTTDISPINFO, $lParam)
			$code = DllStructGetData($tInfo, "Code")
			Switch $code
				Case $TTN_GETDISPINFO
					Local $iID = DllStructGetData($tInfo, "IDFrom")
					Switch $iID
						Case $IDM_NEW
							DllStructSetData($tInfo, "aText", _GUICtrlToolbar_GetButtonText($h_ToolBar, $IDM_NEW))
						Case $IDM_COPY
							DllStructSetData($tInfo, "aText", _GUICtrlToolbar_GetButtonText($h_ToolBar, $IDM_COPY))
						Case $IDM_PASTE
							DllStructSetData($tInfo, "aText", _GUICtrlToolbar_GetButtonText($h_ToolBar, $IDM_PASTE))
						Case $IDM_ABOUT
							DllStructSetData($tInfo, "aText", _GUICtrlToolbar_GetButtonText($h_ToolBar, $IDM_ABOUT))
						Case $IDM_EXIT
							DllStructSetData($tInfo, "aText", _GUICtrlToolbar_GetButtonText($h_ToolBar, $IDM_EXIT))
					EndSwitch
			EndSwitch
		Case Else
			Switch $wParam
				Case $ListView
					Switch $code
						Case $NM_CLICK
							ListView_Click()
						Case $NM_DBLCLK
							ListView_DoubleClick()
					EndSwitch
				Case $TreeView
					Switch $code
						Case $NM_CLICK
							TreeView_Click()
						Case $NM_DBLCLK
							TreeView_DoubleClick()
					EndSwitch
				Case Else
					For $h = 0 To UBound($hl_hwnd) - 1
						Switch $hwndFrom
							Case $hl_hwnd[$h]
								Switch $code
									Case $NM_CLICK, $NM_RETURN
										;----------------------------------------------------------------------------------------------
										If $DebugIt Then _DebugPrint("$NM_CLICK or $NM_RETURN")
										;----------------------------------------------------------------------------------------------
										Local $tNMLINK = DllStructCreate($tagNMLINK, $lParam)
										;----------------------------------------------------------------------------------------------
										If $DebugIt Then _DebugPrint( _
												"hwndFrom " & @TAB & ":" & DllStructGetData($tNMLINK, "hWndFrom") & @CRLF & _
												"idFrom " & @TAB & ":" & DllStructGetData($tNMLINK, "IDFrom") & @LF & _
												"code " & @TAB & ":" & DllStructGetData($tNMLINK, "Code") & @LF & _
												"mask " & @TAB & ":" & DllStructGetData($tNMLINK, "mask") & @LF & _
												"iLink " & @TAB & ":" & DllStructGetData($tNMLINK, "iLink") & @LF & _
												"state " & @TAB & ":" & DllStructGetData($tNMLINK, "state") & @LF & _
												"stateMask " & @TAB & ":" & DllStructGetData($tNMLINK, "stateMask") & @LF & _
												"szID " & @TAB & ":" & DllStructGetData($tNMLINK, "szID") & @LF & _
												"szUrl " & @TAB & ":" & DllStructGetData($tNMLINK, "szUrl"))
										;----------------------------------------------------------------------------------------------
										If StringInStr(DllStructGetData($tNMLINK, 9), "http") Then
											Run(@ComSpec & " /c Start explorer " & DllStructGetData($tNMLINK, "szUrl"), "", @SW_HIDE)
										Else
											Run(@ComSpec & " /c Start " & DllStructGetData($tNMLINK, "szUrl"), "", @SW_HIDE)
										EndIf
										Local $index = StringSplit(StringStripWS(DllStructGetData($tNMLINK, "szID"), 2), " ")
										$index = Int($index[$index[0]]) - 1
										;----------------------------------------------------------------------------------------------
										Local $tLITEM = DllStructCreate($tagLITEM)
										;----------------------------------------------------------------------------------------------
										DllStructSetData($tLITEM, "mask", BitOR($LIF_URL, $LIF_ITEMINDEX, $LIF_STATE, $LIF_ITEMID))
										DllStructSetData($tLITEM, "iLink", $index)
										DllStructSetData($tLITEM, "stateMask", BitOR($LIS_ENABLED, $LIS_FOCUSED, $LIS_VISITED))
										DllStructSetData($tLITEM, "szID", DllStructGetData($tNMLINK, "szID"))
										DllStructSetData($tLITEM, "szUrl", DllStructGetData($tNMLINK, "szUrl"))
										_SendMessage($hl_hwnd[$h], $LM_SETITEM, 0, DllStructGetPtr($tLITEM), 0, "wparam", "ptr")
										;----------------------------------------------------------------------------------------------
										ExitLoop
								EndSwitch
						EndSwitch
					Next
			EndSwitch
	EndSwitch
	; Proceed the default Autoit3 internal message commands.
	; You also can complete let the line out.
	; !!! But only 'Return' (without any value) will not proceed
	; the default Autoit3-message in the future !!!
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_Notify_Events

Func MY_WM_COMMAND($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $hWndGUI, $MsgID, $lParam
	Local $nNotifyCode = _HiWord($wParam)
	Local $nID = _LoWord($wParam)
	
	Switch $nID
		Case $ib_search
			Switch $nNotifyCode
				Case $EN_CHANGE
					_Input_Changed()
			EndSwitch
	EndSwitch
	; Proceed the default Autoit3 internal message commands.
	; You also can complete let the line out.
	; !!! But only 'Return' (without any value) will not proceed
	; the default Autoit3-message in the future !!!
	Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_WM_COMMAND

; Received Data from SciTE
Func _SciTE_MY_WM_COPYDATA($hWnd, $msg, $wParam, $lParam)
	#forceref $hWnd, $msg, $wParam
	Local $COPYDATA = DllStructCreate('Ptr;DWord;Ptr', $lParam)
	Local $SciTECmdLen = DllStructGetData($COPYDATA, 2)
	Local $CmdStruct = DllStructCreate('Char[' & $SciTECmdLen + 1 & ']', DllStructGetData($COPYDATA, 3))
	Local $SciTECmd = StringLeft(DllStructGetData($CmdStruct, 1), $SciTECmdLen)
	$Scite_WM_COPYDATA = $Scite_WM_COPYDATA & $SciTECmd
EndFunc   ;==>_SciTE_MY_WM_COPYDATA
;~ ;
;~ ; Received Data from SciTE
;~ Func _SciTE_MY_WM_COPYDATA($hWndGUI, $MsgID, $wParam, $lParam)
;~ 	#forceref $hWndGUI, $MsgID, $wParam
;~ 	Local $COPYDATA = DllStructCreate('Ptr;DWord;Ptr', $lParam)
;~ 	Local $SciTECmdLen = DllStructGetData($COPYDATA, 2)
;~ 	Local $SciTEBuffer = DllStructCreate("char Buffer[" & $SciTECmdLen + 1 & "]", DllStructGetData($COPYDATA, 3))
;~ 	$Scite_WM_COPYDATA = $Scite_WM_COPYDATA & DllStructGetData($SciTEBuffer, "Buffer")
;~ EndFunc   ;==>_SciTE_MY_WM_COPYDATA

;********************************************************************
; Out WM_MEASURE procedure
;********************************************************************

Func WM_MEASUREITEM_Event($hWnd, $nMsg, $wParam, $lParam)
	#forceref $nMsg, $wParam
	Local $nResult = False, $stMeasureItem
	Local $nIconSize, $nCheckX, $nSpace
	Local $hDC, $hFont, $nMenuItemID, $hMenu, $sText
	Local $nMaxTextWidth, $nHeight, $nWidth
	
	$stMeasureItem = DllStructCreate('uint;uint;uint;uint;uint;dword', $lParam)
	
	If DllStructGetData($stMeasureItem, 1) = $ODT_MENU Then
		
		$nIconSize = 0
		$nCheckX = 0
		$nSpace = 2
		
		_GetMenuInfos($nIconSize, $nCheckX)
		
		If $nIconSize < $nCheckX Then $nIconSize = $nCheckX
		
		
		; Reassign the current menu font to the menuitem
		$hDC = _WinAPI_GetDC($hWnd)
		$hFont = _WinAPI_SelectObject($hDC, $hMenuFont)
		
		$nMenuItemID = DllStructGetData($stMeasureItem, 3)
		$hMenu = _GetMenuHandle($nMenuItemID)
		
		$sText = _GetMenuText($nMenuItemID)
		
		$nMaxTextWidth = _GetMenuMaxTextWidth($hDC, $hMenu)
		
		$nHeight = 2 * $nSpace + $nIconSize
		$nWidth = 0
		
		; Set a default separator height
		If $sText = '' Then
			$nHeight = 4
		Else
			$nWidth = 6 * $nSpace + 2 * $nIconSize + $nMaxTextWidth
			
			; Maybe this differs - have no emulator here at the moment
			If @OSVersion <> 'WIN_98'  And @OSVersion <> 'WIN_ME'  Then
				$nWidth = $nWidth - $nCheckX + 1
			EndIf
		EndIf
		
		DllStructSetData($stMeasureItem, 4, $nWidth) ; ItemWidth
		DllStructSetData($stMeasureItem, 5, $nHeight) ; ItemHeight
		
		_WinAPI_SelectObject($hDC, $hFont)
		
		_WinAPI_ReleaseDC($hWnd, $hDC)
		$nResult = True
	EndIf
	
	$stMeasureItem = 0
	
	Return $nResult
EndFunc   ;==>WM_MEASUREITEM_Event

Func WM_DRAWITEM_Event($hWnd, $nMsg, $wParam, $lParam)
	#forceref $hWnd, $nMsg, $wParam
	Local $nResult = False
	
	Local $stDrawItem = DllStructCreate('uint;uint;uint;uint;uint;dword;dword;int[4];dword', $lParam)
	
	If DllStructGetData($stDrawItem, 1) = $ODT_MENU Then
		Local $nMenuItemID = DllStructGetData($stDrawItem, 3)
		Local $nState = DllStructGetData($stDrawItem, 5)
		Local $hDC = DllStructGetData($stDrawItem, 7)
		
		Local $bChecked = BitAND($nState, $ODS_CHECKED)
		Local $bGrayed = BitAND($nState, $ODS_GRAYED)
		Local $bSelected = BitAND($nState, $ODS_SELECTED)
		Local $bIsRadio = _GetMenuIsRadio($nMenuItemID)
		
		Local $arItemRect[4], $tc
		$arItemRect[0] = DllStructGetData($stDrawItem, 8, 1)
		$arItemRect[1] = DllStructGetData($stDrawItem, 8, 2)
		$arItemRect[2] = DllStructGetData($stDrawItem, 8, 3)
		$arItemRect[3] = DllStructGetData($stDrawItem, 8, 4)
		
		Local $stItemRect = DllStructCreate($tagRECT)
		DllStructSetData($stItemRect, "Left", $arItemRect[0])
		DllStructSetData($stItemRect, "Top", $arItemRect[1])
		DllStructSetData($stItemRect, "Right", $arItemRect[2])
		DllStructSetData($stItemRect, "Bottom", $arItemRect[3])
		
		; Set default menu values if info function fails
		Local $nIconSize = 16
		Local $nCheckX = 16
		Local $nSpace = 2
		
		_GetMenuInfos($nIconSize, $nCheckX)
		
		; Select our at beginning selfcreated menu font into the item device context
		Local $hFont = _WinAPI_SelectObject($hDC, $hMenuFont)
		
		Local $hBorderBrush = 0
		Local $nBkColor, $hBrush, $nClrSel
		
		; Only show a menu bar when the item is enabled
		If $bSelected And Not $bGrayed Then
			$hBorderBrush = _WinAPI_CreateSolidBrush(0x854240)
			
			
			$nBkColor = 0x222255
			$hBrush = _WinAPI_CreateSolidBrush($nBkColor) ; BGR color value
			$nClrSel = $nBkColor
		Else
			$hBrush = _WinAPI_GetSysColorBrush($COLOR_MENU)
			$nClrSel = _WinAPI_GetSysColor($COLOR_MENU)
		EndIf
		Local $nClrTxt
		If $bSelected And Not $bGrayed Then
			; If you want to use a selfdefined item selection text color then just do i.e.:
			$nClrTxt = _WinAPI_SetTextColor($hDC, 0x00FFFF) ; BGR color value - in this case 'yellow'
		ElseIf $bGrayed Then
			$nClrTxt = _WinAPI_SetTextColor($hDC, _WinAPI_GetSysColor($COLOR_GRAYTEXT))
		Else
			$nClrTxt = _WinAPI_SetTextColor($hDC, _WinAPI_GetSysColor($COLOR_MENUTEXT))
		EndIf
		
		
		Local $nClrBk = _WinAPI_SetBkColor($hDC, $nClrSel)
		Local $hOldBrush = _WinAPI_SelectObject($hDC, $hBrush)
		
		_WinAPI_FillRect($hDC, DllStructGetPtr($stItemRect), $hBrush)
		_WinAPI_SelectObject($hDC, $hOldBrush)
		_WinAPI_DeleteObject($hBrush)
		
		; Create a small gray edge
		If Not $bSelected Or $bGrayed Then
			
			; Reassign the item rect
			DllStructSetData($stItemRect, "Left", $arItemRect[0])
			DllStructSetData($stItemRect, "Top", $arItemRect[1])
			DllStructSetData($stItemRect, "Right", $arItemRect[0] + 2 * $nSpace + $nIconSize + 1)
			
			If $nMenuItemID = $menuTreeViewBKColor Then
				$tc = Hex(String($BackColor), 6)
				$hBrush = _WinAPI_CreateSolidBrush('0x' & StringMid($tc, 5, 2) & StringMid($tc, 3, 2) & StringMid($tc, 1, 2))
			ElseIf $nMenuItemID = $menuTreeViewFGColor Then
				$tc = Hex(String($ForeColor), 6)
				$hBrush = _WinAPI_CreateSolidBrush('0x' & StringMid($tc, 5, 2) & StringMid($tc, 3, 2) & StringMid($tc, 1, 2))
			ElseIf $nMenuItemID = $menuTreeViewLineColor Then
				$tc = Hex(String($LineColor), 6)
				$hBrush = _WinAPI_CreateSolidBrush('0x' & StringMid($tc, 5, 2) & StringMid($tc, 3, 2) & StringMid($tc, 1, 2))
			Else
				$hBrush = _WinAPI_CreateSolidBrush(0xCACACA)
			EndIf
			
			$hOldBrush = _WinAPI_SelectObject($hDC, $hBrush);
			
			_WinAPI_FillRect($hDC, DllStructGetPtr($stItemRect), $hBrush)
			
			_WinAPI_SelectObject($hDC, $hOldBrush)
			_WinAPI_DeleteObject($hBrush)
		Else
			If $nMenuItemID = $menuTreeViewBKColor Then
				; Reassign the item rect
				DllStructSetData($stItemRect, "Left", $arItemRect[0])
				DllStructSetData($stItemRect, "Top", $arItemRect[1])
				DllStructSetData($stItemRect, "Right", $arItemRect[0] + 2 * $nSpace + $nIconSize + 1)
				$tc = Hex(String($BackColor), 6)
				$hBrush = _WinAPI_CreateSolidBrush('0x' & StringMid($tc, 5, 2) & StringMid($tc, 3, 2) & StringMid($tc, 1, 2))
				$hOldBrush = _WinAPI_SelectObject($hDC, $hBrush);
				
				_WinAPI_FillRect($hDC, DllStructGetPtr($stItemRect), $hBrush)
				
				_WinAPI_SelectObject($hDC, $hOldBrush)
				_WinAPI_DeleteObject($hBrush)
			ElseIf $nMenuItemID = $menuTreeViewFGColor Then
				; Reassign the item rect
				DllStructSetData($stItemRect, "Left", $arItemRect[0])
				DllStructSetData($stItemRect, "Top", $arItemRect[1])
				DllStructSetData($stItemRect, "Right", $arItemRect[0] + 2 * $nSpace + $nIconSize + 1)
				$tc = Hex(String($ForeColor), 6)
				$hBrush = _WinAPI_CreateSolidBrush('0x' & StringMid($tc, 5, 2) & StringMid($tc, 3, 2) & StringMid($tc, 1, 2))
				$hOldBrush = _WinAPI_SelectObject($hDC, $hBrush);
				
				_WinAPI_FillRect($hDC, DllStructGetPtr($stItemRect), $hBrush)
				
				_WinAPI_SelectObject($hDC, $hOldBrush)
				_WinAPI_DeleteObject($hBrush)
			ElseIf $nMenuItemID = $menuTreeViewLineColor Then
				; Reassign the item rect
				DllStructSetData($stItemRect, "Left", $arItemRect[0])
				DllStructSetData($stItemRect, "Top", $arItemRect[1])
				DllStructSetData($stItemRect, "Right", $arItemRect[0] + 2 * $nSpace + $nIconSize + 1)
				$tc = Hex(String($LineColor), 6)
				$hBrush = _WinAPI_CreateSolidBrush('0x' & StringMid($tc, 5, 2) & StringMid($tc, 3, 2) & StringMid($tc, 1, 2))
				$hOldBrush = _WinAPI_SelectObject($hDC, $hBrush);
				
				_WinAPI_FillRect($hDC, DllStructGetPtr($stItemRect), $hBrush)
				
				_WinAPI_SelectObject($hDC, $hOldBrush)
				_WinAPI_DeleteObject($hBrush)
			EndIf
		EndIf
		Local $hDCBitmap, $hbmpCheck, $hbmpOld, $x, $y, $nCtrlStyle
		If $bChecked Then
			DllStructSetData($stItemRect, "Left", $arItemRect[0] + 1)
			DllStructSetData($stItemRect, "Top", $arItemRect[1] + 1)
			DllStructSetData($stItemRect, "Right", $arItemRect[0] + $nIconSize + 3)
			DllStructSetData($stItemRect, "Bottom", $arItemRect[1] + $nIconSize + 3)
			
			If $bSelected Then
				$hBrush = _WinAPI_CreateSolidBrush(0xE5A2A0)
			Else
				$hBrush = _WinAPI_CreateSolidBrush(0xFFFFFF)
			EndIf
			
			$hOldBrush = _WinAPI_SelectObject($hDC, $hBrush)
			_WinAPI_FillRect($hDC, DllStructGetPtr($stItemRect), $hBrush)
			_WinAPI_SelectObject($hDC, $hOldBrush)
			_WinAPI_DeleteObject($hBrush)
			
			$hBrush = _WinAPI_CreateSolidBrush(0x854240)
			$hOldBrush = _WinAPI_SelectObject($hDC, $hBrush)
			_WinAPI_FrameRect($hDC, DllStructGetPtr($stItemRect), $hBrush)
			_WinAPI_SelectObject($hDC, $hOldBrush)
			_WinAPI_DeleteObject($hBrush)
			
			; Create a checkmark/bullet for the checked/radio items
			$hDCBitmap = _WinAPI_CreateCompatibleDC($hDC)
			$hbmpCheck = _WinAPI_CreateBitmap($nIconSize, $nIconSize, 1, 1, 0)
			$hbmpOld = _WinAPI_SelectObject($hDCBitmap, $hbmpCheck)
			
			$x = DllStructGetData($stItemRect, "Left") + ($nIconSize + $nSpace - $nCheckX) / 2
			$y = DllStructGetData($stItemRect, "Top") + ($nIconSize + $nSpace - $nCheckX) / 2 - 2
			
			DllStructSetData($stItemRect, "Left", 0)
			DllStructSetData($stItemRect, "Top", 0)
			DllStructSetData($stItemRect, "Right", $nIconSize)
			DllStructSetData($stItemRect, "Bottom", $nIconSize)
			
			$nCtrlStyle = $DFCS_MENUCHECK
			
			If $bIsRadio Then $nCtrlStyle = $DFCS_MENUBULLET
			
			_WinAPI_DrawFrameControl($hDCBitmap, DllStructGetPtr($stItemRect), $DFC_MENU, $nCtrlStyle)
			
			_WinAPI_BitBlt($hDC, $x, $y + 1, $nCheckX, $nCheckX, $hDCBitmap, 0, 0, $SRCCOPY)
			
			_WinAPI_SelectObject($hDCBitmap, $hBrush)
			_WinAPI_FillRect($hDCBitmap, DllStructGetPtr($stItemRect), $hBrush)
			
			_WinAPI_SelectObject($hDCBitmap, $hbmpOld)
			_WinAPI_DeleteObject($hbmpCheck)
			_WinAPI_DeleteDC($hDCBitmap)
		EndIf
		
		
		; Reassign the item rect
		DllStructSetData($stItemRect, "Left", $arItemRect[0])
		DllStructSetData($stItemRect, "Top", $arItemRect[1])
		DllStructSetData($stItemRect, "Right", $arItemRect[2])
		DllStructSetData($stItemRect, "Bottom", $arItemRect[3])
		
		If $bSelected And Not $bGrayed Then
			$hOldBrush = _WinAPI_SelectObject($hDC, $hBorderBrush)
			_WinAPI_FrameRect($hDC, DllStructGetPtr($stItemRect), $hBorderBrush)
			_WinAPI_SelectObject($hDC, $hOldBrush)
			_WinAPI_DeleteObject($hBorderBrush)
		EndIf
		
		Local $sText = _GetMenuText($nMenuItemID)
		
		Local $nSaveLeft = DllStructGetData($stItemRect, 1)
		
		Local $nLeft = $nSaveLeft
		$nLeft += $nSpace; Left border
		$nLeft += $nSpace; Space after gray border
		$nLeft += $nIconSize; Icon width
		$nLeft += $nSpace + 1; Right after the icon
		
		DllStructSetData($stItemRect, "Left", $nLeft)
		
		Local $nFlags = BitOR($DT_NOCLIP, $DT_SINGLELINE, $DT_VCENTER)
		
		_WinAPI_DrawText($hDC, $sText, $stItemRect, $nFlags)
		
		Local $nIconIndex = _GetMenuIconIndex($nMenuItemID)
		
		
		If Not $bChecked Then
			If $bGrayed Then
				; An easy way to draw something that looks deactivated
				_GUIImageList_DrawEx($hMenuImageList, $nIconIndex, $hDC, 2, DllStructGetData($stItemRect, "Top") + 2, 0, 0, $CLR_NONE, $CLR_NONE, BitOR($ILD_BLEND, $ILD_TRANSPARENT))
			Else
				; Draw the icon 'normal'
				_GUIImageList_Draw($hMenuImageList, $nIconIndex, $hDC, 2, DllStructGetData($stItemRect, "Top") + 2, $ILD_TRANSPARENT)
			EndIf
		EndIf
		
		DllStructSetData($stItemRect, 1, $nSaveLeft)
		
		; Draw a 'line' for a separator item
		If StringLen($sText) = 0 Then
			DllStructSetData($stItemRect, "Left", DllStructGetData($stItemRect, "Left") + 4 * $nSpace + $nIconSize)
			DllStructSetData($stItemRect, "Top", DllStructGetData($stItemRect, "Top") + 1)
			DllStructSetData($stItemRect, "Bottom", DllStructGetData($stItemRect, "Left") + 2)
			_WinAPI_DrawEdge($hDC, DllStructGetPtr($stItemRect), $EDGE_ETCHED, $BF_TOP)
		EndIf
		
		$stItemRect = 0
		
		_WinAPI_SelectObject($hDC, $hFont)
		
		_WinAPI_SetTextColor($hDC, $nClrTxt)
		_WinAPI_SetBkColor($hDC, $nClrBk)
		
		$nResult = True
	EndIf
	
	$stDrawItem = 0
	
	Return $nResult
EndFunc   ;==>WM_DRAWITEM_Event

Func _DebugPrint($s_text)
	$s_text = StringReplace($s_text, @LF, @LF & "-->")
	ConsoleWrite("!===========================================================" & @LF & _
			"+===========================================================" & @LF & _
			"-->" & $s_text & @LF & _
			"+===========================================================" & @LF)
EndFunc   ;==>_DebugPrint

Func _HiWord($x)
	Return BitShift($x, 16)
EndFunc   ;==>_HiWord

Func _LoWord($x)
	Return BitAND($x, 0xFFFF)
EndFunc   ;==>_LoWord

Func _GuiCtrlHyperLinkCreate($h_Gui, $s_text, $s_link, $s_LinkOn, $x = 10, $y = 10, $width = 120, $height = 20, $v_styles = -1, $v_exstyles = -1, _
		$FontName = "Arial", $FontSize = 10, $FontWeight = 400, $FontItalic = 0, $FontUnderline = 0, $FontStrikeThru = 0)
	Local $hyper_link, $hl, $l_hwnd, $style, $link, $num_links = 0, $l
	Local $UDF_link_num = 1
	If Not IsHWnd($h_Gui) Then $h_Gui = HWnd($h_Gui)
	$style = BitOR($WS_CHILD, $WS_VISIBLE)
	If $v_styles <> -1 Then $style = BitOR($style, $v_styles)
	If $v_exstyles = -1 Then $v_exstyles = 0
	Local $stICCE = DllStructCreate('dword;dword')
	DllStructSetData($stICCE, 1, DllStructGetSize($stICCE))
	DllStructSetData($stICCE, 2, $ICC_LINK_CLASS)
	DllCall('comctl32.dll', 'int', 'InitCommonControlsEx', 'ptr', DllStructGetPtr($stICCE))
	
	DllCall('ole32.dll', 'long', 'CoInitializeEx', 'int', 0, 'long', $COINIT_DISABLE_OLE1DDE)
	If IsArray($s_LinkOn) And IsArray($s_link) Then
		For $l = 0 To UBound($s_LinkOn) - 1
			$s_text = StringReplace($s_text, $s_LinkOn[$l], '<A HREF="' & $s_link[$l] & '">' & $s_LinkOn[$l] & '</A>')
			$num_links += @extended
		Next
		$hyper_link = $s_text
		;----------------------------------------------------------------------------------------------
		If $DebugIt Then _DebugPrint("# of Links: " & $num_links)
		;----------------------------------------------------------------------------------------------
	ElseIf Not IsArray($s_LinkOn) And Not IsArray($s_link) Then
		$hyper_link = StringReplace($s_text, $s_LinkOn, '<A HREF="' & $s_link & '">' & $s_LinkOn & '</A>')
		$num_links = @extended
		;----------------------------------------------------------------------------------------------
		If $DebugIt Then _DebugPrint("# of Links: " & $num_links)
		;----------------------------------------------------------------------------------------------
	Else
		;----------------------------------------------------------------------------------------------
		If $DebugIt Then _DebugPrint("links and link on sizes don't match")
		;----------------------------------------------------------------------------------------------
		SetError(4)
		Return -1
	EndIf
	
	$l_hwnd = _WinAPI_CreateWindowEx($v_exstyles, $WC_LINK, $hyper_link, $style, $x, $y, $width, $height, $h_Gui)
	If Not @error Then
		;----------------------------------------------------------------------------------------------
		If $DebugIt Then _DebugPrint("$l_hwnd " & @TAB & ":" & $l_hwnd)
		;----------------------------------------------------------------------------------------------
		Local $s_szID
		If IsArray($s_LinkOn) Then
			For $y = 0 To UBound($s_link) - 1
				$s_szID = StringFormat("%-" & $MAX_LINKID_TEXT & "s", "UDF Maniac HyperLink " & $UDF_link_num)
				$link = DllStructCreate($tagLITEM)
				DllStructSetData($link, "mask", BitOR($LIF_URL, $LIF_ITEMINDEX, $LIF_STATE, $LIF_ITEMID))
				DllStructSetData($link, "iLink", $UDF_link_num - 1)
				DllStructSetData($link, "szID", $s_szID)
				DllStructSetData($link, "szUrl", $s_link[$y])
				$hl = _SendMessage($l_hwnd, $LM_SETITEM, 0, DllStructGetPtr($link), 0, "wparam", "ptr")
				;----------------------------------------------------------------------------------------------
				If $DebugIt Then _DebugPrint("$hl: " & $hl)
				;----------------------------------------------------------------------------------------------
				$UDF_link_num += 1
				$link = 0
			Next
		Else
			
			For $x = 0 To $num_links - 1
				$s_szID = StringFormat("%-" & $MAX_LINKID_TEXT & "s", "UDF Maniac HyperLink " & $UDF_link_num)
				$link = DllStructCreate($tagLITEM)
				DllStructSetData($link, "mask", BitOR($LIF_URL, $LIF_ITEMINDEX, $LIF_STATE, $LIF_ITEMID))
				DllStructSetData($link, "iLink", $UDF_link_num - 1)
				DllStructSetData($link, "szID", $s_szID)
				DllStructSetData($link, "szUrl", $s_link)
				$hl = _SendMessage($l_hwnd, $LM_SETITEM, 0, DllStructGetPtr($link), 0, "wparam", "ptr")
				;----------------------------------------------------------------------------------------------
				If $DebugIt Then _DebugPrint("$hl: " & $hl)
				;----------------------------------------------------------------------------------------------
				$UDF_link_num += 1
				$link = 0
			Next
		EndIf
		
		If $hl Then
			Local $hDC = _WinAPI_GetDC($h_Gui)
			Local $ret = _WinAPI_GetDeviceCaps($hDC, $LOGPIXELSY)
			If ($ret == -1) Then
				SetError(3)
				Return -1
			EndIf
			_WinAPI_ReleaseDC($h_Gui, $hDC)
			Local $lfHeight = Round(($FontSize * $ret) / 80, 0)
			Local $font = DllStructCreate($tagLOGFONT)
			DllStructSetData($font, "Height", $lfHeight + 1)
			DllStructSetData($font, "Weight", $FontWeight)
			DllStructSetData($font, "Italic", $FontItalic)
			DllStructSetData($font, "Underline", $FontUnderline)
			DllStructSetData($font, "StrikeOut", $FontStrikeThru)
			DllStructSetData($font, "Quality", $PROOF_QUALITY)
			DllStructSetData($font, "FaceName", $FontName)
			$ret = _WinAPI_CreateFontIndirect($font)
			_WinAPI_SetFont($l_hwnd, $ret)
			Return $l_hwnd
		Else
			;----------------------------------------------------------------------------------------------
			If $DebugIt Then _DebugPrint("Error: $LM_SETITEM: " & @error)
			;----------------------------------------------------------------------------------------------
			SetError(2)
			Return $l_hwnd
		EndIf
	Else
		;----------------------------------------------------------------------------------------------
		If $DebugIt Then _DebugPrint("Error: CreateWindowEx: " & @error)
		;----------------------------------------------------------------------------------------------
		SetError(1)
		Return -1
	EndIf
	
	Return 0
EndFunc   ;==>_GuiCtrlHyperLinkCreate

Func OnClipBoardChange($hWnd, $nMsg, $wParam, $lParam)
	#forceref $hWnd, $nMsg
	Local $w_pos = WinGetPos($main_GUI)
	; do what you need when clipboard changes
	$Clip_Text = ClipGet()
	If $chk_ToolTips Then
		ToolTip("Alt+Shift+c 'copy into Snippet Holder'" & @LF & "Alt+Shift+t 'close this tip window'" & @LF & "Alt+Shift+r 'Run'" & @LF & "Alt+Shift+b 'beta Run'", $w_pos[0] + 10, $w_pos[1] + 30, "New Clip Text", 1, 1)
	EndIf
	_SetClipEvent()
	_SendMessage($origHWND, $WM_DRAWCLIPBOARD, $wParam, $lParam)
EndFunc   ;==>OnClipBoardChange

Func OnClipBoardViewerChange($hWnd, $nMsg, $wParam, $lParam)
	#forceref $hWnd, $nMsg
	; if our remembered previous clipviewer is removed then we must remember new next clipviewer
	; else send notification about clipviewr change to next clipviewer
	If $wParam = $origHWND Then
		$origHWND = $lParam
	Else
		_SendMessage($origHWND, $WM_CHANGECBCHAIN, $wParam, $lParam, 0, "hwnd", "hwnd")
	EndIf
EndFunc   ;==>OnClipBoardViewerChange

Func MY_WM_GETMINMAXINFO($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $MsgID, $wParam
	If $hWndGUI = $main_GUI Then; the main GUI-limited
		Local $minmaxinfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
		DllStructSetData($minmaxinfo, 7, 240); min width
		DllStructSetData($minmaxinfo, 8, 400); min height
		DllStructSetData($minmaxinfo, 9, 350); max width
		DllStructSetData($minmaxinfo, 10, 700); max height
		Return 0
	Else;other dialogs-"no" lower limit
		Return 0
	EndIf
EndFunc   ;==>MY_WM_GETMINMAXINFO

;==========================================================================================
;Stores the position and size of the Snippet window for use on next startup
;Stores the X,Y coords and the Width, Height in the ~xx123Data section of the Snippets.ini
;==========================================================================================
Func _WinResized($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $hWndGUI, $MsgID, $lParam
	Local $h = _HiWord($lParam)
	Local $w = _LoWord($lParam)
	If $wParam <> $SIZE_MINIMIZED And $wParam <> $SIZE_MAXSHOW And $hWndGUI = $main_GUI Then
		IniWrite($file, "~xx123Data", "W", $w)
		IniWrite($file, "~xx123Data", "H", $h)
		ControlMove("", "", HWnd($h_ToolBar), 0, 0, $w)
		_GUICtrlStatusBar_Resize($StatusBar)
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc   ;==>_WinResized

Func _WinMoved($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $hWndGUI, $MsgID, $wParam, $lParam
	;lParam
	;Specifies the x and y coordinates of the upper-left corner of the client area of the window.
	;The low-order word contains the x-coordinate while the high-order word contains the y coordinate.
	If ($hWndGUI = $main_GUI) Or ($hWndGUI = $GUI_Edit) Then
		If $DockItPos Then
			_KeepWindowsDocked($GUI_Edit, $main_GUI, $Dock, $x1, $x2, $y1, $y2)
		Else
			_KeepWindowsDocked($main_GUI, $GUI_Edit, $Dock, $x1, $x2, $y1, $y2)
		EndIf
		Local $ExitPOS = WinGetPos($main_GUI, "")
		If IsArray($ExitPOS) Then
			IniWrite($file, "~xx123Data", "X", $ExitPOS[0])
			IniWrite($file, "~xx123Data", "Y", $ExitPOS[1] - 18)
			IniWrite($file, "~xx123Data", "W", $ExitPOS[2] - 6)
			IniWrite($file, "~xx123Data", "H", $ExitPOS[3] - 48)
		Else
			MsgBox(16 + 262144, "Error", "Unable to store Position")
		EndIf
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc   ;==>_WinMoved