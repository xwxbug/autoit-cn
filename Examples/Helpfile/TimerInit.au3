Local $begin = TimerInit()
Sleep(3000)
Local $dif = TimerDiff($begin)
MsgBox(0,"时间差,这个计时的精度比sleep高",$dif)
