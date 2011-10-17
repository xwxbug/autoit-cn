 
 #include  <Date.au3> 
 
 ; 获取长名称 
 $sLongMonthName  =  _DateToMonth ( @MON ) 
 
 ; 获取简略名称 
 $sShortMonthName  =  _DateToMonth ( @MON ,  1 ) 
 
 MsgBox ( 4096 ,  "Month of Year" ,  "The month is: "  &  $sLongMonthName  &  " ("  &  $sShortMonthName  &  ")" )  

