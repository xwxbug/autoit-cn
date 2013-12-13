#RequireAdmin

#include <WinAPIProc.au3>
#include <WinAPI.au3>
#include <Array.au3>

Global $aAdjust, $aList = 0

; Enable "SeDebugPrivilege" privilege for obtain full access rights to another processes
Local $hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, $SE_PRIVILEGE_ENABLED, $aAdjust)

; Retrieve user names for all processes the system
If Not (@error Or @extended) Then
	$aList = ProcessList()
	Local $Data
	For $i = 1 To $aList[0][0]
		$Data = _WinAPI_GetProcessUser($aList[$i][1])
		If IsArray($Data) Then
			$aList[$i][1] = $Data[0]
		Else
			$aList[$i][1] = ''
		EndIf
	Next
EndIf

; Enable SeDebugPrivilege privilege by default
_WinAPI_AdjustTokenPrivileges($hToken, $aAdjust, 0, $aAdjust)
_WinAPI_CloseHandle($hToken)

_ArrayDisplay($aList, '_WinAPI_GetProcessUser')
