#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()
; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, "google.com")
; 指明请求
Global $hRequest = _WinHttpOpenRequest($hConnect)
; 发送请求
_WinHttpSendRequest($hRequest)

; 等待响应
_WinHttpReceiveResponse($hRequest)

; 检查数据是否有效...
If _WinHttpQueryDataAvailable($hRequest) Then
    MsgBox(64, "OK", "Data from google.com is available!")
Else
	MsgBox(48, "Error", "Site is experiencing problems (or you).")
EndIf

; 清理
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

