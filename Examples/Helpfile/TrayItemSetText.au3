#NoTrayIcon
#include <Constants.au3> ; Required for the $TRAY_ITEM_EXIT and $TRAY_ITEM_PAUSE constants.

Opt("TrayAutoPause",0)	; 当点击托盘图标时脚本不会暂停.
Opt("TrayMenuMode", 2) ; Items are not checked when selected.

Example()

Func Example()
	Local $iRandom = TrayCreateItem("Random:") ; Select this item to change the text with a random number.
	TrayCreateItem("") ; Create a separator line.

	Local $iAbout = TrayCreateItem("关于")

	TraySetState(1) ; Show the tray menu.

	TrayItemSetText($TRAY_ITEM_EXIT,"退出程序") ; Set the text of the default 'Exit' item.
	TrayItemSetText($TRAY_ITEM_PAUSE,"暂停程序") ; Set the text of the default 'Pause' item.

	While 1
		Switch TrayGetMsg()
			Case $iAbout ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
				MsgBox(4096, "", "AutoIt tray menu example." & @CRLF & @CRLF & _
						"Version: " & @AutoItVersion & @CRLF & _
						"Install Path: " & StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1) - 1)) ; Find the folder of a full path.

			Case $iRandom
				; Set the text of the 'Random' item with a random integer.
				TrayItemSetText($iRandom, "Random: " & Int(Random(1, 10, 1)))

		EndSwitch
	WEnd
EndFunc   ;==>Example
