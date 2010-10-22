#include-once

; #FUNCTION# ====================================================================================================================
; Name...........: _API_ShellAbout
; Description....: Displays an Windows About dialog box.
; Syntax.........: _API_ShellAbout ( [$hwnd, [$szApp, [$szOtherStuff [, $hIcon ]]]] )
; Parameters.....: $hwnd    - A window handle to a parent window. This parameter can be empty.
;                  $szApp   - A pointer to a null-terminated string that contains text to be displayed in the title bar of the ShellAbout dialog box and on the first line of the dialog box after the text "Microsoft". If the text contains a separator (#) that divides it into two parts, the function displays the first part in the title bar and the second part on the first line after the text "Microsoft". 
;                  $szApp1  - 2K~2K3:If the string pointed to by this parameter contains a separator (#), then the string must be writeable.VISTA+:This string cannot exceed 200 characters in length
;                  $szOtherStuff   - A pointer to a null-terminated string that contains text to be displayed in the dialog box after the version and copyright information. This parameter can be NULL.
;                  $hIcon   - The handle of an icon that the function displays in the dialog box. This parameter can be NULL, in which case the function displays the Windows or Microsoft Windows NT icon.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: thesnow(rundll32@126.com)
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ ShellAbout
; Example........: Yes
; ===============================================================================================================================

Func _API_ShellAbout($hwnd="",$szApp="",$szApp1="",$szOtherStuff="",$hIcon="")
	Local $Ret = DllCall("shell32.dll", "int", "ShellAboutW", "hwnd", $hwnd, "wstr", $szApp & '#' & $szApp1, "WStr", $szOtherStuff,"ptr", $hIcon)
;	Local $Ret = DllCall('shell32.dll', 'int', 'ShellAboutW', 'hwnd', $hParent, 'wstr', $sTitle & '#' & $sName, 'wstr', $sText, 'ptr', $hIcon)
	If (@error) Or ($Ret[0] = 0) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc

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
	Local	$structsize		= DllStructGetSize($pszIconPath)
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
	Else
		Return 0
	EndIf
EndFunc

