#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

For $i = 1 To 3
	msgbox('', '', _WinAPI_CreateGUID())
Next

