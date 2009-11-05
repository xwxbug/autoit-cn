#include <GUIConstantsEx.au3>

Opt('MustDeclareVars', 1)

;==============================================
;==============================================
;服务端! 服务端启用后,再启用客户端(服务端为接收信息方)
;==============================================
;==============================================

Example()

Func Example()
	; 设置一些常用信息
	; 在这里设置你的公共IP地址 (@IPAddress1).
;	Local $szServerPC = @ComputerName
;	Local $szIPADDRESS = TCPNameToIP($szServerPC)
	Local $szIPADDRESS = @IPAddress1;你的公共IP地址
	Local $nPORT = 33891;端口
	Local $MainSocket, $GOOEY, $edit, $ConnectedSocket, $szIP_Accepted
	Local $msg, $recv

	; 开始 TCP 服务
	;==============================================
	TCPStartup()

	; 创建一个监听 "SOCKET".
	;   使用您的IP地址和端口33891.
	;==============================================
	$MainSocket = TCPListen($szIPADDRESS, $nPORT)

	; 如果套接字创建失败，退出.
	If $MainSocket = -1 Then Exit


	; 创建一个图形用户界面消息窗
	;==============================================
	$GOOEY = GUICreate("My Server (IP: " & $szIPADDRESS & ")", 300, 200)
	$edit = GUICtrlCreateEdit("", 10, 10, 280, 180)
	GUISetState()


	; 初始化一个变量描述连接
	;==============================================
	$ConnectedSocket = -1


	;等待和接受连接
	;==============================================
	Do
		$ConnectedSocket = TCPAccept($MainSocket)
	Until $ConnectedSocket <> -1


	; 取得连接的客户端的IP
	$szIP_Accepted = SocketToIP($ConnectedSocket)

	; 循环图形用户界面消息
	;==============================================
	While 1
		$msg = GUIGetMsg()

		; 关闭图形用户界面
		;--------------------
		If $msg = $GUI_EVENT_CLOSE Then ExitLoop

		; 尝试接收（最高）2048字节
		;----------------------------------------------------------------
		$recv = TCPRecv($ConnectedSocket, 2048)

		; 如果接收失败(@error)将断开连接   
		;----------------------------------------------------------------
		If @error Then ExitLoop

		; Update the edit control with what we have received
		;----------------------------------------------------------------
		If $recv <> "" Then GUICtrlSetData($edit, _
				$szIP_Accepted & " > " & $recv & @CRLF & GUICtrlRead($edit))
	WEnd


	If $ConnectedSocket <> -1 Then TCPCloseSocket($ConnectedSocket)

	TCPShutdown()
EndFunc   ;==>Example

; 函数返回一个连接的套接字的IP地址. 
;----------------------------------------------------------------------
Func SocketToIP($SHOCKET)
	Local $sockaddr, $aRet
	
	$sockaddr = DllStructCreate("short;ushort;uint;char[8]")

	$aRet = DllCall("Ws2_32.dll", "int", "getpeername", "int", $SHOCKET, _
			"ptr", DllStructGetPtr($sockaddr), "int*", DllStructGetSize($sockaddr))
	If Not @error And $aRet[0] = 0 Then
		$aRet = DllCall("Ws2_32.dll", "str", "inet_ntoa", "int", DllStructGetData($sockaddr, 3))
		If Not @error Then $aRet = $aRet[0]
	Else
		$aRet = 0
	EndIf

	$sockaddr = 0

	Return $aRet
EndFunc   ;==>SocketToIP