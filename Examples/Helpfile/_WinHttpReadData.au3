#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 初始化
Global $hOpen = _WinHttpOpen()

If @error Then
	MsgBox(48, "Error", "Error initializing the usage of WinHTTP functions.")
	Exit 1
EndIf

; 指明连接到哪里
Global $hConnect = _WinHttpConnect($hOpen, "yahoo.com") ; <- 这儿您的目标
If @error Then
	MsgBox(48, "Error", "Error specifying the initial target server of an HTTP request.")
	_WinHttpCloseHandle($hOpen)
	Exit 2
EndIf

; 创建请求
Global $hRequest = _WinHttpOpenRequest($hConnect)
If @error Then
	MsgBox(48, "Error", "Error creating an HTTP request handle.")
	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)
	Exit 3
EndIf

; 发送它
_WinHttpSendRequest($hRequest)
If @error Then
	MsgBox(48, "Error", "Error sending specified request.")
	_WinHttpCloseHandle($hRequest)
	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)
	Exit 4
EndIf

; 等待响应
_WinHttpReceiveResponse($hRequest)
If @error Then
	MsgBox(48, "Error", "Error waiting for the response from the server.")
	_WinHttpCloseHandle($hRequest)
	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)
	Exit 5
EndIf

; 看看是否有数据读取
Global $sChunk, $sData
If _WinHttpQueryDataAvailable($hRequest) Then
	; 读取
	While 1
		$sChunk = _WinHttpReadData($hRequest)
		If @error Then ExitLoop
		$sData &= $sChunk
	WEnd
	ConsoleWrite($sData & @CRLF) ; 打印到控制台
Else
	MsgBox(48, "Error", "Site is experiencing problems.")
EndIf

; 不再需要那些句柄时关闭它们
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)