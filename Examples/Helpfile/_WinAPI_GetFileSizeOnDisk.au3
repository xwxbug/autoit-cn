#include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global Const $sFile = @ScriptFullPath
Local $result
$result = ' Localtion:' & $sFile & @CRLF
$result &= ' Size:' & FileGetSize($sFile) & @CRLF
$result &= ' Size on disk:' & _WinAPI_GetFileSizeOnDisk($sFile)

msgbox(64, 'info ', $result)

