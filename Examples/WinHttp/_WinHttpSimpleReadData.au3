#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#Include <WinHTTP.au3>

Opt('MustDeclareVars ', 1)

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()

; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, "thetimes.co.uk ")
; 发送简单请求
Global $hRequest = _WinHttpSimpleSendRequest($hConnect)

; 简单读取
Global $sRead = _WinHttpSimpleReadData($hRequest)
msgbox(64, "Returned (first 1100 characters) ", StringLeft($sRead, 1100) & " ... ")

; 关闭句柄
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

