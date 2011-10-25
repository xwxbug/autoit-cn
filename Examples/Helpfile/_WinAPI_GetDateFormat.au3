#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

msgbox('', 'TODAY ', _WinAPI_GetDateFormat() & @CR & _
		_WinAPI_GetDateFormat(0, 0, $$DATE_LONGDATE) & @CR & _
		_WinAPI_GetDateFormat(0, 0, 0, 'dddd dd, yyyy'))

