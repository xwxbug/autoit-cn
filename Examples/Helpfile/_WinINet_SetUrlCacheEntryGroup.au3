 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 #Include <WinINet.au3> 
 
 Global $iMemo 
 
 _Main () 
 
 Func _Main() 
   Local  $hGUI 
 
   ; 创建界面 
   $hGUI  = GUICreate ( " _WinINet_UrlCache ", 600 , 400 ) 
 
   ; 创建memo控件 
   $iMemo = GUICtrlCreateEdit ( "", 2 , 2 , 596 , 396 , $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 初始化WinINet 
   _WinINet_Startup () 
 
   ; 创建虚拟缓存项 
   Global $sSourceUrlName = " http://www.autoitscript.com/ " 
   Global $sLocalFileName = _WinINet_CreateUrlCacheGroup ( $sSourceUrlName ) 
 
   ; 将虚拟项存入磁盘 
   _WinINet_CommitUrlCacheEntry ( $sSourceUrlName , $sLocalFileName ) 
 
   ; 创建虚拟缓存组 
   Global $iCacheGroupID = _WinINet_CreateUrlCacheGroup () 
 
   ; 设置URL为缓存组的一部分 
   _WinINet_SetUrlCacheEntryGroup ( $sSourceUrlName , $INTERNET_CACHE_GROUP_ADD , $iCacheGroupID ) 
 
   ; 枚举缓存组中的缓存项 
   Global $avCacheEntry = _WinINet_FindFirstUrlCacheEntryEx ( 0 , $NORMAL_CACHE_ENTRY , $iCacheGroupID ) 
 
   If Not @error Then 
     ; 将数据存入返回的数组 
     Global $hCacheEntry = $avCacheEntry [ 0 ] 
     Global $avCacheEntryInfo = $avCacheEntry [ 1 ] 
     $avCacheEntry = 0 
 
     While Not @error 
       ; 输出当前找到的缓存值 
       MemoWrite ( " ---------- " ) 
       For $i = 0  To  UBound ( $avCacheEntryInfo ) - 1 
         MemoWrite ( StringFormat ( " --> [%d]: %s ", $i , $avCacheEntryInfo [ $i ])) 
       Next 
       MemoWrite ( " ---------- " & @CRLF ) 
 
       ; 查找下一缓存项 
       $avCacheEntryInfo = _WinINet_FindNextUrlCacheEntryEx ( $hCacheEntry ) 
     Wend 
 
     ; 关闭句柄 
     _WinINet_FindCloseUrlCache ( $hCacheEntry ) 
   EndIf 
 
   ; 删除缓存组 
   _WinINet_DeleteUrlCacheGroup ( $iCacheGroupID , $CACHEGROUP_FLAG_FLUSHURL_ONDELETE ) 
 
   ; 清除 
   _WinINet_Shutdown () 
 
   ; 循环至用户退出 
   Do 
   Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite( $sMessage = "" ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc    ;==>MemoWrite 
 
