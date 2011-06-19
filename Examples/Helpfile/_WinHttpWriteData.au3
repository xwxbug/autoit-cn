#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()
; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, "www.snee.com")
; 指明请求
Global $hRequest = _WinHttpOpenRequest($hConnect, "POST", "xml/crud/posttest.cgi?sgs")

Global $sPostData = "Additional data to send"
; 发送请求
_WinHttpSendRequest($hRequest, Default, Default, StringLen($sPostData))

; 写入附加数据到发送中
_WinHttpWriteData($hRequest, $sPostData)

; 等待响应
_WinHttpReceiveResponse($hRequest)

; 检查数据是否有效...
If _WinHttpQueryDataAvailable($hRequest) Then
	MsgBox(64, "OK", _WinHttpReadData($hRequest))
Else
	MsgBox(48, "Error", "Site is experiencing problems (or you).")
EndIf

; 关闭句柄
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)
