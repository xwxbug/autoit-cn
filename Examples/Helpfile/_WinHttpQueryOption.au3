#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()

; 设置用户代理字符串
_WinHttpSetOption($hOpen, $WINHTTP_OPTION_USER_AGENT, "Who the fuc*k is Alice???")

; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, "google.com")

; 指明请求
Global $hRequest = _WinHttpOpenRequest($hConnect)

; 发送请求
_WinHttpSendRequest($hRequest)

; 检查所使用的用户代理字符串
ConsoleWrite("! Custom agent: " & _WinHttpQueryOption($hOpen, $WINHTTP_OPTION_USER_AGENT) & @CRLF & @CRLF)

; 等待响应
_WinHttpReceiveResponse($hRequest)

Global $sHeader
; 如果数据有效...
If _WinHttpQueryDataAvailable($hRequest) Then $sHeader = _WinHttpQueryHeaders($hRequest) ; ...获取完整头部

; 清理
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; 显示获取的头部
ConsoleWrite($sHeader & @CRLF)