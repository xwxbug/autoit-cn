#include <Security.au3>

Local $sAccount = @UserName
Local $tSID = _Security__GetAccountSid($sAccount)
Local $sStringSID = _Security__SidToStringSid($tSID)
MsgBox(4096, "SID", "User = " & $sAccount & @CRLF & "SID = " & $sStringSID)
