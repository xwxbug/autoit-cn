#include  <Crypt.au3>

; Example of hashing data and using it to authenticate password

; This is the MD5-hash of the correct password
$bPasswordHash="0xCE950A8D7D367B5CE038E636893B49DC"

$sPassword=InputBox("Login","Please type the correct password.","Yellow fruit that is popular among monkeys")

If _Crypt_HashData($sPassword,$CALG_MD5)=$bPasswordHash Then
	MsgBox(64,"Access Granted","Password correct!")
Else
	MsgBox(16,"Access Denied","You entered the wrong password!")
EndIf

