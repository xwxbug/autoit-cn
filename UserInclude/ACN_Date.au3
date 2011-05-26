#include-once

;===============================================================================
;
; Description:      Returns the name of the weekday, based on the specified day.
; Parameter(s):     $iDayNum - Day number
;                   $iShort  - Format:
;                              0 = Long name of the weekday
;                              1 = Abbreviated name of the weekday
; Requirement(s):   None
; Return Value(s):  On Success - Weekday name
;                   On Failure - A NULL string and sets @ERROR = 1
; Author(s):        Jeremy Landes <jlandes at landeserve dot com>
; Note(s):          English only
;
;===============================================================================
Func _DateDayOfWeekC($iDayNum = @WDAY)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $aDayOfWeek[8]

	$aDayOfWeek[1] = "星期天"
	$aDayOfWeek[2] = "星期一"
	$aDayOfWeek[3] = "星期二"
	$aDayOfWeek[4] = "星期三"
	$aDayOfWeek[5] = "星期四"
	$aDayOfWeek[6] = "星期五"
	$aDayOfWeek[7] = "星期六"
	Select
		Case Not StringIsInt($iDayNum)
			SetError(1)
			Return ""
		Case $iDayNum < 1 Or $iDayNum > 7
			SetError(1)
			Return ""
		Case Else
			Return $aDayOfWeek[$iDayNum]
	EndSelect
EndFunc   ;==>_DateDayOfWeekC


;===============================================================================
;
; Description:      Returns the name of the month, based on the specified month.
; Parameter(s):     $iMonthNum - Month number
;                   $iShort    - Format:
;                                0 = Long name of the month
;                                1 = Abbreviated name of the month
; Requirement(s):   None
; Return Value(s):  On Success - Month name
;                   On Failure - A NULL string and sets @ERROR = 1
; Author(s):        Jeremy Landes <jlandes at landeserve dot com>
; Note(s):          English only
;
;===============================================================================
Func _DateMonthOfYear($iMonthNum = @MON)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $aMonthOfYear[13]

	$aMonthOfYear[1] = "一月"
	$aMonthOfYear[2] = "二月"
	$aMonthOfYear[3] = "三月"
	$aMonthOfYear[4] = "四月"
	$aMonthOfYear[5] = "五月"
	$aMonthOfYear[6] = "六月"
	$aMonthOfYear[7] = "七月"
	$aMonthOfYear[8] = "八月"
	$aMonthOfYear[9] = "九月"
	$aMonthOfYear[10] = "十月"
	$aMonthOfYear[11] = "十一月"
	$aMonthOfYear[12] = "十二月"

	Select
		Case Not StringIsInt($iMonthNum)
			SetError(1)
			Return ""
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return ""
		Case Else
			Return $aMonthOfYear[$iMonthNum]
	EndSelect
EndFunc   ;==>_DateMonthOfYear
