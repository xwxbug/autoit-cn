#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#Include <WinHTTP.au3>

; ит╣х
Global $sPACurl = _WinHttpDetectAutoProxyConfigUrl( BitOR($WINHTTP_AUTO_DETECT_TYPE_DHCP, $WINHTTP_AUTO_DETECT_TYPE_DNS_A))
msgbox(64, "_WinHttpDetectAutoProxyConfigUrl ", "The URL for the Proxy Auto-Configuration (PAC) file is:" & $sPACurl))

