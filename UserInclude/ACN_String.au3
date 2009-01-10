#include-once

;======================================================
;
; 函数名称:		SendX("string",flag)
; 详细信息:		发送汉字.
; $string:		$string 为您想输入的汉字.
; $flag:		0或者非1为剪切板模式,1为发送ASC模式
; 返回值 :		没有
; 作者:			thesnow(rundll32@126.com)
; 修改:			make2855
; 注意:			程序请使用UNICODE编码编译，ANSI版本使用以前的SENDX函数.
;======================================================
Func SendX($string, $flag)
	Local $clup
	Local $Nul = Chr(0)
	If $flag <> 1 Then $flag = 0
	Switch $flag
		Case 0
			$clup = ClipGet()
			ClipPut($string)
			Send("+{ins}")
			ClipPut($clup)
		Case 1
			For $i = 1 To StringLen($string)
				Send('{ASC ' & StringToBinary(StringMid($string, $i, 1) & $Nul) & '}')
			Next
	EndSwitch
EndFunc   ;==>SendX