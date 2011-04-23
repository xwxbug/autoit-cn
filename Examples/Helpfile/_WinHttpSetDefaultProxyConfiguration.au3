#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Set No-proxy:
_WinHttpSetDefaultProxyConfiguration($WINHTTP_ACCESS_TYPE_NO_PROXY)

; ... the rest of the code here...