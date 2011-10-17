 #AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 
 #include <WinAPI.au3> 
 
 Global $hWindow , $stRET , $sMsg , $pStruct , $iRET 
 
 ; 创建记事本实例 
 Run ( "notepad.exe" ) 
 WinWait ( "[CLASS:Notepad]" ) 
 $hWindow = WinGetHandle ( "[CLASS:Notepad]" ) 
 WinMove ( $hWindow , "" , 256 , 256 , 400 , 400 ) 
 Sleep ( 1000 ) 
 
 ; 最小化且然后检查由_WinAPI_GetWindowPlacement()返回的位置值 
 WinSetState ( $hWindow , "" , @SW_MINIMIZE ) 
 $stRET = _WinAPI_GetWindowPlacement ( $hWindow ) 
 If @error = 0 Then 
   $sMsg = "$stWindowPlacement:" & @CRLF & @CRLF 
   $sMsg &= @TAB & "length = " & DllStructGetData ( $stRET , "length" ) & @CRLF 
   $sMsg &= @TAB & "flags = " & DllStructGetData ( $stRET , "flags" ) & @CRLF 
   $sMsg &= @TAB & "showCmd = " & DllStructGetData ( $stRET , "showCmd" ) & @CRLF & @CRLF 
   $sMsg &= "ptMinPosition:" & @CRLF 
   $sMsg &= @TAB & "MinX = " & DllStructGetData ( $stRET , "ptMinPosition" , 1 ) & @CRLF 
   $sMsg &= @TAB & "MinY = " & DllStructGetData ( $stRET , "ptMinPosition" , 2 ) & @CRLF & @CRLF 
   $sMsg &= "ptMaxPosition:" & @CRLF 
   $sMsg &= @TAB & "MaxX = " & DllStructGetData ( $stRET , "ptMaxPosition" , 1 ) & @CRLF 
   $sMsg &= @TAB & "MaxY = " & DllStructGetData ( $stRET , "ptMaxPosition" , 2 ) & @CRLF & @CRLF 
   $sMsg &= "rcNormalPosition:" & @CRLF 
   $sMsg &= @TAB & "left = " & DllStructGetData ( $stRET , "rcNormalPosition" , 1 ) & @CRLF 
   $sMsg &= @TAB & "top = " & DllStructGetData ( $stRET , "rcNormalPosition" , 2 ) & @CRLF 
   $sMsg &= @TAB & "right = " & DllStructGetData ( $stRET , "rcNormalPosition" , 3 ) & @CRLF 
   $sMsg &= @TAB & "bottom = " & DllStructGetData ( $stRET , "rcNormalPosition" , 4 ) 
   MsgBox ( 64 , "Success" , $sMsg ) 
 
   ; 使用_WinAPI_SetWindowPlacement()改变正常化的矩形然后恢复 
   DllStructSetData ( $stRET , "rcNormalPosition" , 128 , 1 ) ; 左 
   DllStructSetData ( $stRET , "rcNormalPosition" , 128 , 2 ) ; 顶 
   DllStructSetData ( $stRET , "rcNormalPosition" , @DesktopWidth - 128 , 3 ) ; 右 
   DllStructSetData ( $stRET , "rcNormalPosition" , @DesktopHeight - 128 , 4 ) ; 底 
   $pStruct = DllStructGetPtr ( $stRET ) ; 获取修改后的结构的指针 
   $iRET = _WinAPI_SetWindowPlacement ( $hWindow , $pStruct ) 
   If @error = 0 Then 
     WinSetState ( $hWindow , "" , @SW_RESTORE ) 
     ControlSetText ( $hWindow , "" , "Edit1" , "_WinAPI_SetWindowPlacement() succeeded!" ) 
   Else 
     MsgBox ( 16 , "Error" , "_WinAPI_SetWindowPlacement() failed!" & @CRLF & _ 
             "$iRET = " & $iRET & @CRLF & _ 
             "@error = " & @error & @CRLF & _ 
             "@extended = " & @extended ) 
   EndIf 
 Else 
   MsgBox ( 16 , "Error" , "_WinAPI_GetWindowPlacement() failed!" & @CRLF & _ 
           "$stRET = " & $stRET & @CRLF & _ 
           "@error = " & @error & @CRLF & _ 
           "@extended = " & @extended ) 
 EndIf 
 
