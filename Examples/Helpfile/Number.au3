Local $iNumber1 = Number(1 + 2 + 10) ; 返回结果=13
Local $iNumber2 = Number("3.14") ; 返回结果=3.14
Local $iNumber3 = Number("24/7") ; 返回结果=24
Local $iNumber4 = Number("tmp3") ; 返回结果=0 (字符串返回结果=0)

MsgBox(4096, "", "转换结果:" & @CRLF & _
		$iNumber1 & @CRLF & $iNumber2 & @CRLF & $iNumber3 & @CRLF & $iNumber4)
