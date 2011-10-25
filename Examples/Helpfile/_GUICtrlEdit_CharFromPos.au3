
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiEdit.au3>
#include  <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_Ed = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $aCharPos[2], $hEdit

	; 创建界面
	GUICreate("Edit Char From Pos", 400, 300)

	$hEdit = GUICtrlCreateEdit( "This is
	a test"  &  @CRLF  &  " Another
	Line" ,  2 ,  2 ,  394 ,  268 )
	GUISetState()

	_GUICtrlEdit_AppendText($hEdit, @CRLF & "Append to the end?")

	$aCharPos = _GUICtrlEdit_CharFromPos($hEdit, 100, 20)
	MsgBox(4160, "Information", StringFormat( "Char Nearsest
	Point:[%2d] " ,  $aCharPos [ 0 ])  &  @LF  &  _
			StringFormat( "Line Nearest
	Point:[%2d] " ,  $aCharPos [ 1 ]))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

