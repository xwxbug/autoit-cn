#RequireAdmin

#Include <APIConstants.au3>
#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $hToken, $Data, $aAdjust, $aList = 0

; 为获取对其他进程的完全访问权限而启用 "SeDebugPrivilege" 特权
$hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, $SE_PRIVILEGE_ENABLED, $aAdjust)

; 为系统上所有进程获取用户名
If Not (@error Or @extended) Then
	$aList = ProcessList()
	For $i = 1 To $aList[0][0]
		$Data = _WinAPI_GetProcessUser($aList[$i][1])
		If IsArray($Data) Then
			$aList[$i][1] = $Data[0]
		Else
			$aList[$i][1] = ''
		EndIf
	Next
EndIf

; 默认情况下启用 SeDebugPrivilege 特权
_WinAPI_AdjustTokenPrivileges($hToken, $aAdjust, 0, $aAdjust)
_WinAPI_CloseHandle($hToken)

_ArrayDisplay($aList, '_WinAPI_GetProcessUser')
