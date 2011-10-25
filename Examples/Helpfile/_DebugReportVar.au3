#include <Debug.au3>

_DebugSetup(" _DebugReportVar examples ", True)

Dim $Array2D[5][2]
For $r = 0 to Ubound($Array2D, 1) - 1
	For $c = 0 to UBound($Array2D, 2) - 1
		$Array2D[$r][$c] = $r & " ," & $c
	Next
Next
_DebugReportVar(" Array2D ", $Array2D)

Dim $Array[7] = [1, 1.1, "string ", Binary(0x010203), Ptr(-1), False, Default]
_DebugReportVar(" Array ", $Array)

Dim $Array3D[5][2][10]
_DebugReportVar(" Array3D ", $Array3D)

$int = -1
_DebugReportVar(" int ", $int)

$int64 = 2 ^ 63
_DebugReportVar(" int64 ", $int64)

$bool = True
_DebugReportVar(" bool ", $bool)

$float = 1.1
_DebugReportVar(" float ", $float)

$keyword = Default
_DebugReportVar(" keyword ", $keyword)

$string = " stringstring "
_DebugReportVar(" string ", $string)

$binary = Binary(" 0x0102030405060708 ")
_DebugReportVar(" binary ", $binary)

$binary = Binary(" abcdefghij ")
_DebugReportVar(" binary ", $binary)

$ptr = Ptr(0)
_DebugReportVar(" ptr ", $ptr)

$hwnd = WinActive("", "")
_DebugReportVar(" hwnd ", $hwnd)

$dllstruct = DllStructCreate(" int ")
_DebugReportVar(" dllstruct ", $dllstruct)

$obj = ObjCreate(" shell.application ")
_DebugReportVar(" obj ", $obj)

