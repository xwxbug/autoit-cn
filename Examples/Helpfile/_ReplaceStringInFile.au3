#include <File.au3>

$find = "BEFORE"
$replace = "AFTER"

$filename = "C:\_ReplaceStringInFile.test"

$msg = "Hello Test " & $find & " Hello Test" & @CRLF
$msg &= "Hello Test" & @CRLF
$msg &= @CRLF
$msg &= $find

FileWrite($filename, $msg )
	
msgbox(0,"BEFORE",$msg)

$retval = _ReplaceStringInFile($filename,$find,$replace)
if $retval = -1 then
	msgbox(0, "ERROR", "The pattern could not be replaced in file: " & $filename & " Error: " & @error)
	exit
else
	msgbox(0, "INFO", "Found " & $retval & " occurances of the pattern: " & $find & " in the file: " & $filename)
endif

$msg = FileRead($filename, 1000)
msgbox(0,"AFTER",$msg)
FileDelete($filename)
