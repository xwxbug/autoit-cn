; ****************
; * 第一个例子	 *
; ****************

#Include <Constants.au3>
#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认托盘菜单项目(脚本已暂停/退出脚本) (Script Paused/Exit) 将不显示.

$prefsitem	= TrayCreateItem("参数")
TrayCreateItem("")
$aboutitem	= TrayCreateItem("关于")
TrayCreateItem("")
$exititem	= TrayCreateItem("退出")

TraySetState()

While 1
	$msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $prefsitem
			Msgbox(64, "参数:", "系统版本:" & @OSVersion)
		Case $msg = $aboutitem
			Msgbox(64, "关于:", "AutoIt3-托盘-例子.")
		Case $msg = $exititem
			ExitLoop
	EndSelect
WEnd

Exit


; *****************
; * 第二个例子	 *
; *****************

#Include <Constants.au3>
#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认托盘菜单项目(脚本已暂停/退出脚本) (Script Paused/Exit) 将不显示.

; Let's create 2 radio menuitem groups
$radio1	= TrayCreateItem("单选1", -1, -1, 1)
TrayItemSetState(-1, $TRAY_CHECKED)
$radio2	= TrayCreateItem("单选2", -1, -1, 1)
$radio3	= TrayCreateItem("单选3", -1, -1, 1)

TrayCreateItem("")	; Radio menuitem groups can be separated by a separator line or another norma menuitem

$radio4	= TrayCreateItem("单选4", -1, -1, 1)
$radio5	= TrayCreateItem("单选5", -1, -1, 1)
TrayItemSetState(-1, $TRAY_CHECKED)
$radio6	= TrayCreateItem("单选6", -1, -1, 1)

TrayCreateItem("")

$aboutitem	= TrayCreateItem("关于")
TrayCreateItem("")
$exititem	= TrayCreateItem("退出")

TraySetState()

While 1
	$msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $aboutitem
			Msgbox(64, "关于:", "AutoIt3-托盘-例子 使用单选子菜单.")
		Case $msg = $exititem
			ExitLoop
	EndSelect
WEnd

Exit