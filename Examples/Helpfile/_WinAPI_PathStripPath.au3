#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path = ' C:\Documents\Test.txt '

msgbox('', '_WinAPI_PathStripPath ', 'Before:' & $Path & @CRLF & ' After :' & _WinAPI_PathStripPath($Path))

