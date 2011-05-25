#include <Constants.au3>
#NoTrayIcon

Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode",1)	;默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示. 

TrayCreateItem("退出")
TrayItemSetOnEvent(-1, "ExitEvent")

TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE, "SpecialEvent")
TraySetOnEvent($TRAY_EVENT_SECONDARYUP, "SpecialEvent")

TraySetState()

While 1
	Sleep(10)	; 空闲循环
WEnd

Exit


; Functions
Func SpecialEvent()
	Select
		Case @TRAY_ID = $TRAY_EVENT_PRIMARYDOUBLE
			MsgBox(64,"SpecialEvent-Info","主鼠标键双击.")
		Case @TRAY_ID = $TRAY_EVENT_SECONDARYUP
			MsgBox(64,"SpecialEvent-Info","次鼠标键双击.")
	EndSelect
EndFunc   ;==>SpecialEvent


Func ExitEvent()
	Exit
EndFunc   ;==>ExitEvent
