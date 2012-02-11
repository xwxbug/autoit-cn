AutoItSetOption("WinTitleMatchMode", 2)
Local $x = StatusbarGetText("Internet Explorer")
MsgBox(4096, "Internet Explorer's status bar says:", $x)
