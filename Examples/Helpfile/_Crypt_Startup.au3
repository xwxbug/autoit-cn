 
 #include  <Crypt.au3> 
 
 $sTest = "The quick brown fox jumps over the lazy dog" 
 
 ;  测试加密库的启动和结束 
 _Crypt_Startup () 
 MsgBox ( 0 ,  "MD5" ,  $sTest  &  @CRLF  &  _Crypt_HashData ( $sTest ,  $CALG_MD5 )) 
 _Crypt_Shutdown () 
 
 ; 不带测试 
 MsgBox ( 0 ,  "MD5" ,  $sTest  &  @CRLF  &  _Crypt_HashData ( $sTest ,  $CALG_MD5 )) 
 
