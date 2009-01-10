#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt('MustDeclareVars', 1)

#include <WinAPI.au3>
#include <Constants.au3>

_Main()

Func _Main()
	Local $aInfo, $sInfo = ""
	$aInfo = _WinAPI_GetIconInfo($IDC_WAIT)
	For $x = 0 To UBound($aInfo) - 1
		$sInfo &= $aInfo[$x] & @LF
	Next
	MsgBox(4096, "Icon", "Get Icon Info: " & @LF & $sInfo)
EndFunc   ;==>_Main