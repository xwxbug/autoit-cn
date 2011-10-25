#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path[2] = [' C:\Documents\ ', 'C:\Documents ']

For $i = 0 To 1
	msgbox(0, 'result ', $Path[$i] & '  =>' & _WinAPI_PathAddBackslash($Path[$i]))
Next

