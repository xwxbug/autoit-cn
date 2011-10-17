 ; ******************************************************* 
 ; 示例 - 创建一个新建空白文件的word窗体, 然后向文件添加一些图片. 
 ; ******************************************************* 
 #include <Word.au3> 
 
 $sPath = @WindowsDir & " \ " 
 $search = FileFindFirstFile ( $sPath & " *.bmp " ) 
 
 ; 检查搜索是否成功 
 If $search = -1 Then 
   MsgBox ( 0 , " Error ", " No images found " ) 
   Exit 
 EndIf 
 
 $oWordApp = _WordCreate () 
 $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
 
 While 1 
   $file = FileFindNextFile ( $search ) 
   If @error Then ExitLoop 
   $oShape = _WordDocAddPicture ( $oDoc , $sPath & $file , 0 , 1 ) 
   If Not @error Then $oShape.Range.InsertAfter ( @CRLF ) 
 WEnd 
 
 ; 关闭搜索句柄 
 FileClose ( $search ) 
 
