Example()

Func Example()
	; Ping AutoIt 网站,超时时间为 250 毫秒.
	Local $iPing = Ping("www.autoitscript.com", 250)

	If $iPing Then ; If a value greater than 0 was returned then display the following message.
		MsgBox(4096, "", "收发时间间隔: " & $iPing & "毫秒.")
	Else
		MsgBox(4096, "", "发生了一个错误, @error 值为: " & @error)
	EndIf
EndFunc   ;==>Example
