Local $iNumber1 = Number(1 + 2 + 10) ; Returns 13.
Local $iNumber2 = Number("3.14") ; Returns 3.14.
Local $iNumber3 = Number("24/7") ; Returns 24.
Local $iNumber4 = Number("tmp3") ; Returns 0 as this is a string.
Local $iNumber5 = Number("1,000,000") ; Returns 1 as it strips everything after the first comma.

MsgBox(4096, "", "The following values were converted to a numeric value:" & @CRLF & _
		$iNumber1 & @CRLF & $iNumber2 & @CRLF & $iNumber3 & @CRLF & $iNumber4 & @CRLF & $iNumber5)
