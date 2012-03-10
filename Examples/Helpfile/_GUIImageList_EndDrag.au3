#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <Constants.au3>
#include <WindowsConstants.au3>

#region Globals *************************************************************************
Global $hDragImageList, $hListView, $bDragging = False, $LV_Height
Global $a_index[2] ; 从和到

Global Const $DebugIt = 1

#endregion Globals *************************************************************************

Opt("WinTitleMatchMode", 2)

_Main()

Func _Main()
	Local Const $image_width = 20
	Local Const $image_height = 20
	Local $himages, $main_GUI, $iIndex

	$main_GUI = GUICreate("GuiImageList", 225, 400)

	$hListView = _GUICtrlListView_Create($main_GUI, "Entry Name|Category", 5, 75, 220, 280, -1, BitOR($WS_EX_CLIENTEDGE, $WS_EX_STATICEDGE))
	$LV_Height = 280 - 75
	_GUICtrlListView_SetColumnWidth($hListView, 0, 100)
	_GUICtrlListView_SetColumnWidth($hListView, 1, 100)
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES))
	;------------------------------------------------------
	; 使用子项目图像
	;------------------------------------------------------
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_SUBITEMIMAGES))

	;------------------------------------------------------
	; 创建图像列表
	;------------------------------------------------------
	$himages = _GUIImageList_Create($image_width, $image_height, 5, 1)
	For $x = 1 To 21
		_GUIImageList_AddIcon($himages, @SystemDir & "\shell32.dll", $x)
	Next

	_GUICtrlListView_SetImageList($hListView, $himages, $LVSIL_SMALL)

	;------------------------------------------------------
	;注册事件函数
	;------------------------------------------------------
	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
	GUIRegisterMsg($WM_LBUTTONUP, "WM_LBUTTONUP")
	GUIRegisterMsg($WM_MOUSEMOVE, "WM_MOUSEMOVE")

	;------------------------------------------------------
	; 添加含图像的列表视图项
	;------------------------------------------------------
	Local $y = 1
	For $x = 0 To 9
		$iIndex = _GUICtrlListView_AddItem($hListView, "Name " & $x + 1, $y) ; 句柄, 字符串, 图像索引
		_GUICtrlListView_AddSubItem($hListView, $iIndex, "Category " & $x + 1, 1, $y + 1) ; 句柄, 索引, 字符串, 子项, 图像索引
		$y += 2
	Next

	GUISetState()

	While 1

		Switch GUIGetMsg()

			;-----------------------------------------------------------------------------------------
			;这种情况语句退出并在需要时更新代码
			Case $GUI_EVENT_CLOSE
				ExitLoop
				;-----------------------------------------------------------------------------------------
				;把所有的各种情况填到这里
			Case Else
				;;;
		EndSwitch
	WEnd
	;------------------------------------------------------
	;------------------------------------------------------
	;------------------------------------------------------
	_GUIImageList_Destroy($himages)
	;------------------------------------------------------
	;------------------------------------------------------
	;------------------------------------------------------
	GUIDelete()
EndFunc   ;==>_Main

