;-----------------------_POP3.AU3---------------------------
;~ Basic functions for AU3 Scripts, based on the 1939 RFC.
;~ See http://www.ietf.org/rfc/rfc1939.txt
;~ Include version : 0.99 (March 2006, 9th).
;~ Requires AU3 beta version 3.1.1.110 or newer.
;~ Author : Luc HENNINOT <lhenninot@nordnet.fr>
;-----------------------------------------------------------
;~ Int _pop3Connect (server, login, passwd [, port])	; Conects to the according pop3 server. Returns 0 for OK, -1 if error and sets @error. Server can be an IP address, or a full text name.
;~ String _Pop3Dele(msg_number)							; Delete msg n° msg_number. Returns the server response or -1 if error, and sets @error.
;~ Array _Pop3List([msg_number])						; Returns an array with the msg number and its size (octets), -1 if error ans sets @error.
;~ String _Pop3Noop()									; Actually, does nothing. The most interesting command from RFC 1939 ;)
;~ String _Pop3Quit()									; Validates your actions (dele for example) and stops the connection as it should. Returns the server response, or -1 and sets @error.
;~ String _Pop3Retr(msg_number)							; Downloads the according message, or returns -1 and sets @error.
;~ Int _Pop3Rset()										; Withdraw changes, such as dele orders. Returns 0 for success, -1 for error and sets @error.									
;~ Array _Pop3Stat()									; Sends the number of messages in the pop3 account (array[1]) and the size(array[2]) in octets, or -1 ans sets @error.
;~ Sting _Pop3Top(msg_number, lines)					; Retreives the mail headers, and the X first lines of the message. Or returns -1 and sets @error.
;~ Array _Pop3Uidl([msg_number])						; Same as _Pop3List(), but with UIDL identifiers instead of message size.

;~ Subfunctions, used by the above ones --------------------
;~ Int _pop3Disconnect()								; Shuts down connection. Returns 0 for OK, -1 if error and sets @error. Use _Pop3Quit to exit !!
;~ Sting _Pop3WaitForOK()								; Returns the server response if it starts with "+OK", or -1 and sets @error.
;~ String _WaitTcpResponse()							; Returns the server response, or -1 and sets @error.

#include-once
#include <array.au3>

; -- _POP3 error codes, sent by SetError. Use @error to display it. --
Global Const $pop3_error_tcpconnect_failed = 1
Global Const $pop3_error_server_response_timeout = 2
Global Const $pop3_error_already_connected = 3
Global Const $pop3_error_not_connected = 4
Global Const $pop3_error_no_auth = 5
Global Const $pop3_error_tcprecv_timeout = 6
Global Const $pop3_error_user_refused = 7
Global Const $pop3_error_passwd_refused = 8
Global Const $pop3_error_no_OK_response = 9
Global Const $pop3_error_stat_badresponse = 10
Global Const $pop3_error_no_TCP_response = 11
Global Const $pop3_error_stat_refused = 12
Global Const $pop3_error_list_refused = 13
Global Const $pop3_error_rset_refused = 14
Global Const $pop3_error_retr_refused = 15
Global Const $pop3_error_quit_refused = 16
Global Const $pop3_error_dele_refused = 17
Global Const $pop3_error_top_refused = 18
Global Const $pop3_error_uidl_refused = 19
Global Const $pop3_error_noop_refused = 20; I love this one ;)


;-- _POP3 vars --
Global Const $POP3_OK = "^\+OK"; Regexp syntax
Global Const $POP3_ERR = "^-ERR"; Unused yet, may help later.
Global $pop3_IsConnected = 0
Global $pop3_IsAuth = 0
Global $pop3_socket
Global $pop3_server_response_timeout = 60000 ; 1 mn, modify it if needed


;-- _POP3 Funcs --
Func _pop3Connect($server, $login, $passwd, $port = 110)
	Local $ret
	If $pop3_IsConnected = 0 Then
		Local $server2
		TCPStartUp ()
		; Basic name to IP conversion
		If StringRegExp($server, "[a-zA-Z]") Then
			$server2 = TCPNameToIP ($server)
		Else
			$server2 = $server
		EndIf
		$pop3_socket = TCPConnect ($server2, $port)
		If @error Then
			SetError($pop3_error_tcpconnect_failed)
			Return -1
		Else
			$pop3_IsConnected = 1
		EndIf
		
		; We need a first OK from pop3 server
		$ret = _Pop3WaitForOK()
		If @error Then
			SetError($pop3_error_no_OK_response)
			Return -1
		EndIf
		
		; Send user
		$ret = TCPSend ($pop3_socket, "USER " & $login & @CRLF)
		If @error Then
			SetError($pop3_error_user_refused)
			Return -1
		EndIf
		$ret = _Pop3WaitForOK()
		If @error Then
			SetError($pop3_error_no_OK_response)
			Return -1
		EndIf
		
		; Send passwd
		$ret = TCPSend ($pop3_socket, "PASS " & $passwd & @CRLF)
		If @error Then
			SetError($pop3_error_passwd_refused)
			Return -1
		EndIf
		$ret = _Pop3WaitForOK()
		If @error Then
			SetError($pop3_error_no_OK_response)
			Return -1
		EndIf
		
		$pop3_IsAuth = 1
		Return 0
	Else
		SetError($pop3_error_already_connected)
		Return -1
	EndIf
