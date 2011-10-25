#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path[2] = [' C:\Documents\Test.txt ', 'C:\Documents\Test ']

For $i = 0 To 1
	msgbox(0, 'result ', $Path[$i] & '  =>' & _WinAPI_PathAddExtension($Path[$i], '.doc'))
Next

