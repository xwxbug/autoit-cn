#region - Program_name install script - (WinZip)

Opt('TrayIconDebug', 1)

; Installer.
$executable = 'filename.ext'
; Show progess. 1 = True, 0 = False.
$splash = 0

; Run the installer.
$pid = _Install()
ProcessWaitClose($pid)

#endregion

Exit

#cs - Exitcodes
	 1 = _Install(): Installer not found
	-1 = Blocked processes not unblocked
#ce

Func _Install($parameter = Default)
	; Run WinZip Installer with Default: /autoinstall.
	Dim $splash, $processblock
	If $parameter = Default Then $parameter = '/autoinstall'
	If Not FileExists(@ScriptDir & '\' & $executable) Then Exit 1
	If $processblock <> '' Then Call('_' & 'ProcessBlock')
	If $splash Then _Splash('Installing:' & StringTrimRight(StringReplace(@ScriptName, '_', ' '), 4))
	Return Run('"' & @ScriptDir & '\' & $executable & '" ' & $parameter)
EndFunc
