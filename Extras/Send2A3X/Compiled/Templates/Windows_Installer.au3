#region - Program_name install script - (MSI)

Opt('TrayIconDebug', 1)

; Installer.
$msi = 'filename.ext'
; Show progess. 1 = True, 0 = False.
$splash = 0
; Default catagory folder in startmenu.
$group = '?'
; New catagory to move the default folder into.
$catagory = '?'

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
	; Run MSI Installer with Default: /qn.
	Dim $splash, $processblock
	If $parameters = Default Then $parameters = '/qn'
	If Not FileExists(@ScriptDir & '\' & $msi) Then Exit 1
	If $processblock <> '' Then Call('_' & 'ProcessBlock')
	If $splash Then _Splash('Installing:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	Return Run('"' & @SystemDir & '\msiexec.exe" /i "' & @ScriptDir & '\' & $msi & '" ' & $parameters)
EndFunc
