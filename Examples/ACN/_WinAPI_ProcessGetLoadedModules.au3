
; 获取与explorer.exe进程相关的全部模块

#include  <WinAPIEx.au3>
#include  <Array.au3>

$LIST = ProcessList()
For $x = 1 to $LIST[0][0]
	If $LIST[$x][0] = " explorer.exe " Then
		$MODULES = _WinAPI_ProcessGetLoadedModules($LIST[$x][1])
		_arraydisplay($MODULES, $LIST[$x][0])
		ExitLoop
	EndIf
Next

