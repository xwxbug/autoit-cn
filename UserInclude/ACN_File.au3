#include-once

;===============================================================================
;
; Description:      返回指定文本文件的行数.
; Syntax:           _FileCountLines( $sFilePath )
; Parameter(s):     $sFilePath - 路径+文件名
; Requirement(s):   无
; Return Value(s):  成功 - 返回文件的行数
;                   失败 - 返回0 并设置 @error = 1
; Author(s):        Tylo <tylo at start dot no> 修正 by thesnow
;
;===============================================================================
Func _FileCountLines($sFilePath)
	Local $N = FileGetSize($sFilePath) - 1
	Local $M= ""
	If @error Or $N = -1 Then Return 0
	$M=FileRead($sFilePath)
	$M=StringReplace($M,@CRLF,@CR)
	$M=StringSplit($M,@CR)
	Return $M[0]
EndFunc   ;==>_FileCountLines



;======================================================
;
; 函数名称:		_EncryptFile($sFilePath)
; 详细信息:		加密文件,NTFS磁盘系统自带的EFS加密
; $sFilePath:	$sFilePath 为您想加密的文件.
; 返回值 :		没有
; 作者:			thesnow(rundll32@126.com)
;
;======================================================

Func _EncryptFile($sFilePath)
	Local $ret
	$ret=dllcall(@SystemDir & "\advapi32.dll","int","EncryptFile","str",$sFilePath)
	Return $ret
EndFunc  


;======================================================
;
; 函数名称:		_DecryptFile($sFilePath)
; 详细信息:		解密文件,NTFS磁盘系统自带的EFS加密
; $sFilePath:	$sFilePath 为您想解密的文件.
; 返回值 :		没有
; 作者:			thesnow(rundll32@126.com)
;
;======================================================

Func _DecryptFile($sFilePath)
	Local $ret
	$ret=dllcall(@SystemDir & "\advapi32.dll","int","DecryptFile","str",$sFilePath,"int",1)
	Return $ret
EndFunc  


;======================================================
;
; 函数名称:		_HideSystemFolder($PathCode,$Hide)
; 详细信息:		隐藏系统特殊文件夹.
; $PathCode:	系统文件夹代码:
;				0,控制面板/1,程序文件夹目录/2,系统所在驱动器/3,windows目录
; $Hide:		隐藏为1,不隐藏为0.
; 返回值 :		成功返回1,失败(文件夹代码错误)返回0,失败(隐藏代码错误),返回0.
; 作者:			thesnow(rundll32@126.com)
;
;======================================================

Func _HideSystemFolder($PathCode = 4,$Hide=True)
If Not IsInt($Hide) Then Return 0
Switch $PathCode
	Case 0 
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\WebView\BarricadedFolders","shell:ControlPanelFolder","REG_DWORD",Hex($Hide))
	Case 1
 		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\WebView\BarricadedFolders","shell:ProgramFiles","REG_DWORD",Hex($Hide))
	Case 2
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\WebView\BarricadedFolders","shell:SystemDriveRootFolder","REG_DWORD",Hex($Hide))
	Case 3
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\WebView\BarricadedFolders","shell:Windows","REG_DWORD",Hex($Hide))
	Case else
		Return 0
EndSwitch
Return 1
EndFunc 

;======================================================
;
; 函数名称:		_FileReadAsUnicode($sFile,$dCodepage)
; 详细信息:		读取ANSI文件返回UNICODE字符.
; $sFile:		文件路径.
; $dCodepage:	代码页.参考 http://msdn.microsoft.com/en-us/library/dd317756.aspx
; 返回值 :		成功返回UNICODE字符,设置SetExtended为返回的字符数.
;				失败,返回空字符并设置@error.
;				@error=-1	文件不存在
;				@error=-2	文件为UTF-32编码
;				@error=-3	文件无法打开
;				@error=-4	文件无法进行编码转换
; 作者:			thesnow(rundll32@126.com)
;
;======================================================

Func _FileReadAsUnicode($sFile,$dCodepage=0)
	Local $AnsiFile,$UnicodeFile
	If Not FileExists($sFile) Then Return SetError(-1,0,"")
	Local $hFile=_GetFileEnc($sFile)
	If $hFile=-1 Then Return SetError(-2,0,"")
	If $hFile<>16 Then 
		$UnicodeFile=FileRead($sFile)
		Return $UnicodeFile
	Else
		$hFile=FileOpen($sFile,$hFile)
		If $hFile=-1 Then 
			FileClose($hFile)
			Return SetError(-3,0,"")
		EndIf
		$AnsiFile=FileRead($hFile)
		FileClose($hFile)
		Local $kernel = DllOpen('Kernel32.dll')
		Local $TxtSize=BinaryLen($AnsiFile)
		Local $lpSrc = DLLStructCreate("byte [" & $TxtSize & "]")
		DllStructSetData($lpSrc,1,$AnsiFile)
		Local $lpDst = DLLStructCreate("byte [" & $TxtSize*2 & "]")
		Local $rt=DLLCall($kernel,"int","MultiByteToWideChar", _
                    "int",$dCodepage, _
                    "int",1, _
                    "ptr",DllStructGetPtr($lpSrc), _
                    "int",-1, _
                    "ptr",DllStructGetPtr($lpDst), _
                    "int",$TxtSize*2)
		If $rt[0]=0 Then Return SetError(-4,0,"")
		Local $UnicodeFile=BinaryToString(DllStructGetData($lpDst,1),2)
		DllClose($Kernel)
		SetExtended($rt[0])
		Return $UnicodeFile
	EndIf
EndFunc


Func _GetFileEnc($TheFile)
	Local $hTest_File = FileOpen($TheFile, 16)
	Local $Test_File = FileRead($hTest_File, 4)
	Local $FileEnc=0	;ansi
	FileClose($hTest_File)
;~ 00 00 FE FF UTF-32, big-endian
;~ FF FE 00 00 UTF-32, little-endian
;~ FE FF UTF-16, big-endian
;~ FF FE UTF-16, little-endian
;~ EF BB BF UTF-8
	If $Test_File = "0x0000FFFE" then
		$FileEnc=-1;'UTF32BE'	不支持
	Else 
		if $Test_File = "0xFFFE0000" Then
			$FileEnc=-1;'UTF32LE'	不支持
		Else
			$hTest_File = FileOpen($TheFile, 16)
			$Test_File = FileRead($hTest_File, 2)
			FileClose($hTest_File)
			If $Test_File = "0xFFFE" Then
				$FileEnc=32;'UTF16LE'
			Else
				If $Test_File = "0xFEFF" Then
					$FileEnc=64;'UTF16BE'
				Else
					$hTest_File = FileOpen($TheFile, 16)
					$Test_File = FileRead($hTest_File, 3)
					FileClose($hTest_File)
					If $Test_File = "0xEFBBBF" Then
						$FileEnc=128;'UTF8'
					Else
						$FileEnc=16;ansi
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	Return $FileEnc
EndFunc