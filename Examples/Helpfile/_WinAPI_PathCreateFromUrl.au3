#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path = @ScriptFullPath

$Path = _WinAPI_UrlCreateFromPath($Path)
msgbox(0, '_WinAPI_UrlCreateFromPath ', $Path)

$Path = _WinAPI_PathCreateFromUrl($Path)
msgbox(0, '_WinAPI_PathCreateFromUrl ', $Path)

