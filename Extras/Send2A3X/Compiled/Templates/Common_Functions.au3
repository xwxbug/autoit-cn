
Func _Desktop($shortcut)
	; Delete a Desktop shortcut.
	If FileExists(@DesktopDir & '\' & $shortcut) Then
		Return FileDelete(@DesktopDir & '\' & $shortcut)
	ElseIf FileExists(@DesktopCommonDir & '\' & $shortcut) Then
		Return FileDelete(@DesktopCommonDir & '\' & $shortcut)
	EndIf
EndFunc

Func _MainShortcut($shortcut, $rename = '')
	; Change working directory to correct StartMenu\Group directory.
	Dim $group, $catagory, $splash
	If $group = '' Then Return 0
	If FileExists(@ProgramsDir & '\' & $group) Then
		FileChangeDir(@ProgramsDir & '\' & $group)
	ElseIf FileExists(@ProgramsCommonDir & '\' & $group) Then
		FileChangeDir(@ProgramsCommonDir & '\' & $group)
	Else
		Return 0
	EndIf
	; Wait for main shortcut.
	If $splash Then _Splash('Waiting for shortcuts')
	For $i = 1 To 20
		If FileExists($shortcut) Then ExitLoop
		Sleep(500)
	Next
	If $splash Then _Splash('Cleaning up:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	; If catagory not assigned anything, then return.
	If $catagory = '' Then Return 1
	; Move the group folder into the catagory folder.
	If FileChangeDir('..') And DirCopy($group, $catagory & '\' & $group, 1) Then
		If DirRemove($group, 1) Then
			; If optional rename parameter is used, then rename the group folder.
			If $rename <> '' And FileChangeDir($catagory) Then
				If DirCopy($group, $rename, 1) And DirRemove($group, 1) Then
					Return FileChangeDir($rename)
				EndIf
			Else
				Return FileChangeDir($catagory & '\' & $group)
			EndIf
		EndIf
	EndIf
EndFunc

Func _QuickLaunch($shortcut)
	; Delete a Quicklaunch shortcut.
	Local $subdirs = 'Microsoft\Internet Explorer\Quick Launch'
	If FileExists(@AppDataDir & '\' & $subdirs & '\' & $shortcut) Then
		Return FileDelete(@AppDataDir & '\' & $subdirs & '\' & $shortcut)
	ElseIf FileExists(@AppDataCommonDir & '\' & $subdirs & '\' & $shortcut) Then
		Return FileDelete(@AppDataCommonDir & '\' & $subdirs & '\' & $shortcut)
	EndIf
EndFunc

Func _Splash($text = '')
	; Shows a small borderless splash message.
	Dim $splash
	If $splash Then
		If $text Then
			SplashTextOn('', $text, 500, 25, -1, 5, 1, '', 14)
		Else
			SplashOff()
		EndIf
	EndIf
EndFunc

Func _WinClose($title, $text = '')
	; Close a window with further attempts.
	For $i = 1 To 10
		WinClose($title, $text)
		If Not WinExists($title) Then Return 1
		Sleep(500)
	Next
EndFunc

Func OnAutoItStart()
	; A 2nd script instance will exit.
	If StringInStr($CMDLINERAW, '/dummy') Then Exit
	If WinExists(@ScriptName & '_Interpreter') Then Exit
	AutoItWinSetTitle(@ScriptName & '_Interpreter')
EndFunc
