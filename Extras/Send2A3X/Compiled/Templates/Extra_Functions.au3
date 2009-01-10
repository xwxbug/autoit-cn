
Func _ProcessBlock()
	; Add process block for select processes
	Dim $processblock
	Local $key, $command
	If Not @OSTYPE = 'WIN32_NT' Then Return $processblock = ''
	If $processblock <> '' Then
		$key = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options'
		If @Compiled Then
			$command = '"' & @ScriptFullPath & '" /dummy'
		Else
			$command = '"' & @AutoItExe & '" "' & @ScriptFullPath & '" /dummy'
		EndIf
		If StringInStr($processblock, '|') Then
			$processarray = StringSplit($processblock, '|')
			For $i = 1 To $processarray[0]
				RegWrite($key & '\' & $processarray[$i], 'debugger','Reg_sz', $command)
			Next
		Else
			RegWrite($key & '\' & $processblock, 'debugger','Reg_sz', $command)
		EndIf
	EndIf
EndFunc

Func OnAutoItExit()
	; Blocked processes will be unblocked.
	Dim $processblock, $silenterror
	Local $key, $exitcode
	If @OSTYPE = 'WIN32_NT' And $processblock <> '' Then
		$key = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options'
		If StringInStr($processblock, '|') Then
			$processarray = StringSplit($processblock, '|')
			For $i = 1 To $processarray[0]
				If RegDelete($key & '\' & $processarray[$i]) = 2 Then
					$exitcode = True
					If Not $silenterror Then
						MsgBox(0x40010, 'Error', 'Registry key for ' & $processarray[$i] & ' still exists', 2)
					EndIf
				EndIf
			Next
		Else
			If RegDelete($key & '\' & $processblock) = 2 Then
				$exitcode = True
				If Not $silenterror Then
					MsgBox(0x40010, 'Error', 'Registry key for ' & $processblock & ' still exists', 2)
				EndIf
			EndIf
		EndIf
	EndIf
	If $exitcode Then Exit -1
EndFunc
