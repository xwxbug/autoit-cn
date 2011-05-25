;服务器!! 先打开我 !!!!!!!!!!!!!!!
$g_IP = "127.0.0.1"

; 开始 UDP 服务
;==============================================
UDPStartup()

; 注册清理函数.
OnAutoItExitRegister("Cleanup")

; 创建一个监听套接字("SOCKET")
;==============================================
Local $socket = UDPBind($g_IP, 65432)
If @error <> 0 Then Exit

;--- 这里是您的代码

Func Cleanup()
	UDPCloseSocket($socket)
	UDPShutdown()
EndFunc   ;==>Cleanup
