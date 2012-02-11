#NoTrayIcon

Opt("TrayMenuMode", 3) ; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示,并且所选项目不能被选中(checkbox不会打勾) . 请参考TrayMenuMode选项1和2(3=1+2).

Example()

Func Example()
	Local $iExit = TrayCreateItem("退出")

	TraySetState(1) ; Show the tray menu.

	Local $hTimer = TimerInit() ; Begin the timer and store the handle in a variable.
	Local $iDiff = 0, $iIndex = 0

	While 1
		$iDiff = TimerDiff($hTimer) ; Find the difference in time from the previous call of TimerInit
		If $iDiff > 1000 Then ; If the difference is greater than 1 second then change the tray menu icon.

			$iIndex = -Random(0, 100, 1) ; Use a negative number for ordinal numbering.
			TraySetToolTip("Currently using the icon shell32.dll, " & $iIndex & ".") ; Set the tray menu tooltip with information about the icon index.
			TraySetIcon("shell32.dll", $iIndex) ; Set the tray menu icon using the shell32.dll and the random index number.
			$hTimer = TimerInit() ; Reset the timer.

		EndIf

		Switch TrayGetMsg()
			Case $iExit ; Exit the loop.
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Example
