
#AutoIt3Wrapper_au3check_Parameters=-q -d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7
Opt("MustDeclareVars", 1)

#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <Constants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

Global $hDragImageList, $edit, $hListView, $bDragging = False, $LV_Height, $edit
Global $a_index[2] ; from and to
Global Const $DebugIt = 1

Opt("WinTitleMatchMode", 2)

_Main()

Func _Main()
	Local Const $image_width = 20
	Local Const $image_height = 20
	Local $himages, $main_GUI, $iIndex

	$main_GUI = GUICreate("GuiImageList Begin Drag", 225, 400)

	$hListView = _GUICtrlListView_Create($main_GUI, "Entry Name|Category", 5, 75, 220, 280, -1, BitOR($WS_EX_CLIENTEDGE, $WS_EX_STATICEDGE))
	$LV_Height = 280 - 75
	_GUICtrlListView_SetColumnWidth($hListView, 0, 100)
	_GUICtrlListView_SetColumnWidth($hListView, 1, 100)
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES))

	; 使用子项图像
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_SUBITEMIMAGES))

	; 创建图像列表
	$himages = _GUIImageList_Create($image_width, $image_height, 5, 1)
	For $x = 1 To 21
		_GUIImageList_AddIcon($himages, @SystemDir & "\shell32.dll", $x)
	Next

	_GUICtrlListView_SetImageList($hListView, $himages, $LVSIL_SMALL)

	; 注册事件函数
	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
	GUIRegisterMsg($WM_LBUTTONUP, "WM_LBUTTONUP")
	GUIRegisterMsg($WM_MOUSEMOVE, "WM_MOUSEMOVE")

	; 添加图像列表项
	Local $y = 1
	For $x = 0 To 9
		$iIndex = _GUICtrlListView_AddItem($hListView, "Name" & $x + 1, $y) ; 句柄, 字符串, 图像索引
		_GUICtrlListView_AddSubItem($hListView, $iIndex, "Category" & $x + 1, 1, $y + 1) ; 句柄, 索引, 字符串, 子项, 图像索引
		$y += 2
	Next

	GUISetState()

	While 1

		Switch GUIGetMsg()

			; 该表达式退出且在需要时更新代码
			Case $GUI_EVENT_CLOSE
				ExitLoop
				; put all the misc. stuff here
			Case Else
				;;;
		EndSwitch
	WEnd
	_GUIImageList_Destroy($himages)
	GUIDelete()
endfunc   ;==>_Main

Func _LVInsertItem($i_FromItem, $i_ToItem)
	Local $item_state, $i_newIndex
	Local $struct_LVITEM = DllStructCreate($tagLVITEM)
	Local $struct_String = DllStructCreate("char Buffer[4096]")
	Local $sBuffer_pointer = DllStructGetPtr($struct_String)

	; 在新位置插入项目
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

	; 还原到以前的状态
	If $DebugIt Then memowrite("$i_newIndex =" & $i_newIndex)
	DllStructSetData($struct_LVITEM, "Mask", $LVIF_STATE)
	DllStructSetData($struct_LVITEM, "Item", $i_newIndex)
	DllStructSetData($struct_LVITEM, "State", $item_state)
	DllStructSetData($struct_LVITEM, "StateMask", $LVIS_STATEIMAGEMASK)
	_GUICtrlListView_SetItemState($hListView, $i_newIndex, $item_state, $LVIS_STATEIMAGEMASK)
	If @error Then Return SetError(-1, -1, -1)
	Return $i_newIndex
endfunc   ;==>_LVInsertItem

Func _LVCopyItem($i_FromItem, $i_ToItem, $i_SubItem = 0)
	Local $struct_LVITEM = DllStructCreate($tagLVITEM)
	Local $struct_String = DllStructCreate("char Buffer[4096]")
	Local $sBuffer_pointer = DllStructGetPtr($struct_String)

	; 从项目信息获取
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
endfunc   ;==>_LVCopyItem

