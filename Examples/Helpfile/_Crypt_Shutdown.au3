#include <Crypt.au3>

; Example showing usage of _Crypt_Shutdown:

$sTest="The quick brown fox jumps over the lazy dog"

; Testing Crypt library with startup and shutdown
_Crypt_Startup()
MsgBox(0,"MD5",$sTest&@CRLF&_Crypt_HashData($sTest,$CALG_MD5))
_Crypt_Shutdown()

; Test Without
MsgBox(0,"MD5",$sTest&@CRLF&_Crypt_HashData($sTest,$CALG_MD5))

