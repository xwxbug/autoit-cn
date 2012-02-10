;使用一个数组
Local $aArray[4]

$aArray[0] = "a"
$aArray[1] = 0
$aArray[2] = 1.3434
$aArray[3]="测试"

Local $string = ""
For $element In $aArray
	$string = $string & $element & @CRLF
Next

MsgBox(4096,"For..IN 数组测试","结果: " & @CRLF & $string)

;使用一个对象集合

Local $oShell = ObjCreate("shell.application")
Local $oShellWindows = $oShell.windows

If IsObj($oShellWindows) Then
	$string = ""

	For $Window In $oShellWindows
		$string = $string & $Window.LocationName & @CRLF
	Next

  MsgBox(4096,"","您打开了下列窗口:" & @CRLF & $string)
Else

  MsgBox(4096,"","您没有打开外壳窗口.")
EndIf
