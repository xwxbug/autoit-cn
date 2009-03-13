GUICreate("一个简单的上下文菜单!",300,200)

$trackmenu = GuiCtrlCreateContextMenu ()
$aboutitem = GuiCtrlCreateMenuitem ("关于",$trackmenu)
; next one creates a menu separator (line)
GuiCtrlCreateMenuitem ("",$trackmenu)
$exititem = GuiCtrlCreateMenuitem ("退出",$trackmenu)

GuiSetState()

While 1
	$msg = GuiGetMsg()
	If $msg = $exititem Or $msg = -3 Or $msg = -1 Then ExitLoop
	If $msg = $aboutitem Then Msgbox(0,"关于","一个简单的上下文菜单!")
WEnd

GUIDelete()

Exit