
 #include <WinAPI.au3> 
 #include <Array.au3> 
 
 Local $aWindows = _WinAPI_EnumWindows () 
 ReDim $aWindows [ $aWindows [ 0 ][ 0 ]][ 5 ] 
 For $i = 1  To  UBound ( $aWindows ) - 1 
   $aWindows [ $i ][ 2 ] = WinGetTitle ( $aWindows [ 0 ][ 0 ]) 
   $aWindows [ $i ][ 3 ] = WinGetText ( $aWindows [ 0 ][ 0 ]) 
   $aWindows [ $i ][ 4 ] = WinGetProcess ( $aWindows [ 0 ][ 0 ]) 
 Next 
 _ArrayDisplay ( $aWindows , ' _WinAPI_EnumWindows ') 
 
