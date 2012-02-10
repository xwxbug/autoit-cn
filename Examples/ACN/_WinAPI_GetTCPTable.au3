#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $TCPtable = _WinApi_GetTCPtable()
_arraydisplay($TCPtable)

