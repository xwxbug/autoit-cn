
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiEdit.au3>
#include  <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_Ed = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hEdit

	; 创建界面
	GUICreate( "Edit Get First
	Visible Line" ,  400 ,  300 )
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268)
	GUISetState()

	For $x = 0 To 20
		_GUICtrlEdit_AppendText($hEdit, StringFormat( "[%02d] Append
		to the end?" ,  $x )  &  @CRLF )
	Next

	MsgBox(4160, "Information", "First Visible Line:" & _GUICtrlEdit_GetFirstVisibleLine($hEdit))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

