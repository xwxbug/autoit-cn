 
 #include  <Date.au3> 
 
 ; 计算从UNIX时间戳(1970/01/01 00:00:00)以来经历的秒数 
 $iDateCalc  =  _DateDiff (  's' , "1970/01/01 00:00:00" , _NowCalc ()) 
 MsgBox (  4096 ,  "" ,  "Number of seconds since EPOCH: "  &  $iDateCalc  ) 
 
 ; 计算今年以经过的小时数 
 $iDateCalc  =  _DateDiff (  'h' , @YEAR  &  "/01/01 00:00:00" , _NowCalc ()) 
 MsgBox (  4096 ,  "" ,  "Number of Hours this year: "  &  $iDateCalc  )  

