#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path = @MyDocumentsDir

msgbox('', '_WinAPI_PathUnExpandEnvStrings ', 'Before:' & $Path & @CRLF & ' After :' & _WinAPI_PathUnExpandEnvStrings($Path))

