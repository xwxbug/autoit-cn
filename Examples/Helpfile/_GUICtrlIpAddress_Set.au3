
#include  <GuiConstantsEx.au3>
#include  <GuiIPAddress.au3>

Opt("MustDeclareVars", 1)

$Debug_IP = False ; 检查传递给函数的类名,
设置为真且使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hgui, $hIPAddress

	$hgui = GUICreate( "IP Address
	Control Set(String) 示例" ,  400 ,  300 )

	$hIPAddress = _GUICtrlIpAddress_Create($hgui, 10, 10)
	GUISetState(@SW_SHOW)


	_GUICtrlIpAddress_Set($hIPAddress, "24.168.2.128")

	MsgBox(4160, "Information", "IP Address:
	"  &  _GUICtrlIpAddress_Get ( $hIPAddress ))


	; 等待用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main


