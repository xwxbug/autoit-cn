#include <WinAPIFiles.au3>
#include <APISysConstants.au3>
#include <MsgBoxConstants.au3>

Global $File = FileOpenDialog('Select File', @ScriptDir, 'All Files (*.*)', 1 + 2)
If @error Then Exit

Switch _WinAPI_GetCompression($File)
	Case -1
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Compression File', 'Unable to perform operation.')
	Case $COMPRESSION_FORMAT_NONE
		If _WinAPI_SetCompression($File, $COMPRESSION_FORMAT_DEFAULT) Then
			MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Compression File', 'The file compressed is successfully.')
		Else
			MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Compression File', 'Unable to compress file.')
		EndIf
	Case Else
		If MsgBox(BitOR($MB_YESNO, $MB_ICONQUESTION, $MB_SYSTEMMODAL), 'Compression File', 'The file is already compressed.' & @CRLF & @CRLF & 'Decompress?') = 6 Then
			If _WinAPI_SetCompression($File, $COMPRESSION_FORMAT_NONE) Then
				MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Compression File', 'The file decompressed is successfully.')
			Else
				MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Compression File', 'Unable to decompress file.')
			EndIf
		EndIf
EndSwitch
