 
 #include  <GuiConstantsEx.au3> 
 #include  <Date.au3> 
 #include  <WindowsConstants.au3> 
 
 _Main () 
 
 Func _Main () 
     Local  $aInfo 
 
     ; 打开时钟以便观察函数 
     Run ( "RunDll32.exe shell32.dll,Control_RunDLL timedate.cpl" ) 
     WinWaitActive ( "Date and Time Properties" ) 
 
     ; 调整当前时钟 
     $aInfo  =  _Date_Time_GetSystemTimeAdjustment () 
 
     ; 调慢时钟 
     MsgBox ( 4096 ,  "Information" ,  "Slowing down system clock" ) 
     _Date_Time_SetSystemTimeAdjustment ( $aInfo [ 1 ]  /  10 ,  False ) 
     Sleep ( 5000 ) 
 
     ; 调快时钟 
     MsgBox ( 4096 ,  "Information" ,  "Speeding up system clock" ) 
     _Date_Time_SetSystemTimeAdjustment ( $aInfo [ 1 ]  *  10 ,  False ) 
     Sleep ( 5000 ) 
 
     ; 重设时钟校正 
     _Date_Time_SetSystemTimeAdjustment ( $aInfo [ 1 ],  True ) 
     MsgBox ( 4096 ,  "Information" ,  "System clock restored" ) 
 
 EndFunc    ;==>_Main 
 
