Local $sString = "可以用作调试用, 用于在STDOUT输出文本内容."

; 在文本编辑器中运行,可以捕获控制台输出的数据,例如 SciTE 将显示 $sString 的值
ConsoleWrite($sString & @CRLF) 
