For $i = 1 to 100
$var = RegEnumVal("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\Autoit", $i)
if @error <> 0 Then ExitLoop
MsgBox(4096, "Value Name  #" & $i & " under in AutoIt3 key", $var)
next