#region Item Function(s) **********************************************************************************************
;------------------------------------------------------
;------------------------------------------------------
;------------------------------------------------------
Func _LVInsertItem($i_FromItem, $i_ToItem)
	Local $item_state, $i_newIndex
	Local $struct_LVITEM = DllStructCreate($tagLVITEM)
	Local $struct_String = DllStructCreate("char Buffer[4096]")
	Local $sBuffer_pointer = DllStructGetPtr($struct_String)

	; 插入项目到新位置
	DllStructSetData($struct_LVITEM, "Mask", BitOR($LVIF_STATE, $LVIF_IMAGE, $LVIF_INDENT, $LVIF_PARAM, $LVIF_TEXT))
	DllStructSetData($struct_LVITEM, "StateMask", $LVIS_STATEIMAGEMASK)
	DllStructSetData($struct_LVITEM, "Item", $i_FromItem)
	DllStructSetData($struct_LVITEM, "SubItem", 0)
	DllStructSetData($struct_LVITEM, "TextMax", 4096)
	DllStructSetData($struct_LVITEM, "Text", $sBuffer_pointer)
	_GUICtrlListView_GetItemEx($hListView, $struct_LVITEM)
	If @error Then Return SetError(-1, -1, -1)
	$item_state = DllStructGetData($struct_LVITEM, "State")
	DllStructSetData($struct_LVITEM, "Item", $i_ToItem)
	$i_newIndex = _GUICtrlListView_InsertItem($hListView, DllStructGetData($struct_String, "Buffer"), $i_ToItem, DllStructGetData($struct_LVITEM, "Image"))
	If @error Then Return SetError(-1, -1, -1)

	; 还原之前的状态
	If $DebugIt Then _DebugPrint("$i_newIndex = " & $i_newIndex)
	DllStructSetData($struct_LVITEM, "Mask", $LVIF_STATE)
	DllStructSetData($struct_LVITEM, "Item", $i_newIndex)
	DllStructSetData($struct_LVITEM, "State", $item_state)
	DllStructSetData($struct_LVITEM, "StateMask", $LVIS_STATEIMAGEMASK)
	_GUICtrlListView_SetItemState($hListView, $i_newIndex, $item_state, $LVIS_STATEIMAGEMASK)
	If @error Then Return SetError(-1, -1, -1)
	Return $i_newIndex
EndFunc   ;==>_LVInsertItem
;------------------------------------------------------
;------------------------------------------------------
;------------------------------------------------------
Func _LVCopyItem($i_FromItem, $i_ToItem, $i_SubItem = 0)
	Local $struct_LVITEM = DllStructCreate($tagLVITEM)
	Local $struct_String = DllStructCreate("char Buffer[4096]")
	Local $sBuffer_pointer = DllStructGetPtr($struct_String)

	; 获取项目信息
	DllStructSetData($struct_LVITEM, "Mask", BitOR($LVIF_STATE, $LVIF_IMAGE, $LVIF_INDENT, $LVIF_PARAM, $LVIF_TEXT))
	DllStructSetData($struct_LVITEM, "StateMask", $LVIS_STATEIMAGEMASK)
	DllStructSetData($struct_LVITEM, "Item", $i_FromItem)
	DllStructSetData($struct_LVITEM, "SubItem", $i_SubItem)
	DllStructSetData($struct_LVITEM, "TextMax", 4096)
	DllStructSetData($struct_LVITEM, "Text", $sBuffer_pointer)
	_GUICtrlListView_GetItemEx($hListView, $struct_LVITEM)

	; 设置到
	DllStructSetData($struct_LVITEM, "Item", $i_ToItem)
	; 设置文本
	DllStructSetData($struct_LVITEM, "Mask", $LVIF_TEXT)
	DllStructSetData($struct_LVITEM, "Text", $sBuffer_pointer)
	DllStructSetData($struct_LVITEM, "TextMax", 4096)
	_GUICtrlListView_SetItemEx($hListView, $struct_LVITEM)
	If @error Then Return SetError(@error, @error, @error)
	; 设置状态
	DllStructSetData($struct_LVITEM, "Mask", $LVIF_STATE)
	_GUICtrlListView_SetItemEx($hListView, $struct_LVITEM)
	; 设置图像
	DllStructSetData($struct_LVITEM, "Mask", $LVIF_IMAGE)
	DllStructSetData($struct_LVITEM, "State", $LVIF_IMAGE)
	_GUICtrlListView_SetItemEx($hListView, $struct_LVITEM)
	; 设置状态
	DllStructSetData($struct_LVITEM, "Mask", $LVIF_STATE)
	DllStructSetData($struct_LVITEM, "State", $LVIF_STATE)
	_GUICtrlListView_SetItemEx($hListView, $struct_LVITEM)
	; 设置缩进
	DllStructSetData($struct_LVITEM, "Mask", $LVIF_INDENT)
	DllStructSetData($struct_LVITEM, "State", $LVIF_INDENT)
	_GUICtrlListView_SetItemEx($hListView, $struct_LVITEM)
	; 设置参数
	DllStructSetData($struct_LVITEM, "Mask", $LVIF_PARAM)
	DllStructSetData($struct_LVITEM, "State", $LVIF_PARAM)
	_GUICtrlListView_SetItemEx($hListView, $struct_LVITEM)
