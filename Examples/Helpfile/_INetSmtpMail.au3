#include <INet.au3>

$s_SmtpServer = "mysmtpserver.com.au"
$s_FromName = "My Name"
$s_FromAddress = "From eMail Address"
$s_ToAddress = "To eMail Address"
$s_Subject = "My Test UDF"
Dim $as_Body[2]
$as_Body[0] = "Testing the new email udf"
$as_Body[1] = "Second Line"
$Response = _INetSmtpMail ($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject, $as_Body)
$err = @error
If $Response = 1 Then
	MsgBox(0, "Success!", "Mail sent")
Else
	MsgBox(0, "Error!", "Mail failed with error code " & $err)
EndIf
