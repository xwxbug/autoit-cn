Local $i = 0
Do
	MsgBox(4096, "","$i 当前值是:" & $i)  ; Display the value of $i.
	$i = $i + 1 ; Or $i += 1 can be used as well.
Until $i = 10 ; Increase the value of $i until it equals the value of 10.
