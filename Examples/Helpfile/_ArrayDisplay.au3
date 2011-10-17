 #include <Array.au3> 
 
 ;=============================================================================== 
 ; 例1 
 ;=============================================================================== 
 $asControls = StringSplit ( WinGetClassList ( " [active] ", "" ) , @LF ) 
 _ArrayDisplay ( $asControls , " Class List of Active Window " ) 
 
 ;=============================================================================== 
 ; 例2 (使用一个手工定义的数组) 
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
 
 _ArrayDisplay ( $avArray , " $avArray set manually 1D " ) 
 _ArrayDisplay ( $avArray , " $avArray set manually 1D transposed ", -1 , 1 ) 
 
 ;=============================================================================== 
 ; 例3 (使用由StringSplit()返回的数组) 
 ;=============================================================================== 
 $avArray = StringSplit ( WinGetClassList ( " ", " " ) , @LF ) 
 _ArrayDisplay ( $avArray , " $avArray as a list classes in window " ) 
 
 ;=============================================================================== 
 ; 例4 (二维数组) 
 ;=============================================================================== 
 Local $avArray [ 2 ][ 5 ] = [[ " JPM ", " Holger ", " Jon ", " Larry ", " Jeremy " ] , [ " Valik ", " Cyberslug ", " Nutster ", " JdeB ", " Tylo " ]] 
 _ArrayDisplay ( $avArray , " $avArray as a 2D array " ) 
 _ArrayDisplay ( $avArray , " $avArray as a 2D array , transposed ", -1 , 1 ) 
 
