#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; 设置不使用代理:
_WinHttpSetDefaultProxyConfiguration($WINHTTP_ACCESS_TYPE_NO_PROXY)

; ... 这里是剩余代码...