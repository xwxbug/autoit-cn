#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#Include <WinHTTP.au3>

; 打开所需句柄
$hOpen = _WinHttpOpen()
$hConnect = _WinHttpConnect($hOpen, "msdn.microsoft.com ")
; 指定请求
$hRequest = _WinHttpOpenRequest($hConnect, Default, "en-us/library/aa384101(VS.85).aspx ")

; 发送请求
_WinHttpSendRequest($hRequest)

; 等待应答
_WinHttpReceiveResponse($hRequest)

Global $sHeader
If _WinHttpQueryDataAvailable($hRequest) Then
	$sHeader = _WinHttpQueryHeaders($hRequest)
EndIf

_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; 显示获取的头部
msgbox(0, "Header ", $sHeader)

