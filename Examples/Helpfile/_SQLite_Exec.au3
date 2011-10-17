回调序列的首行为列名. 
   
相关  _SQLite_Query , _SQLite_Gettable , _SQLite_Gettable2d  
   
示例  
 
  #include <sqlite.au3> 
 #include <sqlite.dll.au3> 
 #include <EditConstants.au3> 
 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 
 Local $hQuery , $aRow , $iMemo 
 
 _Main () 
 
 Func _Main () 
   $hGUI = GUICreate ( "_SQLite_Exec" , 400 , 300 ) 
   $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 296 , BitOR ( $ES_READONLY , $ES_AUTOVSCROLL )) 
   GUISetState () 
 
   _SQLite_Startup () 
   _SQLite_Open () 
   ; 无结果查询中不带$sCallback 
   _SQLite_Exec (- 1 , "Create table tblTest (a,b int,c single not null);" & _ 
                    "Insert into tblTest values ('1',2,3);" & _ 
                    "Insert into tblTest values (Null,5,6);" ) 
 
   $d = _SQLite_Exec (- 1 , "Select oid,* From tblTest" , "_cb" ) ; _cb将被每行调用 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
   _SQLite_Close () 
   _SQLite_Shutdown () 
 EndFunc 
 
 Func _cb ( $aRow ) 
   For $s In $aRow 
     memowrite ( $s & @TAB ) 
   Next 
   memowrite ( @LF ) 
   ; 返回$SQLITE_ABORT ; 将退出并导致_SQLite_Exec()出错的操作 
 EndFunc 
 
 Func memowrite ( $s_text ) 
     GUICtrlSetData ( $edit , $s_text & @CR , 1) 
 EndFunc    ;==>memowrite 
 
