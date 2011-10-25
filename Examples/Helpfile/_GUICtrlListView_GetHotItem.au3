#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作


Global $hListView, $edit, $hStatus

_Main()

Func _Main()
	Local $hGUI

	$hGUI = GUICreate("ListView Get Hot Item", 392, 340)

	$hListView = GUICtrlCreateListView("", 2, 2, 394, 100)
	$hListView = GUICtrlGetHandle($hListView)
	_GUICtrlListView_SetHoverTime($hListView, 1000)
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_TRACKSELECT))
	$edit = GUICtrlCreateEdit("", 2, 104, 394, 210, BitOR($WS_VSCROLL, $ES_AUTOVSCROLL))
	$hStatus = _GUICtrlStatusBar_Create($hGUI)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Column 1", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 2", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 3", 100)

	; 添加项
	_GUICtrlListView_AddItem($hListView, "Row 1: Col 1")
	_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 2", 1)
	_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 3", 2)
	_GUICtrlListView_AddItem($hListView, "Row 2: Col 1")
	_GUICtrlListView_AddSubItem($hListView, 1, "Row 2: Col 2", 1)
	_GUICtrlListView_AddItem($hListView, "Row 3: Col 1")

	;注册 WM_NOTIFY 事件
	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

Func ListView_HOTTRACK($iSubItem)
	Local $HotItem = _GUICtrlListView_GetHotItem($hListView)
	If $HotItem <> -1 Then _GUICtrlStatusBar_SetText($hStatus, "Hot Item:" & $HotItem & " SubItem:" & $iSubItem)
endfunc   ;==>ListView_HOTTRACK

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
	$hWndListView = $hListView
	If Not IsHWnd($hListView) Then $hWndListView = GUICtrlGetHandle($hListView)

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd( DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndListView
			Switch $iCode
				Case $LVN_COLUMNCLICK ; 点击一列
					$tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
					memowrite("$LVN_COLUMNCLICK" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode & @LF)
					memowrite("-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF)
					memowrite("-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF)
					memowrite("-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF)
					memowrite("-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF)
					memowrite("-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF)
					memowrite("-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF)
					memowrite("-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF)
					memowrite("-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; 无返回值
				Case $LVN_DELETEITEM ; 将删除一项
					$tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
					memowrite("$LVN_DELETEITEM" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode & @LF)
					memowrite("-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF)
					memowrite("-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF)
					memowrite("-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF)
					memowrite("-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF)
					memowrite("-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF)
					memowrite("-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF)
					memowrite("-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF)
					memowrite("-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; 无返回值
				Case $LVN_HOTTRACK ; 当鼠标移动到一个项目上时由控件发送
					$tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
					ListView_HOTTRACK( DllStructGetData($tInfo, "SubItem "))
;~        memowrite("$LVN_HOTTRACK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF)
;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF)
;~        memowrite("Code:" & @TAB & $iCode & @LF)
;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF)
;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF)
;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF)
;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF)
;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF)
;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF)
;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF)
;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param"))
;~        Return 0 ; 允许列表视图执行简单的跟踪选定进程.
;~        ;Return 1 ; 项目不被选定.
				Case $LVN_KEYDOWN ; 已按下一键
					$tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
					memowrite("$LVN_KEYDOWN" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode & @LF)
					memowrite("-->VKey:" & @TAB & DllStructGetData($tInfo, "VKey") & @LF)
					memowrite("-->Flags:" & @TAB & DllStructGetData($tInfo, "Flags"))
					; 无返回值
				Case $NM_CLICK ; 鼠标左键点击项目时由控件发送
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					memowrite("$NM_CLICK" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode & @LF)
					memowrite("-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF)
					memowrite("-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF)
					memowrite("-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF)
					memowrite("-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF)
					memowrite("-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF)
					memowrite("-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF)
					memowrite("-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF)
					memowrite("-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF)
					memowrite("-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; 无返回值
				Case $NM_DBLCLK ; 鼠标左键双击项目时由控件发送
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					memowrite("$NM_DBLCLK" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode & @LF)
					memowrite("-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF)
					memowrite("-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF)
					memowrite("-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF)
					memowrite("-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF)
					memowrite("-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF)
					memowrite("-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF)
					memowrite("-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF)
					memowrite("-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF)
					memowrite("-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; 无返回值
				Case $NM_KILLFOCUS ; 控件失去输入焦点
					memowrite("$NM_KILLFOCUS" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode)
					; 无返回值
				Case $NM_RCLICK ; 鼠标右键点击项目时由控件发送
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					memowrite("$NM_RCBLCLK" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode & @LF)
					memowrite("-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF)
					memowrite("-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF)
					memowrite("-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF)
					memowrite("-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF)
					memowrite("-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF)
					memowrite("-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF)
					memowrite("-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF)
					memowrite("-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF)
					memowrite("-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					;Return 1 ; 不允许默认操作
					Return 0 ; 允许默认操作
				Case $NM_RDBLCLK ; 鼠标右键双击项目时由控件发送
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					memowrite("$NM_RDBLCLK" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode & @LF)
					memowrite("-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF)
					memowrite("-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF)
					memowrite("-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF)
					memowrite("-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF)
					memowrite("-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF)
					memowrite("-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF)
					memowrite("-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF)
					memowrite("-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF)
					memowrite("-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; 无返回值
				Case $NM_RETURN ; 控件具有输入焦点且用户已按下ENTER键
					memowrite("$NM_RETURN" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode)
					; 无返回值
				Case $NM_SETFOCUS ; 控件已收到输入焦点
					memowrite("$NM_SETFOCUS" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite("-->Code:" & @TAB & $iCode)
					; 无返回值
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_NOTIFY

Func memowrite($s_text)
	GUICtrlSetData($edit, $s_text & @CRLF, 1)
endfunc   ;==>memowrite

