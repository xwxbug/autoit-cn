#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; *****************************************************************************
; 示例1 - 执行当前用户. 第一步获取当前用户的一些属性. 第二部检查用户的该属性.
; *****************************************************************************

; 获取当前登录用户的稍后将检查的一些信息
Global $asProperties[8] = ["sAMAccountName", "cn", "mail", "userPrincipalName", "name", "mailNickname", "displayName", "dNSHostName"]
Global $asObjects[8], $iCount

For $iCount = 0 To UBound($asObjects) - 1
	$asObjects[$iCount] = _AD_GetObjectAttribute(@UserName, $asProperties[$iCount])
Next

; 测试上面收集的信息
Global $sOutput = "Get Attributes for User:" & @UserName & @CRLF & @CRLF
For $iCount = 0 To UBound($asObjects) - 1
	If _AD_ObjectExists($asObjects[$iCount], $asProperties[$iCount]) Then
		$sOutput &= "Object'" & $asObjects[$iCount] & "'for property'" & $asProperties[$iCount] & "'exists" & @CRLF
	ElseIf @error = 1 Then
		$sOutput &= "Object'" & $asObjects[$iCount] & "'for property'" & $asProperties[$iCount] & "'does not exist" & @CRLF
	Else
		$sOutput &= "Object'" & $asObjects[$iCount] & "'for property'" & $asProperties[$iCount] & "'is not unique: >=" & @error & " records found" & @CRLF
	EndIf
Next
msgbox(64, "Active Directory Functions", $sOutput)

; *****************************************************************************
