#include-once
#include <WinAPI.au3>

Global Const $MF_BYCOMMAND			= 0x00000000
Global Const $MF_OWNERDRAW			= 0x00000100
Global Const $MF_SEPARATOR			= 0x00000800

Global Const $ODT_MENU				= 1
Global Const $ODT_LISTBOX			= 2
Global Const $ODT_COMBOBOX			= 3
Global Const $ODT_BUTTON			= 4
Global Const $ODT_STATIC			= 5

Global Const $ODS_SELECTED			= 0x0001
Global Const $ODS_GRAYED			= 0x0002
Global Const $ODS_DISABLED			= 0x0004
Global Const $ODS_CHECKED			= 0x0008
Global Const $ODS_FOCUS				= 0x0010
Global Const $ODS_DEFAULT			= 0x0020

Global Const $DFC_CAPTION			= 1
Global Const $DFC_MENU				= 2
Global Const $DFC_SCROLL			= 3
Global Const $DFC_BUTTON			= 4
Global Const $DFC_POPUPMENU			= 5

Global Const $DFCS_CAPTIONCLOSE		= 0x0000
Global Const $DFCS_CAPTIONMIN		= 0x0001
Global Const $DFCS_CAPTIONMAX		= 0x0002
Global Const $DFCS_CAPTIONRESTORE	= 0x0003
Global Const $DFCS_CAPTIONHELP		= 0x0004

Global Const $DFCS_MENUARROW		= 0x0000
Global Const $DFCS_MENUCHECK		= 0x0001
Global Const $DFCS_MENUBULLET		= 0x0002
Global Const $DFCS_MENUARROWRIGHT	= 0x0004
Global Const $DFCS_SCROLLUP			= 0x0000
Global Const $DFCS_SCROLLDOWN		= 0x0001
Global Const $DFCS_SCROLLLEFT		= 0x0002
Global Const $DFCS_SCROLLRIGHT		= 0x0003
Global Const $DFCS_SCROLLCOMBOBOX	= 0x0005
Global Const $DFCS_SCROLLSIZEGRIP	= 0x0008
Global Const $DFCS_SCROLLSIZEGRIPRIGHT	= 0x0010

Global Const $DFCS_BUTTONCHECK		= 0x0000
Global Const $DFCS_BUTTONRADIOIMAGE	= 0x0001
Global Const $DFCS_BUTTONRADIOMASK	= 0x0002
Global Const $DFCS_BUTTONRADIO		= 0x0004
Global Const $DFCS_BUTTON3STATE		= 0x0008
Global Const $DFCS_BUTTONPUSH		= 0x0010

Global Const $DFCS_INACTIVE			= 0x0100
Global Const $DFCS_PUSHED			= 0x0200
Global Const $DFCS_CHECKED			= 0x0400

Global Const $BDR_RAISEDOUTER		= 0x0001
Global Const $BDR_SUNKENOUTER		= 0x0002
Global Const $BDR_RAISEDINNER		= 0x0004
Global Const $BDR_SUNKENINNER		= 0x0008

Global Const $BF_LEFT				= 0x0001
Global Const $BF_TOP				= 0x0002
Global Const $BF_RIGHT				= 0x0004
Global Const $BF_BOTTOM				= 0x0008
Global Const $BF_TOPLEFT			= BitOr($BF_TOP, $BF_LEFT)
Global Const $BF_TOPRIGHT			= BitOr($BF_TOP, $BF_RIGHT)
Global Const $BF_BOTTOMLEFT			= BitOr($BF_BOTTOM, $BF_LEFT)
Global Const $BF_BOTTOMRIGHT		= BitOr($BF_BOTTOM, $BF_RIGHT)
Global Const $BF_RECT				= BitOr($BF_LEFT, $BF_TOP, $BF_RIGHT, $BF_BOTTOM)

Global Const $EDGE_ETCHED			= 0x0006

; Store here the ID/Text/IconIndex/ParentMenu
Global $arMenuItems[100][5]
$arMenuItems[0][0] = 0
; Create an image list for saving/drawing our menu icons
Global $hMenuImageList = _GUIImageList_Create(16, 16, 5, 1, 0, 1)

#region Begin functions for custom drawn menus
;********************************************************************
; Create a menu and set its style to OwnerDrawn
;********************************************************************

Func _GUICtrlCreateMenu($sMenuText, $nParentMenuID, $sIconFile = '', $nIconID = -1)
	Local $MenuID, $hMenu
	
	$MenuID = GUICtrlCreateMenu($sMenuText, $nParentMenuID)
	
	$arMenuItems[0][0] += 1
	
	$hMenu = GUICtrlGetHandle($nParentMenuID)
	
	$arMenuItems[$arMenuItems[0][0]][0] = $MenuID
	$arMenuItems[$arMenuItems[0][0]][1] = $sMenuText
	If $nIconID > -1 Then
		$arMenuItems[$arMenuItems[0][0]][2] = _GUIImageList_AddIcon($hMenuImageList, $sIconFile, $nIconID)
	Else
		$arMenuItems[$arMenuItems[0][0]][2] = $nIconID
	EndIf
	$arMenuItems[$arMenuItems[0][0]][3] = $hMenu
	$arMenuItems[$arMenuItems[0][0]][4] = 0
	
	_SetOwnerDrawn($hMenu, $MenuID, $sMenuText)
	
	Return $MenuID
EndFunc

;********************************************************************
; Create a menu item and set its style to OwnerDrawn
;********************************************************************

