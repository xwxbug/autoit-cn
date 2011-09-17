#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Windows Live ID. JavaScript required to sign in, remember that.
Global $sDomain = "accountservices.passport.net"
Global $sPage = "uiresetpw.srf"

; 初始化并获取会话句柄
Global $hOpen = _WinHttpOpen()
; 获取连接句柄
Global $hConnect = _WinHttpConnect($hOpen, $sDomain)

; 生成简单的 SSL 请求
Global $hRequestSSL = _WinHttpSimpleSendSSLRequest($hConnect, Default, $sPage)

; 读取...
Global $sReturned = _WinHttpSimpleReadData($hRequestSSL)
; 关闭句柄
_WinHttpCloseHandle($hRequestSSL)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; 看看返回的是什么
ConsoleWrite($sReturned & @CRLF)
MsgBox(64 + 262144, "Done", "Page source is printed to console")