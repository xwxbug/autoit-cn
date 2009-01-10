;;这是一个 UDP 服务器
;;Start this first

; Start The UDP Services
;==============================================
UDPStartup()

; Bind to a SOCKET
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


