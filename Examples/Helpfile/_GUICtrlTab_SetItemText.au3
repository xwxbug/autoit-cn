 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiTab.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_TAB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $hTab 
 
   ; 创建界面 
   GUICreate ( " Tab Control Item Text ", 400 , 300 ) 
   $hTab = GUICtrlCreateTab ( 2 , 2 , 396 , 296 ) 
   GUISetState () 
 
   ; 添加标签页 
   _GUICtrlTab_InsertItem ( $hTab , 0 , " Tab 1 " ) 
   _GUICtrlTab_InsertItem ( $hTab , 1 , " Tab 2 " ) 
   _GUICtrlTab_InsertItem ( $hTab , 2 , " Tab 3 " ) 
 
   ; 获取/设置标签1的文本 
   _GUICtrlTab_SetItemText ( $hTab , 0 , " New Text " ) 
   MsgBox ( 4160 , "Information" , " Tab 1 text: " & _GUICtrlTab_GetItemText ( $hTab , 0 )) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
