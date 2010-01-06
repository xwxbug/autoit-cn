#include "ACN_HASH.au3"

$Encrypt = _XXTEA_Encrypt("The quick brown fox jumps over the lazy dog", "The Key")
MsgBox(0, 'Encrypt String with Zero Padding', $Encrypt)

$Decrypt = _XXTEA_Decrypt($Encrypt, "The Key")
MsgBox(0, 'Decrypt Binary Result', $Decrypt)

MsgBox(0, 'Decrypt String Result', BinaryToString($Decrypt))


$Encrypt = _XXTEA_Encrypt_Pad("0x0000", "The Key")
MsgBox(0, 'Encrypt Binary (0x0000) with "Pad80" Scheme', $Encrypt)

$Decrypt = _XXTEA_Decrypt_Pad($Encrypt, "The Key")
MsgBox(0, 'Decrypt Binary Result', $Decrypt)
