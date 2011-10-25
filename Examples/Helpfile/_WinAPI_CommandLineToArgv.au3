#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Data

$Data = _WinAPI_CommandLineToArgv('" a b " c d')
_arraydisplay($Data, '_WinAPI_CommandLineToArgv')

