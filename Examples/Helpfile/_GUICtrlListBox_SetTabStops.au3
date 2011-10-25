
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GUIListBox.au3>
#include  <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_LB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $aTabs[4] = [3, 100, 200, 300], $hListBox

	; 创建界面
	GUICreate( "List Box Set Tab
	Stops" ,  400 ,  296 )
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($LBS_STANDARD, $LBS_USETABSTOPS))
	GUISetState()

	;
	设置标签中止符
	_GUICtrlListBox_SetTabStops($hListBox, $aTabs)

	;
	添加标签字符串
	_GUICtrlListBox_AddString($hListBox, "Column 1" & @TAB & "Column 2" & @TAB & "Column 3")


	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

