#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $bData, $tSource, $tCompress, $tDecompress

$bData = Binary('0x6C7A6E746C7A6E746C7A6E746C7A6E746C7A6E746C7A6E746C7A6E746C7A6E746C7A6E74') $tSource = DllStructCreate('byte[' & BinaryLen($bData) & ' ]')
DllStructSetData($tSource, 1, $bData)

_WinAPI_LZNTCompress($tSource, $tCompress)
_WinAPI_LZNTDecompress($tCompress, $tDecompress)

msgbox(0, 'Message ', 'Source:' & DllStructGetData($tSource, 1) & @CRLF & _
		' Compressed:' & DllStructGetData($tCompress, 1) & @CRLF & _
		' Decompressed:' & DllStructGetData($tDecompress, 1))

