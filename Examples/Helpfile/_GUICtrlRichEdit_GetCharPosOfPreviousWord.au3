 
 #AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GuiRichEdit.au3> 
 #include  <GUIConstantsEx.au3> 
 #include  <WindowsConstants.au3> 
 
 Global  $lblMsg ,  $hRichEdit 
 
 Main () 
 
 Func Main () 
     Local  $hGui ,  $iMsg ,  $btnNext ,  $iCp  =  200 
     $hGui  =  GUICreate ( "Example ("  &  StringTrimRight ( @ScriptName , 4 )  & ")" ,  320 ,  350 ,  - 1 ,  - 1 ) 
     $hRichEdit  =  _GUICtrlRichEdit_Create ( $hGui ,  "This is a test." ,  10 ,  10 ,  300 ,  220 ,  _ 
             BitOR ( $ES_MULTILINE ,  $WS_VSCROLL ,  $ES_AUTOVSCROLL )) 
     $lblMsg  =  GUICtrlCreateLabel ( "" ,  10 ,  235 ,  300 ,  60 ) 
     $btnNext  =  GUICtrlCreateButton ( "Next" ,  270 ,  310 ,  40 ,  30 ) 
     GUISetState () 
 
     _GuiCtrlRichEdit_AppendText ( $hRichEdit ,  "AutoIt v3 is a freeware BASIC-like scripting language designed for "  _ 
               &  "automating the Windows GUI and general scripting." ) 
 
     While  True 
         $iMsg  =  GUIGetMsg () 
         Select 
             Case  $iMsg  =  $GUI_EVENT_CLOSE 
                 GUIDelete () 
                 Exit 
             Case  $iMsg  =  $btnNext 
                 $iCp  =  _GuiCtrlRichEdit_GetCharPosOfPreviousWord ( $hRichEdit ,  $iCp ) 
                 GUICtrlSetData ( $lblMsg ,  $iCp ) 
                 ControlFocus ( $hRichEdit , "" , "" ) 
                 _GuiCtrlRichEdit_GotoCharPos ( $hRichEdit ,  $iCp ) 
         EndSelect 
     WEnd 
 EndFunc    ;==>Main 
 
