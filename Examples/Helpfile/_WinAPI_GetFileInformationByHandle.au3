#Include <Date.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $tFILETIME, $hFile, $aInfo, $Result

$hFile = _WinAPI_CreateFile(@ScriptFullPath, 2, 0, 6)
$aInfo = _WinAPI_GetFileInformationByHandle($hFile)
If IsArray($aInfo) Then
	For $i = 1 To 3
		If IsDllStruct($aInfo[$i]) Then
			$tFILETIME = _Date_Time_FileTimeToLocalFileTime( DllStructGetPtr($aInfo[$i]))
			$aInfo[$i] = _Date_Time_FileTimeToSystemTime( DllStructGetPtr($tFILETIME))
			$aInfo[$i] = _Date_Time_SystemTimeToDateTimeStr($aInfo[$i])
		Else
			$aInfo[$i] = ' Unknown '
		EndIf
	Next
	$Result = ' Path:' & _WinAPI_GetFinalPathNameByHandle($hFile) & @CRLF
	$Result &= ' Attributes:    0x' & Hex($aInfo[0]) & @CRLF
	$Result &= ' Created:' & $aInfo[1] & @CRLF
	$Result &= ' Accessed:' & $aInfo[2] & @CRLF
	$Result &= ' Modified:' & $aInfo[3] & @CRLF
	$Result &= ' Volume serial:' & $aInfo[4] & @CRLF
	$Result &= ' Size:' & $aInfo[5] & @CRLF
	$Result &= ' Links:' & $aInfo[6] & @CRLF
	$Result &= ' ID:' & $aInfo[7]
EndIf
msgbox(64, 'File Info ', $Result)
_WinAPI_CloseHandle($hFile)

