#include <ACN_HASH.au3>

$Encrypt = _Base64Encode("The quick brown fox jumps over the lazy dog")
msgbox(0, '', $Encrypt)

$Decrypt = _Base64Decode($Encrypt)
msgbox(0, '', $Decrypt)

msgbox(0, '', BinaryToString($Decrypt))
