#Include  <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

_WinAPI_ShellSetSettings($SSF_SHOWEXTENSIONS, Not _WinAPI_ShellGetSettings($SSF_SHOWEXTENSIONS))
msgbox('', '', 'Hide extensions for known file types:' & (Not _WinAPI_ShellSetSettings($$SSF_SHOWEXTENSIONS)))

