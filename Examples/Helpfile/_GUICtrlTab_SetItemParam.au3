 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiTab.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_TAB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 ; 不要对由GUICtrlCreateTabItem创建的项目使用. Param为内置函数创建的项目的controlId 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI , $hTab 
 
   ; 创建界面 
   $hGUI = GUICreate ( "(UDF Created) Tab Control Get Item Param ", 400 , 300 ) 
   $hTab = _GUICtrlTab_Create ( $hGUI , 2 , 2 , 396 , 296 ) 
   GUISetState () 
 
   ; 添加标签页 
   _GUICtrlTab_InsertItem ( $hTab , 0 , " Tab 1 " ) 
   _GUICtrlTab_InsertItem ( $hTab , 1 , " Tab 2 " ) 
   _GUICtrlTab_InsertItem ( $hTab , 2 , " Tab 3 " ) 
 
   ; 获取/设置标签1的参数 
   _GUICtrlTab_SetItemParam ( $hTab , 0 , 1234 ) 
   MsgBox ( 4160 , " Information ", " Tab 1 parameter: " & _GUICtrlTab_GetItemParam ( $hTab , 0 )) 
 
   ; 循环至用户退出 
  Do 
  Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
