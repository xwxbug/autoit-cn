#Include <APIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $sTemp

; 创建临时文件
$sTemp = _WinAPI_GetTempFileName(@TempDir)

ShellExecute('::{645FF040-5081-101B-9F08-00AA002F954E}')

; 删除到回收站
If FileExists($sTemp) Then
	_WinAPI_ShellFileOperation($sTemp, '', $FO_DELETE, BitOR($FOF_ALLOWUNDO, $FOF_NO_UI))
EndIf
