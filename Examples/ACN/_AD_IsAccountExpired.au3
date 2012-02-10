
#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开AD连接
_AD_Open()

; *****************************************************************************
; 示例 1: 检查当前用户是否过期
; *****************************************************************************
If _AD_IsAccountExpired() Then
	msgbox(64, "Active Directory Functions", "User account'" & @UserName & "'has expired")
Else
	msgbox(64, "Active Directory Functions", "User account'" & @UserName & "'has not expired")
EndIf

; *****************************************************************************
; 示例 2: 检查当前计算机用户是否过期
; *****************************************************************************
If _AD_IsAccountExpired(@ComputerName & "$") Then
	msgbox(64, "Active Directory Functions", "Computer account'" & @ComputerName & "$" & "'has expired")
Else
	msgbox(64, "Active Directory Functions", "Computer account'" & @ComputerName & "$" & "'has not expired")
EndIf

; 关闭AD连接
_AD_Close()

