#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $PID = _WinAPI_GetParentProcess()
Global $Data = _WinAPI_EnumChildProcess($PID)

msgbox('', '', _WinAPI_GetCurrentProcessID() & ' -' & _WinAPI_GetProcessName() & _
		$PID & ' -' & _WinAPI_GetProcessName($PID))

_ArrayDisplay($Data, '_WinAPI_EnumChildProcess')

