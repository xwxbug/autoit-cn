#include <WinAPIShellEx.au3>
#include <MsgBoxConstants.au3>

Global $File = InputBox('Run', 'Type the name of a program, folder, document, or Internet resource to open it', '', '', 368, 152)

If $File Then
	_WinAPI_ShellExecute($File, '', '', 'open')
	If @error Then
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to open "' & $File & '".' & @CRLF & @CRLF & @extended)
	EndIf
EndIf
