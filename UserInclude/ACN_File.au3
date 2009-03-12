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