#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiMonthCal.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_MC = False ; 检查传递给MonthCal函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 _Main () 
 
 Func _Main () 
   Local $hMonthCal , $msg 
 
   ; 创建界面 
   GUICreate ( "Month Calendar Get Cur Sel String" , 288 , 188 ) 
   $hMonthCal = GUICtrlCreateMonthCal ( "" , 4 , 4 , - 1 , - 1 , $WS_BORDER , 0x00000000 ) 
   GUISetState () 
 
   ; 获取当前选项 
   $msg = Msgbox ("", " Current selection: ", _GUICtrlMonthCal_GetCurSelStr ( $hMonthCal )) 
 
   ; 循环至用户退出 
   Do 
   Until $msg = 1 
   GUIDelete () 
 EndFunc    ;==>_Main 

