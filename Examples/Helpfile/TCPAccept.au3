;服务器!! 请先运行我 !!!!!!!!!!!!!!!
$g_IP = "127.0.0.1"

; 开始 TCP 服务
;==============================================
TCPStartUp()

; 创建监听套接字("SOCKET")
;==============================================
$MainSocket = TCPListen($g_IP, 65432,  100 )
If $MainSocket = -1 Then Exit

;  等待客户端连接
;--------------------
While 1
$ConnectedSocket = TCPAccept( $MainSocket)
If $ConnectedSocket >= 0 Then
	msgbox(0,"","我的服务器 - 客户端已连接")
	exit
EndIf
Wend
