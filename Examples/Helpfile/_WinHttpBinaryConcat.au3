#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

Global $sHost = "www.smijesne-slike.net"
Global $sTarget = "wp-content/uploads/2009/09/7.jpg"
Global $sDestination = @ScriptDir & "\CatHot.jpg"

; 初始化并获取会话句柄
Global $hHttpOpen = _WinHttpOpen()
If @error Then
	MsgBox(48, "Error", "Error initializing the usage of WinHTTP functions.")
	Exit 1
EndIf
; 获取连接句柄
Global $hHttpConnect = _WinHttpConnect($hHttpOpen, $sHost)
If @error Then
	MsgBox(48, "Error", "Error specifying the initial target server of an HTTP request.")
	_WinHttpCloseHandle($hHttpOpen)
	Exit 2
EndIf
; 指明请求
Global $hHttpRequest = _WinHttpOpenRequest($hHttpConnect, Default, $sTarget)
If @error Then
	MsgBox(48, "Error", "Error creating an HTTP request handle.")
	_WinHttpCloseHandle($hHttpConnect)
	_WinHttpCloseHandle($hHttpOpen)
	Exit 3
EndIf
; 发送请求
_WinHttpSendRequest($hHttpRequest)
If @error Then
	MsgBox(48, "Error", "Error sending specified request.")
	_WinHttpCloseHandle($hHttpConnect)
	_WinHttpCloseHandle($hHttpOpen)
	Exit 4
EndIf

; 等待响应
_WinHttpReceiveResponse($hHttpRequest)
; 如果有效则读取
Global $bChunk, $bData, $hFile
If _WinHttpQueryDataAvailable($hHttpRequest) Then
	While 1
		$bChunk = _WinHttpReadData($hHttpRequest, 2) ; 读取二进制
		If @error Then ExitLoop
		$bData = _WinHttpBinaryConcat($bData, $bChunk) ; 串联两段二进制数据
	WEnd
    ; 保存到文件
	$hFile = FileOpen($sDestination, 26)
	FileWrite($hFile, $bData)
	FileClose($hFile)
Else
	MsgBox(48, "Error occurred", "No data available. " & @CRLF)
EndIf

; 关闭句柄
_WinHttpCloseHandle($hHttpRequest)
_WinHttpCloseHandle($hHttpConnect)
_WinHttpCloseHandle($hHttpOpen)

; 看看下载的是什么
ShellExecute($sDestination)