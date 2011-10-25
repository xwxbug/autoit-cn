#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#Include <WinHttp.au3>

Opt('MustDeclareVars ', 1)

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()
; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, "google.com ")
; 创建请求
Global $hRequest = _WinHttpOpenRequest($hConnect)
; 发送请求
_WinHttpSendRequest($hRequest)

; 等待应答
_WinHttpReceiveResponse($hRequest)

; 检查是否有数据可用
If _WinHttpQueryDataAvailable($hRequest) Then
	msgbox(64, "OK ", "Data from google.com is available! ")
Else
	msgbox(48, "Error ", "Site is experiencing problems (or you). ")
EndIf

; 关闭句柄
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

