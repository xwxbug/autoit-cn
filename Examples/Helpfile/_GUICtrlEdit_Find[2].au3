; using Standard UDF

#include <GuiEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

Example_External()

Func Example_External()
	Local $s_texttest = 'Find And Replace Example with AutoIt ' & FileGetVersion(@AutoItExe) & @CRLF & _
			"this is a test" & @CRLF & _
			"this is only a test" & @CRLF & _
			"this testing should work for you as well as it does for me"
	Local $whandle, $handle
	Local $Title = "[CLASS:Notepad]"

	Run("notepad.exe", "", @SW_MAXIMIZE)
	;Wait for the window "Untitled" to exist
	WinWait($Title)

	; Get the handle of a notepad window
	$whandle = WinGetHandle($Title)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Error", "Could not find the correct window")
	Else
		$handle = ControlGetHandle($whandle, "", "Edit1")
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "Could not find the correct control")
		Else
			; Send some text directly to this window's edit control
			ControlSend($whandle, "", "Edit1", $s_texttest)
			_GUICtrlEdit_Find($handle, True)
		EndIf
	EndIf
EndFunc   ;==>Example_External
