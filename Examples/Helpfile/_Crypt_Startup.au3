#include <Crypt.au3>

; 显示 _Crypt_Startup 的用法示例:

Local $sTest = "The quick brown fox jumps over the lazy dog"

; 初始化加密库后进行测试, 并在完成后关闭
_Crypt_Startup()
MsgBox(0, "MD5", $sTest & @CRLF & _Crypt_HashData($sTest, $CALG_MD5))
_Crypt_Shutdown()

; 没有初始化加密库时进行测试
MsgBox(0, "MD5", $sTest & @CRLF & _Crypt_HashData($sTest, $CALG_MD5))

