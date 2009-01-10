$dll = DllOpen("user32.dll")
$result = DllCall($dll, "int", "MessageBox", "hwnd", 0, "str", "Some text", "str", "Some title", "int", 0)
DllClose($dll)
