#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path = ' C:\Documents\Test.txt '

msgbox('', '_WinAPI_PathRemoveFileSpec ', 'Before:' & $Path & @CRLF & ' After :' & _WinAPI_PathRemoveFileSpec($Path))

