WinMove("[active]","",default, default, 200,300)	; 只调整活动窗口大小(不移动)

MyFunc2(Default,Default)

Func MyFunc2($Param1 = Default, $Param2 = '第二个参数', $Param3 = Default)
    If $Param1 = Default Then $Param1 = '第一个参数'
    If $Param3 = Default Then $Param3 = '第三个参数'

    MsgBox(0, '参数', '1 = ' & $Param1 & @LF & _
        '2 = ' & $Param2 & @LF & _
        '3 = ' & $Param3)
EndFunc
