 
 #include  <Crypt.au3> 
 
 ; 继续使用由_Crypt_DeriveKey创建的密钥的示例 
 
 Local  $StringsToCrypt [ 6 ]=[ "Bluth" ,  "Sunny" ,  "AutoIt3" ,  "SciTe" ,  42 ,  "42" ] 
 Local  $Crypted [ 6 ] 
 
 
 ; 由于DeriveKey/DestroyKey使用内部句柄所以不需要_Crypt_Startup 
 $Key  =  _Crypt_DeriveKey ( "supersecretpassword" ,  $CALG_RC4 ) 
 
 $DisplayStr  =  "" 
 
 for  $Word  In  $StringsToCrypt 
     $DisplayStr  &=  $Word  &  @TAB  &  " = "  &  _Crypt_EncryptData ( $Word ,  $Key ,  $CALG_USERKEY )  &  @CRLF 
 Next 
 
 MsgBox ( 0 ,  "Crypt table" ,  $DisplayStr ) 
 
 _Crypt_DestroyKey ( $Key ) 
 
