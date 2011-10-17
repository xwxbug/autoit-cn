 
 ; *************************************************************** 
 ; 示例1 - 打开并返回工作簿对象标识后使用循环写入单元格. 插入1行后保存并关闭文件. 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿并使之可见 
 
 For  $i  =  1  To  5  ;循环 
     _ExcelWriteCell ( $oExcel ,  $i ,  $i ,  1 )  ;将1到5垂直写入单元格 
 Next 
 
 ToolTip ( "Inserting Row(s) Soon..." ) 
 Sleep ( 3500 )  ;暂停使用户观察操作 
 
 _ExcelRowInsert ( $oExcel ,  1 ,  1 )  ;在行1处插入1行 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 ; *************************************************************** 
 ; 例2 - 打开并返回工作簿对象标识后使用循环写入单元格. 插入多行后保存并关闭文件. 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿并使之可见 
 
 For  $i  =  1  To  5  ;循环 
     _ExcelWriteCell ( $oExcel ,  $i ,  $i ,  1 )  ;将1到5垂直写入单元格 
 Next 
 
 ToolTip ( "Inserting Row(s) Soon..." ) 
 Sleep ( 3500 ) 
 
 _ExcelRowInsert ( $oExcel ,  2 ,  3 )  ;在行2处插入3行 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出  

