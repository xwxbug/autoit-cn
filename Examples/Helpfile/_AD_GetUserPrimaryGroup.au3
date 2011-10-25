#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取当前用户的基本组
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

msgbox(64, "Active Directory Functions", "Primary group for user'" & @UserName & "'is'" & _AD_GetUserPrimaryGroup() & "'")

; 关闭Active Directory连接
_AD_Close()

