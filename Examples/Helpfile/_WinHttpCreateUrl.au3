 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHTTP.au3> 
 
 ; 从数组创建URL 
 Global $URL_array [ 8 ] = [ " http ", 1 , " www.autoitscript.com ", 80 , " Jon ", " deadPiXels ", " admin.php " ] 
 MsgBox ( 0 , " Created URL ", _WinHttpCreateUrl ( $URL_array )) 
 
