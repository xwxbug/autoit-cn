#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()
; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, "w3schools.com")
; 生成请求
Global $hRequest = _WinHttpSimpleSendRequest($hConnect, Default, "tags/tag_input.asp")

If $hRequest Then
	; 简单读取...
	ConsoleWrite(_WinHttpSimpleReadData($hRequest) & @CRLF)
	MsgBox(64, "Okey do!", "Returned source is print to concole. Check it.")
Else
	MsgBox(48, "Error", "Error ocurred for _WinHttpSimpleSendRequest, Error number is " & @error)
EndIf

; 关闭句柄
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)