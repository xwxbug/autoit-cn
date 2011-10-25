#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path = @ScriptFullPath

msgbox('', '_WinAPI_PathCompactPathEx ', 'Before:' & $Path & @CRLF & ' After :' & _WinAPI_PathCompactPathEx($Path, 40))

