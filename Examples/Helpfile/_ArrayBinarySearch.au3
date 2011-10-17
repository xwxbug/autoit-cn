 #include <Array.au3> 
 
 ;=============================================================================== 
 ; 例1 (使用手工定义的脚本) 
 ;=============================================================================== 
 Local $avArray [ 10 ] 
 
 $avArray [ 0 ] = " JPM " 
 $avArray [ 1 ] = " Holger " 
 $avArray [ 2 ] = " Jon " 
 $avArray [ 3 ] = " Larry " 
 $avArray [ 4 ] = " Jeremy " 
 $avArray [ 5 ] = " Valik " 
 $avArray [ 6 ] = " Cyberslug " 
 $avArray [ 7 ] = " Nutster " 
 $avArray [ 8 ] = " JdeB " 
 $avArray [ 9 ] = " Tylo " 
 
 ; 对可进行二进制搜索的数组进行排序 
 _ArraySort ( $avArray ) 
 
 ; 显示排序后的数组 
 _ArrayDisplay ( $avArray , " $avArray AFTER _ArraySort() " ) 
 
 ; 查找存在的值 
 $iKeyIndex = _ArrayBinarySearch ( $avArray , " Jon " ) 
 If Not @error Then 
   MsgBox ( 0 , ' Entry found ', ' Index: ' & $iKeyIndex ) 
 Else 
   MsgBox ( 0 , ' Entry Not found ', ' Error: ' & @error ) 
 EndIf 
 
 ; 查找不存在的值 
 $iKeyIndex = _ArrayBinarySearch ( $avArray , " Unknown " ) 
 If Not @error Then 
   MsgBox ( 0 , ' Entry found ', ' Index: ' & $iKeyIndex ) 
 Else 
   MsgBox ( 0 , ' Entry Not found ', ' Error: ' & @error ) 
 EndIf 
 
 ;=============================================================================== 
 ; 例2 (使用由StringSplit()返回的) 
 ;=============================================================================== 
 $avArray = StringSplit ( " a,b,d,c,e,f,g,h,i ", "," ) 
 
 ; 对可进行二进制搜索的数组进行排序 
 _ArraySort ( $avArray , 0 , 1 ) ; start at index 1 to skip $avArray[0] 
 
 ; 显示排序后的数组 
 _ArrayDisplay ( $avArray , " $avArray AFTER _ArraySort() " ) 
 
 ; 从索引 1 开始浏览 $avArray[0] 
 $iKeyIndex = _ArrayBinarySearch ( $avArray , "c " , 1 ) 
 If Not @error Then 
   Msgbox ( 0 , ' Entry found ', ' Index: ' & $iKeyIndex ) 
 Else 
   Msgbox ( 0 , ' Entry Not found ', ' Error: ' & @error ) 
 EndIf 
 
