Local $val = RunWait(@WindowsDir & "\notepad.exe", @WindowsDir, @SW_MAXIMIZE)
; 脚本将会等待记事本退出.
MsgBox(0, "程序退出代码:", $val)
