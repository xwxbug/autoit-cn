; :collapseFolds=0:maxLineLen=80:mode=autoitscript:tabSize=8:indentSize=8:folding=indent:
;===============================================================================
; Original UDF:
; http://www.autoitscript.com/forum/index.php?showtopic=22838
;~ Basic functions for AU3 Scripts, based on the 1939 RFC.
;~ See http://www.ietf.org/rfc/rfc1939.txt
;~ Include version : 0.99 (March 2006, 9th).
;~ Requires AU3 beta version 3.1.1.110 or newer.
;~ Author : Luc HENNINOT <lhenninot@nordnet.fr>
;===============================================================================
; Name ..........: _POP3.au3
; Author: .......: Thorsten Willert (thorsten [dot] willert [at] gmx [dot] de)
; Date ..........: Thu Feb 24 22:59:56 CET 2010 @778 /Internet Time/
; Version .......: 1.03
; AutoIt ........: v3.3.2.0
;===============================================================================
#include-once

#Region Global constants
; -- _ACN_POP3 error codes, sent by SetError. Use @error to display it. --
Global Enum $POP3_ERROR_OK = 0, _
		$POP3_ERROR, _
		$POP3_ERROR_TCPCONNECT_FAILED, _
		$POP3_ERROR_SERVER_RESPONSE_TIMEOUT, _
		$POP3_ERROR_ALREADY_CONNECTED, _
		$POP3_ERROR_NOT_CONNECTED, _
		$POP3_ERROR_NO_AUTH, _
		$POP3_ERROR_TCPRECV_TIMEOUT, _
		$POP3_ERROR_USER_REFUSED, _
		$POP3_ERROR_PASSWD_REFUSED, _
		$POP3_ERROR_ERR_RESPONSE, _
		$POP3_ERROR_NO_OK_RESPONSE, _
		$POP3_ERROR_STAT_BADRESPONSE, _
		$POP3_ERROR_NO_TCP_RESPONSE, _
		$POP3_ERROR_STAT_REFUSED, _
		$POP3_ERROR_LIST_REFUSED, _
		$POP3_ERROR_RSET_REFUSED, _
		$POP3_ERROR_RETR_REFUSED, _
		$POP3_ERROR_QUIT_REFUSED, _
		$POP3_ERROR_DELE_REFUSED, _
		$POP3_ERROR_TOP_REFUSED, _
		$POP3_ERROR_UIDL_REFUSED, _
		$POP3_ERROR_NOOP_REFUSED ; I love this one ;)

;-- _ACN_POP3 vars --
Global Const $POP3_OK = '^\+OK'; Regexp syntax
#EndRegion Global constants

