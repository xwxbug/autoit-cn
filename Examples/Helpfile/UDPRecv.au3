;;这是一个 UDP 服务器
;;请先运行服务端

; 开始 UDP 服务
;==============================================
UDPStartup()

; 注册清理函数.
OnAutoItExitRegister("Cleanup")

; 绑定到一个套接字(SOCKET)
;==============================================
Local $socket = UDPBind("127.0.0.1", 65532)
If @error <> 0 Then Exit

While 1
	Local $data = UDPRecv($socket, 50)
	If $data <> "" Then
        MsgBox(0, "UDP 数据", $data, 1)
	EndIf
	Sleep(100)
WEnd

Func Cleanup()
	UDPCloseSocket($socket)
	UDPShutdown()
EndFunc   ;==>Cleanup


