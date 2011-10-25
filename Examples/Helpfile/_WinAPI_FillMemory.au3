#include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $tStruct1, $tStruct2

_WinAPI_FillMemory( DllStructGetPtr($tStruct1), 8, 0x1D)

$tStruct2 = _WinAPI_CopyStruct($tStruct1)

msgbox(0, 'Info ', 'Source:' & DllStructGetData($tStruct1, 1) & @CRLF & _
		' Destination:' & DllStructGetData($tStruct2, 1))