Func _GUICtrlCreateMenuItem($sMenuItemText, $nParentMenuID, $sIconFile = '', $nIconID = -1, $bRadio = 0)
	Local $MenuItemID = GUICtrlCreateMenuItem($sMenuItemText, $nParentMenuID, -1, $bRadio)
	
	$arMenuItems[0][0] += 1
	
	Local $hMenu = GUICtrlGetHandle($nParentMenuID)

	$arMenuItems[$arMenuItems[0][0]][0] = $MenuItemID
	$arMenuItems[$arMenuItems[0][0]][1] = $sMenuItemText
	If $nIconID  > -1 Then
		$arMenuItems[$arMenuItems[0][0]][2] = _GUIImageList_AddIcon($hMenuImageList, $sIconFile, $nIconID)
	Else
		$arMenuItems[$arMenuItems[0][0]][2] = $nIconID
	EndIf
	$arMenuItems[$arMenuItems[0][0]][3] = $hMenu
	$arMenuItems[$arMenuItems[0][0]][4] = $bRadio
	
	_SetOwnerDrawn($hMenu, $MenuItemID, $sMenuItemText)
	
	Return $MenuItemID
EndFunc

;********************************************************************
; Convert a normal menu item to an ownerdrawn menu item
;********************************************************************

Func _SetOwnerDrawn($hMenu, $MenuItemID, $sText)
	Local $stItemData = DllStructcreate('int')
	DllStructSetData($stItemData, 1, $MenuItemID)
	
	Local $nFlags = BitOr($MF_BYCOMMAND, $MF_OWNERDRAW)
	
	If StringLen($sText) = 0 Then $nFlags = BitOr($nFlags, $MF_SEPARATOR)
	
	ModifyMenu($hMenu, _
			$MenuItemID, _
			$nFlags, _
			$MenuItemID, _
			DllStructGetPtr($stItemData))
EndFunc

;********************************************************************
; Create our special menu font
;********************************************************************

Func _CreateMenuFont($hGUI, $sFontName, $nHeight = 8, $nWidth = 400)
	Local $stFontName = DllStructCreate('char[260]')
	Local $hDC, $nPixel, $hFont
	
	DllStructSetData($stFontName, 1, $sFontName)
	
	$hDC		= _WinAPI_GetDC($hGUI)
	$nPixel		= _WinAPI_GetDeviceCaps($hDC, 90)
	$nHeight	= 0 - _WinAPI_MulDiv($nHeight, $nPixel, 72)
		
	_WinAPI_ReleaseDC($hGUI, $hDC)
	
	$hFont = _WinAPI_CreateFont($nHeight, 0, 0, 0, $nWidth, 0, 0, 0, 0, 0, 0, 0, 0, DllStructGetPtr($stFontName))

	$stFontName = 0
	
	Return $hFont
EndFunc

;********************************************************************
; Get some system menu constants
;********************************************************************

Func _GetMenuInfos(ByRef $nS, ByRef $nX)
	Local $SM_CXSMICON=49
	Local $SM_CXMENUCHECK=71
	$nS	= _WinAPI_GetSystemMetrics($SM_CXSMICON)
	$nX	= _WinAPI_GetSystemMetrics($SM_CXMENUCHECK)
EndFunc

;********************************************************************
; Get the parent menu handle for a menu item
;********************************************************************

Func _GetMenuHandle($nMenuItemID)
	Local $hMenu = 0, $i
	
	For $i = 1 To $arMenuItems[0][0]
		If $arMenuItems[$i][0] = $nMenuItemID Then
			$hMenu = $arMenuItems[$i][3]
			ExitLoop
		EndIf
	Next
	
	Return $hMenu
EndFunc

;********************************************************************
; Get the menu item text
;********************************************************************

Func _GetMenuText($nMenuItemID)
	Local $sText = '', $i
	
	For $i = 1 To $arMenuItems[0][0]
		If $arMenuItems[$i][0] = $nMenuItemID Then
			$sText = $arMenuItems[$i][1]
			ExitLoop
		EndIf
	Next
	
	Return $sText			
EndFunc

;********************************************************************
; Get the maximum text width in a menu
;********************************************************************

Func _GetMenuMaxTextWidth($hDC, $hMenu)
	Local $nMaxWidth = 0, $nWidth = 0, $i, $stSize
	
	For $i = 1 To $arMenuItems[0][0]
		If $arMenuItems[$i][3] = $hMenu Then
			$stSize = _WinAPI_GetTextExtentPoint32($hDC, $arMenuItems[$i][1])
			
			$nWidth = DllStructGetData($stSize, "X")
			
			If $nWidth > $nMaxWidth Then $nMaxWidth = $nWidth
		EndIf
	Next
	
	Return $nMaxWidth
EndFunc

;********************************************************************
; Get the index of an icon from our store
;********************************************************************

Func _GetMenuIsRadio($nMenuItemID)
	Local $bRadio = 0, $i
	
	For $i = 1 To $arMenuItems[0][0]
		If $arMenuItems[$i][0] = $nMenuItemID Then
			$bRadio = $arMenuItems[$i][4]
			ExitLoop
		EndIf
	Next
	
	Return $bRadio			
EndFunc

;********************************************************************
; Get the index of an icon from our store
;********************************************************************

Func _GetMenuIconIndex($nMenuItemID)
	Local $nIconIndex = -1, $i
	
	For $i = 1 To $arMenuItems[0][0]
		If $arMenuItems[$i][0] = $nMenuItemID Then
			$nIconIndex = $arMenuItems[$i][2]
			ExitLoop
		EndIf
	Next
	
	Return $nIconIndex			
EndFunc

Func ModifyMenu($hMenu, $nID, $nFlags, $nNewID, $ptrItemData)
	Local $bResult = DllCall('user32.dll', 'int', 'ModifyMenu', _
												'hwnd', $hMenu, _
												'int', $nID, _
												'int', $nFlags, _
												'int', $nNewID, _
												'ptr', $ptrItemData)
	Return $bResult[0]
EndFunc

#endregion End functions for custom drawn menus
