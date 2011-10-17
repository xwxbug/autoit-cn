58
 _GUICtrlComboBox_GetCueBanner     _GUICtrlComboBox_GetCueBanner   
获取显示在组合框编辑控件的提示标志文字  
#Include <GuiComboBox.au3> 
_GUICtrlComboBox_GetCueBanner( $hWnd ) 
 
   
参数    
 $hWnd  控件句柄  
   
返回值 成功: 提示标志文字 
失败: 空字符串 "" 
   
备注 提示标志是指当组合框的编辑控件中无选项时显示的文本 
最低系统要求: Windows Vista 
   
相关 _GUICtrlComboBox_SetCueBanner  
   
 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIComboBox.au3> 
 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 Global $iMemo 
 _Main() 
 
 Func _Main() 
   Local $hCombo 
 
   ; 创建界面 
   GUICreate ( " ComboBox ", 400 , 296 ) 
   $hCombo = GUICtrlCreateCombo ( Select an Item " ) 
   $iMemo = GUICtrlCreateEdit ( "", 10 , 50 , 376 , 234 , $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 添加文件 
   _GUICtrlComboBox_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBox_AddDir ( $hCombo , @WindowsDir & " \*.exe " ) 
   _GUICtrlComboBox_EndUpdate ( $hCombo ) 
 
   MemoWrite( " Cue Banner: " & _GUICtrlComboBox_GetCueBanner ( $hCombo )) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
 ; 写入memo控件 
 Func MemoWrite( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
