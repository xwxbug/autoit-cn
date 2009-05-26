#OnAutoItStartRegister("MyTestFunc")
#OnAutoItStartRegister("MyTestFunc2")

Sleep(1000)

Func OnAutoItStart()
	;If we have our own OnAutoItStart function, OnAutoItStart_Handler will add ("pick up") this function to the handler :)
	;It's helpfull when this function is defined by some UDF that we using in our scripts.
	MsgBox(64, "Start Results 1", "Start Message from OnAutoItStart()")
EndFunc

Func MyTestFunc()
	MsgBox(64, "Start Results 2", 'Start Message from MyTestFunc()')
EndFunc

Func MyTestFunc2()
	MsgBox(64, "Start Results 3", 'Start Message from MyTestFunc()')
EndFunc
