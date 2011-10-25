#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hToken, $aAdjust, $aList

; 启用SeDebugPrivilege权限获取其他进程的完全访问权限
$hToken = _WinAPI_OpenProcessToken( BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, $SE_PRIVILEGE_ENABLED, $aAdjust)

; 获取系统所有进程的命令行参数
$aList = ProcessList()
For $i = 1 To $aList[0][0]
	$aList[$i][1] = _WinAPI_GetProcessCommandLine($aList[$i][1])
Next

; 默认启用SeDebugPrivilege权限
_WinAPI_AdjustTokenPrivileges($hToken, $aAdjust, 0, $aAdjust)
_WinAPI_CloseHandle($hToken)

_arraydisplay($aList, '_WinAPI_GetProcessCommandLine')

