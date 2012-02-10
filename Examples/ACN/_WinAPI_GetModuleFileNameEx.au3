#Include  <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Id = ProcessExists('QQ.exe')

If $Id > 0 Then
	msgbox('', 'The Path of QQ.exe ', _WinAPI_GetModuleFileNameEx($Id))
EndIf

