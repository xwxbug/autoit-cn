 
 ; *************************************************************** 
 ; 例1 - 打开工作簿并返回其对象标识后使用循环写入单元格. 插入一列后保存并关闭文件. 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿, 并使之可见 
 
 For  $i  =  1  To  5  ;循环 
     _ExcelWriteCell ( $oExcel ,  $i ,  $i ,  1 )  ;使用值1到5垂直写入单元格 
 Next 
 
 ToolTip ( "Inserting Column(s) Soon..." ) 
 Sleep ( 3500 )  ;暂停让用户观察操作 
 
 _ExcelColumnInsert ( $oExcel ,  1 ,  1 )  ;在列1位置插入一列 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出 
 
 ; *************************************************************** 
 ; 例2 - 打开工作簿并返回其对象标识后使用循环写入单元格. 插入几列后保存并关闭文件. 
 ; ***************************************************************** 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿, 并使之可见 
 
 ; 可以使用一个简单循环和随机数字填充单元格 
 For  $i  =  1  To  10 
     For  $j  =  1  To  10 
         _ExcelWriteCell ( $oExcel ,  Round ( Random ( 1 ,  100 ),  0 ),  $i ,  $j )  ;循环写入一些随机数字 
     Next 
 Next 
 
 ToolTip ( "Inserting Column(s) Soon..." ) 
 Sleep ( 3500 )  ;暂停让用户观察操作 
 
 _ExcelColumnInsert ( $oExcel ,  2 ,  3 )  ;在列2位置插入三列 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出  

