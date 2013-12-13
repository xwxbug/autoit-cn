#include <WinAPIDlg.au3>
#include <WinAPI.au3>

; Single file selection (returns the fully qualified path)
Local $File = _WinAPI_OpenFileDlg('', @WorkingDir, 'AutoIt v3 Scripts (*.au3)|All Files (*.*)', 1, '', '', BitOR($OFN_PATHMUSTEXIST, $OFN_FILEMUSTEXIST, $OFN_HIDEREADONLY))
If Not @error Then
	ConsoleWrite($File & @CRLF)
EndIf

; Multiple file selection (returns an array)
$File = _WinAPI_OpenFileDlg('', @WorkingDir, 'AutoIt v3 Scripts (*.au3)|All Files (*.*)', 1, '', '', BitOR($OFN_PATHMUSTEXIST, $OFN_FILEMUSTEXIST, $OFN_HIDEREADONLY, $OFN_ALLOWMULTISELECT, $OFN_EXPLORER))
If Not @error Then
	ConsoleWrite('--------------------------------------------------' & @CRLF)
	For $i = 1 To $File[0]
		ConsoleWrite($File[$i] & @CRLF)
	Next
EndIf
