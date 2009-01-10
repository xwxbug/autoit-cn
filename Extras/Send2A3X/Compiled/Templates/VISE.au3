#region - Program_name install script - (VISE)

Opt('TrayIconDebug', 1)

; Installer.
$executable = 'filename.ext'
; Show progess. 1 = True, 0 = False.
$splash = 0
; Default catagory folder in startmenu.
$group = '?'
; New catagory to move the default folder into.
$catagory = '?'
; Installation folder in Program Files.
$directory = '?'

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
	-1 = Blocked processes not unblocked
#ce

Func _Install($parameters = Default)
	; Run a VISE Installer  with Default: /s.
	Dim $splash, $directory, $processblock
	If $parameters = Default Then
		$parameters = '/s'
		If $directory <> '' Then $parameters &= ' /t:"' & @ProgramFilesDir & '\' & $directory & '"'
	EndIf
	If Not FileExists(@ScriptDir & '\' & $executable) Then Exit 1
	If $processblock <> '' Then Call('_' & 'ProcessBlock')
	If $splash Then _Splash('Installing:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	Return Run('"' & @ScriptDir & '\' & $executable & '" ' & $parameters)
EndFunc
