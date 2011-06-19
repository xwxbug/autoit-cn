#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen("Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.9.0.3; .NET CLR 2.0.50727; ffco7) Gecko/2008092417 Firefox/3.0.3")
; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, "autoit.de")

; 进行简单请求...
MsgBox(64, "Returned (first 1400 characters)", StringLeft(_WinHttpSimpleRequest($hConnect), 1400) & "...")

; 关闭句柄
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)
