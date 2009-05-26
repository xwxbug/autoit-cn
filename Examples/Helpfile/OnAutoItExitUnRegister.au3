OnAutoItExitRegister("MyTestFunc")
OnAutoItExitRegister("MyTestFunc2")

Sleep(1000)

OnAutoItExitUnRegister("MyTestFunc")

Func OnAutoItExit()
	;If we have our own OnAutoItExit function, OnAutoItExit_Handler will add ("pick up") this function to the handler :)
	;It's helpfull when this function is defined by some UDF that we using in our scripts.
	MsgBox(64, "Exit Results 1", "Exit Message from OnAutoItExit()")
EndFunc

Func MyTestFunc()
	MsgBox(64, "Exit Results 2", 'Exit Message from MyTestFunc()')
EndFunc

Func MyTestFunc2()
	MsgBox(64, "Exit Results 3", 'Exit Message from MyTestFunc()')
EndFunc
