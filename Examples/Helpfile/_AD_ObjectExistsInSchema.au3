
#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 连接AD
_AD_Open()

; *****************************************************************************
; 示例 1 - 执行Windows模式.
; 检查属性是否为Windows模式的一部分, 并为每个用户存在.
; *****************************************************************************
Global $sProperty = "displayname"
If _AD_ObjectExistsInSchema($sProperty) Then
	msgbox(64, "Active Directory Functions", "Property'" & $sProperty & "'does exist in the Windows AD Schema")
Else
	msgbox(64, "Active Directory Functions", "Property'" & $sProperty & "'does not exist in the Windows AD Schema")
EndIf

; *****************************************************************************
; 示例 2 - 执行Exchange模式.
; 检查属性是否为Exchange模式的一部分, 并为每个用户存在.
; *****************************************************************************
$sProperty = "mailNickname"
If _AD_ObjectExistsInSchema($sProperty) Then
	msgbox(64, "Active Directory Functions", "Property'" & $sProperty & "'does exist in the Exchange AD Schema")
Else
	msgbox(64, "Active Directory Functions", "Property'" & $sProperty & "'does not exist in the Exchange AD Schema")
EndIf

; *****************************************************************************
; 示例 3 - 查询不存在的属性
; *****************************************************************************
$sProperty = "non-existing-property"
If _AD_ObjectExistsInSchema($sProperty) Then
	msgbox(64, "Active Directory Functions", "Property'" & $sProperty & "'does exist in the AD Schema")
Else
	msgbox(64, "Active Directory Functions", "Property'" & $sProperty & "'does not exist in the AD Schema")
EndIf

; 关闭AD连接
_AD_Close()

