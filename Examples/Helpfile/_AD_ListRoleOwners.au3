#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取全部FSMO规则所有者的数组
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取全部FSMO规则所有者加描述的列表
Global $aFSMO[6][2] = [[""],["Domains PDC Emulator"],["Domains RID (Relative-Identifierer) master"],["Domains Infrastructure master"],["Forest-wide Schema master"],["Forest-wide Domain naming master"]]
Global $aTemp = _AD_ListRoleOwners()
Global $iCount
For $iCount = 1 To $aTemp[0]
	$aFSMO[$iCount][1] = $aTemp[$iCount]
Next
$aFSMO[0][0] = $aTemp[0]
_arraydisplay($aFSMO, "Active Directory Functions", -1, 0, "<")

; 关闭Active Directory连接
_AD_Close()

