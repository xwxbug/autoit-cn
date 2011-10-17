 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIListBox.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_LB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 _Main () 
 
 Func _Main () 
   Local $sItems , $aItems , $hListBox 
 
   ; 创建界面 
   GUICreate ( "List Box Get Sel Items" , 400 , 296 ) 
   $hListBox = GUICtrlCreateList ( "" , 2 , 2 , 396 , 296 , BitOR ( $LBS_STANDARD , $LBS_EXTENDEDSEL )) 
   GUISetState () 
 
   ; 添加字符串 
   _GUICtrlListBox_BeginUpdate ( $hListBox ) 
   For $iI = 1 To 9 
     _GUICtrlListBox_AddString ( $hListBox , StringFormat ( "%03d : Random string" , Random ( 1 , 100 , 1 ))) 
   Next 
   _GUICtrlListBox_EndUpdate ( $hListBox ) 
 
   ; 选择一些项目 
   _GUICtrlListBox_SetSel ( $hListBox , 3 ) 
   _GUICtrlListBox_SetSel ( $hListBox , 4 ) 
   _GUICtrlListBox_SetSel ( $hListBox , 5 ) 
 
   ; 获取被选项目索引 
   $aItems = _GUICtrlListBox_GetSelItems ( $hListBox ) 
   For $iI = 1 To $aItems [ 0 ] 
     If $iI > 1 Then $sItems &= ", " 
     $sItems &= $aItems [ $iI ] 
   Next 
   MsgBox ( 4160 , "Information" , "Items Selected: " & $sItems ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