EndFunc   ;==>_LVCopyItem
#endregion Item Function(s) **********************************************************************************************

#region Event Function(s) **********************************************************************************************
;------------------------------------------------------
;------------------------------------------------------
;------------------------------------------------------
; WM_MOUSEMOVE 事件处理程序
;------------------------------------------------------
;------------------------------------------------------
;------------------------------------------------------
Func WM_MOUSEMOVE($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $MsgID, $wParam
	;------------------------------------------------------
	; 像这里一样不去拖动项目
	;------------------------------------------------------
	If $bDragging = False Then Return $GUI_RUNDEFMSG

	;------------------------------------------------------
	; 更新图像移动
	;------------------------------------------------------
	Local $lpos = ControlGetPos($hWndGUI, "", $hListView)
	Local $x = BitAND($lParam, 0xFFFF) - $lpos[0]
	Local $y = BitShift($lParam, 16) - $lpos[1]
	If $y > $LV_Height - 20 Then
		_GUICtrlListView_Scroll($hListView, 0, $y)
	ElseIf $y < 20 Then
		_GUICtrlListView_Scroll($hListView, 0, $y * - 1)
	EndIf
	_GUIImageList_DragMove($x, $y)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_MOUSEMOVE
;------------------------------------------------------
;------------------------------------------------------
;------------------------------------------------------
; WM_LBUTTONUP 事件处理程序
;------------------------------------------------------
;------------------------------------------------------
;------------------------------------------------------
Func WM_LBUTTONUP($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $MsgID, $wParam
	$bDragging = False
	Local $lpos = ControlGetPos($hWndGUI, "", $hListView)
	Local $x = BitAND($lParam, 0xFFFF) - $lpos[0]
	Local $y = BitShift($lParam, 16) - $lpos[1]
	If $DebugIt Then _DebugPrint("$x = " & $x)
	If $DebugIt Then _DebugPrint("$y = " & $y)
	;------------------------------------------------------
	; 完成拖动
	;------------------------------------------------------
	_GUIImageList_DragLeave($hListView)
	;------------------------------------------------------
	;------------------------------------------------------
	;------------------------------------------------------
	_GUIImageList_EndDrag()
	;------------------------------------------------------
	;------------------------------------------------------
	;------------------------------------------------------
	_GUIImageList_Destroy($hDragImageList[0])
	_WinAPI_ReleaseCapture()
	;------------------------------------------------------
	; 在列表视图中进行点击测试以判断拖动是否结束
	;------------------------------------------------------
	Local $struct_LVHITTESTINFO = DllStructCreate($tagLVHITTESTINFO)

	DllStructSetData($struct_LVHITTESTINFO, "X", $x)
	DllStructSetData($struct_LVHITTESTINFO, "Y", $y)
	$a_index[1] = _SendMessage($hListView, $LVM_HITTEST, 0, DllStructGetPtr($struct_LVHITTESTINFO), 0, "wparam", "ptr")
	Local $flags = DllStructGetData($struct_LVHITTESTINFO, "Flags")
	If $DebugIt Then _DebugPrint("$flags: " & $flags)
	;------------------------------------------------------
;~ 	// Out of the ListView?
	;------------------------------------------------------
	If $a_index[1] == -1 Then Return $GUI_RUNDEFMSG
	;------------------------------------------------------
;~ 	// Not in an item?
	;------------------------------------------------------
	If BitAND($flags, $LVHT_ONITEMLABEL) == 0 And BitAND($flags, $LVHT_ONITEMSTATEICON) == 0 And BitAND($flags, $LVHT_ONITEMICON) = 0 Then Return $GUI_RUNDEFMSG
	;------------------------------------------------------
	; 确保在上面或下面至少插入两项, 不要创建副本
	;------------------------------------------------------
	If $a_index[0] < $a_index[1] - 1 Or $a_index[0] > $a_index[1] + 1 Then
		If $DebugIt Then _DebugPrint("To = " & $a_index[1])
		Local $i_newIndex = _LVInsertItem($a_index[0], $a_index[1])
		If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
		Local $From_index = $a_index[0]
		If $a_index[0] > $a_index[1] Then $From_index = $a_index[0] + 1
		;------------------------------------------------------
		; 复制项目和子项目的图像, 文本以及状态
		;------------------------------------------------------
		For $x = 1 To _GUICtrlListView_GetColumnCount($hListView) - 1
			_LVCopyItem($From_index, $i_newIndex, $x)
			If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
		Next
		;------------------------------------------------------
		; 删除自
		;------------------------------------------------------
		_GUICtrlListView_DeleteItem($hListView, $From_index)
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_LBUTTONUP
;------------------------------------------------------
;------------------------------------------------------
;------------------------------------------------------
; WM_NOTIFY 事件处理程序
;------------------------------------------------------
;------------------------------------------------------
;------------------------------------------------------
Func WM_NOTIFY($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $hWndGUI, $MsgID, $wParam
	Local $tNMHDR, $code, $x, $y, $tNMLISTVIEW, $hwndFrom, $tDraw, $dwDrawStage, $dwItemSpec
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam) ;NMHDR (hwndFrom, idFrom, code)
	If @error Then Return
	$code = DllStructGetData($tNMHDR, "Code")
	$hwndFrom = DllStructGetData($tNMHDR, "hWndFrom")
	Switch $hwndFrom
		Case $hListView
			Switch $code
				Case $LVN_BEGINDRAG
					If $DebugIt Then _DebugPrint("$LVN_BEGINDRAG")
					$x = BitAND($lParam, 0xFFFF)
					$y = BitShift($lParam, 16)
					$tNMLISTVIEW = DllStructCreate($tagNMLISTVIEW, $lParam)
					$a_index[0] = DllStructGetData($tNMLISTVIEW, "Item")
					$hDragImageList = _GUICtrlListView_CreateDragImage($hListView, $a_index[0])
					If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
					_GUIImageList_BeginDrag($hDragImageList[0], 0, 0, 0)
					If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
					If $DebugIt Then _DebugPrint("From = " & $a_index[0])
					_GUIImageList_DragEnter($hListView, $x, $y)
					_WinAPI_SetCapture($hWndGUI)
					$bDragging = True
				Case $NM_CUSTOMDRAW
					If $DebugIt Then _DebugPrint("$NM_CUSTOMDRAW")
					$tDraw = DllStructCreate($tagNMLVCUSTOMDRAW, $lParam)
					$dwDrawStage = DllStructGetData($tDraw, "dwDrawStage")
					$dwItemSpec = DllStructGetData($tDraw, "dwItemSpec")
					Switch $dwDrawStage
						Case $CDDS_PREPAINT
							If $DebugIt Then _DebugPrint("$CDDS_PREPAINT")
							Return $CDRF_NOTIFYITEMDRAW
						Case $CDDS_ITEMPREPAINT
							If $DebugIt Then _DebugPrint("$CDDS_ITEMPREPAINT")
							If BitAND($dwItemSpec, 1) = 1 Then
								DllStructSetData($tDraw, "clrTextBk", $CLR_AQUA)
							Else
								DllStructSetData($tDraw, "clrTextBk", $CLR_WHITE)
							EndIf
							Return $CDRF_NEWFONT
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
#endregion Event Function(s) **********************************************************************************************

Func _DebugPrint($s_text)
	$s_text = StringReplace($s_text, @LF, @LF & "-->")
	ConsoleWrite("!===========================================================" & @LF & _
			"+===========================================================" & @LF & _
			"-->" & $s_text & @LF & _
			"+===========================================================" & @LF)
EndFunc   ;==>_DebugPrint
