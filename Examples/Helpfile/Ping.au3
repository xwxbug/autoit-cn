$var = Ping("www.AutoItScript.com",250)
If $var Then; also possible:  If @error = 0 Then ...
    Msgbox(0,"Status","Online, roundtrip was:" & $var)
Else
    Msgbox(0,"Status","An error occured with number: " & @error)
EndIf