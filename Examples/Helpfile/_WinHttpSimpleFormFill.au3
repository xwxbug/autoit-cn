 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHTTP.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 ; 初始化并获取会话句柄 
 Global $hOpen = _WinHttpOpen () 
 
 Global $hConnect , $sRead 
 Global $hFileHTM , $sFileHTM = @ScriptDir & " \Form.htm " 
 
 ; 示例1: 
 ; 1. 打开APNIC whois页(http://wq.apnic.net/apnic-bin/whois.pl) 
 ; 2. 填写页上的表单: 
 ; - 填写默认表单 
 ; - 设置输入框的ip地址为4.2.2.2. 使用名称属性"定位"输入t 
 ; - 发送表单(点击按钮) 
 ; - 收集数据 
 
 ; 获取连接句柄 
 $hConnect = _WinHttpConnect ( $hOpen , " wq.apnic.net " ) 
 ; 填写页面上的表单 
 $sRead = _WinHttpSimpleFormFill ( $hConnect , " apnic-bin/whois.pl ", Default , " name:searchtext ", " 4.2.2.2 " ) 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hConnect ) 
 ; 查看返回值(默认浏览器中或其它程序) 
 If $sRead Then 
  MsgBox ( 64 + 262144 , " Done! ", " Will open returned page in your default browser now. " & @CRLF & _ 
    " When you close that window another example will run. " ) 
  $hFileHTM = FileOpen ( $sFileHTM , 2 ) 
  FileWrite ( $hFileHTM , $sRead ) 
  FileClose ( $hFileHTM ) 
  ShellExecuteWait ( $sFileHTM ) 
 EndIf 
 
 ;===================================================================================================================== 
 MsgBox ( 262144 , " Example 2 ", " Click ok to run new example. " ) 
 
 ; 示例2: 
 ; 1. 打开w3schools表单页(http://www.w3schools.com/html/html_forms.asp) 
 ; 2. 填写页上的表单: 
 ; - 表单由其名称标识, 名为"input0" 
 ; - 设置输入框的"OMG!!!"数据. 由其名称定位输入框. 为"user" 
 ; - 收集数据 
 
 ; 获取连接句柄 
 $hConnect = _WinHttpConnect ( $hOpen , " w3schools.com " ) 
 ; 填写页面上的表单 
 $sRead = _WinHttpSimpleFormFill ( $hConnect , " html/html_forms.asp ", " name:input0 ", " name:user ", " OMG!!! " ) 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hConnect ) 
 If $sRead Then 
  MsgBox ( 64 + 262144 , " Done! ", " Will open returned page in your default browser now. " & @CRLF & _ 
    " You should see 'OMG!!!' somewhere on that page. " ) 
  $hFileHTM = FileOpen ( $sFileHTM , 2 ) 
  FileWrite ( $hFileHTM , $sRead ) 
  FileClose ( $hFileHTM ) 
  ShellExecuteWait ( $sFileHTM ) 
 EndIf 
 
 ;===================================================================================================================== 
 MsgBox ( 262144 , " Example 3 ", " Click ok to run new example. " ) 
 
 ; 示例3: 
 ; 1. 打开cs.tut.fi表单页(http://www.cs.tut.fi/~jkorpela/forms/testing.html) 
 ; 2. 填写页上的表单: 
 ; - 表单由其索引标识, 此例为页上的首个表单, 如索引为0 
 ; - 设置输入框的"Johnny B. Goode"数据. 由其名称定位输入框. 为"box" 
 ; - 设置名为"hidden field"输入框的"This is hidden, so what?"数据 
 ; - 收集数据 
 
 ; 获取连接句柄 
 $hConnect = _WinHttpConnect ( $hOpen , " www.cs.tut.fi " ) 
 ; 填写页面上的表单 
 $sRead = _WinHttpSimpleFormFill ( $hConnect , " ~jkorpela/forms/testing.html ", " index:0 ", " name:box ", " Johnny B. Goode ", " name:hidden field ", " This is hidden, so what? " ) 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hConnect ) 
 If $sRead Then 
  MsgBox ( 64 + 262144 , " Done! ", " Will open returned page in your default browser now. " & @CRLF & _ 
    " It should show sent data. " ) 
  $hFileHTM = FileOpen ( $sFileHTM , 2 ) 
  FileWrite ( $hFileHTM , $sRead ) 
  FileClose ( $hFileHTM ) 
  ShellExecuteWait ( $sFileHTM ) 
 EndIf 
 
 ;===================================================================================================================== 
 MsgBox ( 262144 , " Example 4 ", " Click ok to run new example. " ) 
 
 ; 示例4: 
 ; 1. 打开yahoo邮件登录页(https://login.yahoo.com/config/login_verify2?&.src=ym) 
 ; 2. 填写页上的表单: 
 ; - 表单由其名称标识, 名为"login_form" 
 ; - 设置用户名输入框的"MyUserName"数据. 由其ID定位输入框. 为"username" 
 ; - 设置指密码输入框的"MyPassword"数据. 由其ID定位输入框. 为"passwd" 
 ; - 收集数据 
 
 ; 获取连接句柄 
 $hConnect = _WinHttpConnect ( $hOpen , " login.yahoo.com " ) 
 ; 填写页面上的表单 
 $sRead = _WinHttpSimpleFormFill ( $hConnect , " config/login_verify2?&.src=ym ", " name:login_form ", " username ", " MyUserName ", " passwd ", " MyPassword " ) 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hConnect ) 
 
 MsgBox ( 262144 , " The End ", " Source of the last example is printed to console. " & @CRLF & _ 
    " In case valid login data was passed it will be user's mail page on yahoo.mail. " ) 
 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hOpen ) 
 