#Region Global variables
Global $POP3_TRACE = True
Global $POP3_ISCONNECTED = 0
Global $POP3_ISAUTH = 0
Global $POP3_SOCKET
Global $POP3_SERVER_RESPONSE_TIMEOUT = 60000 ; 1 mn, modify it if needed
#EndRegion Global variables

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Info
; Description ...: Returns an array with the specified informations about all mails
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Info([$vInfo = ""])
; Parameter(s): .: $vInfo       - Optional: (Default = "") : string or array
; Return Value ..: Success      - array (Default: array[date,from,to,subject])
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Thorsten Willert
; Date ..........: Fri Jan 15 18:17:54 CET 2010
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Info($vInfo = "")
	If $POP3_ISAUTH Then
		Local $vInf
		If $vInfo = "" Then
			Local $vInf[4] = ["Date", "From", "To", "Subject"]
		ElseIf IsArray($vInfo) Then
			$vInf = $vInfo
		Else
			Local $vInf[1] = [$vInfo]
		EndIf

		Local $iCnt = _ACN_POP3MsgCnt()
		If @error Then Return SetError(@error, 0, 0)

		Local $sTMP, $aTMP
		Local $iInf = UBound($vInf)

		If $iCnt > 0 Then
			Local $aRet[$iCnt + 1][$iInf]
			$aRet[0][0] = $iCnt
			For $i = 1 To $iCnt
				$sTMP = _ACN_POP3Top($i)
				If @error Then Return SetError(@error, 0, 0)
				For $j = 0 To $iInf - 1
					$aTMP = StringRegExp($sTMP, '(?i)\n' & $vInf[$j] & ':\s*(.*?)\r', 3)
					If Not @error Then $aRet[$i][$j] = $aTMP[0]
				Next
			Next
			Return $aRet
		EndIf

		Return SetError($POP3_ERROR, 0, 0)
	Else
		Return SetError($POP3_ERROR_NO_AUTH, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Info

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Connect
; Description ...: Conects to the according pop3 server.
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Connect($sLogin, $sPasswd[, $sServer = ""[, $iPort = 110]])
; Parameter(s): .: $sLogin      -
;                  $sPasswd     -
;                  $sServer     - Optional: (Default = "") : pop3 server
;                  $iPort       - Optional: (Default = 110) :
; Return Value ..: Success      - 1
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Fri Jan 15 18:37:29 CET 2010
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Connect($sLogin, $sPasswd, $sServer = "", $iPort = 110)
	If $POP3_ISCONNECTED = 0 Then

		If $iPort = 995 Then
			ConsoleWriteError("_ACN_POP3Connect: Error: SSL not supported ..." & @CRLF)
			Return SetError(1, 0, 0)
		EndIf

		If Not StringInStr($sServer, ".") Then
			Local $aTMP = StringRegExp($sLogin, '.*?@(.*?)\.(.*)', 3)
			If UBound($aTMP) Then
				$sServer = $aTMP[0]
				Local $sD = "." & $aTMP[1]
			Else
				ConsoleWriteError("_ACN_POP3Connect: Error: Can't find domain in login-name." & @CRLF)
				Return SetError(1, 0, 0)
			EndIf
			Select
				Case Ping("pop3." & $sServer & $sD, 2000)
					$sServer = "pop3." & $sServer & $sD
				Case Ping("pop." & $sServer & $sD, 2000)
					$sServer = "pop." & $sServer & $sD
				Case Ping("pop3." & $sServer & ".com", 2000)
					$sServer = "pop3." & $sServer & ".com"
				Case Ping("pop." & $sServer & ".com", 2000)
					$sServer = "pop." & $sServer & ".com"
				Case Else
					ConsoleWriteError("_ACN_POP3Connect: Error: Can't find POP3-server." & @CRLF)
					Return SetError(1, 0, 0)
			EndSelect
		EndIf

		TCPStartup()

		; Basic name to IP conversion
		ConsoleWrite("_ACN_POP3Connect: connecting to: (" & $sServer & ") ")
		If StringRegExp($sServer, "[a-zA-Z]") Then $sServer = TCPNameToIP($sServer)
		ConsoleWrite($sServer & ":" & $iPort & @CRLF)
		$POP3_SOCKET = TCPConnect($sServer, $iPort)
		If @error Then
			$POP3_ISCONNECTED = 0
			ConsoleWriteError("_ACN_POP3Connect: Error: " & @error & @CRLF)
			Return SetError($POP3_ERROR_TCPCONNECT_FAILED, 0, 0)
		Else
			$POP3_ISCONNECTED = 1
		EndIf

		; We need a first OK from pop3 server
		_ACN_POP3WaitForOK()
		If @error Then Return SetError($POP3_ERROR_NO_OK_RESPONSE, 0, 0)

		; Send user
		_ACN_POP3Cmd("USER " & $sLogin)
		If @error Then Return SetError(@error, 0, 0)

		; Send passwd
		_ACN_POP3Cmd("PASS " & $sPasswd)
		If @error Then Return SetError(@error, 0, 0)

		$POP3_ISAUTH = 1
		Return 1
	Else
		Return SetError($POP3_ERROR_ALREADY_CONNECTED, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Connect

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Dele
; Description ...: Delete msg n-msg_number.
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Dele($iMsg)
; Parameter(s): .: $iMsg        - msg-number
; Return Value ..: Success      - server response
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 15:24:41 CET 2010
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Dele($iMsg)
	If $POP3_ISAUTH Then
		_ACN_POP3Cmd("DELE " & $iMsg)
		If @error Then Return SetError(@error, 0, 0)

		Local $sRet = _ACN_POP3WaitTcpResponse()
		If @error Then Return SetError($POP3_ERROR_NO_TCP_RESPONSE, 0, 0)
		Return $sRet
	Else
		Return SetError($POP3_ERROR_NO_AUTH, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Dele

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Disconnect
; Description ...: Shuts down connection.
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Disconnect()
; Parameter(s): .:              -
; Return Value ..: Success      - 1
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 11:15:16 CET 2010
; Remark(s) .....: Use _ACN_POP3Quit to exit !!
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Disconnect()
	If $POP3_ISCONNECTED <> 0 Then
		TCPCloseSocket($POP3_SOCKET)
		TCPShutdown()
		$POP3_ISCONNECTED = 0
		Return 1
	Else
		Return SetError($POP3_ERROR_NOT_CONNECTED, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Disconnect

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3List
; Description ...: Returns an array with the msg number and its size (octets)
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3List([$iMsg = -1])
; Parameter(s): .: $iMsg        - Optional: (Default = -1) :
;                               | -1 = all
; Return Value ..: Success      - array[n][2]
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert, Oscar
; Date ..........: Thu Feb 24 23:00:26 CET 2010
; Link ..........:
; Related .......: _ACN_POP3Uidl
; Example .......: No
; ==============================================================================
Func _ACN_POP3List($iMsg = -1)
	If $POP3_ISAUTH Then
		Local $aRet[1][2], $aTMP2
		Local $sAddMsg = ""

		If $iMsg <> -1 Then
			$sAddMsg = " " & $iMsg
		EndIf

		; Send List
		Local $sRet = _ACN_POP3Cmd("LIST" & $sAddMsg)
		If @error Then Return SetError(@error, 0, 0)

		While $iMsg = -1 And Not StringRegExp($sRet, "\r\n\.\r\n")
			$sRet = $sRet & _ACN_POP3WaitTcpResponse()
			If @error Then Return SetError($POP3_ERROR_NO_TCP_RESPONSE, 0, 0)
		WEnd

		$sRet = StringRegExpReplace($sRet, '.+?message.+\(.+\)\r\n', @LF) ; Yahoo-Support, by Oscar

		; Stripping useless infos for complete listing
		If $iMsg = -1 Then
			$sRet = StringMid($sRet, 2, StringLen($sRet) - 6)
		Else
			$sRet = StringMid($sRet, 1, StringLen($sRet) - 2)
		EndIf

		Local $aTMP = StringSplit(StringStripCR($sRet), @LF)

		Local $iE = UBound($aTMP)
		ReDim $aRet[$iE][2]
		$aRet[0][0] = $iE - 1
		For $i = 1 To $iE - 1
			$aTMP2 = StringSplit($aTMP[$i], " ", 2)
			$aRet[$i][0] = $aTMP2[0]
			$aRet[$i][1] = $aTMP2[1]
		Next

		Return $aRet
	EndIf
EndFunc   ;==>_ACN_POP3List

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Noop
; Description ...: Actually, does nothing.
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Noop()
; Parameter(s): .:              -
; Return Value ..: Success      - 1
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 11:22:36 CET 2010
; Remark(s) .....: The most interesting command from RFC 1939 ;)
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Noop()
	If $POP3_ISAUTH Then
		; Send NOOP
		_ACN_POP3Cmd("NOOP")
		If @error Then Return SetError($POP3_ERROR_USER_REFUSED, 0, 0)
		Return 1
	EndIf
EndFunc   ;==>_ACN_POP3Noop

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Quit
; Description ...: Validates your actions (dele for example) and stops the connection as it should.
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Quit()
; Parameter(s): .:              -
; Return Value ..: Success      - 1
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 11:25:00 CET 2010
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Quit()
	If $POP3_ISAUTH Then
		_ACN_POP3Cmd("QUIT")
		If @error Then Return SetError(@error, 0, 0)
		Return 1
	Else
		Return SetError($POP3_ERROR_NO_AUTH, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Quit

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Retr
; Description ...: Downloads the according message
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Retr([$iMsg = -1])
; Parameter(s): .: $iMsg        - Optional: (Default = -1) :
;                                | -1 = newest
; Return Value ..: Success      - string
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 17:23:03 CET 2010
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Retr($iMsg = -1)
	If $POP3_ISAUTH Then
		If $iMsg = -1 Then
			Local $aStat = _ACN_POP3Stat()
			If Not @error Then $iMsg = $aStat[0]
		EndIf
		; Send Retr
		Local $sRet = _ACN_POP3Cmd("RETR " & $iMsg)
		If @error Then Return SetError(@error, 0, 0)

		; Downloading until final dot and cariage return.
		While Not StringRegExp($sRet, "\r\n\.\r\n")
			$sRet = $sRet & _ACN_POP3WaitTcpResponse()
			If @error Then Return SetError($POP3_ERROR_NO_TCP_RESPONSE, 0, 0)
		WEnd

		Return $sRet
	Else
		Return SetError($POP3_ERROR_NO_AUTH, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Retr

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Rset
; Description ...: Withdraw changes, such as dele orders
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Rset()
; Parameter(s): .:              -
; Return Value ..: Success      - 1
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 11:34:52 CET 2010
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Rset()
	If $POP3_ISAUTH Then
		; Send RSET
		_ACN_POP3Cmd("RSET")
		If @error Then Return SetError(@error, 0, 0)
		Return 1
	Else
		Return SetError($POP3_ERROR_NO_AUTH, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Rset

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Stat
; Description ...: Gets the number of messages in the pop3 account (array[1]) and the size(array[2]) in octets
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Stat()
; Parameter(s): .:              -
; Return Value ..: Success      - array
;                  Failure      - array[-1,-1]
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Fri Jan 15 09:54:17 CET 2010
; Link ..........:
; Related .......: _ACN_POP3MsgCnt
; Example .......: No
; ==============================================================================
Func _ACN_POP3Stat()
	Local $aRet[2] = [-1, -1]
	If $POP3_ISAUTH Then
		; Send STAT
		Local $sRet = _ACN_POP3Cmd("STAT")
		If @error Then Return SetError(@error, 0, 0)

		$sRet = StringStripWS($sRet, 3)
		$aRet = StringSplit($sRet, " ", 2)
		If IsArray($aRet) Then
			Return $aRet
		Else
			Return SetError($POP3_ERROR_STAT_BADRESPONSE, 0, $aRet)
		EndIf
	Else
		Return SetError($POP3_ERROR_NO_AUTH, 0, $aRet)
	EndIf
EndFunc   ;==>_ACN_POP3Stat

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3MsgCnt
; Description ...: Returns the number of messages
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3MsgCnt()
; Parameter(s): .:              -
; Return Value ..: Success      - number of messages
;                  Failure      - -1
;                  @ERROR       -
; Author(s) .....: Thorsten Willert
; Date ..........: Fri Jan 15 09:56:20 CET 2010
; Link ..........:
; Related .......: _ACN_POP3Stat
; Example .......: NO
; ==============================================================================
Func _ACN_POP3MsgCnt()
	Local $a = _ACN_POP3Stat()
	Return SetError(@error, 0, $a[0])
EndFunc   ;==>_ACN_POP3MsgCnt

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Top
; Description ...: Retreives the mail headers, and the X first lines of the message
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Top([$iMsg = -1[, $iLines = 0]])
; Parameter(s): .: $iMsg        - Optional: (Default = -1) :
;                               | -1 : newest
;                  $iLines      - Optional: (Default = 0) :
; Return Value ..: Success      - string
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 17:26:42 CET 2010
; Link ..........:
; Related .......:
; Example .......: No
; ==============================================================================
Func _ACN_POP3Top($iMsg = -1, $iLines = 0)
	If $POP3_ISAUTH Then
		If $iMsg = -1 Then
			Local $aStat = _ACN_POP3Stat()
			If Not @error Then $iMsg = $aStat[0]
		EndIf
		; Send Top
		Local $sRet = _ACN_POP3Cmd("TOP " & $iMsg & " " & $iLines)
		If @error Then Return SetError(@error, 0, 0)

		; Downloading until final dot and cariage return.
		While Not StringRegExp($sRet, "\r\n\.\r\n")
			$sRet = $sRet & _ACN_POP3WaitTcpResponse()
			If @error Then Return SetError($POP3_ERROR_NO_TCP_RESPONSE, 0, 0)
		WEnd
		Return $sRet
	Else
		Return SetError($POP3_ERROR_NO_AUTH, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Top

; #FUNCTION# ===================================================================
; Name ..........: _ACN_POP3Uidl
; Description ...: Same as _ACN_POP3List(), but with UIDL identifiers instead of message size.
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Uidl([$iMsg = -1])
; Parameter(s): .: $iMsg        - Optional: (Default = -1) :
; Return Value ..: Success      - array[n][2]
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 16:51:30 CET 2010
; Link ..........:
; Related .......: _ACN_POP3List
; Example .......: No
; ==============================================================================
Func _ACN_POP3Uidl($iMsg = -1)
	If $POP3_ISAUTH Then
		Local $aRet[1][2], $aTMP2
		Local $sAddMsg = ""

		If $iMsg <> -1 Then $sAddMsg = " " & $iMsg

		; Send List
		Local $sRet = _ACN_POP3Cmd("UIDL " & $sAddMsg)
		If @error Then Return SetError(@error, 0, 0)

		While $iMsg = -1 And Not StringRegExp($sRet, "\r\n\.\r\n")
			$sRet = $sRet & _ACN_POP3WaitTcpResponse()
			If @error Then Return SetError($POP3_ERROR_NO_TCP_RESPONSE, 0, 0)
		WEnd

		; Stripping useless infos for complete listing
		If $iMsg = -1 Then
			$sRet = StringMid($sRet, 2, StringLen($sRet) - 6)
		Else
			$sRet = StringMid($sRet, 1, StringLen($sRet) - 2)
		EndIf

		Local $aTMP = StringSplit(StringStripCR($sRet), @LF)

		Local $iE = UBound($aTMP)
		ReDim $aRet[$iE][2]
		$aRet[0][0] = $iE - 1
		For $i = 1 To $iE - 1
			$aTMP2 = StringSplit($aTMP[$i], " ", 2)
			$aRet[$i][0] = $aTMP2[0]
			$aRet[$i][1] = $aTMP2[1]
		Next

		Return $aRet
	Else
		Return SetError($POP3_ERROR_NO_AUTH, 0, 0)
	EndIf
EndFunc   ;==>_ACN_POP3Uidl

; #INTERNAL_USE_ONLY# ==========================================================
; Name ..........: _ACN_POP3Cmd
; Description ...:
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3Cmd($sMSg)
; Parameter(s): .: $sMSg        -
; Return Value ..: Success      - string
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Thorsten Willert
; Date ..........: Thu Jan 14 17:07:08 CET 2010
; ==============================================================================
Func _ACN_POP3Cmd($sMSg)
	If $POP3_TRACE Then ConsoleWrite(">: " & $sMSg & @CRLF)
	TCPSend($POP3_SOCKET, $sMSg & @CRLF)
	If @error Then Return SetError($POP3_ERROR_USER_REFUSED, 0, 0)
	Local $sRet = _ACN_POP3WaitForOK()
	If @error Then Return SetError($POP3_ERROR_NO_OK_RESPONSE, 0, 0)
	Return $sRet
EndFunc   ;==>_ACN_POP3Cmd

; #INTERNAL_USE_ONLY# ==========================================================
; Name ..........: _ACN_POP3WaitForOK
; Description ...: Returns the server response if it starts with "+OK"
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3WaitForOK()
; Parameter(s): .:              -
; Return Value ..: Success      - string
;                  Failure      - ""
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 11:50:34 CET 2010
; ==============================================================================
Func _ACN_POP3WaitForOK()
	; Wait for server response.
	Local $sRet
	Local $T = TimerInit()
	While TimerDiff($T) < $POP3_SERVER_RESPONSE_TIMEOUT
		$sRet = _ACN_POP3WaitTcpResponse()
		If Not @error And StringRegExp($sRet, '\+OK') Then Return StringRegExpReplace($sRet, '\+OK\s?', "")
		If StringRegExp($sRet, '\-ERR\s?') Then Return SetError($POP3_ERROR_ERR_RESPONSE, 0, "")
		Sleep(100)
	WEnd

	Return SetError($POP3_ERROR_SERVER_RESPONSE_TIMEOUT, 0, "")
EndFunc   ;==>_ACN_POP3WaitForOK

; #INTERNAL_USE_ONLY# ==========================================================
; Name ..........: _ACN_POP3WaitTcpResponse
; Description ...: Returns the server response
; AutoIt Version : V3.3.2.0
; Syntax ........: _ACN_POP3WaitTcpResponse([$iTimeOut = 30000])
; Parameter(s): .: $iTimeOut    - Optional: (Default = 30000) :
; Return Value ..: Success      - string
;                  Failure      - 0
;                  @ERROR       -
; Author(s) .....: Luc HENNINOT, Thorsten Willert
; Date ..........: Thu Jan 14 11:51:07 CET 2010
; ==============================================================================
Func _ACN_POP3WaitTcpResponse($iTimeOut = 30000)
	;Timeout to 30 s, should be enough in most cases. Overwright it if needed.
	Local $sRet = ""
	Local $T = TimerInit()
	While TimerDiff($T) < $iTimeOut
		$sRet = TCPRecv($POP3_SOCKET, 512)
		If $POP3_TRACE And $sRet Then ConsoleWrite("<: " & $sRet)
		If $sRet <> "" Then Return $sRet
		Sleep(100)
	WEnd
	Return SetError($POP3_ERROR_TCPRECV_TIMEOUT, 0, 0)
EndFunc   ;==>_ACN_POP3WaitTcpResponse