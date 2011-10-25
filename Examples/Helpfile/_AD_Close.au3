
#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 打开到Active Directory的连接; 为当前用户获取合法域名(FQDN); 关闭连接.
; *****************************************************************************
#include  <AD.au3>

; 打开与Active Directory的连接
_AD_Open()

; 为当前用户获取合法域名(FQDN)
Global $sFQDN = _AD_SAMAccountNameToFQDN()
msgbox(64, "Active Directory Functions", "The Fully Qualified Domain Name (FQDN) for the currently logged on user is:" & @CRLF & $sFQDN)

; 关闭与Active Directory的连接
_AD_Close()

