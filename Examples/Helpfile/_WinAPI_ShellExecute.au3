#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Local $File

; InputBox('运行', '输入程序, 文件夹, 文档或网络资源名称以打开'....
$File = InputBox('Run ', 'Type the name of a program , folder , document , or Internet resource to open it ', '', '', 368, 152)
If $File Then
	_WinAPI_ShellExecute($File, '', '', 'open')
	If @error Then
		msgbox(16, 'Error ', 'Unable to open "'& $File & ' ".' & @CR & @CR & @extended)
	EndIf
EndIf

