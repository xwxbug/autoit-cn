#include <Date.au3>
;#include <ACN_Date.au3>	;如果要使用中文的星期名称或者月名称请使用这个 #include
; 返回长名
$sLongDayName = _DateDayOfWeek( @WDAY )

; 返回短名
$sShortDayName = _DateDayOfWeek( @WDAY, 1 )

MsgBox( 4096, "一周中的一天", "今天是: " & $sLongDayName & " (" & $sShortDayName & ")" )
