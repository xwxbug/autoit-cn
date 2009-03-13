;SERVER!! Start Me First !!!!!!!!!!!!!!!
$g_IP = "127.0.0.1"

; Start The TCP Services
;==============================================
TCPStartUp()

; Create a Listening "SOCKET"
;==============================================
$MainSocket = TCPListen($g_IP, 65432,  100 )
If $MainSocket = -1 Then Exit

;  look for client connection
;--------------------
While 1
$ConnectedSocket = TCPAccept( $MainSocket)
If $ConnectedSocket >= 0 Then
	msgbox(0,"","my server - Client Connected")
	exit
EndIf
Wend
