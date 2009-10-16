#include <Security.au3>

$account=@UserName
$sid =_Security__GetAccountSid($account)
$stringSID = _Security__SidToStringSid(DllStructGetPtr($sid,1))
MsgBox(0, "SID", "User = " & $account & @CRLF & "SID = " & $stringSID)
