#NoTrayIcon

Opt("TrayMenuMode", 3) ; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示,并且所选项目不能被选中(checkbox不会打勾) . 请参考TrayMenuMode选项1和2(3=1+2).

Example()

Func Example()
	Local $iDelete = TrayCreateItem("删除")
	TrayCreateItem("") ; Create a separator line.

	Local $iAbout = TrayCreateItem("关于")
	TrayCreateItem("") ; Create a separator line.

	Local $iExit = TrayCreateItem("退出")

	TraySetState(1) ; Show the tray menu.

	While 1
		Switch TrayGetMsg()
			Case $iAbout ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
				MsgBox(4096, "", "AutoIt tray menu example." & @CRLF & @CRLF & _
						"Version: " & @AutoItVersion & @CRLF & _
						"Install Path: " & StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1) - 1)) ; Find the folder of a full path.

			Case $iDelete
				; Display a message box to ask whether or not to delete the 'Delete' item. If the return value of MsgBox is equal to 6 then delete the item.
				If MsgBox(4, "", "Do you want to delete the 'Delete' tray menu item?") = 6 Then
					TrayItemDelete($iDelete) ; Delete the tray menu item.
				EndIf

			Case $iExit ; Exit the loop.
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Example
