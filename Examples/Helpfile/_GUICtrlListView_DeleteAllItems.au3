
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiListView.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_LV = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 Example1 () 
 Example2 () 
 Example_UDF_Created () 
 
 Func Example1 () 
   Local $GUI , $hListView 
 
   $GUI = GUICreate ( "ListView Delete All Items" , 400 , 300 ) 
 
   $hListView = GUICtrlCreateListView ( "col1|col2|col3" , 2 , 2 , 394 , 268 ) 
   GUISetState () 
 
   ;  加载3列 
   For $iI = 0 To 9 
     GUICtrlCreateListViewItem ( "Item " & $iI & "|Item " & $iI & "-1|Item " & $iI & "-2" , $hListView ) 
   Next 
 
   MsgBox ( 4160 , "Information" , "Delete All Items" ) 
   ; 使用建立函数创建的项目, 传递控件ID 
   MsgBox ( 4160 , "Deleted?" , _GUICtrlListView_DeleteAllItems ( $hListView )) 
   
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>Example1 
 
 Func Example2 () 
   Local $GUI , $hListView , $aItems [ 10 ][ 3 ] 
   
   $GUI = GUICreate ( "ListView Delete All Items" , 400 , 300 ) 
 
   $hListView = GUICtrlCreateListView ( "col1|col2|col3" , 2 , 2 , 394 , 268 ) 
   GUISetState () 
 
   ; 加载3列 
   For $iI = 0 To UBound ( $aItems ) - 1 
     $aItems [ $iI ][ 0 ] = "Item " & $iI 
     $aItems [ $iI ][ 1 ] = "Item " & $iI & "-1" 
     $aItems [ $iI ][ 2 ] = "Item " & $iI & "-2" 
   Next 
 
   _GUICtrlListView_AddArray ( $hListView , $aItems ) 
   
   MsgBox ( 4160 , "Information" , "Delete All Items" ) 
   ; 使用UDF函数创建的项目, 向控件传递句柄 
   MsgBox ( 4160 , "Deleted?" , _GUICtrlListView_DeleteAllItems ( GUICtrlGetHandle ( $hListView ))) 
   
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>Example2 
 
 Func Example_UDF_Created () 
   Local $GUI , $hListView , $aItems [ 10 ][ 3 ] 
   
   $GUI = GUICreate ( "(UDF Created) ListView Delete All Items" , 400 , 300 ) 
 
   $hListView = _GUICtrlListView_Create ( $GUI , "col1|col2|col3" , 2 , 2 , 394 , 268 ) 
   GUISetState () 
 
   ; 加载3列 
   For $iI = 0 To UBound ( $aItems ) - 1 
     $aItems [ $iI ][ 0 ] = "Item " & $iI 
     $aItems [ $iI ][ 1 ] = "Item " & $iI & "-1" 
     $aItems [ $iI ][ 2 ] = "Item " & $iI & "-2" 
   Next 
 
   _GUICtrlListView_AddArray ( $hListView , $aItems ) 
   
   MsgBox ( 4160 , "Information" , "Delete All Items" ) 
   ; 已经是一个句柄 
   MsgBox ( 4160 , "Deleted?" , _GUICtrlListView_DeleteAllItems ( $hListView )) 
   
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>Example_UDF_Created 
 
