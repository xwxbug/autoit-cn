#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path = ' C:\Documents\Test.txt '

msgbox('', '_WinAPI_PathStripToRoot ', 'Before:' & $Path & @CRLF & ' After :' & _WinAPI_PathStripToRoot($Path))

