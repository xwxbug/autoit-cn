#include <ACN_HASH.au3>

$Encrypt = _Base64Encode("The quick brown fox jumps over the lazy dog")
MsgBox(0, '', $Encrypt)

$Decrypt = _Base64Decode($Encrypt)
MsgBox(0, '', $Decrypt)

MsgBox(0, '', BinaryToString($Decrypt))
