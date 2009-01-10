#region - Program_name install script - (InstallShield AFW)

Opt('TrayIconDebug', 1)

; Installer.
$executable = 'filename.ext'
; Show progess. 1 = True, 0 = False.
$splash = 0
; *.log name.
$name = 'Program_name'
; *** Use '' for default settings below ***
; Directory in startmenu that was recorded.
$group = '?'

; Run the installer. Extract the setup.iss.
If Not FileInstall('setup.iss', @WindowsDir & '\', 1) Then
	_Splash('No setup.iss file')
EndIf
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
	; Run a InstallShield AFW Installer with Default: /s /a /s /sms /f1"' & @WindowsDir & '\setup.iss".
	Dim $splash, $name, $processblock
	If $parameters = Default Then
		$parameters = '/s /a /s /sms /f1"' & @WindowsDir & '\setup.iss"'
		If $name <> '' Then $parameters &= ' /f2"' & @TempDir & '\' & $name & '.log"'
	EndIf
	If Not FileExists(@ScriptDir & '\' & $executable) Then Exit 1
	If $processblock <> '' Then Call('_' & 'ProcessBlock')
	If $splash Then _Splash('Installing:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	Return Run('"' & @ScriptDir & '\' & $executable & '" ' & $parameters)
EndFunc
