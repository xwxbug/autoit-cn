;使用一个数组
Dim $aArray[4]

$aArray[0]="a"
$aArray[1]=0
$aArray[2]=1.3434
$aArray[3]="测试"

$string = ""
FOR $element IN $aArray
	$string = $string & $element & @CRLF
NEXT

Msgbox(0,"For..IN 数组测试","结果: " & @CRLF & $string)

;使用一个对象集合

$oShell = ObjCreate("shell.application")
$oShellWindows=$oShell.windows

if Isobj($oShellWindows) then
  $string=""

  for $Window in $oShellWindows
	$String = $String & $Window.LocationName & @CRLF
  next

  msgbox(0,"","您打开了下列窗口:" & @CRLF & $String)
else

  msgbox(0,"","您没有打开外壳窗口.")
endif