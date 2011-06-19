#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

Global $hOpen, $hConnect
Global $sRead, $hFileHTM, $sFileHTM = @ScriptDir & "\Form.htm"

; 示例1:
;    1. 打开 APNIC whois 页面 (http://wq.apnic.net/apnic-bin/whois.pl)
;    2. 使用这些值/条件填写那个页面的表单:
;         - 填写默认表单
;         - 设置 IP 地址 4.2.2.2 到输入框. 使用名称属性定位输入
;         - 发送表单 (点击按钮)
;         - 采集返回的数据

; 初始化并获取会话句柄
$hOpen = _WinHttpOpen()
; 获取连接句柄
$hConnect = _WinHttpConnect($hOpen, "wq.apnic.net")
; 填写此页面的表单
$sRead = _WinHttpSimpleFormFill($hConnect, "apnic-bin/whois.pl", Default, "name:searchtext", "4.2.2.2")
; 关闭连接句柄
_WinHttpCloseHandle($hConnect)
; 关闭会话句柄
_WinHttpCloseHandle($hOpen)

; 看看返回了什么 (在默认浏览器或其他什么的)
If $sRead Then
	MsgBox(64 + 262144, "Done!", "Will open returned page in your default browser now." & @CRLF & _
			"When you close that window another example will run.")
	$hFileHTM = FileOpen($sFileHTM, 2)
	FileWrite($hFileHTM, $sRead)
	FileClose($hFileHTM)
	ShellExecuteWait($sFileHTM)
EndIf


;=====================================================================================================================
If MsgBox(262148, "Example 2", "Run new example?") = 7 Then Exit

; 示例 2:
;    1. 打开 w3schools 表单页面 (http://www.w3schools.com/html/html_forms.asp)
;    2. 使用这些值/条件填写那个页面的表单:
;         - 表单是根据其名称标识的, 名称为 "input0"
;         - 设置 "OMG!!!" 数据到输入框. 根据名称找到输入框. 名称为 "user"
;         - 采集数据

; 初始化并获取会话句柄
$hOpen = _WinHttpOpen()
; 获取连接句柄
$hConnect = _WinHttpConnect($hOpen, "w3schools.com")
; 填写此页面的表单
$sRead = _WinHttpSimpleFormFill($hConnect, "html/html_forms.asp", "name:input0", "name:user", "OMG!!!")
; 关闭连接句柄
_WinHttpCloseHandle($hConnect)
; 关闭会话句柄
_WinHttpCloseHandle($hOpen)

If $sRead Then
	MsgBox(64 + 262144, "Done!", "Will open returned page in your default browser now." & @CRLF & _
			"You should see 'OMG!!!' or 'OMG%21%21%21' (encoded version) somewhere on that page.")
	$hFileHTM = FileOpen($sFileHTM, 2)
	FileWrite($hFileHTM, $sRead)
	FileClose($hFileHTM)
	ShellExecuteWait($sFileHTM)
EndIf


;=====================================================================================================================
If MsgBox(262148, "Example 3", "Run new example?") = 7 Then Exit

; 示例 3:
;    1. Open cs.tut.fi forms page (http://www.cs.tut.fi/~jkorpela/forms/testing.html)
;    2. 使用这些值/条件填写那个页面的表单:
;         - 表单是根据其索引标识的, 这是页面上的首个表单, 即索引为 0
;         - 设置 "Johnny B. Goode" 数据到文本区. 根据 "Comments" 名称找到它.
;         - 选中复选框. 根据名称 "box" 找到它. 选中的值为 "yes".
;         - 设置 "This is hidden, so what?" 数据到由 "hidden field" 名称标识的输入字段.
;         - 采集数据

; 初始化并获取会话句柄
$hOpen = _WinHttpOpen()
; 获取连接句柄
$hConnect = _WinHttpConnect($hOpen, "www.cs.tut.fi")
; 填写此页面的表单
$sRead = _WinHttpSimpleFormFill($hConnect, "~jkorpela/forms/testing.html", "index:0", "name:Comments", "Johnny B. Goode", "name:box", "yes", "name:hidden field", "This is hidden, so what?")
; 关闭连接句柄
_WinHttpCloseHandle($hConnect)
; 现在关闭不再需要的会话句柄
_WinHttpCloseHandle($hOpen)

If $sRead Then
	MsgBox(64 + 262144, "Done!", "Will open returned page in your default browser now." & @CRLF & _
			"It should show sent data.")
	$hFileHTM = FileOpen($sFileHTM, 2)
	FileWrite($hFileHTM, $sRead)
	FileClose($hFileHTM)
	ShellExecuteWait($sFileHTM)
EndIf


;=====================================================================================================================
If MsgBox(262148, "Example 4", "Run new example?") = 7 Then Exit

; 示例 4:
;    1. 打开雅虎邮箱登录页面 (https://login.yahoo.com/config/login_verify2?&.src=ym)
;    2. 使用这些值/条件填写那个页面的表单:
;         - 表单是根据其名称标识的, 名称为 "login_form"
;         - 设置 "MyUserName" 数据到用户名输入框. 根据其 ID 找到输入框. 它是 "username"
;         - 设置 "MyPassword" 数据到密码输入框. 根据其 ID 找到输入框. 它是 "passwd"
;         - 采集数据

; 初始化并获取会话句柄
$hOpen = _WinHttpOpen()
; 获取连接句柄
$hConnect = _WinHttpConnect($hOpen, "login.yahoo.com")
; 填写此页面的表单
$sRead = _WinHttpSimpleFormFill($hConnect, "config/login_verify2?&.src=ym", "name:login_form", "username", "MyUserName", "passwd", "MyPassword")
;关闭连接句柄
_WinHttpCloseHandle($hConnect)
; 关闭会话句柄
_WinHttpCloseHandle($hOpen);打印返回的:

ConsoleWrite($sRead & @CRLF)
MsgBox(262144, "The End", "Source of the last example is printed to console." & @CRLF & _
 "In case valid login data was passed it will be user's mail page on yahoo.mail")


