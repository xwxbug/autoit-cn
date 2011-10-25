#Include <WinAPIEx.au3>
#Include <File.au3>

Opt('MustDeclareVars ', 1)

Global $hFile, $sTemp

; 创建临时文件
$sTemp = _TempFile()
$hFile = FileOpen($sTemp, 2)
FileClose($sTemp)

; 删除到回收站
msgbox(64, 'Created & To be deleted ', StringRegExpReplace($sTemp, '^.*\\', ''))
If FileExists($sTemp) Then
	_WinAPI_ShellFileOperation($sTemp, '', $FO_DELETE, BitOR($FOF_ALLOWUNDO, $FOF_NO_UI)
	If FileExists($sTemp) Then
		msgbox(64, 'info ', 'file not been deleted!')
	Else
		msgbox(64, 'info ', 'file has been deleted!')
	EndIf
EndIf

