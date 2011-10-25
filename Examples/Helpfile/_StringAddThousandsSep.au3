#include  <String.au3>
$nAmount = 89996.31
$sDelimted = _StringAddThousandsSep($nAmount)
msgbox(64, 'Info ', $sDelimted)

$nAmt = ' 38849230 '
$sDelim = _StringAddThousandsSep($nAmt)
msgbox(64, 'Info ', $sDelim)

