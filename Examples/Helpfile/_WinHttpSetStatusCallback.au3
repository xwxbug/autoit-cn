#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 注册回调函数
Global $hWINHTTP_STATUS_CALLBACK = DllCallbackRegister("__WINHTTP_STATUS_CALLBACK", "none", "handle;dword_ptr;dword;ptr;dword")
; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()
; 把回调函数和此句柄关联起来
_WinHttpSetStatusCallback($hOpen, $hWINHTTP_STATUS_CALLBACK)

; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, "google.com")
; 指明请求:
Global $hRequest = _WinHttpOpenRequest($hConnect)
; 发送请求
_WinHttpSendRequest($hRequest)
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
ConsoleWrite(@CRLF & $sHeader & @CRLF)

; 暂停几秒以便看看是否有更多事件
Sleep(2000)

; 不需要时释放回调 (此时可以忽略)
DllCallbackFree($hWINHTTP_STATUS_CALLBACK)


; 定义回调函数
Func __WINHTTP_STATUS_CALLBACK($hInternet, $iContext, $iInternetStatus, $pStatusInformation, $iStatusInformationLength)
	#forceref $hInternet, $iContext, $pStatusInformation, $iStatusInformationLength
	ConsoleWrite("!->Current status of the connection: " & $iInternetStatus & "    " & @TAB & "    ")
	; 解释状态
	Local $sStatus
	Switch $iInternetStatus
		Case $WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION
			$sStatus = "Closing the connection to the server"
		Case $WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER
			$sStatus = "Successfully connected to the server."
		Case $WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER
			$sStatus = "Connecting to the server."
		Case $WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED
			$sStatus = "Successfully closed the connection to the server."
		Case $WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE
			$sStatus = "Data is available to be retrieved with WinHttpReadData."
		Case $WINHTTP_CALLBACK_STATUS_HANDLE_CREATED
			$sStatus = "An HINTERNET handle has been created."
		Case $WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING
			$sStatus = "This handle value has been terminated."
		Case $WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE
			$sStatus = "The response header has been received and is available with WinHttpQueryHeaders."
		Case $WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE
			$sStatus = "Received an intermediate (100 level) status code message from the server."
		Case $WINHTTP_CALLBACK_STATUS_NAME_RESOLVED
			$sStatus = "Successfully found the IP address of the server."
		Case $WINHTTP_CALLBACK_STATUS_READ_COMPLETE
			$sStatus = "Data was successfully read from the server."
		Case $WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE
			$sStatus = "Waiting for the server to respond to a request."
		Case $WINHTTP_CALLBACK_STATUS_REDIRECT
			$sStatus = "An HTTP request is about to automatically redirect the request."
		Case $WINHTTP_CALLBACK_STATUS_REQUEST_ERROR
			$sStatus = "An error occurred while sending an HTTP request."
		Case $WINHTTP_CALLBACK_STATUS_REQUEST_SENT
			$sStatus = "Successfully sent the information request to the server."
		Case $WINHTTP_CALLBACK_STATUS_RESOLVING_NAME
			$sStatus = "Looking up the IP address of a server name."
		Case $WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED
			$sStatus = "Successfully received a response from the server."
		Case $WINHTTP_CALLBACK_STATUS_SECURE_FAILURE
			$sStatus = "One or more errors were encountered while retrieving a Secure Sockets Layer (SSL) certificate from the server."
		Case $WINHTTP_CALLBACK_STATUS_SENDING_REQUEST
			$sStatus = "Sending the information request to the server."
		Case $WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE
			$sStatus = "The request completed successfully."
		Case $WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE
			$sStatus = "Data was successfully written to the server."
	EndSwitch
	; 打印它
	ConsoleWrite($sStatus & @CRLF)
EndFunc   ;==>__WINHTTP_STATUS_CALLBACK