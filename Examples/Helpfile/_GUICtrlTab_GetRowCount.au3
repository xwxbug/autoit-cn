 
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiTab.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_TAB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $hTab 
 
   ; 创建界面 
   GUICreate ( " Tab Control Get Row Count ", 400 , 300 ) 
   $hTab = GUICtrlCreateTab ( 2 , 2 , 396 , 296 , $TCS_MULTILINE ) 
   GUISetState () 
 
   ; 添加标签页 
   For $x = 0  To 10 
     _GUICtrlTab_InsertItem ( $hTab , $x , " Tab " & $x + 1 ) 
   Next 
 
   ; 获取行数量 
   MsgBox ( 4160 , " Information ", " Row count: " & _GUICtrlTab_GetRowCount ( $hTab )) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
