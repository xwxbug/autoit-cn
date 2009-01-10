;Using an Array
Dim $aArray[4]

$aArray[0]="a"
$aArray[1]=0
$aArray[2]=1.3434
$aArray[3]="test"

$string = ""
FOR $element IN $aArray
	$string = $string & $element & @CRLF
NEXT

Msgbox(0,"For..IN Arraytest","Result is: " & @CRLF & $string)

;Using an Object Collection

$oShell = ObjCreate("shell.application")
$oShellWindows=$oShell.windows

if Isobj($oShellWindows) then
  $string=""

  for $Window in $oShellWindows
	$String = $String & $Window.LocationName & @CRLF
  next

  msgbox(0,"","You have the following windows open:" & @CRLF & $String)
else

  msgbox(0,"","you have no open shell windows.")
endif