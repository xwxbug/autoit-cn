Local $var = Ping("www.AutoItScript.com", 250)
If $var Then; 还可以:  If @error = 0 Then ...
    MsgBox(0,"状态-成功","收发时间间隔:" & $var & "毫秒")
Else
    MsgBox(0,"状态-失败","错误代码:" & @error)
EndIf