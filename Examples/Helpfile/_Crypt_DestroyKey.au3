#include <Crypt.au3>

; Exa,ple of resuing a key using _Crypt_DeriveKey

Local $StringsToCrypt[6]=["Bluth","Sunny","AutoIt3","SciTe",42,"42"]
Local $Crypted[6]


; We don't need _Crypt_Startup since DeriveKey/DestroyKey handles it internally
$Key=_Crypt_DeriveKey("supersecretpassword",$CALG_RC4)

$DisplayStr=""

for $Word In $StringsToCrypt
	$DisplayStr&=$Word&@TAB&" = "&_Crypt_EncryptData($Word,$Key,$CALG_USERKEY)&@CRLF
Next

MsgBox(0,"Crypt table",$DisplayStr)

_Crypt_DestroyKey($Key)