EndFunc   ;==>_pop3Connect


Func _Pop3Stat()
	If $pop3_IsAuth = 1 Then
		Local $ret
		Local $a_ret
		; Send STAT
		$ret = TCPSend ($pop3_socket, "STAT" & @CRLF)
		If @error Then
			SetError($pop3_error_stat_refused)
			Return -1
		EndIf
		$ret = _Pop3WaitForOK()
		If @error Then
			SetError($pop3_error_no_OK_response)
			Return -1
		EndIf
		$a_ret = StringSplit($ret, " ")
		If IsArray($a_ret) Then
			_ArrayDelete($a_ret, 1)
			$a_ret[0] = $a_ret[0] - 1
			Return $a_ret
		Else
			SetError($pop3_error_stat_badresponse)
			Return -1
		EndIf
	EndIf
EndFunc   ;==>_Pop3Stat


Func _Pop3Noop()
	If $pop3_IsAuth = 1 Then
		Local $ret
		Local $a_ret
		; Send NOOP
		$ret = TCPSend ($pop3_socket, "NOOP" & @CRLF)
		If @error Then
			SetError($pop3_error_noop_refused)
			Return -1
		EndIf
		$ret = _Pop3WaitForOK()
		If @error Then
			SetError($pop3_error_no_OK_response)
			Return -1
		EndIf
		Return $ret
	EndIf
EndFunc   ;==>_Pop3Noop


Func _Pop3Rset()
	If $pop3_IsAuth = 1 Then
		Local $ret
		; Send RSET
		$ret = TCPSend ($pop3_socket, "RSET" & @CRLF)
		If @error Then
			SetError($pop3_error_rset_refused)
			Return -1
		EndIf
		$ret = _Pop3WaitForOK()
		If @error Then
			SetError($pop3_error_no_OK_response)
			Return -1
		EndIf
		Return 0
	EndIf
EndFunc   ;==>_Pop3Rset


Func _Pop3List($msg = -1)
	If $pop3_IsAuth = 1 Then
		Local $ret
		Local $AddMsg = ""
		
		If $msg <> - 1 Then
			$AddMsg = " " & $msg
		EndIf
		
		; Send List
		$ret = TCPSend ($pop3_socket, "LIST" & $AddMsg & @CRLF)
		If @error Then
			SetError($pop3_error_list_refused)
			Return -1
		EndIf
		$ret = _WaitTcpResponse()
		If @error Then
			SetError($pop3_error_no_TCP_response)
			Return -1
		EndIf
		While $msg = -1 And Not StringRegExp($ret, "\r\n\.\r\n")
			$ret = $ret & _WaitTcpResponse()
			If @error Then
				SetError($pop3_error_no_TCP_response)
				Return -1
			EndIf
		WEnd
		
		; Stripping useless infos for complete listing
		$ret = StringSplit(StringStripCR($ret), @LF)
		If $msg = -1 Then
			_ArrayDelete($ret, $ret[0])
			_ArrayDelete($ret, $ret[0] - 1)
			_ArrayDelete($ret, 1)
			$ret[0] = $ret[0] - 3
		Else
			_ArrayDelete($ret, $ret[0])
			$ret[0] = $ret[0] - 1
			$ret[1] = StringReplace($ret[1], "+OK ", "")
		EndIf
		Return $ret
	EndIf
EndFunc   ;==>_Pop3List


Func _Pop3Uidl($msg = -1)
	If $pop3_IsAuth = 1 Then
		Local $ret
		Local $AddMsg = ""
		
		If $msg <> - 1 Then
			$AddMsg = " " & $msg
		EndIf
		
		; Send List
		$ret = TCPSend ($pop3_socket, "UIDL" & $AddMsg & @CRLF)
		If @error Then
			SetError($pop3_error_uidl_refused)
			Return -1
		EndIf
		$ret = _WaitTcpResponse()
		If @error Then
			SetError($pop3_error_no_TCP_response)
			Return -1
		EndIf
		While $msg = -1 And Not StringRegExp($ret, "\r\n\.\r\n")
			$ret = $ret & _WaitTcpResponse()
			If @error Then
				SetError($pop3_error_no_TCP_response)
				Return -1
			EndIf
		WEnd
		
		; Stripping useless infos for complete listing
		$ret = StringSplit(StringStripCR($ret), @LF)
		If $msg = -1 Then
			_ArrayDelete($ret, $ret[0])
			_ArrayDelete($ret, $ret[0] - 1)
			_ArrayDelete($ret, 1)
			$ret[0] = $ret[0] - 3
		Else
			_ArrayDelete($ret, $ret[0])
			$ret[0] = $ret[0] - 1
			$ret[1] = StringReplace($ret[1], "+OK ", "")
		EndIf
		Return $ret
	EndIf
