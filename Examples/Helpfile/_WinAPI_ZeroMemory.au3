#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $tStruct = DllStructCreate('byte[4096]')
Global $pStruct = DllStructGetPtr($tStruct)

Local $return = Hex( _WinAPI_ComputeCrc32($pStruct, 4096)) & @CRLF

_WinAPI_FillMemory($pStruct, 4096, Random(0, 255, 1))

$return &= Hex( _WinAPI_ComputeCrc32($pStruct, 4096)) & @CRLF

_WinAPI_ZeroMemory($pStruct, 4096)

$return &= Hex( _WinAPI_ComputeCrc32($pStruct, 4096))

msgbox(0, 'Result ', $return)

