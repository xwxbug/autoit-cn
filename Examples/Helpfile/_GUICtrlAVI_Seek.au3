 #include <GuiConstantsEx.au3> 
 #include <GuiAVI.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_AVI = False ; 检查传递给AVI函数的类名, 设置为真并设置另一控件句柄观察其工作 
 
 Global $hAVI 
 
 _Example_Internal () 
 _Example_External () 
 
 Func _Example_Internal () 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( " (Internal) AVI Seek ", 300 , 100 ) 
   $hAVI = GUICtrlCreateAvi ( @SystemDir & "\shell32.dll ", 160 , 10 , 10 ) 
   GUISetState () 
 
   ; 循环至用户退出 
   Do 
     Sleep ( 100 ) 
     ; 查找剪辑中的随机帧 
     _GUICtrlAVI_Seek ( $hAVI , Random ( 1 , 30 , 1 )) 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 
   ; 关闭影片片段 
   _GUICtrlAVI_Close ( $hAVI ) 
 
   GUIDelete () 
 EndFunc ;==>_Main 
 
 Func _Example_External () 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( " (External) AVI Seek ", 300 , 100 ) 
   $hAVI = _GUICtrlAVI_Create ( $hGUI , @SystemDir & "\Shell32.dll ", 160 , 10 , 10 ) 
   GUISetState () 
 
   ; 循环至用户退出 
   Do 
     Sleep ( 100 ) 
     ; 查找剪辑中的随机帧 
     _GUICtrlAVI_Seek ( $hAVI , Random ( 1 , 30 , 1 )) 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 
   ; 关闭影片片段 
   _GUICtrlAVI_Close ( $hAVI ) 
 
   GUIDelete () 
 EndFunc ;==>_Main 
 
