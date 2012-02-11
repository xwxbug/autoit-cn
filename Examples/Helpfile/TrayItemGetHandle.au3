#NoTrayIcon

Opt("TrayMenuMode", 3) ; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示,并且所选项目不能被选中(checkbox不会打勾) . 请参考TrayMenuMode选项1和2(3=1+2).

Global Const $MIM_APPLYTOSUBMENUS = 0x80000000, $MIM_BACKGROUND = 0x00000002 ; Constants required for SetMenuColor

Example()

Func Example()
	Local $iSettings = TrayCreateMenu("设置") ; Create a tray menu sub menu with two sub items.
	Local $iDisplay = TrayCreateItem("显示", $iSettings)
	Local $iPrinter = TrayCreateItem("打印", $iSettings)
	TrayCreateItem("") ; Create a separator line.

	Local $iAbout = TrayCreateItem("关于")
	TrayCreateItem("") ; Create a separator line.

	Local $iExit = TrayCreateItem("退出例子")

	TraySetState(1) ; Show the tray menu.

	SetMenuColor(0, 0xEEBB99)   ; BGR 颜色值, '0' 的意思是托盘关联菜单自己.
	SetMenuColor($iSettings, 0x66BB99); BGR 颜色值

	While 1
		Switch TrayGetMsg()
			Case $iAbout ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
				MsgBox(4096, "", "关于托盘菜单例子." & @CRLF & @CRLF & _
						"程序版本: " & @AutoItVersion & @CRLF & _
						"安装路径: " & StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1) - 1)) ; Find the folder of a full path.

			Case $iDisplay, $iPrinter
				MsgBox(4096, "", "A sub menu item was selected from the tray menu.")

			Case $iExit ; Exit the loop.
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Example

; 应用菜单颜色
Func SetMenuColor($iMenuID, $iColor)
	Local $hMenu  = TrayItemGetHandle($iMenuID) ; 得到内部菜单句柄

	Local $hBrush = DllCall("gdi32.dll", "hwnd", "CreateSolidBrush", "int", $iColor)
	$hBrush = $hBrush[0]

	Local $tMenuInfo = DllStructCreate("dword;dword;dword;uint;ptr;dword;ptr")
	DllStructSetData($tMenuInfo, 1, DllStructGetSize($tMenuInfo))
	DllStructSetData($tMenuInfo, 2, BitOR($MIM_APPLYTOSUBMENUS, $MIM_BACKGROUND))
	DllStructSetData($tMenuInfo, 5, $hBrush)

	DllCall("user32.dll", "int", "SetMenuInfo", "hwnd", $hMenu, "ptr", DllStructGetPtr($tMenuInfo))
EndFunc   ;==>SetMenuColor
