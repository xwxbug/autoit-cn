#include <Constants.au3>

Example()

Func Example()
	Local $iPID = Run(@ComSpec & " /c DIR Example.au3", @SystemDir, @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	Local $sOutput
	While 1
		$sOutput = StdoutRead($iPID)
		If @error Then ; Exit the loop if the process closes or StdoutRead returns an error.
			ExitLoop
		EndIf
		MsgBox(4096, "Stdout Read:", $sOutput)
	WEnd

	While 1
		$sOutput = StderrRead($iPID)
		If @error Then ; Exit the loop if the process closes or StderrRead returns an error.
			ExitLoop
		EndIf
		MsgBox(4096, "Stderr Read:", $sOutput)
	WEnd
EndFunc   ;==>Example
