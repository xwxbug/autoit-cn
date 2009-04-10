#include <Date.au3>

$iDays = _DateDaysInMonth( @YEAR,@MON )
MsgBox( 4096, "一个月的天数", "这个月共有 " & String( $iDays ) & " 天." )
