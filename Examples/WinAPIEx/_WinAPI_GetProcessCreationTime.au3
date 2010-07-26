#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $tFILETIME, $tSYSTEMTIME, $Id = ProcessExists('SciTE.exe')

If $Id > 0 Then
	$tFILETIME = _WinAPI_GetProcessCreationTime($Id)
	$tSYSTEMTIME = _WinAPI_FileTimeToSystemTime(_WinAPI_FileTimeToLocalFileTime($tFILETIME))
	ConsoleWrite('SciTE was run at: ' & _WinAPI_GetTimeFormat(0, $tSYSTEMTIME) & @CR)
EndIf
