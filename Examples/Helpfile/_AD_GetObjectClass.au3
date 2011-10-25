#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 显示登录的用户和本地计算机的类
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 返回登录的用户和本地计算机的类
msgbox(64, "Active Directory Functions", _
		"Class for logged on user:" & _AD_GetObjectClass(@UserName) & @CRLF & _
		"Class for local computer:" & _AD_GetObjectClass(@ComputerName & "$"))

; 关闭Active Directory连接
_AD_Close()

