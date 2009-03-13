#include <Date.au3>
Global $Sec, $Min, $Hour, $Time
; calculate with time
$StartTicks = _TimeToTicks(@HOUR,@MIN,@SEC)
; calculate 45 minutes later
$EndTicks = $StartTicks + 45 * 60 * 1000
_TicksToTime($EndTicks,$Hour,$Min,$Sec)
MsgBox(262144,'' , 'New Time:' &  $Hour & ":" & $Min & ":" & $Sec) 

