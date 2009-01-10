#region - Program_name install script - (Tarma Installer)

Opt('TrayIconDebug', 1)

; Installer.
$executable = 'filename.ext'
; Show progess.
$splash = 0
; Directory in startmenu that was recorded.
$group = '?'
; New catagory to move the default folder into.
$catagory = '?'

; Run the installer.
$pid = _Install()
ProcessWaitClose($pid)

; Remove shortcuts.
If _MainShortcut('?.lnk') Then
	FileDelete('?.lnk')
	FileDelete('?.lnk')
	FileDelete('?.lnk')
	FileDelete('?.lnk')
	FileDelete('?.lnk')
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
	; Run a Tarma Installer with Default: /q2.
	Dim $splash, $processblock
	If $parameters = Default Then $parameters = '/q2'
	If Not FileExists(@ScriptDir & '\' & $executable) Then Exit 1
	If $processblock <> '' Then Call('_' & 'ProcessBlock')
	If $splash Then _Splash('Installing:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	Return Run('"' & @ScriptDir & '\' & $executable & '" ' & $parameters)
EndFunc
