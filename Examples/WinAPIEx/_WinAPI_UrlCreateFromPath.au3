#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

ConsoleWrite(_WinAPI_UrlCreateFromPath(@ScriptFullPath) & @CR)
ConsoleWrite(_WinAPI_UrlCreateFromPath(@ScriptName) & @CR)
