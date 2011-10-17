 #include <Array.au3> 
 
 ;=============================================================================== 
 ; 示例1 (使用一个一维数组) 
 ;=============================================================================== 
 Local $avArray [ 10 ] = [ 9 , 8 , 7 , 6 , 5 , 4 , 3 , 2 , 1 , 0 ] 
 
 _ArrayDisplay ( $avArray , " $avArray BEFORE _ArraySort() " ) 
 _ArraySort ( $avArray ) 
 _ArrayDisplay ( $avArray , " $avArray AFTER _ArraySort() ascending " ) 
 _ArraySort ( $avArray , 1 ) 
 _ArrayDisplay ( $avArray , " $avArray AFTER _ArraySort() descending " ) 
 _ArraySort ( $avArray , 0 , 3 , 6 ) 
 _ArrayDisplay ( $avArray , " $avArray AFTER _ArraySort() ascending from index 3 to 6 " ) 
 
 ;=============================================================================== 
 ; 示例2 (使用一个二维数组) 
 ;=============================================================================== 
 Local $avArray [ 5 ][ 3 ] = [[ 5 , 20 , 8 ] , [ 4 , 32 , 7 ] , [ 3 , 16 , 9 ] , [ 2 , 35 , 0 ] , [ 1 , 19 , 6 ]] 
 
 _ArrayDisplay ( $avArray , " $avArray BEFORE _ArraySort() " ) 
 _ArraySort ( $avArray , 0 , 0 , 0 , 0 ) 
 _ArrayDisplay ( $avArray , " $avArray AFTER _ArraySort() ascending column 0 " ) 
 _ArraySort ( $avArray , 0 , 0 , 0 , 1 ) 
 _ArrayDisplay ( $avArray , " $avArray AFTER _ArraySort() ascending column 1 " ) 
 _ArraySort ( $avArray , 0 , 0 , 0 , 2 ) 
 _ArrayDisplay ( $avArray , " $avArray AFTER _ArraySort() ascending column 2 " ) 
 
