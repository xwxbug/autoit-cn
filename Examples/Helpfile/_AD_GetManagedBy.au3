#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

Global $aManagedBy[1][2]
Global $bNotFound = False
; *****************************************************************************
; 示例1 - 获取居有"managedBy"属性设置的组列表
; *****************************************************************************
$aManagedBy = _AD_GetManagedBy()
If @error > 0 Or $aManagedBy[0][0] = 0 Then
	msgbox(64, "Active Directory Functions - Example 1", "No managed groups could be found")
	$bNotFound = True
Else
	_ArrayDisplay($aManagedBy, "Active Directory Functions - groups managed by")
EndIf

; *****************************************************************************
; 示例2 - 获取由在示例1中找到的由首个管理者管理的组列表
; *****************************************************************************
If $bNotFound Then
	msgbox(64, "Active Directory Functions - Example 2", "Can't run example 2 because example 1 returned no data")
	Exit
EndIf
Global $Result = _AD_GetObjectAttribute( _AD_FQDNToSamAccountName($aManagedBy[1][1]), "managedObjects")
_ArrayDisplay($Result, "Active Directory Functions - groups managed by'" & $aManagedBy[1][1] & "'")

; 关闭Active Directory连接
_AD_Close()

