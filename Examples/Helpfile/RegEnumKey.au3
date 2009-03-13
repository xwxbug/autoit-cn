For $i= 1 to 10
	$var = RegEnumKey("HKEY_LOCAL_MACHINE\SOFTWARE", $i)
	If @error <> 0 then ExitLoop
	MsgBox(4096, "SubKey #" & $i & " under HKLM\Software: ", $var)
Next

