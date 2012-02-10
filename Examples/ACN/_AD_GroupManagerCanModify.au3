#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取具有"manager"属性设置的用户列表
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取具有"manageBy"属性设置的组列表 set
Global $bNotFound, $bFound, $iCount, $aManager
Global $aManagedBy = _AD_GetManagedBy()
If @error > 0 Or $aManagedBy[0][0] = 0 Then
	msgbox(64, "Active Directory Functions", "No managed groups could be found")
	$bNotFound = True
EndIf

; 检查组列表确定是否有一个管理员可修改组成员
$bFound = False
For $iCount = 1 To $aManagedBy[0][0]
	$aManager = _AD_GroupManagerCanModify($aManagedBy[1][0])
	If $aManager = 1 Then
		$bFound = True
		ExitLoop
	EndIf
Next
If Not $bFound Then
	msgbox(64, "Active Directory Functions", "No group manager can modify the group membership")
	Exit
Else
	msgbox(64, "Active Directory Functions", "Group manager can modify the group membership for group'" & $aManagedBy[$iCount][0] & "'")
EndIf

; 关闭Active Directory连接
_AD_Close()

