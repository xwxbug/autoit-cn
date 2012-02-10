; Register Example1 and Example2 to be called when AutoIt starts.
#OnAutoItStartRegister "Example1"
#OnAutoItStartRegister "Example2"

Sleep(1000)

Func Example1()
	MsgBox(4096, "", '首先调用了 Example1() 函数')
EndFunc   ;==>Example1

Func Example2()
	MsgBox(4096, "", '然后调用了 Example2() 函数')
EndFunc   ;==>Example2
