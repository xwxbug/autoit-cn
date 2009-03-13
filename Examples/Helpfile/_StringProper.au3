#include <String.au3>
;Will return : Somebody Lastnames
Msgbox(0,'',_StringProper("somebody lastnames"))
;Will return : Some.Body Last(Name)
Msgbox(0,'',_StringProper("SOME.BODY LAST(NAME)"))
Exit
