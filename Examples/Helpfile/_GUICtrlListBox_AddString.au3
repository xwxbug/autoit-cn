#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GUIListBox.au3>
#include  <GuiConstantsEx.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

$Debug_LB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hListBox

	; 创建界面
	GUICreate(" ListBox Add String ", 400, 296)
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOTIFY, $LBS_DISABLENOSCROLL, $WS_HSCROLL))

	GUISetState()

	; 添加字符串
	_GUICtrlListBox_BeginUpdate($hListBox)
	For $iI = 1 To 9
		_GUICtrlListBox_AddString($hListBox, StringFormat("%03d : Random string ", Random(1, 100, 1)))
	Next
	_GUICtrlListBox_InsertString($hListBox, "Exact teXt ", 3)
	_GUICtrlListBox_InsertString($hListBox, "This is the string that we're looking for ", 6)
	_GUICtrlListBox_InsertString($hListBox, _
			" Let ' s add one really long line of text so that we can set the horizontal scroll bar and show that , unless we dynamically update the scroll baar, it won't show the full line. ", 9)
	_GUICtrlListBox_UpdateHScroll($hListBox)
	_GUICtrlListBox_EndUpdate($hListBox)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

