#Include  <WinAPIEx.au3>

While 1
	msgbox('', 'Idle time (ms) ', _WinAPI_GetIdleTime())
	Sleep(1000)
WEnd

