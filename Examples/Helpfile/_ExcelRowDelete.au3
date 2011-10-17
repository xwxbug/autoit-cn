 
 ; *************************************************************** 
 ; 例1 - 打开工作簿并返回其对象标识后使用循环写入单元格. 删除一行后保存并关闭文件. 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿, 并使之可见 
 
 For  $i  =  1  To  5  ; 循环 
     _ExcelWriteCell ( $oExcel ,  $i ,  $i ,  1 )  ;将1到5垂直写入单元格 
 Next 
 
 ToolTip ( "Deleting Rows Soon..." ) 
 Sleep ( 3500 ) 
 
 _ExcelRowDelete ( $oExcel ,  1 ,  1 )  ; 删除且仅删除行1 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 ; *************************************************************** 
 ; 例2 - 打开工作簿并返回其对象标识后使用循环写入单元格. 插入几行后保存并关闭文件. 
 ; ***************************************************************** 
 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ; 新建工作簿, 并使之可见 
 
 For  $i  =  1  To  5  ;循环 
     _ExcelWriteCell ( $oExcel ,  $i ,  $i ,  1 )  ;将1到5垂直写入单元格 
 Next 
 
 ToolTip ( "Deleting Rows Soon..." ) 
 Sleep ( 3500 ) 
 
 _ExcelRowDelete ( $oExcel ,  3 ,  2 )  ;从行3开始删除2行 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出  

