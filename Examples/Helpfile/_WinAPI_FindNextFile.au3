#include <WinAPIFiles.au3>
#include <WinAPIDiag.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>

Global $List[101][2] = [[0]]

Local $tData = DllStructCreate($tagWIN32_FIND_DATA)
Local $pData = DllStructGetPtr($tData)

Local $File
Local $hSearch = _WinAPI_FindFirstFile(@ScriptDir & '\*', $pData)
While Not @error
	$File = DllStructGetData($tData, 'cFileName')
	Switch $File
		Case '.', '..'

		Case Else
			If Not BitAND(DllStructGetData($tData, 'dwFileAttributes'), $FILE_ATTRIBUTE_DIRECTORY) Then
				$List[0][0] += 1
				If $List[0][0] > UBound($List) - 1 Then
					ReDim $List[UBound($List) + 100][2]
				EndIf
				$List[$List[0][0]][0] = $File
				$List[$List[0][0]][1] = _WinAPI_MakeQWord(DllStructGetData($tData, 'nFileSizeLow'), DllStructGetData($tData, 'nFileSizeHigh'))
			EndIf
	EndSwitch
	_WinAPI_FindNextFile($hSearch, $pData)
WEnd

Switch @extended
	Case 18 ; ERROR_NO_MORE_FILES

	Case Else
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
		Exit
EndSwitch

_WinAPI_FindClose($hSearch)

_ArrayDisplay($List, '_WinAPI_Find...', $List[0][0])
