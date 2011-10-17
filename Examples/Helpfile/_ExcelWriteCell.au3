 
 ; *************************************************************** 
 ; 例1 - 打开并返回工作簿对象标识后写入一个单元格, 保存并关闭文件. 
 ; ***************************************************************** 
 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿, 并使之可见 
 
 _ExcelWriteCell ( $oExcel ,  "I Wrote to This Cell" ,  1 ,  1 )  ;写入单元格 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 ; *************************************************************** 
 ; 例2 - 打开并返回工作簿对象标识后使用循环写入一个单元格, 保存并关闭文件. 
 ; ***************************************************************** 
 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿, 并使之可见 
 
 For  $i  =  1  To  20  ;循环 
     _ExcelWriteCell ( $oExcel ,  "I Wrote to This Cell" ,  $i ,  1 )  ;写入单元格 
 Next 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 
 ; *************************************************************** 
 ; 例3 - 打开并返回工作簿对象标识后使用循环写入一个单元格, 然后使用_ExcelWriteCell输入公式. 
 ; ***************************************************************** 
 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿, 并使之可见 
 
 For  $i  =  1  To  20  ;循环 
     _ExcelWriteCell ( $oExcel ,  $i ,  $i ,  1 )  ;写入单元格 
 Next 
 
 _ExcelWriteCell ( $oExcel ,  "=Average(A:A)" ,  1 ,  2 )  ;使用A1样式, 并非R1C1 
 _ExcelWriteCell ( $oExcel ,  "=Average(A1:A20)" ,  1 ,  3 )  ;另一种使用A1方式而非R1C1方式写入公式的方法 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出  

