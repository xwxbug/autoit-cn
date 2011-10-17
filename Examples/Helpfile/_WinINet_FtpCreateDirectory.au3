 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 #Include <WinINet.au3> 
 
 Global $iMemo 
 
 _Main () 
 
 Func _Main() 
   Local  $hGUI 
 
   ; 创建界面 
   $hGUI  = GUICreate ( " _WinINet_FtpCreateDirectory ", 600 , 400 ) 
 
   ; 创建memo控件 
   $iMemo = GUICtrlCreateEdit ( "", 2 , 2 , 596 , 396 , $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 初始化WinINet 
   _WinINet_Startup () 
 
   ; 设置变量 
   Global $sServerName = "" 
   Global $iServerPort = 21 
   Global $sUsername = Default 
   Global $sPassword = Default 
 
   Global $iPauseTime = 3000 
   Global $sDirectory = " /_WININET_UDF_TEST_DIRECTORY_ " 
   Global $sFile = " _WININET_UDF_TEST_FILE_ " 
   Global $sFileRenamed = " _WININET_UDF_TEST_FILE_RENAMED_ " 
 
   ; 创建句柄 
   Global $hInternetOpen = _WinINet_InternetOpen ( " AutoIt/ " & @AutoItVersion ) 
   Global $hInternetConnect = _WinINet_InternetConnect ( $hInternetOpen ,  $INTERNET_SERVICE_FTP ,  $sServerName ,  $iServerPort ,  0 ,  $sUsername ,  $sPassword ) 
 
   ; 创建目录 
   _WinINet_FtpCreateDirectory ( $hInternetConnect ,  $sDirectory ) 
   _WinINet_FtpSetCurrentDirectory ( $hInternetConnect ,  $sDirectory ) 
   MemoWrite( " Current Directory: " & _WinINet_FtpGetCurrentDirectory ( $hInternetConnect ) & @CRLF ) 
 
   ; 创建/上传测试文件 
   Sleep ( $iPauseTime ) 
   MemoWrite( " Uploading: " & @TempDir & " \ " & $sFile ) 
   FileWrite ( @TempDir & " \ " & $sFile , " AutoIt v " & @AutoItVersion ) 
   _WinINet_FtpPutFile ( $hInternetConnect ,  @TempDir & " \ " & $sFile ,  $sFile ) 
 
   ; 重命名测试文件 
   Sleep ( $iPauseTime ) 
   MemoWrite( " Renaming to: " & $sFileRenamed ) 
   _WinINet_FtpRenameFile ( $hInternetConnect ,  $sFile ,  $sFileRenamed ) 
 
   ; 确定远程文件存在 
   Global $avFtpFile = _WinINet_FtpFindFirstFile ( $hInternetConnect ,  $sFileRenamed ) 
   If @error Then 
     MemoWrite( " Found: " & DllStructGetData ( $avFtpFile [ 1 ] ,  " FileName " ) & @CRLF ) 
 
     ; 检查远程文件大小 
     Sleep ( $iPauseTime ) 
     MemoWrite( " Local Size: " & FileGetSize ( @TempDir & " \ " & $sFile )) 
 
     Global $hFtpOpenFile = _WinINet_FtpOpenFile ( $hInternetConnect ,  $sFileRenamed ,  $GENERIC_READ ) 
     Global $iFileSize = _WinINet_FtpGetFileSize ( $hFtpOpenFile ) 
     MemoWrite( " Remote Size: " & $iFileSize & @CRLF ) 
 
     ; 读取远程文件 
     Sleep ( $iPauseTime ) 
     Global $vReceived = Binary ( "" ) 
     Do 
       $vReceived &= _WinINet_InternetReadFile ( $hFtpOpenFile ,  $iFileSize ) 
     Until @error Or Not @extended 
     _WinINet_InternetCloseHandle ( $hFtpOpenFile ) 
 
     MemoWrite( " Remote file contents: " & BinaryToString ( $vReceived ) & @CRLF ) 
 
     ; 下载远程文件 
     Sleep ( $iPauseTime ) 
     _WinINet_FtpGetFile ( $hInternetConnect ,  $sFileRenamed ,  @TempDir & " \ " & $sFileRenamed ) 
     MemoWrite( " Downloaded file contents: " & FileRead ( @TempDir & " \ " & $sFileRenamed ) & @CRLF ) 
 
     ; 删除远程文件 
     Sleep ( $iPauseTime ) 
     MemoWrite( " Deleting remote file... " ) 
     _WinINet_FtpDeleteFile ( $hInternetConnect ,  $sFileRenamed ) 
 
     ; 删除远程目录 
     Sleep ( $iPauseTime ) 
     MemoWrite( " Deleting remote directory... " & @CRLF ) 
     _WinINet_FtpSetCurrentDirectory ( $hInternetConnect ,  $sDirectory & " /.. " ) 
     _WinINet_FtpRemoveDirectory ( $hInternetConnect ,  $sDirectory ) 
   EndIf 
 
   ; 清空... 
   MemoWrite( " Local cleanup... " ) 
   FileDelete ( @TempDir & " \ " & $sFile ) 
   FileDelete ( @TempDir & " \ " & $sFileRenamed ) 
 
   ; 清空 
   _WinINet_InternetCloseHandle ( $hInternetConnect ) 
   _WinINet_InternetCloseHandle ( $hInternetOpen ) 
   _WinINet_Shutdown () 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite( $sMessage = "" ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc    ;==>MemoWrite 
 
