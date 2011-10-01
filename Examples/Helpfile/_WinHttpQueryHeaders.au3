#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 打开需要的句柄
Global $hOpen = _WinHttpOpen()
Global $hConnect = _WinHttpConnect($hOpen, "msdn.microsoft.com")
; 指明请求:
Global $hRequest = _WinHttpOpenRequest($hConnect, Default, "en-us/library/aa384101(VS.85).aspx")

; 发送请求
_WinHttpSendRequest($hRequest)

; 等待响应
_WinHttpReceiveResponse($hRequest)

; 获取完整头部
Global $sHeader = _WinHttpQueryHeaders($hRequest)

; 关闭句柄
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; 显示获取的头部
MsgBox(0, "Header", $sHeader)