 
 #include  <Date.au3> 
 ; 给定日期的周的ISO日序号0=周一 - 6=周日 
 $iWeekday  =  _DateToDayOfWeekISO  ( @YEAR ,  @MON ,  @MDAY ) 
 ; 与@Wday不同 
 MsgBox ( 4096 ,  "" ,  "Todays ISO WeekdayNumber is: "  &  $iWeekDay ) 
 
