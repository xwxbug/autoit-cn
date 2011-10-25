#include  <file.au3>
$CountLines = _FileCountLines(" error.log ")
msgbox(64, "Error log recordcount ", "There are" & $CountLines & "  in the error.log. ")
Exit

