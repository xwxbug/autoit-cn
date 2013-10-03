#include <Constants.au3>

; AutoITCOM 3.1.0
;
;
; Testing ByRef variables on COM function calls
;
; Retrieving the Internet Explorer home page value using registry-read by WMI

Const $HKEY_CURRENT_USER = 0x80000001

Local $strComputer = @ComputerName

Local $objReg = ObjGet("winmgmts:\\" & $strComputer & "\root\default:StdRegProv")
Local $strKeyPath = "SOFTWARE\Microsoft\Internet Explorer\Main"
Local $ValueName = "Start Page"
Local $strvalue = ""
Local $return = $objReg.GetStringValue($HKEY_CURRENT_USER, $strKeyPath, $ValueName, $strvalue)

If $strvalue = "" Then
	MsgBox($MB_SYSTEMMODAL, "WMIGetStringTest", "The value of your IE start page is either Null or could not be found in the registry.")
Else
	MsgBox($MB_SYSTEMMODAL, "WMIGetStringTest", "Your Internet Explorer start page is: " & @CRLF & $strvalue)
EndIf
