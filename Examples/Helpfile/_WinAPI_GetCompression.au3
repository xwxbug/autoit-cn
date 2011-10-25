#include  <WinAPIEx.au3>

Global $File, $Result

$File = FileOpenDialog('Select File ', @ScriptDir, 'All files (*.*) ', 1 + 2)

If Not @error Then
	$Result = _WinAPI_GetCompression($File)
	If Not @error Then
		Switch $Result
			Case $COMPRESSION_FORMAT_NONE
				If _WinAPI_SetCompression($File, $COMPRESSION_FORMAT_DEFAULT) Then
					msgbox(64, 'Compression File ', 'The file compressed is successfully.')
				Else
					msgbox(16, 'Compression File ', 'The file can not be compressed.')
				EndIf
			Case Else
				If msgbox(36, 'Compression File ', 'The file is already compressed. Decompress?') = 6 Then
					If _WinAPI_SetCompression($File, $COMPRESSION_FORMAT_NONE) Then
						msgbox(64, 'Compression File ', 'The file decompressed is successfully.')
					Else
						msgbox(16, 'Compression File ', 'The file can not be decompressed.')
					EndIf
				EndIf
		EndSwitch
	EndIf
EndIf

