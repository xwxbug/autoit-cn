Local $sString

; 判断是否指定的变量赋值，是的话将会修改变量数据，并且输出至对话框中.
If Assign("sString", "你好") Then MsgBox(4096, "Assign", $sString) 
