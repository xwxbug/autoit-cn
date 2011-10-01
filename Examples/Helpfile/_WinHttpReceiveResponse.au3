#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 初始化
Global $hOpen = _WinHttpOpen()
; 指明连接到哪里
Global $hConnect = _WinHttpConnect($hOpen, "en.wikipedia.org")
; 创建请求
Global $hRequest = _WinHttpOpenRequest($hConnect, -1, "wiki/Manchester_United_F.C.")
; 发送它
_WinHttpSendRequest($hRequest)

; 等待响应
_WinHttpReceiveResponse($hRequest)
If @error Then
	MsgBox(48, "Error", "Error ocurred for WinHttpReceiveResponse, Error number is " & @error)
Else
	MsgBox(64, "All right!", "Server at 'en.wikipedia.org' processed the request.")
EndIf

; 关闭句柄
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