EndFunc   ;==>_Pop3Uidl


Func _Pop3Retr($msg)
	If $pop3_IsAuth = 1 Then
		Local $ret
		
		; Send Retr
		$ret = TCPSend ($pop3_socket, "RETR " & $msg & @CRLF)
		If @error Then
			SetError($pop3_error_retr_refused)
			Return -1
		EndIf
		$ret = _Pop3WaitForOK()
		If @error Then
			SetError($pop3_error_no_OK_response)
			Return -1
		EndIf
		
		$ret = _WaitTcpResponse()
		If @error Then
			SetError($pop3_error_no_TCP_response)
			Return -1
		EndIf
		
		; Downloading until final dot and cariage return.
		While Not StringRegExp($ret, "\r\n\.\r\n")
			$ret = $ret & _WaitTcpResponse()
			If @error Then
				SetError($pop3_error_no_TCP_response)
				Return -1
			EndIf
		WEnd
		Return $ret
	Else
		SetError($pop3_error_no_auth)
		Return -1
	EndIf
EndFunc   ;==>_Pop3Retr


Func _Pop3Top($msg, $nb)
	If $pop3_IsAuth = 1 Then
		Local $ret
		
		; Send Top
		$ret = TCPSend ($pop3_socket, "TOP " & $msg & " " & $nb & @CRLF)
		If @error Then
			SetError($pop3_error_top_refused)
			Return -1
		EndIf
		$ret = _Pop3WaitForOK()
		If @error Then
			SetError($pop3_error_no_OK_response)
			Return -1
		EndIf
		
		$ret = _WaitTcpResponse()
		If @error Then
			SetError($pop3_error_no_TCP_response)
			Return -1
		EndIf
		
		; Downloading until final dot and cariage return.
		While Not StringRegExp($ret, "\r\n\.\r\n")
			$ret = $ret & _WaitTcpResponse()
			If @error Then
				SetError($pop3_error_no_TCP_response)
				Return -1
			EndIf
		WEnd
		Return $ret
	Else
		SetError($pop3_error_no_auth)
		Return -1
	EndIf
EndFunc   ;==>_Pop3Top


Func _Pop3Quit()
	Local $ret
	If $pop3_IsAuth = 1 Then
		$ret = TCPSend ($pop3_socket, "QUIT" & @CRLF)
		If @error Then
			SetError($pop3_error_quit_refused)
			Return -1
		EndIf
		$ret = _WaitTcpResponse()
		If @error Then
			SetError($pop3_error_no_TCP_response)
			Return -1
		EndIf
		Return $ret
	Else
		SetError($pop3_error_no_auth)
		Return -1
	EndIf
EndFunc   ;==>_Pop3Quit


Func _Pop3Dele($msg)
	Local $ret
	If $pop3_IsAuth = 1 Then
		$ret = TCPSend ($pop3_socket, "DELE " & $msg & @CRLF)
		If @error Then
			SetError($pop3_error_dele_refused)
			Return -1
		EndIf
		$ret = _WaitTcpResponse()
		If @error Then
			SetError($pop3_error_no_TCP_response)
			Return -1
		EndIf
		Return $ret
	Else
		SetError($pop3_error_no_auth)
		Return -1
	EndIf
EndFunc   ;==>_Pop3Dele


Func _pop3Disconnect()
	If $pop3_IsConnected <> 0 Then
		TCPCloseSocket ($pop3_socket)
		TCPShutDown ()
		Return 0
	Else
		SetError($pop3_error_not_connected)
		Return -1
	EndIf
EndFunc   ;==>_pop3Disconnect


Func _Pop3WaitForOK()
	; Wait for server response.
	Local $ret
	Local $T = TimerInit()
	While 1
		If TimerDiff($T) > $pop3_server_response_timeout Then
			SetError($pop3_error_server_response_timeout)
			Return -1
		EndIf
		$ret = _WaitTcpResponse()
		If Not @error And StringRegExp($ret, $POP3_OK) Then
			Return $ret
		EndIf
		Sleep(10)
	WEnd
	SetError($pop3_error_no_OK_response)
	Return -1
EndFunc   ;==>_Pop3WaitForOK


Func _WaitTcpResponse($timeout = 30000)
	;Timeout to 30 s, should be enough in most cases. Overwright it if needed.
	Local $ret
	Local $T = TimerInit()
	While 1
		If TimerDiff($T) > $timeout Then
			SetError($pop3_error_tcprecv_timeout)
			Return -1
		EndIf
		$ret = TCPRecv ($pop3_socket, 512)
		If $ret <> "" Then
			Return $ret
		EndIf
		Sleep(10)
	WEnd
EndFunc   ;==>_WaitTcpResponse

