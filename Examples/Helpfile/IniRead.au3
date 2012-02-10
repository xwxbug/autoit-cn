Example()

Func Example()
	; Write the value of 'AutoIt' to the key 'Title' and in the section labelled 'General'.
	IniWrite(@ScriptDir & "\Example.ini", "General", "Title", "AutoIt")

	; Read the INI file for the value of 'Title' in the section labelled 'General'.
	Local $sRead = IniRead(@ScriptDir & "\Example.ini", "General", "Title", "Default Value")

	; Display the value returned by IniRead.
	MsgBox(4096, "", "The value of 'Title' in the section labelled 'General' is: " & $sRead)

	; Delete the key labelled 'Title'.
	IniDelete(@ScriptDir & "\Example.ini", "General", "Title")

	; Read the INI file for the value of 'Title' in the section labelled 'General'.
	$sRead = IniRead(@ScriptDir & "\Example.ini", "General", "Title", "Default Value")

	; Display the value returned by IniRead. Since there is no key stored the value will be the 'Default Value' passed to IniRead.
	MsgBox(4096, "", "The value of 'Title' in the section labelled 'General' is: " & $sRead)

	; Delete the INI file.
	FileDelete(@ScriptDir & "\Example.ini")
EndFunc   ;==>Example
