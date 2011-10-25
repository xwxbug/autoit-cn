
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GUIListBox.au3>
#include  <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_LB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hListBox

	; 创建界面
	GUICreate( "List Box Init
	Storage" ,  400 ,  296 )
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState()

	; 添加文件
	_GUICtrlListBox_BeginUpdate($hListBox)
	_GUICtrlListBox_ResetContent($hListBox)
	MsgBox(4160, "Information", "Storage Allocated:" & _GUICtrlListBox_InitStorage($hListBox, 100, 4096))
	_GUICtrlListBox_Dir($hListBox, @WindowsDir & "\win*.exe")

	_GUICtrlListBox_AddFile($hListBox, @WindowsDir & "\Notepad.exe")

	_GUICtrlListBox_EndUpdate($hListBox)

	;
	循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

