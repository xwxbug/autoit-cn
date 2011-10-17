 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHttp.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 ; !!!注意该示例将因为无效用户名和密码失败!!! 
 
 ; 认证数据 
 Global $sUserName = " UserName " 
 Global $sPassword = " Password " 
 
 ; 地址 
 Global $sAddress = " space.livevn.com " 
 
 ; 初始化并获取会话句柄 
 Global $hOpen = _WinHttpOpen () 
 
 ; 获取连接句柄 
 Global $hConnect = _WinHttpConnect ( $hOpen , $sAddress ) 
 
 ; 创建请求 
 Global $hRequest = _WinHttpOpenRequest ( $hConnect , _ 
    " POST ", _ ; 动作 
    " /do.php?ac=71ee30ae117cddace55bd01714904227&&ref ", _ ; 目标 
    Default , _ ; 版本 
    " http://space.livevn.com/index.php ", _ ; 参考 
    " */* " )  ; 接受 
 
 ; 发送 
 _WinHttpSendRequest ( $hRequest , _ 
    " Content-Type: application/x-www-form-urlencoded " & @CRLF , _ 
    " username= " & $sUsername & " &password= " & $sPassword & _ 
    " &loginsubmit=&loginsubmit=loginnnnnnnnnnn&refer=network.html&formhash=c51a94db " ) 
 
 ; 等待应答 
 _WinHttpReceiveResponse ( $hRequest ) 
 
 ; 检查返回值 
 If _WinHttpQueryDataAvailable ( $hRequest ) Then 
  Global $sHeader = _WinHttpQueryHeaders ( $hRequest ) 
  MsgBox ( 64 , " Header ", $sHeader ) 
  ; 检查给定Cookie是否正确 
  If StringInStr ( $sHeader , ' Set-Cookie: uchome_loginuser= ' & $sUsername ) Then 
    MsgBox ( 0 , "", " Login Success " ) 
  Else 
    MsgBox ( 0 , "", " Login Failed " ) 
  EndIf 
 Else 
  MsgBox ( 48 , " Error ", " Site is experiencing problems. " ) 
 EndIf 
 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hRequest ) 
 _WinHttpCloseHandle ( $hConnect ) 
 _WinHttpCloseHandle ( $hOpen ) 
 
