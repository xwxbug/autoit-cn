;==============================================
;==============================================
;客户端! 运行前必须确保服务端已运行(客户端为发送信息方)
;==============================================
;==============================================

Example()

Func Example()
	; 开始 TCP 服务
	;==============================================
	TCPStartup()

	; 设置一些常用信息
	;--------------------------
	Local $ConnectedSocket, $szData
	; 设置 $szIPADDRESS 为服务端IP. 这里使用本地的机器名称转换为 IP 地址
	;	Local $szServerPC = @ComputerName
	;	Local $szIPADDRESS = TCPNameToIP($szServerPC)
	Local $szIPADDRESS = @IPAddress1
	Local $nPORT = 33891

	; 初始化一个变量描述连接
	;==============================================
	$ConnectedSocket = -1

	;尝试连接到服务端IP的 33891 端口.
	;=======================================================
	$ConnectedSocket = TCPConnect($szIPADDRESS, $nPORT)

	; 如果发生了错误... 显示出来
	If @error Then
		MsgBox(4112, "错误", "TCP连接失败,服务端未启用!错误代码: " & @error)
		; 如果这里没有错误,就循环一个 inputbox 用于发送数据
		; 到服务端
	Else
		;不断循环,每次将询问发送什么数据给服务端
		While 1
			; 使用 InputBox 得到要发送的数据 
			$szData = InputBox("发送数据给服务端", @LF & @LF & "输入一个要发送给服务端的数据:")

			; 如果点击了 InputBox 的取消按钮或者使用一个空数据将退出这个循环
			If @error Or $szData = "" Then ExitLoop

			; 我们确保在 $szData 中有数据... 然后尝试通过连接发送数据.
			; convert AutoIt native UTF-16 to UTF-8
			TCPSend($ConnectedSocket, StringToBinary($szData, 4))

			; 如果发送失败(@error)将断开连接
			;----------------------------------------------------------------
			If @error Then ExitLoop
		WEnd
	EndIf
EndFunc   ;==>Example