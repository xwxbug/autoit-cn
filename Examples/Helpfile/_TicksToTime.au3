 
 ; *** 显示计时器窗体示例 
 #include  <GUIConstantsEx.au3> 
 #include  <Date.au3> 
 
 Opt ( "TrayIconDebug" ,  1 ) 
 
 Opt ( "MustDeclareVars" ,  1 ) 
 
 Global  $timer ,  $Secs ,  $Mins ,  $Hour ,  $Time 
 
 _Main () 
 
 Func _Main () 
     ;创建界面 
     GUICreate ( "Timer" ,  120 ,  50 ) 
     GUICtrlCreateLabel ( "00:00:00" ,  10 ,  10 ) 
     GUISetState () 
     ;启动计时器 
     $timer  =  TimerInit () 
     AdlibEnable ( "Timer" ,  50 ) 
     ; 
     While  1 
         ;FileWriteLine("debug.log",@min & ":" & @sec & " ==> before") 
         Switch  GUIGetMsg () 
             Case  $GUI_EVENT_CLOSE 
                 Exit 
         EndSwitch 
         ;FileWriteLine("debug.log",@min & ":" & @sec & " ==> after") 
     WEnd 
 EndFunc    ;==>_Main 
 ; 
 Func Timer () 
     _TicksToTime ( Int ( TimerDiff ( $timer )),  $Hour ,  $Mins ,  $Secs ) 
     Local  $sTime  =  $Time   ; 保存当前计时器以便测试及避免碎片.. 
     $Time  =  StringFormat ( "%02i:%02i:%02i" ,  $Hour ,  $Mins ,  $Secs ) 
     If  $sTime  <>  $Time  Then  ControlSetText ( "Timer" ,  "" ,  "Static1" ,  $Time ) 
 EndFunc    ;==>Timer 

