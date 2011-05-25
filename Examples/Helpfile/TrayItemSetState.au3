#include <Constants.au3>
#NoTrayIcon

Opt("TrayMenuMode",1)	; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

Local $chkitem		= TrayCreateItem("选中它")
TrayCreateItem("")
Local $checkeditem	= TrayCreateItem("已选中")
TrayCreateItem("")
Local $exititem		= TrayCreateItem("退出")

TraySetState()

While 1
	Local $msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $chkitem
			TrayItemSetState($checkeditem, $TRAY_CHECKED)
		Case $msg = $exititem
			ExitLoop
	EndSelect
WEnd

Exit
