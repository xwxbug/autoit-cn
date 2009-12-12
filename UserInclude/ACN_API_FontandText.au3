#include-once

; #FUNCTION# ====================================================================================================================
; Name...........: AddFontResourceA
; Description ...: The AddFontResource function adds the font resource from the specified file to the system font table. The font can subsequently be used for text output by any application.
; Syntax.........: AddFontResourceA($sFont)
; Parameters ....: $sFont:		  - 字体文件(路径)名(.fon/.fnt/.ttf/.ttc/.fot/.otf/.mmm/.pfb/.pfm)
; Return values .: If the function succeeds, the return value specifies the number of fonts added.
;                  If the function fails, the return value is zero. No extended error information is available.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: 添加一个字体文件,无需复制到系统字体文件夹(这是全局共享的,如果需要只是本程序使用,请使用AddFontResourceEx)
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/dd183326(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func AddFontResourceA($sFont)
	$ret=DllCall("Gdi32.dll",'int','AddFontResourceA','str',$sFont)
	Return $ret
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: AddFontResourceW
; Description ...: The AddFontResource function adds the font resource from the specified file to the system font table. The font can subsequently be used for text output by any application.
; Syntax.........: AddFontResourceW($sFont)
; Parameters ....: $sFont:		  - 字体文件(路径)名(.fon/.fnt/.ttf/.ttc/.fot/.otf/.mmm/.pfb/.pfm)
; Return values .: If the function succeeds, the return value specifies the number of fonts added.
;                  If the function fails, the return value is zero. No extended error information is available.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: 添加一个字体文件,无需复制到系统字体文件夹(这是全局共享的,如果需要只是本程序使用,请使用AddFontResourceEx)
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/dd183326(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func AddFontResourceW($sFont)
	$ret=DllCall("Gdi32.dll",'int','AddFontResourceW','wstr',$sFont)
	Return $ret
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: RemoveFontResourceA
; Description ...: 注册DLL文件
; Syntax.........: RemoveFontResourceA($sFont)
; Parameters ....: $sFont:		  - 字体文件(路径)名(.fon/.fnt/.ttf/.ttc/.fot/.otf/.mmm/.pfb/.pfm)
; Return values .: If the function succeeds, the return value is nonzero.
;                  If the function fails, the return value is zero.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: 如果你需要卸载一个已经安装的文件,必须提供完整的路径名称(和原始路径一样)
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/dd162922(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func RemoveFontResourceA($sFont)
	$ret=DllCall("Gdi32.dll",'int','RemoveFontResourceA','str',$sFont)
	Return $ret
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: RemoveFontResourceW
; Description ...: 注册DLL文件
; Syntax.........: RemoveFontResourceW($sFont)
; Parameters ....: $sFont:		  - 字体文件(路径)名(.fon/.fnt/.ttf/.ttc/.fot/.otf/.mmm/.pfb/.pfm)
; Return values .: If the function succeeds, the return value is nonzero.
;                  If the function fails, the return value is zero.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: 如果你需要卸载一个已经安装的文件,必须提供完整的路径名称(和原始路径一样)
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/dd162922(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func RemoveFontResourceW($sFont)
	$ret=DllCall("Gdi32.dll",'int','RemoveFontResourceW','wstr',$sFont)
	Return $ret
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: WM_FONTCHANGE
; Description ...: 发送字体改变消息给系统
; Syntax.........: WM_FONTCHANGE()
; Parameters ....: 
; Return values .: none
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/dd145211(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func WM_FONTCHANGE()
	Local $HWND_BROADCAST=0xFFFF,$WM_FONTCHANGE=0x001D
	DllCall("user32.dll","lparam", "SendMessage", "hwnd",$HWND_BROADCAST,"int",$WM_FONTCHANGE,"wparam",0,"lparam",0)
EndFunc