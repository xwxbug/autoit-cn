112
   _GUICtrlButton_GetState      _GUICtrlButton_GetState   
获取按钮或复选框的状态 
 
#Include <GuiButton.au3> 
_GUICtrlButton_GetState( $hWnd ) 
  
   
参数   
 $hWnd  控件句柄    
   
返回值 成功: 返回按钮的当前状态。 使用下列值设定状态信息: 
    $BST_CHECKED - 按钮被选中. 
    $BST_FOCUS - 焦点状态.一个非零值指出按钮有键盘焦点. 
    $BST_INDETERMINATE - 不确定状态，按钮变为灰色.这个值仅用于有 $BS_3STATE 或 $BS_AUTO3STATE 样式的按钮. 
    $BST_PUSHED - 高亮显示状态。一个非零值指出按钮被突出显示.当用户在它上面放置光标与点击鼠标左键，按钮自动地被高亮突显；当用户放开鼠标按钮时，高亮突显自动消失. 
    $BST_UNCHECKED - 非选中状态，相当于返回一个零值. 
 
   
相关  _GUICtrlButton_SetState , _GUICtrlButton_GetCheck  
   
参考 在知识库中搜索BM_GETSTATE相关信息  
   
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GUIConstantsEx.au3> 
 #include  <GuiButton.au3> 
 #include  <WindowsConstants.au3> 
 
 Opt  ( " MustDeclareVars ", 1 ) 
 
 Global $iMemo 
 
 _Main  () 
 
 Func _Main() 
   Local $rdo , $rdo2 , $chk , $chk2 , $chk3 , $btn , $btn2 
 
   GUICreate  ( " Buttons ", 400 , 400 ) 
   $iMemo = GUICtrlCreateEdit ( "", 119 , 10 , 276 , 374 , $WS_VSCROLL ) 
   GUICtrlSetFont  ( $iMemo , 9 , 400 , 0 , " Courier New" ) 
 
   $btn = GUICtrlCreateButton ( " Button1 ", 10 , 10 , 90 , 25 ) 
   _GUICtrlButton_SetState ( $btn ) 
 
   $btn2 = GUICtrlCreateButton ( " Button2 ", 10 , 60 , 90 , 25 ) 
 
   $rdo = GUICtrlCreateRadio ( " Radio1 ", 10 , 110 , 90 , 25 ) 
   _GUICtrlButton_SetFocus ( $rdo ) 
 
   $rdo2 = GUICtrlCreateRadio ( " Radio2 ", 10 , 170 , 90 , 25 ) 
   _GUICtrlButton_SetCheck ( $rdo2 ) 
 
   $chk = GUICtrlCreateCheckbox ( " Check1 ", 10 , 230 , 90 , 25 , BitOR  ( $BS_AUTO3STATE , $BS_NOTIFY  )) 
   _GUICtrlButton_SetCheck ( $chk , $BST_INDETERMINATE ) 
 
   $chk2 = GUICtrlCreateCheckbox ( " Check2 ", 10 , 290 , 90 , 25 , BitOR  ( $BS_AUTO3STATE , $BS_NOTIFY  )) 
 
   $chk3 = GUICtrlCreateCheckbox ( " Check3 ", 10 , 350 , 90 , 25 , BitOR  ( $BS_AUTO3STATE , $BS_NOTIFY  )) 
   _GUICtrlButton_SetCheck ( $chk3 , $BST_CHECKED ) 
 
   GUISetState  () 
 
   MemoWrite( " Button1 status: " & @CRLF & " -------------------------------- " & _ 
       _ExplainState( _GUICtrlButton_GetState ( $btn ), True )) 
   MemoWrite( " Button2 status: " & @CRLF & " -------------------------------- " & _ 
       _ExplainState( _GUICtrlButton_GetState ( $btn2 ), True )) 
   MemoWrite( " Radio1 status: " & @CRLF & " -------------------------------- " & _ 
       _ExplainState( _GUICtrlButton_GetState ( $rdo ))) 
   MemoWrite( " Radio2 status: " & @CRLF & " -------------------------------- " & _ 
       _ExplainState( _GUICtrlButton_GetState ( $rdo2 ))) 
   MemoWrite( " Check1 status: " & @CRLF & " -------------------------------- " & _ 
       _ExplainState( _GUICtrlButton_GetState ( $chk ))) 
   MemoWrite( " Check2 status: " & @CRLF & " -------------------------------- " & _ 
       _ExplainState( _GUICtrlButton_GetState ( $chk2 ))) 
   MemoWrite( " Check3 status: " & @CRLF & " -------------------------------- " & _ 
       _ExplainState( _GUICtrlButton_GetState ( $chk3 ))) 
 
   While 1 
     Switch GUIGetMsg  () 
       Case $GUI_EVENT_CLOSE 
         ExitLoop 
     EndSwitch 
   WEnd 
 
   Exit 
 EndFunc ;==>_Main 
 
 ; 写入Memo控件 
 Func MemoWrite  ( $sMessage ) 
   GUICtrlSetData  ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc    ;==>MemoWrite 
 
 Func _ExplainState  ( $iState , $fPushButton = False ) 
   Local $sText = "" 
   If Not $fPushButton  And Not  $iState  Then Return _ 
       @CRLF & " Indicates the button is cleared. Same as a return value of zero. " & @CRLF  ;按钮已被清除. 等同于返回0 
   If BitAND ( $iState , $BST_CHECKED ) = $BST_CHECKED  Then _ 
       $sText &= @CRLF & " Indicates the button is checked. " & @CRLF  ;按钮已选中 
   If BitAND ( $iState , $BST_FOCUS ) = $BST_FOCUS  Then _ 
       $sText &= @CRLF & " Specifies the focus state. A nonzero value indicates that the button has the keyboard focus. " & @CRLF  ;按钮具有焦点. 非0值表示有键盘焦点 
   If BitAND ( $iState , $BST_INDETERMINATE ) = $BST_INDETERMINATE  Then _ 
       $sText &= @CRLF & " Indicates the button is grayed because the state of the button is indeterminate. " & @CRLF  ;按钮处于灰色状态 
   If $fPushButton  Then 
     If BitAND ( $iState , $BST_PUSHED ) = $BST_PUSHED  Then 
       $sText &= @CRLF & " Specifies the highlight state. " & @CRLF  ;按钮处于高亮状态 
     Else 
       $sText &= @CRLF & " Specifies not highlighted state. " & @CRLF  ;按钮未处于高亮状态 
     EndIf 
   EndIf 
   Return $sText 
 EndFunc ;==>_ExplainState 
 
