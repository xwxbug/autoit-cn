#include <Constants.au3>

; AutoIt 3.1.1.x beta version
;
; COM Test File
;
; Error Event test using Winnt ADSI
;
; This will cause an ErrorEvent on most computers.

; Initialize my Error function
Local $g_oErrObj = ObjEvent("AutoIt.Error", "MyErrFunc")

; Open Winnt object on local machine, this might take a few seconds time.
Local $objContainer = ObjGet("WinNT://" & @ComputerName)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "AutoItCOM Test", "Failed to open WinNT://. Error code: " & Hex(@error, 8))
	Exit
EndIf

Local $strUser = "CBrooke"
Local $clsUser = $objContainer.Create("User", $strUser)

; This will only succeed on computers where local user passwords are allowed to be empty.
$clsUser.SetInfo()

; The line below should throw an Error after a short timeout,
; because "domain" and "MyGroup" do not exist.

Local $objGroup = ObjGet("WinNT://domain/MyGroup, group")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "error opening object $objGroup, error code: " & @error)
	Exit
Else
	$objGroup.Add($clsUser.ADsPath)
	$objGroup.SetInfo()
EndIf

Exit

; ----------------

Func MyErrFunc($oerrobj)
	Local $hexnum = Hex($oerrobj.number, 8)

	MsgBox($MB_SYSTEMMODAL, "", "We intercepted a COM Error!!" & @CRLF & @CRLF & _
			"err.description is: " & $oerrobj.description & @CRLF & _
			"err.windescription is: " & $oerrobj.windescription & @CRLF & _
			"err.lastdllerror is: " & $oerrobj.lastdllerror & @CRLF & _
			"err.scriptline is: " & $oerrobj.scriptline & @CRLF & _
			"err.number is: " & $hexnum & @CRLF & _
			"err.source is: " & $oerrobj.source & @CRLF & _
			"err.helpfile is: " & $oerrobj.helpfile & @CRLF & _
			"err.helpcontext is: " & $oerrobj.helpcontext _
			)
EndFunc   ;==>MyErrFunc
