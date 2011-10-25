#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path = ' C:\Documents\ '

msgbox('', '_WinAPI_PathRemoveBackslash ', 'Before:' & $Path & @CRLF & ' After :' & _WinAPI_PathRemoveBackslash($Path))

