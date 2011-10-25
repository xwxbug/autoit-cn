#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; *****************************************************************************
; 示例1 - 获取活动目录中所有OU的列表
; *****************************************************************************
Global $aOUs = _AD_GetAllOUs()
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "No OUs could be found")
Else
	_ArrayDisplay($aOUs, "Active Directory Functions - All OUs found in the Active Directory")
EndIf

; *****************************************************************************
; 示例2 - 获取开始于子树首个OU的所有OU列表
; *****************************************************************************
Global $sOU, $iCount
For $iCount = 1 To $aOUs[0][0]
	If StringInStr($aOUs[$iCount][0], "\") > 0 Then
		$sOU = "OU=" & StringReplace($aOUs[$iCount - 1][0], "\", ",OU=") & "," & $sAD_DNSDomain
		ExitLoop
	EndIf
Next

$aOUs = _AD_GetAllOUs($sOU)
If @error > 0 Then
	msgbox(64, "Active Directory Functions", "No OUs could be found")
Else
	_ArrayDisplay($aOUs, "Active Directory Functions - All OUs starting with:'" & $sOU & "'")
EndIf

; 关闭Active Directory连接
_AD_Close()

