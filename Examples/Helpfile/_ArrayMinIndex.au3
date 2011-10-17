32
 _ArrayMinIndex     _ArrayMinIndex   
返回数组中最小值的索引. 
 
" #Include <Array.au3> 
_ArrayMinIndex(Const ByRef $avArray[, $iCompNumeric = 0[, $iStart = 0[, $iEnd = 0]]]) 
 
   
参数    
 $avArray  要搜索的数组  
 $iCompNumeric  [可选] 比较的方法: 
0 - 按字母 
1 - 按数字  
 $iStart  [可选] 开始搜索的索引  
 $iEnd  [可选] 结束搜索的索引  
   
返回值 成功: 数组中最大值的索引 
失败: 返回-1设置@error为: 
    1 - $avArray 不是数组 
    2 - $iStart 大于 $iEnd 
    3 - $avArray 不是一维数组 
 
   
相关  _ArrayMax , _ArrayMaxIndex , _ArrayMin  
   
 #include <Array.au3> 
 
 Local $avArray = StringSplit ( " 4 , 2 , 06 , 8 , 12 , 5 ", " , " ) 
 
 MsgBox ( 0 , ' Min Index String value ', _ArrayMinIndex ( $avArray , 0 , 1 )) 
 MsgBox ( 0 , ' Min Index Numeric value ', _ArrayMinIndex ( $avArray , 1 , 1 )) 
 
