#include <WinAPIDiag.au3>
#include <APIDiagConstants.au3>
#include <WinAPISys.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Global $Count = 10

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 300, 100)
Local $Label = GUICtrlCreateLabel('The application will be crashes after ' & $Count & ' seconds.', 10, 43, 280, 14, $SS_CENTER)
GUISetState()

If $CmdLine[0] And ($CmdLine[1] = '/crash') Then
	MsgBox(BitOR($MB_ICONWARNING, $MB_SYSTEMMODAL), 'Attention', 'The application has been restarted after an abnormal exit.', 0, $hForm)
EndIf

If Not @Compiled Then
	_WinAPI_RegisterApplicationRestart(BitOR($RESTART_NO_PATCH, $RESTART_NO_REBOOT), '"' & @ScriptFullPath & '" /crash')
Else
	_WinAPI_RegisterApplicationRestart(BitOR($RESTART_NO_PATCH, $RESTART_NO_REBOOT), '/crash')
EndIf

AdlibRegister('_Countdown', 1000)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _Countdown()
	Local $iData
	#forceref $iData

	$Count -= 1
	If $Count Then
		GUICtrlSetData($Label, 'The application will be crashes after ' & $Count & ' seconds.')
	Else
		Local $tData
		; Forced script crash due to a memory access violation
		$tData = DllStructCreate('int', 0x12345678)
		$iData = DllStructGetData($tData, 1)
	EndIf
EndFunc   ;==>_Countdown
