AutoItSetOption("WinTitleMatchMode", 2)
$x = StatusbarGetText("Internet Explorer")
MsgBox(0, "Internet Explorer's status bar says:", $x)
