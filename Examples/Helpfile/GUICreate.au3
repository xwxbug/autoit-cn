#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Example1()
Example2()

;示例 1
Func Example1()
	Local $msg

	GUICreate("My GUI") ; 创建一个居中显示的 GUI 窗口
	GUISetState(@SW_SHOW) ; 显示一个空白的窗口

	; 运行界面，直到窗口被关闭
	While 1
		$msg = GUIGetMsg()

		If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	GUIDelete()
EndFunc   ;==>Example1

;示例 2
Func Example2()
	Local $gui, $background, $pic, $basti_stay, $msg
	Local $sFile = "..\GUI\logo4.gif"
	
	$gui = GUICreate("Background", 400, 100)
	; 创建背景图片
	$background = GUICtrlCreatePic("..\GUI\msoobe.jpg", 0, 0, 400, 100)	
		
	GUISetState(@SW_SHOW)

	; 创建透明的 MDI子窗口
	$pic = GUICreate("", 169, 68, 20, 20, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $gui)
	; 透明图片
	$basti_stay = GUICtrlCreatePic($sFile, 0, 0, 169, 68)
	GUISetState(@SW_SHOW)

	Do
		$msg = GUIGetMsg()

	Until $msg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example2