#region - Program_name install script - (InstallShield Unpacked)

Opt('TrayIconDebug', 1)

; Installer.
$executable = 'filename.ext'
; Show progess. 1 = True, 0 = False.
$splash = 0
; Directory in startmenu that was recorded.
$group = '?'
; *.log name.
$name = 'Program_name'

; Run the installer.
$pid = _Install()
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
	-1 = _ProcessBlock(): Blocked processes not unblocked
#ce

Func _Install($parameters = Default)
	; Run InstallShield Unpacked Installer with Default: /s /sms.
	Dim $splash, $name, $processblock
	If $parameters = Default Then
		$parameters = '/s /sms'
		If $name <> '' Then $parameters &= ' /f2"' & @TempDir & '\' & $name & '.log"'
	EndIf
	If Not FileExists(@ScriptDir & '\' & $executable) Then Exit 1
	If $processblock <> '' Then Call('_' & 'ProcessBlock')
	If $splash Then _Splash('Installing:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	Return Run('"' & @ScriptDir & '\' & $executable & '" ' & $parameters)
EndFunc
