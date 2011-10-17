 
 #AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GuiRichEdit.au3> 
 #include  <GUIConstantsEx.au3> 
 #include  <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 Global  $lblMsg ,  $hRichEdit 
 
 Main () 
 
 Func Main () 
     Local  $hGui ,  $iMsg ,  $btnNext ,  $iStep  =  0 
     $hGui  =  GUICreate ( "Example ("  &  StringTrimRight ( @ScriptName , 4 )  & ")" ,  320 ,  350 ,  - 1 ,  - 1 ) 
     $hRichEdit  =  _GUICtrlRichEdit_Create ( $hGui ,  "" ,  10 ,  10 ,  300 ,  220 ,  _ 
             BitOR ( $ES_MULTILINE ,  $WS_VSCROLL ,  $ES_AUTOVSCROLL )) 
     $lblMsg  =  GUICtrlCreateLabel ( "" ,  10 ,  235 ,  300 ,  60 ) 
     $btnNext  =  GUICtrlCreateButton ( "Next" ,  270 ,  310 ,  40 ,  30 ) 
     GUISetState () 
 
     _GuiCtrlRichEdit_SetText ( $hRichEdit ,  "Paragraph 1" ) 
     For  $i  =  2  To  20 
         _GuiCtrlRichEdit_AppendText ( $hRichEdit ,  @CRLF  &  "Paragraph "  &  $i ) 
     Next 
     Report ( "0. Initially scrolled to show insertion point" ) 
 
     While  True 
         $iMsg  =  GUIGetMsg () 
         Select 
             Case  $iMsg  =  $GUI_EVENT_CLOSE 
                 GUIDelete () 
                 Exit 
             Case  $iMsg  =  $btnNext 
                 $iStep  +=  1 
                 Switch  $iStep 
                     Case  1 
                         _GUICtrlRichEdit_SetScrollPos ( $hRichEdit ,  0 ,  0 ) 
                         Report ( "1. Scrolled to top" ) 
                     Case  2 
                         _GUICtrlRichEdit_SetScrollPos ( $hRichEdit ,  7 ,  22 ) 
                         Report ( "2. Scrolled down a bit, and to the right" ) 
                         GUICtrlSetState ( $btnNext ,  $GUI_DISABLE ) 
                 EndSwitch 
         EndSelect 
     WEnd 
 EndFunc    ;==>Main 
 
 Func Report ( $sMsg ) 
     Local  $aPos  =  _GUICtrlRichEdit_GetScrollPos ( $hRichEdit ) 
     $sMsg  =  $sMsg  &  "Get function returns "  &  $aPos [ 0 ]  &  ";"  &  $aPos [ 1 ] 
     GUICtrlSetData ( $lblMsg ,  $sMsg ) 
     ControlFocus ( $hRichEdit ,  "" ,  "" ) 
 EndFunc    ;==>Report 
 
