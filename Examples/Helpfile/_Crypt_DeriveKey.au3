#include <Crypt.au3>

; Exa,ple of resuing a key using _Crypt_DeriveKey

Local $StringsToCrypt[6] = ["Bluth", "Sunny", "AutoIt3", "SciTe", 42, "42"]
Local $Crypted[6]


; 由于 DeriveKey/DestroyKey 会内部处理, 所以我们不需要 _Crypt_Startup
Local $Key = _Crypt_DeriveKey("supersecretpassword", $CALG_RC4)

Local $DisplayStr = ""

For $Word In $StringsToCrypt
	$DisplayStr &= $Word & @TAB & " = " & _Crypt_EncryptData($Word, $Key, $CALG_USERKEY) & @CRLF
Next

MsgBox(0, "Crypt table", $DisplayStr)

_Crypt_DestroyKey($Key)
