 
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GuiConstantsEx.au3> 
 #include  <GuiListView.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 $Debug_LV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 _Main () 
 
 Func _Main () 
     Local  $aItem ,  $hListView 
     
     GUICreate ( "ListView Get Item" ,  400 ,  300 ) 
 
     $hListView  =  GUICtrlCreateListView ( "Items" ,  2 ,  2 ,  394 ,  268 ) 
     GUISetState () 
 
     GUICtrlCreateListViewItem ( "Row 1" ,  $hListView ) 
     GUICtrlCreateListViewItem ( "Row 2" ,  $hListView ) 
     GUICtrlCreateListViewItem ( "Row 3" ,  $hListView ) 
 
     ; 显示项目2的文本 
     $aItem  =  _GUICtrlListView_GetItem ( $hListView ,  1 ) 
     MsgBox ( 4160 ,  "Information" ,  "Item 2 Text: "  &  $aItem [ 3 ]) 
     
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 
     GUIDelete () 
 EndFunc    ;==>_Main 
 
