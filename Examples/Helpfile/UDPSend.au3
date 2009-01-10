;;This is the UDP Client
;;Start the server first

; Start The UDP Services
;==============================================
UDPStartup()

; Open a "SOCKET"
;==============================================
$socket = UDPOpen("127.0.0.1", 65532)
If @error <> 0 Then Exit

$n=0
While 1
    Sleep(2000)
    $n = $n + 1
    $status = UDPSend($socket, "消息 #" & $n)
    If $status = 0 then 
        MsgBox(0, "错误", "当发送 UDP 消息时发生错误: " & @error)
        Exit
    EndIf
WEnd

Func OnAutoItExit()
    UDPCloseSocket($socket)
    UDPShutdown()
EndFunc
