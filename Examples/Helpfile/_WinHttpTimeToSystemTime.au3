#Include <WinHTTP.au3>
#Include <Array.au3>

; 将HTTP/1.0时间格式转变为系统时间格式 $time_array = _WinHttpTimeToSystemTime ( " Mon, 12 Jul 2010 20:42:16 GMT " )
_arraydisplay($time_array, "_WinHttpTimeToSystemTime() ")

