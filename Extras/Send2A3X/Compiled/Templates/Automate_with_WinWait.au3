#region - Program_name install script - (Automated with WinWait functions)

Opt('TrayIconDebug', 1)
Opt('WinDetectHiddenText', 1)
Opt('WinTitleMatchMode', 4)

; Installer.
$executable = 'filename.ext'
; Show progess.
$splash = 0
; Default catagory folder in startmenu.
$group = ''
; New catagory to move the default folder into.
$catagory = ''
; Installation folder in Program Files.
$directory = ''

; Run the installer.
$pid = _Install()
If WinWait('', '', 60) Then
	ControlClick('', '', '')
	WinWait('', '')
	ControlClick('', '', '')
	WinWait('', '')
	ControlClick('', '', '')
	WinWait('', '')
	ControlClick('', '', '')
	WinWait('', '')
	ControlClick('', '', '')
Else
	_Abort()
EndIf
ProcessWaitClose($pid)

; Remove shortcuts.
If _MainShortcut('?.lnk') Then
	; Relative to shortcut directories
	; Remove Startmenu shortcuts
	FileDelete('?.lnk')
	FileDelete('?.lnk')
	FileDelete('?.lnk')
	FileDelete('?.lnk')
	FileDelete('?.lnk')
	; Remove other shortcuts
	_Desktop('?.lnk')
	_QuickLaunch('?.lnk')
EndIf

#endregion

Exit

#cs - Exitcodes
	 1 = _Install(): Installer not found
	 2 = _Abort(): Installer process closed and then Abort
	 3 = _Abort(): Abort only
	-1 = _ProcessBlock(): Blocked processes not unblocked
#ce

Func _Install($path = Default)
	; Run the installer in Default Script directory.
	Dim $splash, $processblock
	If $path = Default Then $path = @ScriptDir
	If StringRight($path, 1) <> '\' Then $path &= '\'
	If StringInStr($executable, '\') Then $path = ''
	If Not FileExists($path & $executable) Then Exit 1
	If $processblock <> '' Then Call('_' & 'ProcessBlock')
	If $splash Then _Splash('Installing:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	If StringRight($executable, 4) = '.msi' Then
		Return Run('"' & @SystemDir & '\msiexec.exe" /i "' & $path & $executable & '"')
	Else
		Return Run('"' & $path & $executable & '"')
	EndIf
EndFunc

Func _Abort()
	; close process if exists then exit.
	Dim $pid
	If ProcessExists($pid) Then
		ProcessClose($pid)
		Exit 2
	Else
		Exit 3
	EndIf
EndFunc
