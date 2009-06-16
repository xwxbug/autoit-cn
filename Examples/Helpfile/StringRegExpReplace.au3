MsgBox(0, "Regular Expression Replace Test", StringRegExpReplace("Where have all the flowers gone, long time passing?", "[aeiou]", "@"))

#cs
\x20 is Chr(32) ie. space at begin and end of date
each part of date is closed in group ()
each group can be back referenced by $n starting from 1
so '$2.$1.$3' means changed order of MM and DD and using dot instead of slash among date parts
#ce

$text_in = _
'some text1 12/31/2009 01:02:03 some text2' & @CRLF & _
'some text3 02/28/2009 11:22:33 some text4'

; change date format from mm/dd/yyyy to dd.mm.yyyy
$text_out = StringRegExpReplace($text_in, '\x20(\d{2})/(\d{2})/(\d{4})\x20', ' $2.$1.$3 ')

MsgBox(0, "RegExp Replace Test - back-references", 'OLD:' & @CRLF & $text_in & @CRLF & @CRLF & 'NEW:' & @CRLF & $text_out )
