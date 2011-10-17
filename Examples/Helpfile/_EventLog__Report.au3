 #include <EventLog.au3> 
 
 _Main() 
 
 Func _Main() 

   Local $hEventLog 

   $hEventLog = _EventLog__Open ( "", " Application " ) 
   _EventLog__Report ( $hEventLog , 4 , 0 , 2 , " Administrator ", " AutoIt3 generated event ", $aData ) 
   _EventLog__Close ( $hEventLog ) 

 EndFunc ;==>_Main 
 
