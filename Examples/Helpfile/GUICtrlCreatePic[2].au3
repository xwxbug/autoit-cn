#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $gui, $guiPos, $pic, $picPos

Example()

Func Example()
	Local $msg

	$gui = GUICreate("test transparentpic", 200, 100)
	$pic = GUICreate("", 68, 71, 10, 20, $WS_POPUp, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $gui)
	GUICtrlCreatePic("..\GUI\merlin.gif", 0, 0, 0, 0)

	GUISetState(@SW_SHOW, $pic)
	GUISetState(@SW_SHOW, $gui)

	HotKeySet("{ESC}", "Main")
	HotKeySet("{Left}", "Left")
	HotKeySet("{Right}", "Right")
	HotKeySet("{Down}", "Down")
	HotKeySet("{Up}", "Up")
	$picPos = WinGetPos($pic)
	$guiPos = WinGetPos($gui)

	Do
		$msg = GUIGetMsg()
	Until $msg = $GUI_EVENT_CLOSE

	HotKeySet("{ESC}")
	HotKeySet("{Left}")
	HotKeySet("{Right}")
	HotKeySet("{Down}")
	HotKeySet("{Up}")
EndFunc   ;==>Example

Func Main()
	$guiPos = WinGetPos($gui)
	WinMove($gui, "", $guiPos[0] + 10, $guiPos[1] + 10)
EndFunc   ;==>Main

Func Left()
	$picPos = WinGetPos($pic)
	WinMove($pic, "", $picPos[0] - 10, $picPos[1])
EndFunc   ;==>Left

Func Right()
	$picPos = WinGetPos($pic)
	WinMove($pic, "", $picPos[0] + 10, $picPos[1])
EndFunc   ;==>Right

Func Down()
	$picPos = WinGetPos($pic)
	WinMove($pic, "", $picPos[0], $picPos[1] + 10)
EndFunc   ;==>Down

Func Up()
	$picPos = WinGetPos($pic)
	WinMove($pic, "", $picPos[0], $picPos[1] - 10)
EndFunc   ;==>Up
