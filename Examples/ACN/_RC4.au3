#include <ACN_HASH.au3>

$Encrypt = _RC4("The quick brown fox jumps over the lazy dog", "The Key")
msgbox(0, 'Encrypt Binary Result', $Encrypt)

$Decrypt = _RC4($Encrypt, "The Key")
msgbox(0, 'Decrypt Binary Result', $Decrypt)

msgbox(0, 'Decrypt String Result', BinaryToString($Decrypt))
