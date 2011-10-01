#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; !!!注意如果用户名和密码无效, 那么此例子将失败!!!

; 身份验证数据
Global $sUsername = "UserName"
Global $sPassword = "Password"

; 地址
Global $sAddress = "space.livevn.com"

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()

; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, $sAddress)

; 请求
Global $hRequest = _WinHttpOpenRequest($hConnect, _
		"POST", _ ; 动作
		"/do.php?ac=71ee30ae117cddace55bd01714904227&&ref", _  ; 目标
		Default, _ ; 版本
		"http://space.livevn.com/index.php", _  ; referer
		"*/*") ; 接受

; 发送它
_WinHttpSendRequest($hRequest, _
		"Content-Type: application/x-www-form-urlencoded" & @CRLF, _
		"username=" & $sUsername & "&password=" & $sPassword & "&loginsubmit=&loginsubmit=loginnnnnnnnnnn&refer=network.html&formhash=c51a94db")

; 等待响应
_WinHttpReceiveResponse($hRequest)

; 看看返回的是什么
If _WinHttpQueryDataAvailable($hRequest) Then
	Global $sHeader = _WinHttpQueryHeaders($hRequest)
	ConsoleWrite($sHeader & @CRLF)
	; 检查是否有适当的 cookie
	If StringInStr($sHeader, 'Set-Cookie: uchome_loginuser=' & $sUsername) Then
		MsgBox(0, "", "Login success")
	Else
		MsgBox(0, "", "Login failed")
	EndIf
Else
	MsgBox(48, "Error", "Site is experiencing problems.")
EndIf


; 关闭打开的句柄并退出
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)