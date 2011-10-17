 
 #include  <Date.au3> 
 Global  $Sec ,  $Min ,  $Hour ,  $Time 
 ; 以时间计算 
 $StartTicks  =  _TimeToTicks ( @HOUR , @MIN , @SEC ) 
 ; 计算45分后 
 $EndTicks  =  $StartTicks  +  45  *  60  *  1000 
 _TicksToTime ( $EndTicks , $Hour , $Min , $Sec ) 
 MsgBox ( 262144 , ''  ,  'New Time:'  &   $Hour  &  ":"  &  $Min  &  ":"  &  $Sec )  
 

