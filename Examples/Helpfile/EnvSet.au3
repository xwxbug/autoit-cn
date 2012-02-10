Example()

Func Example()
	; Create an environment variable called %MYVAR% and assign it a value. When you assign or retrieve an envorinment variable you do so minus the percentage signs (%).
	EnvSet("MYVAR", "This is some text!")

	; Retrieve the environment variable that was just assigned a value previously.
	Local $sEnvVar = EnvGet("MYVAR")

	; Display the value of the environment variable $MYVAR%.
	MsgBox(4096, "", "The environment variable %MYVAR% has the value of: " & @CRLF & @CRLF & $sEnvVar)
EndFunc   ;==>Example
