48
 _GUICtrlListBox_GetLocale     _GUICtrlListBox_GetLocale   
获取当前地区 
 
#Include <GuiListBox.au3> 
_GUICtrlListBox_GetLocale( $hWnd ) 
  
   
参数    
 $hWnd  控件句柄  
   
返回值 成功: 高级别文字包含国家代码, 低级别文字包含语言识别码. 
 
   
相关 _GUICtrlListBox_GetLocaleCountry , _GUICtrlListBox_GetLocaleLang , _GUICtrlListBox_GetLocalePrimLang , _GUICtrlListBox_GetLocaleSubLang , _GUICtrlListBox_SetLocale  
   
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIListBox.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_LB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $hListBox 
 
   ; 创建界面 
   GUICreate ( " List Box Get Locale ",  400 , 296 ) 
   $hListBox = GUICtrlCreateList ( "",  2 , 2 , 396 , 296 ) 
   GUISetState () 
 
   ; 显示地区, 国家代码, 语言识别码, 基本语言编号, 子语言编号 
   MsgBox ( 4160 , " Information ", _ 
       " Locale .................: " & _GUICtrlListBox_GetLocale ( $hListBox ) & @LF & _ 
       " Country code ........: " & _GUICtrlListBox_GetLocaleCountry ( $hListBox ) & @LF & _ 
       " Language identifier..: " & _GUICtrlListBox_GetLocaleLang ( $hListBox ) & @LF & _ 
       " Primary Language id : " & _GUICtrlListBox_GetLocalePrimLang ( $hListBox ) & @LF & _ 
       " Sub-Language id ....: " & _GUICtrlListBox_GetLocaleSubLang ( $hListBox )) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
