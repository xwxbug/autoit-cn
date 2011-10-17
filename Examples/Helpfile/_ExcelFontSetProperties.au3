 
 ; ***************************************************************** 
 ; 示例 - 打开并返回工作簿对象标识后, 设置一个范围内的字体属性. 
 ; ***************************************************************** 
 
 #include  <Excel.au3> 
 
 Local  $oExcel  =  _ExcelBookNew ()  ;新建工作簿, 并使之可见 
 Local  $sRangeOrRowStart  =  1 ,  $iColStart  =  1 ,  $iRowEnd  =  10 ,  $iColEnd  =  10 
 Local  $fBold ,  $fItalic ,  $fUnderline ,  $i  =  1 
 
 ; 可以使用简单循环和随机数字填充单元格 
 For  $i  =  1  To  10 
     For  $j  =  1  To  10 
         _ExcelWriteCell ( $oExcel ,  Round ( Random ( 1 ,  100 ),  0 ),  $i ,  $j )  ;四舍五入一些随机数字到文件 
     Next 
 Next 
 
 MsgBox ( 0 ,  "_ExcelHorizontalAlignSet" ,  "Notice the Font Properties, This will go through all the Possible Combinations"  &  @CRLF  &  "Press OK to Continue" ) 
 
 $i  =  1 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: : "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  True ,  True ,  True ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 $i  +=  1 
 Sleep ( 2500 ) 
 
 _ExcelFontSetProperties ( $oExcel ,  $sRangeOrRowStart ,  $iColStart ,  $iRowEnd ,  $iColEnd ,  False ,  False ,  False ) 
 ToolTip ( "New Font Setting: "  &  $i ) 
 
 MsgBox ( 0 ,  "Exiting" ,  "Press OK to Save File and Exit" ) 
 _ExcelBookSaveAs ( $oExcel ,  @TempDir  &  "\Temp.xls" ,  "xls" ,  0 ,  1 )  ; 现在将其保存至临时目录; 必要时覆盖已存在的文件 
 _ExcelBookClose ( $oExcel )  ; 关闭退出  

