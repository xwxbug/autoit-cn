 AutoItSetOption ( "MustDeclareVars" ,  1 ) 
 
 #include  <Debug.au3> 
 
 _DebugSetup  ( "Check Excel" ) 
 For  $i  =  1  To  4 
     WinActivate ( "Microsoft Excel" ) 
     ; ”ÎExcelΩªª• 
     Send ( " {Down} " ) 
     _DebugOut  ( "Moved Mouse Down" ,  1 )   ; forces debug notepad window to take control 
 Next 

