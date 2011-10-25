#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIComboBox.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作

Global $hCombo

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" (UDF) ComboBox Create ", 400, 296)
	$hCombo = _GUICtrlComboBox_Create($hGUI, "", 2, 272, 396, 296)
	$edit = GUICtrlCreateEdit("", 2, 2, 396, 266, BitOR($WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState()

	; 添加文件
	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, "", $DDL_DRIVES, False)
	_GUICtrlComboBox_EndUpdate($hCombo)

	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND ")

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode, $hWndCombo
	If Not IsHWnd($hCombo) Then $hWndCombo = GUICtrlGetHandle($hCombo)
	$hWndFrom = $ilParam
	$iIDFrom = BitAND($iwParam, 0xFFFF) ; Low Word
	$iCode = BitShift($iwParam, 16) ; Hi Word
	Switch $hWndFrom
		Case $hCombo, $hWndCombo
			Switch $iCode
				Case $CBN_CLOSEUP ; 组合框的列表框关闭时发送
					memowrite(" $CBN_CLOSEUP" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_DBLCLK ; 双击组合框的列表框中的一个字符串时发送
					memowrite(" $CBN_DBLCLK" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_DROPDOWN ; 当组合框的列表框将可见时发送
					memowrite(" $CBN_DROPDOWN" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_EDITCHANGE ; 在组合框的编辑控件部分中执行选择文本操作后发送
					memowrite(" $CBN_EDITCHANGE" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_EDITUPDATE ; 组合框编辑控件部分显示可选文本时发送
					memowrite(" $CBN_EDITUPDATE" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_ERRSPACE ; 组合框无法分配足够内存以满足请求时发送
					memowrite(" $CBN_ERRSPACE" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_KILLFOCUS ; 组合框丢失键盘焦点时发送
					memowrite(" $CBN_KILLFOCUS" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_SELCHANGE ; 组合框的列表框中的当前选项改变时发送
					memowrite(" $CBN_SELCHANGE" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_SELENDCANCEL ; 选定一个项目时发送, 然后选取另一控件或关闭对话框
					memowrite(" $CBN_SELENDCANCEL" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_SELENDOK ; 选取一个列表项或一个项目后关闭列表时发送
					memowrite(" $CBN_SELENDOK" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $CBN_SETFOCUS ; 组合框收到键盘焦点时发送
					memowrite(" $CBN_SETFOCUS" & @LF)
					memowrite(" -->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite(" -->IDFrom:" & @TAB & $iIDFrom & @LF)
					memowrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_COMMAND

Func memowrite($s_text)
	GUICtrlSetData($edit, $s_text & @CRLF, 1)
endfunc   ;==>memowrite

