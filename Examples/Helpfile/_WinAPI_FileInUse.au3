#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hFile = FileOpen(@ScriptFullPath)

While 1
	Switch _WinAPI_FileInUse(@ScriptFullPath)
		case 1
			msgbox(0, 0, @ScriptName & ' is in use')
			FileClose($hFile)
		case 0
			msgbox(0, 0, @ScriptName & ' is not in use')
			ExitLoop
	EndSwitch
WEnd

