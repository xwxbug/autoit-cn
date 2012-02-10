Example1()
Example2()

Func Example1()
	Local $aDays = StringSplit("Mon,Tues,Wed,Thur,Fri,Sat,Sun", ",") ; Split the string of days using the delimeter "," and the default flag value.
	#cs
		The array returned will contain the following values:
		$aDays[1] = "Mon"
		$aDays[2] = "Tues"
		$aDays[3] = "Wed"
		...
		$aDays[7] = "Sun"
	#ce

	For $i = 1 To $aDays[0] ; Loop through the array returned by StringSplit to display the individual values.
		MsgBox(4096, "Example1", "$aDays[" & $i & "] - " & $aDays[$i])
	Next
EndFunc   ;==>Example1

Func Example2()
	Local $sText = "This\nline\ncontains\nC-style breaks." ; Define a variable with a string of text.
	Local $aArray = StringSplit($sText, '\n', 1) ; Pass the variable to StringSplit and using the delimeter "\n". Note that flag paramter is set to 1.
	#cs
		The array returned will contain the following values:
		$aArray[1] = "This"
		$aArray[2] = "line"
		...
		$aArray[4] = "C-style breaks."
	#ce

	For $i = 1 To $aArray[0] ; Loop through the array returned by StringSplit to display the individual values.
		MsgBox(4096, "Example2", "$aArray[" & $i & "] - " & $aArray[$i])
	Next
EndFunc   ;==>Example2
