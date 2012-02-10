#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取当前用户的最后登录日期. 返回如YYYYMMDDHHMMSS
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取当前用户的最后登录日期
Global $iLLDate = _AD_GetLastLoginDate()
msgbox(64, "Active Directory Functions", "Last Login Date for User'" & @UserName & "'" & @CRLF & $iLLDate)

; 关闭Active Directory连接
_AD_Close()

