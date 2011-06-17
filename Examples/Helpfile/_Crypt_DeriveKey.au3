#include <Crypt.au3>

; 使用 _Crypt_DeriveKey 重用密匙示例

Local $StringsToCrypt[6] = ["Bluth", "Sunny", "AutoIt3", "SciTe", 42, "42"]
Local $Crypted[6]


; 由于 DeriveKey/DestroyKey 会内部初始化, 所以这里不需要 _Crypt_Startup
Local $Key = _Crypt_DeriveKey("supersecretpassword", $CALG_RC4)

Local $DisplayStr = ""

For $Word In $StringsToCrypt
	$DisplayStr &= $Word & @TAB & " = " & _Crypt_EncryptData($Word, $Key, $CALG_USERKEY) & @CRLF
Next

MsgBox(0, "Crypt table", $DisplayStr)

_Crypt_DestroyKey($Key)
