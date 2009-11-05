#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>

Opt('MustDeclareVars', 1)

;==============================================
;==============================================
;SERVER!! Start Me First !!!!!!!!!!!!!!!
;==============================================
;==============================================

; 初始化一个变量描述连接
;==============================================
Global $ConnectedSocket = -1

Global $MainSocket

Example()

Func Example()
	OnAutoItExitRegister("Cleanup")

	Local $g_IP, $RogueSocket, $GOOEY, $edit, $input, $butt, $msg
	Local $ret, $recv

	$g_IP = "127.0.0.1"

	; 开始 TCP 服务
	;==============================================
	TCPStartup()

	; 创建一个套接字(socket)监听
	;==============================================
	$MainSocket = TCPListen($g_IP, 65432, 100)
	If $MainSocket = -1 Then Exit
	$RogueSocket = -1

	; 创建一个图形用户界面消息窗
	;==============================================
	$GOOEY = GUICreate("我的服务端", 300, 200)
	$edit = GUICtrlCreateEdit("", 10, 40, 280, 150, $WS_DISABLED)
	$input = GUICtrlCreateInput("", 10, 10, 200, 20)
	$butt = GUICtrlCreateButton("发送", 210, 10, 80, 20, $BS_DEFPUSHBUTTON)
	GUISetState()


	; 循环图形用户界面消息
	;==============================================
	While 1
		$msg = GUIGetMsg()

		; 关闭界面
		;--------------------
		If $msg = $GUI_EVENT_CLOSE Then ExitLoop

		; 用户按下发送按钮
		;--------------------
		If $msg = $butt Then
			If $ConnectedSocket > -1 Then
				$ret = TCPSend($ConnectedSocket, GUICtrlRead($input))
				If @error Or $ret < 0 Then
					; ERROR OCCURRED, CLOSE SOCKET AND RESET ConnectedSocket to -1
					;----------------------------------------------------------------
					TCPCloseSocket($ConnectedSocket)
					WinSetTitle($GOOEY, "", "我的服务端 - 客户端断开连接")
					$ConnectedSocket = -1
				ElseIf $ret > 0 Then
					; UPDATE EDIT CONTROL WITH DATA WE SENT
					;----------------------------------------------------------------
					GUICtrlSetData($edit, GUICtrlRead($edit) & GUICtrlRead($input) & @CRLF)
				EndIf
			EndIf
			GUICtrlSetData($input, "")
		EndIf

		If $RogueSocket > 0 Then
			$recv = TCPRecv($RogueSocket, 512)
			If Not @error Then
				TCPCloseSocket($RogueSocket)
				$RogueSocket = -1
			EndIf
		EndIf

		; If no connection look for one
		;--------------------
		If $ConnectedSocket = -1 Then
			$ConnectedSocket = TCPAccept($MainSocket)
			If $ConnectedSocket < 0 Then
				$ConnectedSocket = -1
			Else
				WinSetTitle($GOOEY, "", "my server - Client Connected")
			EndIf

			; If connected try to read some data
			;--------------------
		Else
			; EXECUTE AN UNCONDITIONAL ACCEPT IN CASE ANOTHER CLIENT TRIES TO CONNECT
			;----------------------------------------------------------------
			$RogueSocket = TCPAccept($MainSocket)
			If $RogueSocket > 0 Then
				TCPSend($RogueSocket, "~~rejected")
			EndIf

			$recv = TCPRecv($ConnectedSocket, 512)

			If $recv <> "" And $recv <> "~~bye"  Then
				; UPDATE EDIT CONTROL WITH DATA WE RECEIVED
				;----------------------------------------------------------------
				GUICtrlSetData($edit, GUICtrlRead($edit) & ">" & $recv & @CRLF)

			ElseIf @error Or $recv = "~~bye"  Then
				; ERROR OCCURRED, CLOSE SOCKET AND RESET ConnectedSocket to -1
				;----------------------------------------------------------------
				WinSetTitle($GOOEY, "", "my server - Client Disconnected")
				TCPCloseSocket($ConnectedSocket)
				$ConnectedSocket = -1
			EndIf
		EndIf
	WEnd

	GUIDelete($GOOEY)
EndFunc   ;==>Example

Func Cleanup()
	;ON SCRIPT EXIT close opened sockets and shutdown TCP service
	;----------------------------------------------------------------------
	If $ConnectedSocket > -1 Then
		TCPSend($ConnectedSocket, "~~bye")
		Sleep(2000)
		TCPRecv($ConnectedSocket, 512)
		TCPCloseSocket($ConnectedSocket)
	EndIf
	TCPCloseSocket($MainSocket)
	TCPShutdown()
EndFunc   ;==>Cleanup
