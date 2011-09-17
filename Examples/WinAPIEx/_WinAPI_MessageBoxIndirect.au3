#Include <APIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $tMBP, $tTitle, $tText, $Result

$tMBP = DllStructCreate($tagMSGBOXPARAMS)
DllStructSetData($tMBP, 'Size', DllStructGetSize($tMBP))
DllStructSetData($tMBP, 'hOwner', 0)
DllStructSetData($tMBP, 'hInstance', _WinAPI_GetModuleHandle(@SystemDir & '\shell32.dll'))
DllStructSetData($tMBP, 'Text', _WinAPI_CreateString('This is a simple message box with a custom icon.', $tText))
DllStructSetData($tMBP, 'Caption', _WinAPI_CreateString('Message', $tTitle))
DllStructSetData($tMBP, 'Style', BitOR($MB_OKCANCEL, $MB_USERICON))
DllStructSetData($tMBP, 'Icon', 239)
DllStructSetData($tMBP, 'ContextHelpId', 0)
DllStructSetData($tMBP, 'MsgBoxCallback', 0)
DllStructSetData($tMBP, 'LanguageId', 0)

$Result = _WinAPI_MessageBoxIndirect($tMBP)

ConsoleWrite('Return: ' & $Result & @CR)
