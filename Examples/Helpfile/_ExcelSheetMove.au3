 
 ; ***************************************************************** 
 ; 例1 - 打开并返回工作簿对象标识后, 通过表的索引移动表 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿并使之可见 
 _ExcelSheetMove ( $oExcel ,  2 )  ;移动第二张表到第一个位置(基于整数/索引) 
 MsgBox ( 0 ,  "Exiting" ,  "Notice How Sheet2 is in the 1st Position"  &  @CRLF  &  @CRLF  &  "Now Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 ; ***************************************************************** 
 ; 例2 - 打开并返回工作簿对象标识后, 通过表的字符串名称移动表 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿并使之可见 
 _ExcelSheetMove ( $oExcel ,  "Sheet2" )  ;移动第二张表到第一个位置(基于字符串/名称) 
 MsgBox ( 0 ,  "Exiting" ,  "Notice How Sheet2 is in the 1st Position"  &  @CRLF  &  @CRLF  &  "Now Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 ; *************************************************************** 
 ; 例3 - 打开并返回工作簿对象标识后, 通过表的索引值移动表 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿并使之可见 
 ;添加一些表, 并做一些整理 
 $sSheetName4  =  "Sheet4" 
 $sSheetName5  =  "Sheet5" 
 _ExcelSheetAddNew ( $oExcel ,  $sSheetName4 )  ;添加一些表 
 _ExcelSheetMove ( $oExcel ,  $sSheetName4 ,  4 ,  False )  ;移动$sSheetName4到第四的位置(如果失败将其放置在相关表后) 
 
 _ExcelSheetAddNew ( $oExcel ,  $sSheetName5 )  ;添加一些表 
 _ExcelSheetMove ( $oExcel ,  $sSheetName5 ,  5 ,  False )  ;移动$sSheetName4到第五的位置(如果失败将其放置在相关表后) 
 
 MsgBox ( 0 ,  "Show" ,  "Take note of the order of the Worksheets"  &  @CRLF  &  @CRLF  &  "Press OK to Continue" ) 
 
 _ExcelSheetMove ( $oExcel ,  $sSheetName5 ,  "Sheet3" ,  True )  ;移动第五张表到相关的命名为'Sheet3'的位置前 
 MsgBox ( 0 ,  "Exiting" ,  "'"  &  $sSheetName5  &  "'"  &  " when the $fBefore paramter is True (Relative to 'Sheet3')"  &  @CRLF  &  @CRLF  &  "Press OK to Continue" ) 
 _ExcelSheetMove ( $oExcel ,  $sSheetName5 ,  "Sheet3" ,  False )  ;移动第五张表到相关的命名为'Sheet3'的位置前 
 MsgBox ( 0 ,  "Exiting" ,  "'"  &  $sSheetName5  &  "'"  &  " when the $fBefore paramter is False (Relative to 'Sheet3')"  &  @CRLF  &  @CRLF  &  "Now Press OK to Save File and Exit" ) 
 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出  

