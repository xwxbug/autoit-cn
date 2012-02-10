#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

Global $aManager[1][2]
Global $bNotFound = False
; *****************************************************************************
; 示例1 - 获取居有"manager"属性设置的用户列表
; *****************************************************************************
$aManager = _AD_GetManager()
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "No managed users could be found")
	$bNotFound = True
Else
	_ArrayDisplay($aManager, "Active Directory Functions - managed users")
EndIf

; *****************************************************************************
; 示例2 - 获取由在示例1中找到的由首个管理者管理的用户列表
; *****************************************************************************
If $bNotFound Then
	msgbox(64, "Active Directory Functions", "Can't run example 2 because example 1 returned no data")
	Exit
EndIf
Global $Result = _AD_GetObjectAttribute( _AD_FQDNToSamAccountName($aManager[1][1]), "directReports")
_ArrayDisplay($Result, "Active Directory Functions - users managed by'" & $aManager[1][1] & "'")

; 关闭Active Directory连接
_AD_Close()

