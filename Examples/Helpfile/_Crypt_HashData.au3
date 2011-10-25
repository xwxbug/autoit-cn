
#include  <Crypt.au3>

; 散列化数据并使用它来确认密码的示例

; 此为正确密码的MD5-hash
$bPasswordHash = "0xCE950A8D7D367B5CE038E636893B49DC"

$sPassword = InputBox("Login", "Please type the correct password.", "Yellow fruit that is popular among monkeys")

If _Crypt_HashData($sPassword, $CALG_MD5) = $bPasswordHash Then
	msgbox(64, "Access Granted", "Password correct!")
Else
	msgbox(16, "Access Denied", "You entered the wrong password!")
EndIf

