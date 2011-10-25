#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

msgbox('', 'NOW ', _WinAPI_GetTimeFormat() & @CR & _
		_WinAPI_GetTimeFormat(0, 0, BitOR($TIME_FORCE24HOURFORMAT, $TIME_NOSECONDS)))

