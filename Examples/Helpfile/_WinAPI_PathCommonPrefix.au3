#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path1 = ' C:\Documents\Test.txt ' Global $Path2 = ' C:\Documents\Archive\Sample.txt ' Local $result

$result = ' Path1 :' & $Path1 & @CRLF
$result &= ' Path2 :' & $Path2 & @CRLF
$result &= ' Prefix :' & _WinAPI_PathCommonPrefix($Path1, $Path2)

msgbox(0, 'result ', $result)

