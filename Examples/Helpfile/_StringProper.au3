#include <String.au3>
;将返回 : Somebody Lastnames
MsgBox(4096, '', _StringProper("somebody lastnames"))
;将返回 : Some.Body Last(Name)
MsgBox(4096, '', _StringProper("SOME.BODY LAST(NAME)"))
Exit
