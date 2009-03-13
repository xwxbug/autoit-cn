$begin = TimerInit()
sleep(3000)
$dif = TimerDiff($begin)
MsgBox(0,"时间差,这个计时的精度比sleep高",$dif)
