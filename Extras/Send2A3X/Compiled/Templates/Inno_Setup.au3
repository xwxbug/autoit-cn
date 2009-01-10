#region - Program_name install script - (Inno Setup)

Opt('TrayIconDebug', 1)

; Installer.
$executable = 'filename.ext'
; Show progess. 1 = True, 0 = False.
$splash = 0
; Use '' for default settings below
; '' for $group, indicates no shortcut removal
; Default catagory\group folder in startmenu.
$group = '?\?'
; Installation folder in Program Files.
$directory = '?'
; Components to install.
$components = '?'
; Specify language.
$language = '?'

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
	; Run a Inno Setup Installer with Default: /Sp- /NoRestart /VerySilent /SuppressMsgBoxes.
	Dim $splash, $group, $directory, $components, $language, $processblock
	If $parameters = Default Then
		$parameters = '/Sp- /NoRestart /VerySilent /SuppressMsgBoxes'
		If $group <> '' Then $parameters &= ' /Group="' & $group & '"'
		If $directory <> '' Then $parameters &= ' /Dir="' & @ProgramFilesDir & '\' & $directory & '"'
		If $components <> '' Then $parameters &= ' /Components="' & $components & '"'
		If $language <> '' Then $parameters &= ' /Lang=' & $language
	EndIf
	If Not FileExists(@ScriptDir & '\' & $executable) Then Exit 1
	If $processblock <> '' Then Call('_' & 'ProcessBlock')
	If $splash Then _Splash('Installing:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	Return Run('"' & @ScriptDir & '\' & $executable & '" ' & $parameters)
EndFunc
