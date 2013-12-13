#include <WinAPIFiles.au3>
#include <APIFilesConstants.au3>
#include <MsgBoxConstants.au3>

Local $Text, $Path = @MyDocumentsDir & '\'
While 1
	$Path = FileOpenDialog('Select File', _WinAPI_PathRemoveFileSpec($Path), 'All Files (*.*)', 1 + 2)
	If $Path Then
		If _WinAPI_GetBinaryType($Path) Then
			Switch @extended
				Case $SCS_32BIT_BINARY
					$Text = ' is 32-bit Windows-based application.'
				Case $SCS_64BIT_BINARY
					$Text = ' is 64-bit Windows-based application.'
				Case $SCS_DOS_BINARY
					$Text = ' is MS-DOS–based application.'
				Case $SCS_OS216_BINARY
					$Text = ' is 16-bit OS/2-based application.'
				Case $SCS_PIF_BINARY
					$Text = ' is PIF file that executes an MS-DOS–based application.'
				Case $SCS_POSIX_BINARY
					$Text = ' is POSIX–based application.'
				Case $SCS_WOW_BINARY
					$Text = ' is 16-bit Windows-based application.'
				Case Else
					$Text = ' is unknown executable type.'
			EndSwitch
		Else
			$Text = ' is not executable file.'
		EndIf
		MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), '_WinAPI_GetBinaryType()', '"' & _WinAPI_PathStripPath($Path) & '"' & $Text)
	Else
		ExitLoop
	EndIf
WEnd
