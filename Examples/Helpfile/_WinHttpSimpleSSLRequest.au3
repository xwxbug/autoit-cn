#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; !!!注意如果用户名和密码无效, 那么此例子将失败!!!

; 使用真实的数据用来身份验证
Global $sUserName = "SomeUserName"
Global $sPassword = "SomePassword"
Global $sDomain = "www.google.com"
Global $sPage = "accounts/ClientLogin"
; 访问 http://code.google.com/apis/accounts/docs/AuthForInstalledApps.html 获取更多信息
Global $sAdditionalData = "accountType=HOSTED_OR_GOOGLE&Email=" & $sUserName & "&Passwd=" & $sPassword & "&service=mail&source=Gulp-CalGulp-1.05"

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()
; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, $sDomain)

; 进行简单 SSL 请求...
Global $sReturned = _WinHttpSimpleSSLRequest($hConnect, "POST", $sPage, Default, $sAdditionalData)

; 关闭句柄
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; 看看返回的是什么
MsgBox(0, "Returned", $sReturned)