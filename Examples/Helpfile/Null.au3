; 显示一个"错误"提示的消息框
DllCall("user32.dll", "int", "MessageBoxW", "hwnd", 0, "wstr", "Some text", "wstr", Null, "dword", 0)

