 
 ; *************************************************************** 
 ; 例1 - 打开并返回工作簿对象标识后, 通过表名的字符串值激活一张表 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿并使之可见 
 
 _ExcelSheetActivate ( $oExcel ,  "Sheet2" ) 
 
 MsgBox ( 0 ,  "Exiting" ,  "Notice How Sheet2 is Active and not Sheet1"  &  @CRLF  &  @CRLF  &  "Now Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 ; *************************************************************** 
 ; 例2 - 打开并返回工作簿对象标识后, 通过使用表的索引值激活一张表 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿并使之可见 
 
 _ExcelSheetActivate ( $oExcel ,  2 ) 
 
 MsgBox ( 0 ,  "Exiting" ,  "Notice How Sheet2 is Active and not Sheet1"  &  @CRLF  &  @CRLF  &  "Now Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 ; *************************************************************** 
 ; 例3 - 打开并返回工作簿对象标识后, 通过使用表的索引值激活一张表 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿并使之可见 
 
 $iNumberOfWorksheets  =  $oExcel . Worksheets . Count 
 
 MsgBox ( 0 ,  "" ,  $oExcel . Worksheets . Count ) 
 _ExcelSheetActivate ( $oExcel ,  2 ) 
 
 MsgBox ( 0 ,  "Exiting" ,  "Notice How Sheet2 is Active and not Sheet1"  &  @CRLF  &  @CRLF  &  "Now Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出  

