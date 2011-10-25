#Include <WinHTTP.au3>

; 获取HTTP 1.0版规范的日期时间
msgbox(0, "Date and time according to the HTTP version 1.0 specification ", _WinHttpTimeFromSystemTime())

