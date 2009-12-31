#include-once
; #FUNCTION# ====================================================================================================================
; Name...........: _API_PickIconDlg
; Description ...: Displays a dialog box that allows the user to choose an icon from the selection available embedded in a resource such as an executable or DLL file.
; Syntax.........: _API_PickIconDlg()
; Parameters ....: 
; Return values .: Returns 1 if successful; otherwise, 0.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: some time,Error return 1
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/bb776481(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================

Func _API_PickIconDlg(ByRef $sFileName,ByRef $IconIndex)
	Local	$piIconIndex	= DllStructCreate("int")
	Local	$pszIconPath	= DLLStructCreate("wchar[260]")
	Local	$structsize		= DllStructGetSize($pszIconPath)/2
	DllStructSetData($pszIconPath, 1, $sFileName)
	DllStructSetData($piIconIndex, 1, $IconIndex)
	; 调用 PickIconDlg API - '62' 为序号值,部分系统没有命名函数名,只有序号,所以为了兼容使用62.
	Local $ret=DllCall("shell32.dll", "Int", 62, "hwnd", 0, "ptr", DllStructGetPtr($pszIconPath), "int", $structsize, "ptr", DllStructGetPtr($piIconIndex))
	If IsArray($ret) Then
		If $ret[0]=0 Then
			Return 0
		Else
			$sFileName = DllStructGetData($pszIconPath, 1)
			$IconIndex = DllStructGetData($piIconIndex, 1)
			Return 1
		EndIf
	EndIf
EndFunc