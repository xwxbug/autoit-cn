Example1() ; Flip a coin.
Example2() ; Roll a die.
Example3() ; Create a random string of text.

Func Example1()
	If Random(0, 1, 1) Then ; Return an integer between 0 and 1.
		MsgBox(4096, "", "The side of the coin was: Heads") ; If the random integer was 1 then heads was thrown.
	Else
		MsgBox(4096, "", "The side of the coin was: Tails") ; If the random integer was 0 then tails was thrown.
	EndIf
EndFunc   ;==>Example1

Func Example2()
	MsgBox(4096, "", "The die landed on number " & Random(1, 6, 1) & ".") ; Return an integer between 1 and 6.
EndFunc   ;==>Example2

Func Example3()
	Local $sText = ""
	For $i = 1 To Random(5, 20, 1) ; Return an integer between 5 and 20 to determine the length of the string.
		$sText &= Chr(Random(65, 122, 1)) ; Return an integer between 65 and 122 which represent the ASCII characters between a (lower-case) to Z (upper-case).
	Next
	MsgBox(4096, "", "The random string of text was: " & $sText) ; Display the string of text.
EndFunc   ;==>Example3
