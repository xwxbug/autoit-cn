#include  <INet.au3>

$Address = InputBox('Address ', 'Enter the E-Mail address to send message to')
$Subject = InputBox('Subject ', 'Enter a subject for the E-Mail')
$Body = InputBox('Body ', 'Enter the body (message) of the E-Mail')
msgbox(0 ', E-Mail has been opened ', 'The E-Mail has been opened and process identifier for the E-Mail client is' & _INetMail($Address, $Subject, $Body))

