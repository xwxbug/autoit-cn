
参考 搜索MSDN知识库中SetConsoleTextAttribute的相关信息

示例
#AutoIt3Wrapper_Change2CUI=y
#Include <WinAPIEx.au3>

$hnd = _WinAPI_GetStdHandle(1)
For $i = 0 To 255
	If $i = 0 Then
		_WinAPI_SetConsoleTextAttribute($hnd, 240)
		ConsoleWrite('0 - Colors' & @CRLF)
		ContinueLoop
	EndIf
	_WinAPI_SetConsoleTextAttribute($hnd, $i)
	ConsoleWrite($i & ' - Colors' & @CRLF)
Next
While 1
	Sleep(500)
WEnd

