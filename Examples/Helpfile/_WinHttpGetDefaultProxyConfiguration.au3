#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"
#include <Array.au3>

Opt("MustDeclareVars", 1)

; 当前 WinHTTP 代理配置:
Global $aProxy = _WinHttpGetDefaultProxyConfiguration()
_ArrayDisplay($aProxy, "Current WinHTTP proxy configuration")