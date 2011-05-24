#include <Security.au3>

Local $account = @UserName
Local $sid = _Security__GetAccountSid($account)
Local $stringSID = _Security__SidToStringSid(DllStructGetPtr($sid, 1))
MsgBox(0, "SID", "User = " & $account & @CRLF & "SID = " & $stringSID)
