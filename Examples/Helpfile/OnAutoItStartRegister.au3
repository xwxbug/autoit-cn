#OnAutoItStartRegister "MyTestFunc"
#OnAutoItStartRegister "MyTestFunc2"

Sleep(1000)

Func MyTestFunc()
	MsgBox(64, "开始结果 2", '开始消息从 MyTestFunc() 函数')
EndFunc   ;==>MyTestFunc

Func MyTestFunc2()
	MsgBox(64, "开始结果 3", '开始消息从 MyTestFunc() 函数')
EndFunc   ;==>MyTestFunc2