Func WM_MOUSEMOVE($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $MsgID, $wParam
	; 此处不拖曳项目
	If $bDragging = False Then Return $GUI_RUNDEFMSG

	; 更新移动的图像
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
endfunc   ;==>WM_MOUSEMOVE

; WM_LBUTTONUP 事件句柄
Func WM_LBUTTONUP($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $MsgID, $wParam
	$bDragging = False
	Local $lpos = ControlGetPos($hWndGUI, "", $hListView)
	Local $x = BitAND($lParam, 0xFFFF) - $lpos[0]
	Local $y = BitShift($lParam, 16) - $lpos[1]
	If $DebugIt Then memowrite("$x =" & $x)
	If $DebugIt Then memowrite("$y =" & $y)

	; 完成拖曳
	_GUIImageList_DragLeave($hListView)
	_GUIImageList_EndDrag()
	_GUIImageList_Destroy($hDragImageList[0])
	_WinAPI_ReleaseCapture()

	; 点击测试列表视图中的拖曳是否结束
	Local $struct_LVHITTESTINFO = DllStructCreate($tagLVHITTESTINFO)

	DllStructSetData($struct_LVHITTESTINFO, "X", $x)
	DllStructSetData($struct_LVHITTESTINFO, "Y", $y)
	$a_index[1] = _SendMessage($hListView, $LVM_HITTEST, 0, DllStructGetPtr($struct_LVHITTESTINFO), 0, "wparam", "ptr")
	Local $flags = DllStructGetData($struct_LVHITTESTINFO, "Flags")
	If $DebugIt Then memowrite("$flags:" & $flags)

;~  // 超出列表视图?
	If $a_index[1] == -1 Then Return $GUI_RUNDEFMSG
;~  // 不在项中?
	If BitAND($flags, $LVHT_ONITEMLABEL) == 0 And BitAND($flags, $LVHT_ONITEMSTATEICON) == 0 And BitAND($flags, $LVHT_ONITEMICON) = 0 Then Return $GUI_RUNDEFMSG

	; 在上方或下方添加至少 2 项不重复的项
	If $a_index[0] < $a_index[1] - 1 Or $a_index[0] > $a_index[1] + 1 Then
		If $DebugIt Then memowrite("To =" & $a_index[1])
		Local $i_newIndex = _LVInsertItem($a_index[0], $a_index[1])
		If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
		Local $From_index = $a_index[0]
		If $a_index[0] > $a_index[1] Then $From_index = $a_index[0] + 1

		; 复制项目和子项目图像, 文本, 和状态
		For $x = 1 To _GUICtrlListView_GetColumnCount($hListView) - 1
			_LVCopyItem($From_index, $i_newIndex, $x)
			If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
		Next

		; 删除自
		_GUICtrlListView_DeleteItem($hListView, $From_index)
	EndIf
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_LBUTTONUP

; WM_NOTIFY 事件句柄
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
					If $DebugIt Then memowrite("$LVN_BEGINDRAG")
					$x = BitAND($lParam, 0xFFFF)
					$y = BitShift($lParam, 16)
					$tNMLISTVIEW = DllStructCreate($tagNMLISTVIEW, $lParam)
					$a_index[0] = DllStructGetData($tNMLISTVIEW, "Item")
					$hDragImageList = _GUICtrlListView_CreateDragImage($hListView, $a_index[0])
					If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)

					_GUIImageList_BeginDrag($hDragImageList[0], 0, 0, 0)

					If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
					If $DebugIt Then memowrite("From =" & $a_index[0])
					_GUIImageList_DragEnter($hListView, $x, $y)
					_WinAPI_SetCapture($hWndGUI)
					$bDragging = True
				Case $NM_CUSTOMDRAW
					If $DebugIt Then memowrite("$NM_CUSTOMDRAW")
					$tDraw = DllStructCreate($tagNMLVCUSTOMDRAW, $lParam)
					$dwDrawStage = DllStructGetData($tDraw, "dwDrawStage")
					$dwItemSpec = DllStructGetData($tDraw, "dwItemSpec")
					Switch $dwDrawStage
						Case $CDDS_PREPAINT
							If $DebugIt Then memowrite("$CDDS_PREPAINT")
							Return $CDRF_NOTIFYITEMDRAW
						Case $CDDS_ITEMPREPAINT
							If $DebugIt Then memowrite("$CDDS_ITEMPREPAINT")
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
endfunc   ;==>WM_NOTIFY

Func memowrite($s_text)
	GUICtrlSetData($edit, $s_text & @CRLF, 1)
endfunc   ;==>memowrite

