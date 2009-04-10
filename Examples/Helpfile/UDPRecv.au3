;;这是一个 UDP 服务器
;;请先运行服务端

; 开始 UDP 服务
;==============================================
UDPStartup()

; 绑定到一个套接字(SOCKET)
;==============================================
$socket = UDPBind("127.0.0.1", 65532)
If @error <> 0 Then Exit

While 1
    $data = UDPRecv($socket, 50)
    If $data <> "" Then
        MsgBox(0, "UDP 数据", $data, 1)
    EndIf
    sleep(100)
WEnd

Func OnAutoItExit()
    UDPCloseSocket($socket)
    UDPShutdown()
EndFunc


