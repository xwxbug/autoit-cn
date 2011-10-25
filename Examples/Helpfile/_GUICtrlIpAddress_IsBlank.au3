
#include  <GuiConstantsEx.au3>
#include  <GuiIPAddress.au3>

Opt("MustDeclareVars", 1)

$Debug_IP = False ; 检查传递给函数的类名,
设置为真且使用另一控件的句柄观察其工作

Global $iMemo

_Main()

Func _Main()
	Local $msg, $hgui, $clear, $getaddress, $isblank, $button, $hIPAddress

	$hgui = GUICreate( "IP Address
	Control IsBlank 示例" ,  400 ,  300 )

	$hIPAddress = _GUICtrlIpAddress_Create($hgui, 2, 4)

	$iMemo = GUICtrlCreateEdit("", 2, 28, 396, 270, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")

	GUISetState(@SW_SHOW)


	; 查看IP地址是否为空
	MemoWrite("Blank:" & _GUICtrlIpAddress_IsBlank($hIPAddress))

	Sleep(1000)

	_GUICtrlIpAddress_Set($hIPAddress, "24.168.2.128")

	; 查看IP地址是否为空
	MemoWrite("Blank:" & _GUICtrlIpAddress_IsBlank($hIPAddress))

	; 等待用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入文本
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite


