 #include <EditConstants.au3> 
 #include <GUIConstants.au3> 
 #include <SQLite.au3> 
 #include <SQLite.dll.au3> 
 
 Dim $msg 
 $GUI = GUICreate ( " SQLite Change ", 400 , 300 ) 
 $button = GUICtrlCreateButton ( " Push ", 145 , 274 , 110 , 24 , 0x2000 ) 
 $edit = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 270 , BitOR ( $ES_READONLY , $ES_AUTOVSCROLL )) 
 
 GUISetState ( @SW_SHOW , $GUI ) 
 
 While 1 
  $msg = GUIGetMsg () 
  Select 
    Case $msg = $button 
      $ERROR = 0 
 
      _SQLite_Startup () 
      _SQLite_Open () 
      _SQLite_Exec ( -1 , " CREATE TABLE test (a, b); " ) ; 创建表 
      _SQLite_Exec ( -1 , " INSERT INTO test VALUES ( ' 1 ' , ' 2 ' ); " ) ; 插入行1 
      _SQLite_Exec ( -1 , " INSERT INTO test VALUES ( ' 3 ' , ' 4 ' ); " ) ; 插入行2 
 
      $data = " _SQLite_LibVersion= " & _SQLite_LibVersion () & @CRLF & _ 
        " The Last Query changed " & _SQLite_Changes () & " Rows " & @CRLF & _ 
        " All Query changed " & _SQLite_TotalChanges () & " Rows " 
      _SQLite_Close () 
      _SQLite_Shutdown () 
      GUICtrlSetData ( $edit , $data ) 
    Case $msg = $GUI_EVENT_CLOSE 
      Exit 
  EndSelect 
 WEnd 
 
