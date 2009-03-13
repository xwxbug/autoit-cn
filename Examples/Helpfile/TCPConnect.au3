;CLIENT!!!!!!!! Start SERVER First... dummy!!
$g_IP = "127.0.0.1"

; Start The TCP Services
;==============================================
TCPStartUp()

; Connect to a Listening "SOCKET"
;==============================================
$socket = TCPConnect( $g_IP, 65432 )
If $socket = -1 Then Exit
