#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; !!!注意如果用户名和密码无效, 那么此例子将失败!!!

Global $sUserName = "SomeUserName"
Global $sPassword = "SomePassword"
Global $sDomain = "www.google.com"
Global $sPage = "accounts/ClientLogin"
; 访问 http://code.google.com/apis/accounts/docs/AuthForInstalledApps.html 获取更多信息
Global $sAdditionalData = "accountType=HOSTED_OR_GOOGLE&Email=" & $sUserName & "&Passwd=" & $sPassword & "&service=mail&source=Gulp-CalGulp-1.05"

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen("Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6")

; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, $sDomain)

; 生成请求
Global $hRequest = _WinHttpOpenRequest($hConnect, "POST", $sPage, -1, -1, -1, $WINHTTP_FLAG_SECURE)

; 发送它. 也指明需要发送的附加数据. 这是通过 Google API 所需要的:
_WinHttpSendRequest($hRequest, "Content-Type: application/x-www-form-urlencoded", $sAdditionalData)

; 等待响应
_WinHttpReceiveResponse($hRequest)

; 看看返回的是什么
Global $sReturned
If _WinHttpQueryDataAvailable($hRequest) Then ; 如果是数据
	Do
		$sReturned &= _WinHttpReadData($hRequest)
	Until @error
EndIf

; 关闭句柄
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; 看看返回的是什么
MsgBox(0, "Returned", $sReturned)