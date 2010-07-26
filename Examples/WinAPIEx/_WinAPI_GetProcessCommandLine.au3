#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $hToken, $aList

; Enable SeDebugPrivilege privilege for obtain full access rights to another processes
$hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, 1)

; Retrieve command-line arguments for all processes the system
$aList = ProcessList()
For $i = 1 To $aList[0][0]
	$aList[$i][1] = _WinAPI_GetProcessCommandLine($aList[$i][1])
Next

; Enable SeDebugPrivilege privilege by default
_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, 2)
_WinAPI_CloseHandle($hToken)

_ArrayDisplay($aList, '_WinAPI_GetProcessCommandLine')
