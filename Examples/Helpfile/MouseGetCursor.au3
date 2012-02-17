Sleep(2000) ;设置一个延迟时间，方便获取指针光标ID.

;创建一个包含了指针光标 ID 编号含义的数组.
Local $IDs = StringSplit("AppStarting|Arrow|Cross|Help|IBeam|Icon|No|" & _
        "Size|SizeAll|SizeNESW|SizeNS|SizeNWSE|SizeWE|UpArrow|Wait|Hand", "|")
$IDs[0] = "Unknown"

;返回当前鼠标指针光标的ID.
Local $cursor = MouseGetCursor()
MsgBox(4096, "ID = " & $cursor, "Which means " & $IDs[$cursor])