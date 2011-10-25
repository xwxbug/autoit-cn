#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Data = _WinAPI_GetCurrentThemeName()

If IsArray($Data) Then
	msgbox('', 'Current Theme ', 'File:' & $Data[0] & @CRLF & _
			' Color:' & $Data[1] & @CRLF & _
			' Size:' & $Data[2] & @CRLF & _
			' Name:' & _WinAPI_GetThemeDocumentationProperty($Data[0], $SZ_THDOCPROP_CANONICALNAME) & @CRLF & _
			' Display:' & _WinAPI_GetThemeDocumentationProperty($Data[0], $SZ_THDOCPROP_DISPLAYNAME) & @CRLF & _
			' Tooltip:' & _WinAPI_GetThemeDocumentationProperty($Data[0], $SZ_THDOCPROP_TOOLTIP) & @CRLF & _
			' Author:' & _WinAPI_GetThemeDocumentationProperty($Data[0], $SZ_THDOCPROP_AUTHOR))
EndIf

