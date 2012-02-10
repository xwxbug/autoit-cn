Example()

Func Example()
	; Create an INI section structure as a string.
	Local $sSection = "Title=AutoIt" & @LF & "Version=" & @AutoItVersion & @LF & "OS=" & @OSVersion

	; Write the string to the sections labelled 'General', 'Version' and 'Other'.
	IniWriteSection(@ScriptDir & "\Example.ini", "General", $sSection)
	IniWriteSection(@ScriptDir & "\Example.ini", "Version", $sSection)
	IniWriteSection(@ScriptDir & "\Example.ini", "Other", $sSection)

	; Read the INI section names. This will return a 1 dimensional array.
	Local $aArray = IniReadSectionNames(@ScriptDir & "\Example.ini")

	; Check if an error occurred.
	If Not @error Then
		; Enumerate through the array displaying the section names.
		For $i = 1 To $aArray[0]
			MsgBox(4096, "", "Section: " & $aArray[$i])
		Next
	EndIf

	; Delete the INI file.
	FileDelete(@ScriptDir & "\Example.ini")
EndFunc   ;==>Example
