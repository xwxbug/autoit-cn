If Not IsDeclared ("a") then
    MsgBox(0,"", "$a is NOT declared")     ; $a has never been assigned
EndIf

$a=1

If IsDeclared ("a") then
    MsgBox(0,"", "$a IS declared"  )      ; due to previous $a=1 assignment
EndIf
