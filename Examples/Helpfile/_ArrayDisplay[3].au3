; using an array returned by StringSplit()

#include <Array.au3>

Local $avArray = StringSplit(WinGetClassList("", ""), @CRLF)
_ArrayDisplay($avArray, "$avArray as a list classes in window")
