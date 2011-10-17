 
 #include  <SQLite.au3> 
 #include  <SQLite.dll.au3> 
 
 _SQLite_Startup () 
 _SQLite_Open () 
 If  $SQLITE_OK  <>  _SQLite_Exec (- 1 , "CREATE table test ('a', 'b');" )  Then  _  ; ²éÑ¯¶ªÊ§ 
     MsgBox ( 0 , "SQLite Error" , "Error Code: "  &  _SQLite_ErrCode ()  &  @CR  &  "Error Message: "  &  _SQLite_ErrMsg ()) 
 _SQLite_Close () 
 _SQLite_Shutdown () 
 
