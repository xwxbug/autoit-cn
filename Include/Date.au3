#include-once
#include <Memory.au3>
#include <WinAPI.au3>
#include <Security.au3>
#include <StructureConstants.au3>

; #INDEX# =======================================================================================================================
; Title .........: Date
; AutoIt Version: 3.2.3++
; Language:       English
; Description ...: There are five time formats: System, File, Local, MS-DOS and Windows.  Time related functions return  time  in
;                  one of these formats.  You can also use the time functions  to  convert  between  time  formats  for  ease  of
;                  comparison and display
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global Const $__DATECONSTANT_TOKEN_ADJUST_PRIVILEGES = 0x00000020
Global Const $__DATECONSTANT_TOKEN_QUERY = 0x00000008

;==============================================================================================================================
; #NO_DOC_FUNCTION# =============================================================================================================
; Not working/documented/implimented at this time
; ===============================================================================================================================
;_DateLastWeekdayNum
;_DateLastMonthNum
;_DateLastMonthYear
;_DateNextWeekdayNum
;_DateNextMonthNum
;_DateNextMonthYear
;_Date_JulianDayNo
;_JulianToDate
;_WeekNumber
;__DaysInMonth
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_DateAdd
;_DateDayOfWeek
;_DateDaysInMonth
;_DateDiff
;_DateIsLeapYear
;_DateIsValid
;_DateTimeFormat
;_DateTimeSplit
;_DateToDayOfWeek
;_DateToDayOfWeekISO
;_DateToDayValue
;_DateToMonth
;_DayValueToDate
;_Now
;_NowCalc
;_NowCalcDate
;_NowDate
;_NowTime
;_SetDate
;_SetTime
;_TicksToTime
;_TimeToTicks
;_WeekNumberISO
;_Date_Time_CompareFileTime
;_Date_Time_DOSDateTimeToFileTime
;_Date_Time_DOSDateToArray
;_Date_Time_DOSDateTimeToArray
;_Date_Time_DOSDateTimeToStr
;_Date_Time_DOSDateToStr
;_Date_Time_DOSTimeToArray
;_Date_Time_DOSTimeToStr
;_Date_Time_EncodeFileTime
;_Date_Time_EncodeSystemTime
;_Date_Time_FileTimeToArray
;_Date_Time_FileTimeToStr
;_Date_Time_FileTimeToDOSDateTime
;_Date_Time_FileTimeToLocalFileTime
;_Date_Time_FileTimeToSystemTime
;_Date_Time_GetFileTime
;_Date_Time_GetLocalTime
;_Date_Time_GetSystemTime
;_Date_Time_GetSystemTimeAdjustment
;_Date_Time_GetSystemTimeAsFileTime
;_Date_Time_GetSystemTimes
;_Date_Time_GetTickCount
;_Date_Time_GetTimeZoneInformation
;_Date_Time_LocalFileTimeToFileTime
;_Date_Time_SetFileTime
;_Date_Time_SetLocalTime
;_Date_Time_SetSystemTime
;_Date_Time_SetSystemTimeAdjustment
;_Date_Time_SetTimeZoneInformation
;_Date_Time_SystemTimeToArray
;_Date_Time_SystemTimeToDateStr
;_Date_Time_SystemTimeToDateTimeStr
;_Date_Time_SystemTimeToFileTime
;_Date_Time_SystemTimeToTimeStr
;_Date_Time_SystemTimeToTzSpecificLocalTime
;_Date_Time_TzSpecificLocalTimeToSystemTime
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;_DateIsMonth
;_DateIsYear
;_DateMonthOfYear
;_Date_Time_CloneSystemTime
;==============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _DateAdd
; Description ...: Calculates a new date based on a given date and add an interval.
; Syntax.........: _DateAdd($sType, $iValToAdd, $sDate)
; Parameters ....: $sType - of one the following:
;                  |D - Add number of days to the given date
;                  |M - Add number of months to the given date
;                  |Y - Add number of years to the given date
;                  |w - Add number of Weeks to the given date
;                  |h - Add number of hours to the given date
;                  |n - Add number of minutes to the given date
;                  |s - Add number of seconds to the given date
;                  $iValToAdd - number to be added
;                  $sDate    - Input date in the format YYYY/MM/DD[ HH:MM:SS]
; Return values .: Success - Date newly calculated date.
;                  Failure - 0 and Set @ERROR to:
;                  |1 - Invalid $sType
;                  |2 - Invalid $iValToAdd
;                  |3 - Invalid $sDate
; Author ........: Jos van der Zande
; Modified.......:
; Remarks .......: The function will not return an invalid date.
;                   When 3 months is are to '2004/1/31' then the result will be 2004/04/30
; Related .......: _DateDiff
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateAdd($sType, $iValToAdd, $sDate)
	Local $asTimePart[4]
	Local $asDatePart[4]
	Local $iJulianDate
	Local $iTimeVal
	Local $iNumDays
	Local $Day2Add
	; Verify that $sType is Valid
	$sType = StringLeft($sType, 1)
	If StringInStr("D,M,Y,w,h,n,s", $sType) = 0 Or $sType = "" Then
		SetError(1)
		Return (0)
	EndIf
	; Verify that Value to Add  is Valid
	If Not StringIsInt($iValToAdd) Then
		SetError(2)
		Return (0)
	EndIf
	; Verify If InputDate is valid
	If Not _DateIsValid($sDate) Then
		SetError(3)
		Return (0)
	EndIf
	; split the date and time into arrays
	_DateTimeSplit($sDate, $asDatePart, $asTimePart)

	; ====================================================
	; adding days then get the julian date
	; add the number of day
	; and convert back to Gregorian
	If $sType = "d" Or $sType = "w" Then
		If $sType = "w" Then $iValToAdd = $iValToAdd * 7
		$iJulianDate = _DateToDayValue($asDatePart[1], $asDatePart[2], $asDatePart[3]) + $iValToAdd
		_DayValueToDate($iJulianDate, $asDatePart[1], $asDatePart[2], $asDatePart[3])
	EndIf
	; ====================================================
	; adding Months
	If $sType = "m" Then
		$asDatePart[2] = $asDatePart[2] + $iValToAdd
		; pos number of months
		While $asDatePart[2] > 12
			$asDatePart[2] = $asDatePart[2] - 12
			$asDatePart[1] = $asDatePart[1] + 1
		WEnd
		; Neg number of months
		While $asDatePart[2] < 1
			$asDatePart[2] = $asDatePart[2] + 12
			$asDatePart[1] = $asDatePart[1] - 1
		WEnd
	EndIf
	; ====================================================
	; adding Years
	If $sType = "y" Then
		$asDatePart[1] = $asDatePart[1] + $iValToAdd
	EndIf
	; ====================================================
	; adding Time value
	If $sType = "h" Or $sType = "n" Or $sType = "s" Then
		$iTimeVal = _TimeToTicks($asTimePart[1], $asTimePart[2], $asTimePart[3]) / 1000
		If $sType = "h" Then $iTimeVal = $iTimeVal + $iValToAdd * 3600
		If $sType = "n" Then $iTimeVal = $iTimeVal + $iValToAdd * 60
		If $sType = "s" Then $iTimeVal = $iTimeVal + $iValToAdd
		; calculated days to add
		$Day2Add = Int($iTimeVal / (24 * 60 * 60))
		$iTimeVal = $iTimeVal - $Day2Add * 24 * 60 * 60
		If $iTimeVal < 0 Then
			$Day2Add = $Day2Add - 1
			$iTimeVal = $iTimeVal + 24 * 60 * 60
		EndIf
		$iJulianDate = _DateToDayValue($asDatePart[1], $asDatePart[2], $asDatePart[3]) + $Day2Add
		; calculate the julian back to date
		_DayValueToDate($iJulianDate, $asDatePart[1], $asDatePart[2], $asDatePart[3])
		; caluculate the new time
		_TicksToTime($iTimeVal * 1000, $asTimePart[1], $asTimePart[2], $asTimePart[3])
	EndIf
	; ====================================================
	; check if the Input day is Greater then the new month last day.
	; if so then change it to the last possible day in the month
	$iNumDays = StringSplit('31,28,31,30,31,30,31,31,30,31,30,31', ',')
	If _DateIsLeapYear($asDatePart[1]) Then $iNumDays[2] = 29
	;
	If $iNumDays[$asDatePart[2]] < $asDatePart[3] Then $asDatePart[3] = $iNumDays[$asDatePart[2]]
	; ========================
	; Format the return date
	; ========================
	; Format the return date
	$sDate = $asDatePart[1] & '/' & StringRight("0" & $asDatePart[2], 2) & '/' & StringRight("0" & $asDatePart[3], 2)
	; add the time when specified in the input
	If $asTimePart[0] > 0 Then
		If $asTimePart[0] > 2 Then
			$sDate = $sDate & " " & StringRight("0" & $asTimePart[1], 2) & ':' & StringRight("0" & $asTimePart[2], 2) & ':' & StringRight("0" & $asTimePart[3], 2)
		Else
			$sDate = $sDate & " " & StringRight("0" & $asTimePart[1], 2) & ':' & StringRight("0" & $asTimePart[2], 2)
		EndIf
	EndIf
	;
	Return ($sDate)
EndFunc   ;==>_DateAdd

; #FUNCTION# ====================================================================================================================
; Name...........: _DateDayOfWeek
; Description ...: Returns the name of the weekday, based on the specified day.
; Syntax.........: _DateDayOfWeek($iDayNum[, $iShort = 0])
; Parameters ....: $iDayNum - Day number (1 = Sunday, 7 = Saturday).
;                  $iShort  - Format:
;                  |0 - Long name of the weekday
;                  |1 - Abbreviated name of the weekday
; Return values .: Success - Weekday name
;                  Failure - A NULL string and sets @ERROR = 1
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......: This function returns English day names only.
; Related .......: _DateDaysInMonth
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateDayOfWeek($iDayNum, $iShort = 0)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $aDayOfWeek[8]

	$aDayOfWeek[1] = "Sunday"
	$aDayOfWeek[2] = "Monday"
	$aDayOfWeek[3] = "Tuesday"
	$aDayOfWeek[4] = "Wednesday"
	$aDayOfWeek[5] = "Thursday"
	$aDayOfWeek[6] = "Friday"
	$aDayOfWeek[7] = "Saturday"
	Select
		Case Not StringIsInt($iDayNum) Or Not StringIsInt($iShort)
			SetError(1)
			Return ""
		Case $iDayNum < 1 Or $iDayNum > 7
			SetError(1)
			Return ""
		Case Else
			Select
				Case $iShort = 0
					Return $aDayOfWeek[$iDayNum]
				Case $iShort = 1
					Return StringLeft($aDayOfWeek[$iDayNum], 3)
				Case Else
					SetError(1)
					Return ""
			EndSelect
	EndSelect
EndFunc   ;==>_DateDayOfWeek

; #FUNCTION# ====================================================================================================================
; Name...........: _DateDaysInMonth
; Description ...: Returns the number of days in a month, based on the specified month and year.
; Syntax.........: _DateDaysInMonth($iYear, $iMonthNum)
; Parameters ....: $iYear - 4-digit year.
;                  $iMonthNum - Month number (1 = January, 12 = December).
; Return values .: Success - Returns the number of days in the month.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No error.
;                  |1 - Invalid month number or year.
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateDaysInMonth($iYear, $iMonthNum)
	Local $aiNumDays
	$aiNumDays = "31,28,31,30,31,30,31,31,30,31,30,31"
	$aiNumDays = StringSplit($aiNumDays, ",")
	If _DateIsMonth($iMonthNum) And _DateIsYear($iYear) Then
		If _DateIsLeapYear($iYear) Then $aiNumDays[2] = $aiNumDays[2] + 1
		SetError(0)
		Return $aiNumDays[$iMonthNum]
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_DateDaysInMonth

; #FUNCTION# ====================================================================================================================
; Name...........: _DateDiff
; Description ...: Returns the difference between 2 dates, expressed in the type requested
; Syntax.........: _DateDiff($sType, $sStartDate, $sEndDate)
; Parameters ....: $sType - One of the following:
;                  |D = Difference in days between the given dates
;                  |M = Difference in months between the given dates
;                  |Y = Difference in years between the given dates
;                  |w = Difference in Weeks between the given dates
;                  |h = Difference in hours between the given dates
;                  |n = Difference in minutes between the given dates
;                  |s = Difference in seconds between the given dates
;                  $sStartDate  - Input Start date in the format "YYYY/MM/DD[ HH:MM:SS]"
;                  $sEndDate    - Input End date in the format "YYYY/MM/DD[ HH:MM:SS]"
; Return values .: Success - Difference between the 2 dates.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No error.
;                  |1 - Invalid $sType
;                  |2 - Invalid $sStartDate
;                  |3 - Invalid $sEndDate
; Author ........: Jos van der Zande
; Modified.......:
; Remarks .......:
; Related .......: _DateAdd
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateDiff($sType, $sStartDate, $sEndDate)
	Local $asStartDatePart[4]
	Local $asStartTimePart[4]
	Local $asEndDatePart[4]
	Local $asEndTimePart[4]
	Local $iTimeDiff
	Local $iYearDiff
	Local $iMonthDiff
	Local $iStartTimeInSecs
	Local $iEndTimeInSecs
	Local $aDaysDiff
	;
	; Verify that $sType is Valid
	$sType = StringLeft($sType, 1)
	If StringInStr("d,m,y,w,h,n,s", $sType) = 0 Or $sType = "" Then
		SetError(1)
		Return (0)
	EndIf
	; Verify If StartDate is valid
	If Not _DateIsValid($sStartDate) Then
		SetError(2)
		Return (0)
	EndIf
	; Verify If EndDate is valid
	If Not _DateIsValid($sEndDate) Then
		SetError(3)
		Return (0)
	EndIf
	; split the StartDate and Time into arrays
	_DateTimeSplit($sStartDate, $asStartDatePart, $asStartTimePart)
	; split the End  Date and time into arrays
	_DateTimeSplit($sEndDate, $asEndDatePart, $asEndTimePart)
	; ====================================================
	; Get the differens in days between the 2 dates
	$aDaysDiff = _DateToDayValue($asEndDatePart[1], $asEndDatePart[2], $asEndDatePart[3]) - _DateToDayValue($asStartDatePart[1], $asStartDatePart[2], $asStartDatePart[3])
	; ====================================================
	; Get the differens in Seconds between the 2 times when specified
	If $asStartTimePart[0] > 1 And $asEndTimePart[0] > 1 Then
		$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
		$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
		$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
		If $iTimeDiff < 0 Then
			$aDaysDiff = $aDaysDiff - 1
			$iTimeDiff = $iTimeDiff + 24 * 60 * 60
		EndIf
	Else
		$iTimeDiff = 0
	EndIf
	Select
		Case $sType = "d"
			Return ($aDaysDiff)
		Case $sType = "m"
			$iYearDiff = $asEndDatePart[1] - $asStartDatePart[1]
			$iMonthDiff = $asEndDatePart[2] - $asStartDatePart[2] + $iYearDiff * 12
			If $asEndDatePart[3] < $asStartDatePart[3] Then $iMonthDiff = $iMonthDiff - 1
			$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
			$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
			$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
			If $asEndDatePart[3] = $asStartDatePart[3] And $iTimeDiff < 0 Then $iMonthDiff = $iMonthDiff - 1
			Return ($iMonthDiff)
		Case $sType = "y"
			$iYearDiff = $asEndDatePart[1] - $asStartDatePart[1]
			If $asEndDatePart[2] < $asStartDatePart[2] Then $iYearDiff = $iYearDiff - 1
			If $asEndDatePart[2] = $asStartDatePart[2] And $asEndDatePart[3] < $asStartDatePart[3] Then $iYearDiff = $iYearDiff - 1
			$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
			$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
			$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
			If $asEndDatePart[2] = $asStartDatePart[2] And $asEndDatePart[3] = $asStartDatePart[3] And $iTimeDiff < 0 Then $iYearDiff = $iYearDiff - 1
			Return ($iYearDiff)
		Case $sType = "w"
			Return (Int($aDaysDiff / 7))
		Case $sType = "h"
			Return ($aDaysDiff * 24 + Int($iTimeDiff / 3600))
		Case $sType = "n"
			Return ($aDaysDiff * 24 * 60 + Int($iTimeDiff / 60))
		Case $sType = "s"
			Return ($aDaysDiff * 24 * 60 * 60 + $iTimeDiff)
	EndSelect
EndFunc   ;==>_DateDiff

; #FUNCTION# ====================================================================================================================
; Name...........: _DateIsLeapYear
; Description ...: Checks a given year to see if it is a leap year.
; Syntax.........: _DateIsLeapYear($iYear)
; Parameters ....: $iYear - The 4-digit year to check.
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 if the year is not a leap year and Sets @Error:
;                  |0 - No error.
;                  |1 - 1 = Invalid year.
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateIsLeapYear($iYear)
	If StringIsInt($iYear) Then
		Select
			Case Mod($iYear, 4) = 0 And Mod($iYear, 100) <> 0
				Return 1
			Case Mod($iYear, 400) = 0
				Return 1
			Case Else
				Return 0
		EndSelect
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_DateIsLeapYear

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _DateIsMonth
; Description ...: Checks a given number to see if it is a valid month.
; Syntax.........: _DateIsMonth($iNumber)
; Parameters ....: $iNumber - Month number to check.
; Return values .: Success - Returns 1 if month is valid.
;                  Failure - Returns 0
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateIsMonth($iNumber)
	If StringIsInt($iNumber) Then
		If $iNumber >= 1 And $iNumber <= 12 Then
			Return 1
		Else
			Return 0
		EndIf
	Else
		Return 0
	EndIf
EndFunc   ;==>_DateIsMonth

; #FUNCTION# ====================================================================================================================
; Name...........: _DateIsValid
; Description ...: Checks the given date to determine if it is a valid date.
; Syntax.........: _DateIsValid($sDate)
; Parameters ....: $sDate - The date to be checked.
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 if the specified date is not valid.
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......: This function takes a date input in one of the following formats:
;                  "yyyy/mm/dd[ hh:mm[:ss]]" or "yyyy/mm/dd[Thh:mm[:ss]]"
;                  "yyyy-mm-dd[ hh:mm[:ss]]" or "yyyy-mm-dd[Thh:mm[:ss]]"
;                  "yyyy.mm.dd[ hh:mm[:ss]]" or "yyyy.mm.dd[Thh:mm[:ss]]"
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateIsValid($sDate)
	Local $asDatePart[4]
	Local $asTimePart[4]
	Local $iNumDays
	Local $sDateTime
	$iNumDays = "31,28,31,30,31,30,31,31,30,31,30,31"
	$iNumDays = StringSplit($iNumDays, ",")
	; split the Date and Time portion
	$sDateTime = StringSplit($sDate, " T")
	; split the date portion
	If $sDateTime[0] > 0 Then $asDatePart = StringSplit($sDateTime[1], "/-.")
	; Ensure the date contains 3 sections YYYY MM DD
	If UBound($asDatePart) <> 4 Then Return (0)
	If $asDatePart[0] <> 3 Then Return (0)
	; verify valid input date values
	; Make sure the Date parts contains numeric
	If Not StringIsInt($asDatePart[1]) Then Return (0)
	If Not StringIsInt($asDatePart[2]) Then Return (0)
	If Not StringIsInt($asDatePart[3]) Then Return (0)
	$asDatePart[1] = Number($asDatePart[1])
	$asDatePart[2] = Number($asDatePart[2])
	$asDatePart[3] = Number($asDatePart[3])
	; check if all contain valid values
	If _DateIsLeapYear($asDatePart[1]) Then $iNumDays[2] = 29
	If $asDatePart[1] < 1000 Or $asDatePart[1] > 2999 Then Return (0)
	If $asDatePart[2] < 1 Or $asDatePart[2] > 12 Then Return (0)
	If $asDatePart[3] < 1 Or $asDatePart[3] > $iNumDays[$asDatePart[2]] Then Return (0)
	; split the Time portion
	If $sDateTime[0] > 1 Then
		$asTimePart = StringSplit($sDateTime[2], ":")
		If UBound($asTimePart) < 4 Then ReDim $asTimePart[4]
	Else
		Dim $asTimePart[4]
	EndIf
	; check Time portion
	If $asTimePart[0] < 1 Then Return (1) ; No time specified so date must be correct
	If $asTimePart[0] < 2 Then Return (0) ; need at least HH:MM when something is specified
	If $asTimePart[0] = 2 Then $asTimePart[3] = "00" ; init SS when only HH:MM is specified
	; Make sure the Time parts contains numeric
	If Not StringIsInt($asTimePart[1]) Then Return (0)
	If Not StringIsInt($asTimePart[2]) Then Return (0)
	If Not StringIsInt($asTimePart[3]) Then Return (0)
	; check if all contain valid values
	$asTimePart[1] = Number($asTimePart[1])
	$asTimePart[2] = Number($asTimePart[2])
	$asTimePart[3] = Number($asTimePart[3])
	If $asTimePart[1] < 0 Or $asTimePart[1] > 23 Then Return (0)
	If $asTimePart[2] < 0 Or $asTimePart[2] > 59 Then Return (0)
	If $asTimePart[3] < 0 Or $asTimePart[3] > 59 Then Return (0)
	; we got here so date/time must be good
	Return (1)
EndFunc   ;==>_DateIsValid


; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _DateIsYear
; Description ...: Checks a given number to see if it is a valid year.
; Syntax.........: _DateIsYear($iNumber)
; Parameters ....: $iNumber - Year number to check.
; Return values .: Success - Returns 1 if year is valid.
;                  Failure - Returns 0
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateIsYear($iNumber)
	If StringIsInt($iNumber) Then
		If StringLen($iNumber) = 4 Then
			Return 1
		Else
			Return 0
		EndIf
	Else
		Return 0
	EndIf
EndFunc   ;==>_DateIsYear

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _DateLastWeekdayNum
; Description ...: Returns previous weekday number, based on the specified day of the week.
; Syntax.........: _DateLastWeekdayNum($iWeekdayNum)
; Parameters ....: $iWeekdayNum - Weekday number
; Return values .: Success - Previous weekday number
;                  Failure - Returns 0 and sets @ERROR = 1
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateLastWeekdayNum($iWeekdayNum)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iLastWeekdayNum

	Select
		Case Not StringIsInt($iWeekdayNum)
			SetError(1)
			Return 0
		Case $iWeekdayNum < 1 Or $iWeekdayNum > 7
			SetError(1)
			Return 0
		Case Else
			If $iWeekdayNum = 1 Then
				$iLastWeekdayNum = 7
			Else
				$iLastWeekdayNum = $iWeekdayNum - 1
			EndIf

			Return $iLastWeekdayNum
	EndSelect
EndFunc   ;==>_DateLastWeekdayNum

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _DateLastMonthNum
; Description ...: Returns previous month number, based on the specified month.
; Syntax.........: _DateLastMonthNum($iMonthNum)
; Parameters ....: $iMonthNum - Month number
; Return values .: Success - Previous month number
;                  Failure - Returns 0 and sets @ERROR = 1
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateLastMonthNum($iMonthNum)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iLastMonthNum

	Select
		Case Not StringIsInt($iMonthNum)
			SetError(1)
			Return 0
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return 0
		Case Else
			If $iMonthNum = 1 Then
				$iLastMonthNum = 12
			Else
				$iLastMonthNum = $iMonthNum - 1
			EndIf

			$iLastMonthNum = StringFormat("%02d", $iLastMonthNum)
			Return $iLastMonthNum
	EndSelect
EndFunc   ;==>_DateLastMonthNum

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _DateLastMonthYear
; Description ...: Returns previous month's year, based on the specified month and year.
; Syntax.........: _DateLastMonthYear($iMonthNum, $iYear)
; Parameters ....: $iMonthNum - Month number
;                  $iYear     - Year
; Return values .: Success - Previous month's year
;                  Failure - Returns 0 and sets @ERROR = 1
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateLastMonthYear($iMonthNum, $iYear)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iLastYear

	Select
		Case Not StringIsInt($iMonthNum) Or Not StringIsInt($iYear)
			SetError(1)
			Return 0
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return 0
		Case Else
			If $iMonthNum = 1 Then
				$iLastYear = $iYear - 1
			Else
				$iLastYear = $iYear
			EndIf

			$iLastYear = StringFormat("%04d", $iLastYear)
			Return $iLastYear
	EndSelect
EndFunc   ;==>_DateLastMonthYear

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _DateMonthOfYear
; Description ...: Returns the name of the month, based on the specified month.
; Syntax.........: _DateMonthOfYear($iMonthNum, $iShort)
; Parameters ....: $iMonthNum - Month number
;                  $iShort    - Format:
;                  |0 - Long name of the month
;                  |1 - Abbreviated name of the month
; Return values .: Success - Month name
;                  Failure - A NULL string and sets @ERROR = 1
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......: English only
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateMonthOfYear($iMonthNum, $iShort)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $aMonthOfYear[13]

	$aMonthOfYear[1] = "January"
	$aMonthOfYear[2] = "February"
	$aMonthOfYear[3] = "March"
	$aMonthOfYear[4] = "April"
	$aMonthOfYear[5] = "May"
	$aMonthOfYear[6] = "June"
	$aMonthOfYear[7] = "July"
	$aMonthOfYear[8] = "August"
	$aMonthOfYear[9] = "September"
	$aMonthOfYear[10] = "October"
	$aMonthOfYear[11] = "November"
	$aMonthOfYear[12] = "December"

	Select
		Case Not StringIsInt($iMonthNum) Or Not StringIsInt($iShort)
			SetError(1)
			Return ""
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return ""
		Case Else
			Select
				Case $iShort = 0
					Return $aMonthOfYear[$iMonthNum]
				Case $iShort = 1
					Return StringLeft($aMonthOfYear[$iMonthNum], 3)
				Case Else
					SetError(1)
					Return ""
			EndSelect
	EndSelect
EndFunc   ;==>_DateMonthOfYear

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _DateNextWeekdayNum
; Description ...: Returns next weekday number, based on the specified day of the week.
; Syntax.........: _DateNextWeekdayNum($iWeekdayNum)
; Parameters ....: $iWeekdayNum - Weekday number
; Return values .: Success - Next weekday number
;                  Failure - 0 and sets @ERROR = 1
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateNextWeekdayNum($iWeekdayNum)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iNextWeekdayNum

	Select
		Case Not StringIsInt($iWeekdayNum)
			SetError(1)
			Return 0
		Case $iWeekdayNum < 1 Or $iWeekdayNum > 7
			SetError(1)
			Return 0
		Case Else
			If $iWeekdayNum = 7 Then
				$iNextWeekdayNum = 1
			Else
				$iNextWeekdayNum = $iWeekdayNum + 1
			EndIf

			Return $iNextWeekdayNum
	EndSelect
EndFunc   ;==>_DateNextWeekdayNum

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _DateNextMonthNum
; Description ...: Returns next month number, based on the specified month.
; Syntax.........: _DateNextMonthNum($iMonthNum)
; Parameters ....: $iMonthNum - Month number
; Return values .: Success - Next month number
;                  Failure - 0 and sets @ERROR = 1
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateNextMonthNum($iMonthNum)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iNextMonthNum

	Select
		Case Not StringIsInt($iMonthNum)
			SetError(1)
			Return 0
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return 0
		Case Else
			If $iMonthNum = 12 Then
				$iNextMonthNum = 1
			Else
				$iNextMonthNum = $iMonthNum + 1
			EndIf

			$iNextMonthNum = StringFormat("%02d", $iNextMonthNum)
			Return $iNextMonthNum
	EndSelect
EndFunc   ;==>_DateNextMonthNum

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _DateNextMonthYear
; Description ...: Returns next month's year, based on the specified month and year.
; Syntax.........: _DateNextMonthYear($iMonthNum, $iYear)
; Parameters ....: $iMonthNum - Month number
;                  $iYear     - Year
; Return values .: Success - Next month's year
;                  Failure - 0 and sets @ERROR = 1
; Author ........: Jeremy Landes <jlandes at landeserve dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _DateNextMonthYear($iMonthNum, $iYear)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iNextYear

	Select
		Case Not StringIsInt($iMonthNum) Or Not StringIsInt($iYear)
			SetError(1)
			Return 0
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return 0
		Case Else
			If $iMonthNum = 12 Then
				$iNextYear = $iYear + 1
			Else
				$iNextYear = $iYear
			EndIf

			$iNextYear = StringFormat("%04d", $iNextYear)
			Return $iNextYear
	EndSelect
EndFunc   ;==>_DateNextMonthYear

; #FUNCTION# ====================================================================================================================
; Name...........: _DateTimeFormat
; Description ...: Returns the date in the PC's regional settings format.
; Syntax.........: _DateTimeFormat($sDate, $sType)
; Parameters ....: $sDate - Input date in the format "YYYY/MM/DD[ HH:MM:SS]"
;                  $sType - one the following:
;                  |0 - Display a date and/or time. If there is a date part, display it as a short date.
;                  +If there is a time part, display it as a long time. If present, both parts are displayed.
;                  |1 - Display a date using the long date format specified in your computer's regional settings.
;                  |2 - Display a date using the short date format specified in your computer's regional settings.
;                  |3 - Display a time using the time format specified in your computer's regional settings.
;                  |4 - Display a time using the 24-hour format (hh:mm).
;                  |5 - Display a time using the 24-hour format (hh:mm:ss).
; Return values .: Success - Returns date in proper format.
;                  Failure - 0 and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid $sDate
;                  |2 - Invalid $sType
; Author ........: Jos van der Zande <jdeb at autoitscript dot com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateTimeFormat($sDate, $sType)
	Local $asDatePart[4]
	Local $asTimePart[4]
	Local $sTempDate = ""
	Local $sTempTime = ""
	Local $sAM
	Local $sPM
	Local $iWday
	Local $lngX
	; Verify If InputDate is valid
	If Not _DateIsValid($sDate) Then
		SetError(1)
		Return ("")
	EndIf
	; input validation
	If $sType < 0 Or $sType > 5 Or Not IsInt($sType) Then
		SetError(2)
		Return ("")
	EndIf
	; split the date and time into arrays
	_DateTimeSplit($sDate, $asDatePart, $asTimePart)
	;
	; 	Const $LOCALE_USER_DEFAULT = 0x400
	;   Const $LOCALE_SDATE = 0x1D            ;  date separator
	;   Const $LOCALE_STIME = 0x1E            ;  time separator
	;   Const $LOCALE_S1159 = 0x28            ;  AM designator
	;   Const $LOCALE_S2359 = 0x29            ;  PM designator
	; 	Const $LOCALE_SSHORTDATE = 0x1F       ;  short date format string
	; 	Const $LOCALE_SLONGDATE = 0x20        ;  long date format string
	; 	Const $LOCALE_STIMEFORMAT = 0x1003    ;  time format string

	Switch $sType
		Case 0
			; Get ShortDate format
			$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1F, "str", "", "long", 255)
			If Not @error And $lngX[0] <> 0 Then
				$sTempDate = $lngX[3]
			Else
				$sTempDate = "M/d/yyyy"
			EndIf
			;
			; Get Time format
			If $asTimePart[0] > 1 Then
				$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1003, "str", "", "long", 255)
				If Not @error And $lngX[0] <> 0 Then
					$sTempTime = $lngX[3]
				Else
					$sTempTime = "h:mm:ss tt"
				EndIf
			EndIf
		Case 1
			; Get LongDate format
			$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x20, "str", "", "long", 255)
			If Not @error And $lngX[0] <> 0 Then
				$sTempDate = $lngX[3]
			Else
				$sTempDate = "dddd, MMMM dd, yyyy"
			EndIf
		Case 2
			; Get ShortDate format
			$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1F, "str", "", "long", 255)
			If Not @error And $lngX[0] <> 0 Then
				$sTempDate = $lngX[3]
			Else
				$sTempDate = "M/d/yyyy"
			EndIf
		Case 3
			;
			; Get Time format
			If $asTimePart[0] > 1 Then
				$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1003, "str", "", "long", 255)
				If Not @error And $lngX[0] <> 0 Then
					$sTempTime = $lngX[3]
				Else
					$sTempTime = "h:mm:ss tt"
				EndIf
			EndIf
		Case 4
			If $asTimePart[0] > 1 Then
				$sTempTime = "hh:mm"
			EndIf
		Case 5
			If $asTimePart[0] > 1 Then
				$sTempTime = "hh:mm:ss"
			EndIf
	EndSwitch
	; Format DATE
	If $sTempDate <> "" Then
		;   Const $LOCALE_SDATE = 0x1D            ;  date separator
		$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1D, "str", "", "long", 255)
		If Not @error And $lngX[0] <> 0 Then
;~ 			$sTempTime = StringReplace($sTempTime, "/", $lngX[3])
			$sTempDate = StringReplace($sTempDate, "/", $lngX[3])
		EndIf
		$iWday = _DateToDayOfWeek($asDatePart[1], $asDatePart[2], $asDatePart[3])
		$asDatePart[3] = StringRight("0" & $asDatePart[3], 2) ; make sure the length is 2
		$asDatePart[2] = StringRight("0" & $asDatePart[2], 2) ; make sure the length is 2
		$sTempDate = StringReplace($sTempDate, "d", "@")
		$sTempDate = StringReplace($sTempDate, "m", "#")
		$sTempDate = StringReplace($sTempDate, "y", "&")
		$sTempDate = StringReplace($sTempDate, "@@@@", _DateDayOfWeek($iWday, 0))
		$sTempDate = StringReplace($sTempDate, "@@@", _DateDayOfWeek($iWday, 1))
		$sTempDate = StringReplace($sTempDate, "@@", $asDatePart[3])
		$sTempDate = StringReplace($sTempDate, "@", StringReplace(StringLeft($asDatePart[3], 1), "0", "") & StringRight($asDatePart[3], 1))
		$sTempDate = StringReplace($sTempDate, "####", _DateMonthOfYear($asDatePart[2], 0))
		$sTempDate = StringReplace($sTempDate, "###", _DateMonthOfYear($asDatePart[2], 1))
		$sTempDate = StringReplace($sTempDate, "##", $asDatePart[2])
		$sTempDate = StringReplace($sTempDate, "#", StringReplace(StringLeft($asDatePart[2], 1), "0", "") & StringRight($asDatePart[2], 1))
		$sTempDate = StringReplace($sTempDate, "&&&&", $asDatePart[1])
		$sTempDate = StringReplace($sTempDate, "&&", StringRight($asDatePart[1], 2))
	EndIf
	; Format TIME
	If $sTempTime <> "" Then
		$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x28, "str", "", "long", 255)
		If Not @error And $lngX[0] <> 0 Then
			$sAM = $lngX[3]
		Else
			$sAM = "AM"
		EndIf
		$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x29, "str", "", "long", 255)
		If Not @error And $lngX[0] <> 0 Then
			$sPM = $lngX[3]
		Else
			$sPM = "PM"
		EndIf
		;   Const $LOCALE_STIME = 0x1E            ;  time separator
		$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1E, "str", "", "long", 255)
		If Not @error And $lngX[0] <> 0 Then
			$sTempTime = StringReplace($sTempTime, ":", $lngX[3])
		EndIf
		If StringInStr($sTempTime, "tt") Then
			If $asTimePart[1] < 12 Then
				$sTempTime = StringReplace($sTempTime, "tt", $sAM)
				If $asTimePart[1] = 0 Then $asTimePart[1] = 12
			Else
				$sTempTime = StringReplace($sTempTime, "tt", $sPM)
				If $asTimePart[1] > 12 Then $asTimePart[1] = $asTimePart[1] - 12
			EndIf
		EndIf
		$asTimePart[1] = StringRight("0" & $asTimePart[1], 2) ; make sure the length is 2
		$asTimePart[2] = StringRight("0" & $asTimePart[2], 2) ; make sure the length is 2
		$asTimePart[3] = StringRight("0" & $asTimePart[3], 2) ; make sure the length is 2
		$sTempTime = StringReplace($sTempTime, "hh", StringFormat("%02d", $asTimePart[1]))
		$sTempTime = StringReplace($sTempTime, "h", StringReplace(StringLeft($asTimePart[1], 1), "0", "") & StringRight($asTimePart[1], 1))
		$sTempTime = StringReplace($sTempTime, "mm", StringFormat("%02d", $asTimePart[2]))
		$sTempTime = StringReplace($sTempTime, "ss", StringFormat("%02d", $asTimePart[3]))
		$sTempDate = StringStripWS($sTempDate & " " & $sTempTime, 3)
	EndIf
	Return ($sTempDate)
EndFunc   ;==>_DateTimeFormat

; #FUNCTION# ====================================================================================================================
; Name...........: _DateTimeSplit
; Description ...: Split a string containing Date and Time into two separate Arrays.
; Syntax.........: _DateTimeSplit($sDate, ByRef $asDatePart, ByRef $iTimePart)
; Parameters ....: $sDate - Any of these formats:
;                  |"yyyy/mm/dd[ hh:mm[:ss]]"
;                  |"yyyy/mm/dd[Thh:mm[:ss]]"
;                  |"yyyy-mm-dd[ hh:mm[:ss]]"
;                  |"yyyy-mm-dd[Thh:mm[:ss]]"
;                  |"yyyy.mm.dd[ hh:mm[:ss]]"
;                  |"yyyy.mm.dd[Thh:mm[:ss]]"
;                  $asDatePart - array that contains the Date.
;                  |$asDatePart[0] number of values returned
;                  $iTimePart - array that contains the Time.
;                  |$asTimePart[0] number of values returned
; Return values .: Success - Date and Time into two separate Arrays.
;                  Failure - 0 and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid Input Date
; Author ........: Jos van der Zande <jdeb at autoitscript dot com>
; Modified.......:
; Remarks .......:
; Related .......: _DayValueToDate, _DateAdd, _DateDiff
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateTimeSplit($sDate, ByRef $asDatePart, ByRef $iTimePart)
	Local $sDateTime
	Local $x
	; split the Date and Time portion
	$sDateTime = StringSplit($sDate, " T")
	; split the date portion
	If $sDateTime[0] > 0 Then $asDatePart = StringSplit($sDateTime[1], "/-.")
	; split the Time portion
	If $sDateTime[0] > 1 Then
		$iTimePart = StringSplit($sDateTime[2], ":")
		If UBound($iTimePart) < 4 Then ReDim $iTimePart[4]
	Else
		Dim $iTimePart[4]
	EndIf
	; Ensure the arrays contain 4 values
	If UBound($asDatePart) < 4 Then ReDim $asDatePart[4]
	; update the array to contain numbers not strings
	For $x = 1 To 3
		If StringIsInt($asDatePart[$x]) Then
			$asDatePart[$x] = Number($asDatePart[$x])
		Else
			$asDatePart[$x] = -1
		EndIf
		If StringIsInt($iTimePart[$x]) Then
			$iTimePart[$x] = Number($iTimePart[$x])
		Else
			$iTimePart[$x] = 0
		EndIf
	Next
	Return (1)
EndFunc   ;==>_DateTimeSplit

; #FUNCTION# ====================================================================================================================
; Name...........: _DateToDayOfWeek
; Description ...: Returns the weekdaynumber for a given date.
; Syntax.........: _DateToDayOfWeek($iYear, $iMonth, $iDay)
; Parameters ....: $iYear  - A valid year in format YYYY
;                  $iMonth - A valid month in format MM
;                  $iDay   - A valid day in format DD
; Return values .: Success - Returns Day of the Week Range is 1 to 7 where 1=Sunday.
;                  Failure - 0 and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid Input Date
; Author ........: Jos van der Zande <jdeb at autoitscript dot com>
; Modified.......:
; Remarks .......:
; Related .......: _DateToDayOfWeekISO, _DateDayOfWeek, _DayValueToDate, _DateAdd, _DateDiff
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateToDayOfWeek($iYear, $iMonth, $iDay)
	Local $i_aFactor
	Local $i_yFactor
	Local $i_mFactor
	Local $i_dFactor
	; Verify If InputDate is valid
	If Not _DateIsValid($iYear & "/" & $iMonth & "/" & $iDay) Then
		SetError(1)
		Return ("")
	EndIf
	$i_aFactor = Int((14 - $iMonth) / 12)
	$i_yFactor = $iYear - $i_aFactor
	$i_mFactor = $iMonth + (12 * $i_aFactor) - 2
	$i_dFactor = Mod($iDay + $i_yFactor + Int($i_yFactor / 4) - Int($i_yFactor / 100) + Int($i_yFactor / 400) + Int((31 * $i_mFactor) / 12), 7)
	Return ($i_dFactor + 1)
EndFunc   ;==>_DateToDayOfWeek

; #FUNCTION# ====================================================================================================================
; Name...........: _DateToDayOfWeekISO
; Description ...: Returns the ISO weekdaynumber for a given date.
; Syntax.........: _DateToDayOfWeekISO($iYear, $iMonth, $iDay)
; Parameters ....: $iYear  - A valid year in format YYYY
;                  $iMonth - A valid month in format MM
;                  $iDay   - A valid day in format DD
; Return values .: Success - Returns Day of the Week Range is 0 to 6 where 0=Monday.
;                  Failure - 0 and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid Input Date
; Author ........: Jos van der Zande <jdeb at autoitscript dot com>
; Modified.......:
; Remarks .......:
; Related .......: _DateToDayOfWeek, _DateDayOfWeek, _DayValueToDate, _DateAdd, _DateDiff
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateToDayOfWeekISO($iYear, $iMonth, $iDay)
	Local $idow = _DateToDayOfWeek($iYear, $iMonth, $iDay)
	If @error Then
		SetError(1)
		Return ""
	EndIf
	If $idow >= 2 Then Return $idow - 2
	Return 6
EndFunc   ;==>_DateToDayOfWeekISO

; #FUNCTION# ====================================================================================================================
; Name...........: _DateToDayValue
; Description ...: Returns the daynumber since since noon 4713 BC January 1 for a given Gregorian date.
; Syntax.........: _DateToDayValue($iYear, $iMonth, $iDay)
; Parameters ....: $iYear  - A valid year in format YYYY
;                  $iMonth - A valid month in format MM
;                  $iDay   - A valid day in format DD
; Return values .: Success - Returns the Juliandate (days since noon 4713 BC January 1)
;                  Failure - 0 and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid Input Date
; Author ........: Jos van der Zande / Jeremy Landes
; Modified.......:
; Remarks .......:
; Related .......: _DayValueToDate, _DateAdd, _DateDiff
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateToDayValue($iYear, $iMonth, $iDay)
	Local $i_aFactor
	Local $i_bFactor
	Local $i_cFactor
	Local $i_eFactor
	Local $i_fFactor
	Local $iJulianDate
	; Verify If InputDate is valid
	If Not _DateIsValid(StringFormat("%04d/%02d/%02d", $iYear, $iMonth, $iDay)) Then
		SetError(1)
		Return ("")
	EndIf
	If $iMonth < 3 Then
		$iMonth = $iMonth + 12
		$iYear = $iYear - 1
	EndIf
	$i_aFactor = Int($iYear / 100)
	$i_bFactor = Int($i_aFactor / 4)
	$i_cFactor = 2 - $i_aFactor + $i_bFactor
	$i_eFactor = Int(1461 * ($iYear + 4716) / 4)
	$i_fFactor = Int(153 * ($iMonth + 1) / 5)
	$iJulianDate = $i_cFactor + $iDay + $i_eFactor + $i_fFactor - 1524.5
	Return ($iJulianDate)
EndFunc   ;==>_DateToDayValue

; #FUNCTION# ====================================================================================================================
; Name...........: _DateToMonth
; Description ...: Returns the name of the Month, based on the specified month number.
; Syntax.........: _DateToMonth($iMonthNum[, $ishort = 0])
; Parameters ....: $iMonth - Month number (1 = January, 12 = December).
;                  $ishort   - 1 of the Following:
;                  |0 - Long name of the Month.
;                  |1 - Abbreviated name of the Month.
; Return values .: Success - Returns the name of the given Month.
;                  Failure - empty string and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid month number or format.
; Author ........: Jason Brand <exodius at gmail dot com>
; Modified.......:
; Remarks .......: This function returns English day names only.
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DateToMonth($iMonthNum, $iShort = 0)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $aMonthNumber[13] = ["", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	Local $aMonthNumberAbbrev[13] = ["", "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]

	Select
		Case Not StringIsInt($iMonthNum)
			SetError(1)
			Return ""
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return ""
		Case Else
			Select
				Case $iShort = 0
					Return $aMonthNumber[$iMonthNum]
				Case $iShort = 1
					Return $aMonthNumberAbbrev[$iMonthNum]
				Case Else
					SetError(1)
					Return ""
			EndSelect
	EndSelect
EndFunc   ;==>_DateToMonth

; #FUNCTION# ====================================================================================================================
; Name...........: _DayValueToDate
; Description ...: Add the given days since noon 4713 BC January 1 and returns the Gregorian date.
; Syntax.........: _DayValueToDate($iJulianDate, ByRef $iYear, ByRef $iMonth, ByRef $iDay)
; Parameters ....: $iJulianDate - A valid number of days.
;                  $iYear       - will return the year in format YYYY
;                  $iMonth      - will return the month in format MM
;                  $iDay        - will return the day in format DD
; Return values .: Success - Returns the date calculated
;                  Failure - 0 and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid Input number of days
; Author ........: Jos van der Zande
; Modified.......:
; Remarks .......:
; Related .......: _DateToDayValue, _DateAdd, _DateDiff
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _DayValueToDate($iJulianDate, ByRef $iYear, ByRef $iMonth, ByRef $iDay)
	Local $i_zFactor
	Local $i_wFactor
	Local $i_aFactor
	Local $i_bFactor
	Local $i_xFactor
	Local $i_cFactor
	Local $i_dFactor
	Local $i_eFactor
	Local $i_fFactor
	; check for valid input date
	If $iJulianDate < 0 Or Not IsNumber($iJulianDate) Then
		SetError(1)
		Return 0
	EndIf
	; calculte the date
	$i_zFactor = Int($iJulianDate + 0.5)
	$i_wFactor = Int(($i_zFactor - 1867216.25) / 36524.25)
	$i_xFactor = Int($i_wFactor / 4)
	$i_aFactor = $i_zFactor + 1 + $i_wFactor - $i_xFactor
	$i_bFactor = $i_aFactor + 1524
	$i_cFactor = Int(($i_bFactor - 122.1) / 365.25)
	$i_dFactor = Int(365.25 * $i_cFactor)
	$i_eFactor = Int(($i_bFactor - $i_dFactor) / 30.6001)
	$i_fFactor = Int(30.6001 * $i_eFactor)
	$iDay = $i_bFactor - $i_dFactor - $i_fFactor
	; (must get number less than or equal to 12)
	If $i_eFactor - 1 < 13 Then
		$iMonth = $i_eFactor - 1
	Else
		$iMonth = $i_eFactor - 13
	EndIf
	If $iMonth < 3 Then
		$iYear = $i_cFactor - 4715 ; (if Month is January or February)
	Else
		$iYear = $i_cFactor - 4716 ;(otherwise)
	EndIf
	$iYear = StringFormat("%04d", $iYear)
	$iMonth = StringFormat("%02d", $iMonth)
	$iDay = StringFormat("%02d", $iDay)
	Return $iYear & "/" & $iMonth & "/" & $iDay
EndFunc   ;==>_DayValueToDate

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _Date_JulianDayNo
; Description ...: Returns the the julian date in format YYDDD
; Syntax.........: _Date_JulianDayNo($iYear, $iMonth, $iDay)
; Parameters ....: $iJulianDate - Julian date number
;                  $iYear       - Year in format YYYY
;                  $iMonth      - Month in format MM
;                  $iDay        - Day of the month format DD
; Return values .: Success - Returns the date calculated
;                  Failure - 0 and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid Input number of days
; Author ........: Jeremy Landes / Jos van der Zande
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _Date_JulianDayNo($iYear, $iMonth, $iDay)
	Local $sFullDate
	Local $aiDaysInMonth
	Local $iJDay
	Local $iCntr
	; Verify If InputDate is valid
	$sFullDate = StringFormat("%04d/%02d/%02d", $iYear, $iMonth, $iDay)
	If Not _DateIsValid($sFullDate) Then
		SetError(1)
		Return ""
	EndIf
	; Build JDay value
	$iJDay = 0
	$aiDaysInMonth = __DaysInMonth($iYear)
	For $iCntr = 1 To $iMonth - 1
		$iJDay = $iJDay + $aiDaysInMonth[$iCntr]
	Next
	$iJDay = ($iYear * 1000) + ($iJDay + $iDay)
	Return $iJDay
EndFunc   ;==>_Date_JulianDayNo

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _JulianToDate
; Description ...: Returns the the julian date in format YYDDD
; Syntax.........: _JulianToDate($iJDay[, $sSep = "/"])
; Parameters ....: $iJDate  - Julian date number
;                  $sSep    - Seperator character
; Return values .: Success - Returns the Date in format YYYY/MM/DD
;                  Failure - 0 and Set @ERROR to:
;                  |0 - No error.
;                  |1 - Invalid Julian
; Author ........: Jeremy Landes / Jos van der Zande
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _JulianToDate($iJDay, $sSep = "/")
	Local $aiDaysInMonth
	Local $iYear
	Local $iMonth
	Local $iDay
	Local $iDays
	Local $iMaxDays
	; Verify If InputDate is valid
	$iYear = Int($iJDay / 1000)
	$iDays = Mod($iJDay, 1000)
	$iMaxDays = 365
	If _DateIsLeapYear($iYear) Then $iMaxDays = 366
	If $iDays > $iMaxDays Then
		SetError(1)
		Return ""
	EndIf
	; Convert to regular date
	$aiDaysInMonth = __DaysInMonth($iYear)
	$iMonth = 1
	While $iDays > $aiDaysInMonth[$iMonth]
		$iDays = $iDays - $aiDaysInMonth[$iMonth]
		$iMonth = $iMonth + 1
	WEnd
	$iDay = $iDays
	Return StringFormat("%04d%s%02d%s%02d", $iYear, $sSep, $iMonth, $sSep, $iDay)
EndFunc   ;==>_JulianToDate

; #FUNCTION# ====================================================================================================================
; Name...........: _Now
; Description ...: Returns the current Date and Time in PC's format.
; Syntax.........: _Now()
; Parameters ....:
; Return values .: Success - Current Date and Time in PC's format
; Author ........: Jos van der Zande
; Modified.......:
; Remarks .......: If Date format isn't found in the registry it returns the date in the mm/dd/yyyy format.
;                  If Time format isn't found in the registry it returns the time in the hh:mm:ss format.
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Now()
	Return (_DateTimeFormat(@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC, 0))
EndFunc   ;==>_Now

; #FUNCTION# ====================================================================================================================
; Name...........: _NowCalc
; Description ...: Returns the current Date and Time in format YYYY/MM/DD HH:MM:SS for use in date calculations.
; Syntax.........: _NowCalc()
; Parameters ....:
; Return values .: Success - Returns the current Date and Time in format YYYY/MM/DD HH:MM:SS
; Author ........: Jos van der Zande
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _NowCalc()
	Return (@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC)
EndFunc   ;==>_NowCalc

; #FUNCTION# ====================================================================================================================
; Name...........: _NowCalcDate
; Description ...: Returns the current Date in format YYYY/MM/DD.
; Syntax.........: _NowCalcDate()
; Parameters ....:
; Return values .: Success - Returns the current Date in format YYYY/MM/DD
; Author ........: Jos van der Zande
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _NowCalcDate()
	Return (@YEAR & "/" & @MON & "/" & @MDAY)
EndFunc   ;==>_NowCalcDate

; #FUNCTION# ====================================================================================================================
; Name...........: _NowDate
; Description ...: Returns the current Date in the Pc's format.
; Syntax.........: _NowDate()
; Parameters ....:
; Return values .: Success - Returns the current Date in the Pc's format.
; Author ........: Jos van der Zande
; Modified.......:
; Remarks .......: If Date format isn't found in the registry it returns the date in the mm/dd/yyyy format.
; Related .......: _DateTimeFormat, _Now, _NowCalc, _NowCalcDate, _NowTime
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _NowDate()
	Return (_DateTimeFormat(@YEAR & "/" & @MON & "/" & @MDAY, 0))
EndFunc   ;==>_NowDate

; #FUNCTION# ====================================================================================================================
; Name...........: _NowTime
; Description ...: Returns the current Date in the Pc's format.
; Syntax.........: _NowTime([$sType = 3])
; Parameters ....: $sType - Default: 3 = Display a time using the time format specified in your computer's regional settings.
;                  |4 - Display a time using the 24-hour format (hh:mm).
;                  |5 - Display a time using the 24-hour format (hh:mm:ss).
; Return values .: Success - Returns the current Date in the Pc's format.
; Author ........: Jos van der Zande
; Modified.......:
; Remarks .......: If Date format isn't found in the registry it returns the date in the mm/dd/yyyy format.
; Related .......: _DateTimeFormat, _Now, _NowCalc, _NowCalcDate
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _NowTime($sType = 3)
	If $sType < 3 Or $sType > 5 Then $sType = 3
	Return (_DateTimeFormat(@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC, $sType))
EndFunc   ;==>_NowTime

; #FUNCTION# ====================================================================================================================
; Name...........: _SetDate
; Description ...: Sets the current date of the system
; Syntax.........: _SetDate($iDay[, $iMonth = 0[, $iYear = 0]])
; Parameters ....: $iDay - Day of the month. Values: 1-31
;                  $iMonth - Optional: month. Values: 1-12
;                  $iYear - Optional: year. Values: > 0 (windows might restrict this further!!)
; Return values .: Success - 1
;                  Failure - 0
;                  @Error - 0 - No error.
;                  |1 - Failure
;                  @extended - GetLastError()
;                  |Error code(s): http://msdn.microsoft.com/library/default.asp?url=/library/en-us/debug/base/system_error_codes.asp
; Author ........: /dev/null
; Modified.......:
; Remarks .......: If the optional parameters (iMonth,iYear) are NOT defined, the function will not change the current value!
; Related .......: _SetTime
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _SetDate($iDay, $iMonth = 0, $iYear = 0)

	Local $iRetval, $SYSTEMTIME, $lpSystemTime

	;============================================================================
	;== Some error checking
	;============================================================================
	If $iYear = 0 Then $iYear = @YEAR
	If $iMonth = 0 Then $iMonth = @MON
	If Not _DateIsValid($iYear & "/" & $iMonth & "/" & $iDay) Then Return 1

	$SYSTEMTIME = DllStructCreate("ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort")
	$lpSystemTime = DllStructGetPtr($SYSTEMTIME)

	;============================================================================
	;== Get the local system time to fill up the SYSTEMTIME structure
	;============================================================================
	$iRetval = DllCall("kernel32.dll", "long", "GetLocalTime", "ptr", $lpSystemTime)

	;============================================================================
	;== Change the necessary values
	;============================================================================
	DllStructSetData($SYSTEMTIME, 4, $iDay)
	If $iMonth > 0 Then DllStructSetData($SYSTEMTIME, 2, $iMonth)
	If $iYear > 0 Then DllStructSetData($SYSTEMTIME, 1, $iYear)

	;============================================================================
	;== Set the new date
	;============================================================================
	$iRetval = DllCall("kernel32.dll", "long", "SetLocalTime", "ptr", $lpSystemTime)
	; a second call is needed to take care of daylight saving see MSDN
	$iRetval = DllCall("kernel32.dll", "long", "SetLocalTime", "ptr", $lpSystemTime)

	;============================================================================
	;== If DllCall was successfull, check for an error of the API Call
	;============================================================================
	If @error = 0 Then
		If $iRetval[0] = 0 Then
			Local $lastError = DllCall("kernel32.dll", "int", "GetLastError")
			SetExtended($lastError[0])
			SetError(1)
			Return 0
		Else
			Return 1
		EndIf
		;============================================================================
		;== If DllCall was UNsuccessfull, return an error
		;============================================================================
	Else
		SetError(1)
		Return 0
	EndIf

EndFunc   ;==>_SetDate

; #FUNCTION# ====================================================================================================================
; Name...........: _SetTime
; Description ...: Sets the current time of the system
; Syntax.........: _SetTime($iHour, $iMinute[, $iSecond = 0])
; Parameters ....: $iHour - the hour. Values: 0-23
;                  $iMinute - the minute. Values: 0-59
;                  $iSecond - Optional: the seconds. Values: 0-59
; Return values .: Success - 1
;                  Failure - 0
;                  @Error - 0 - No error.
;                  |1 - Failure
;                  @extended - GetLastError()
;                  |Error code(s): http://msdn.microsoft.com/library/default.asp?url=/library/en-us/debug/base/system_error_codes.asp
; Author ........: /dev/null
; Modified.......:
; Remarks .......: If the optional parameter (iSecond) is NOT defined, the function will not change the current value!
; Related .......: _SetDate
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _SetTime($iHour, $iMinute, $iSecond = 0)

	Local $iRetval, $SYSTEMTIME, $lpSystemTime

	;============================================================================
	;== Some error checking
	;============================================================================
	If $iHour < 0 Or $iHour > 23 Then Return 1
	If $iMinute < 0 Or $iMinute > 59 Then Return 1
	If $iSecond < 0 Or $iSecond > 59 Then Return 1

	$SYSTEMTIME = DllStructCreate("ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort")
	$lpSystemTime = DllStructGetPtr($SYSTEMTIME)

	;============================================================================
	;== Get the local system time to fill up the SYSTEMTIME structure
	;============================================================================
	$iRetval = DllCall("kernel32.dll", "long", "GetLocalTime", "ptr", $lpSystemTime)

	;============================================================================
	;== Change the necessary values
	;============================================================================
	DllStructSetData($SYSTEMTIME, 5, $iHour)
	DllStructSetData($SYSTEMTIME, 6, $iMinute)
	If $iSecond > 0 Then DllStructSetData($SYSTEMTIME, 7, $iSecond)

	;============================================================================
	;== Set the new time
	;============================================================================
	$iRetval = DllCall("kernel32.dll", "long", "SetLocalTime", "ptr", $lpSystemTime)
	; a second call is needed to take care of daylight saving see MSDN
	$iRetval = DllCall("kernel32.dll", "long", "SetLocalTime", "ptr", $lpSystemTime)

	;============================================================================
	;== If DllCall was successfull, check for an error of the API Call
	;============================================================================
	If @error = 0 Then
		If $iRetval[0] = 0 Then
			Local $lastError = DllCall("kernel32.dll", "int", "GetLastError")
			SetExtended($lastError[0])
			SetError(1)
			Return 0
		Else
			Return 1
		EndIf
		;============================================================================
		;== If DllCall was UNsuccessfull, return an error
		;============================================================================
	Else
		SetError(1)
		Return 0
	EndIf

EndFunc   ;==>_SetTime

; #FUNCTION# ====================================================================================================================
; Name...........: _TicksToTime
; Description ...: Converts the specified tick amount to hours, minutes and seconds.
; Syntax.........: _TicksToTime($iTicks, ByRef $iHours, ByRef $iMins, ByRef $iSecs)
; Parameters ....: $iTicks - Tick amount.
;                  $iHours - Variable to store the hours.
;                  $iMins - Variable to store the minutes.
;                  $iSecs - Variable to store the seconds.
; Return values .: Success - 1
;                  Failure - 0
;                  @Error - 0 - No error.
;                  |1 - $iTicks isn't an integer.
; Author ........: Marc <mrd at gmx de>
; Modified.......:
; Remarks .......:
; Related .......: _TimeToTicks
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _TicksToTime($iTicks, ByRef $iHours, ByRef $iMins, ByRef $iSecs)
	If Number($iTicks) > 0 Then
		$iTicks = Round($iTicks / 1000)
		$iHours = Int($iTicks / 3600)
		$iTicks = Mod($iTicks, 3600)
		$iMins = Int($iTicks / 60)
		$iSecs = Round(Mod($iTicks, 60))
		; If $iHours = 0 then $iHours = 24
		Return 1
	ElseIf Number($iTicks) = 0 Then
		$iHours = 0
		$iTicks = 0
		$iMins = 0
		$iSecs = 0
		Return 1
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_TicksToTime

; #FUNCTION# ====================================================================================================================
; Name...........: _TimeToTicks
; Description ...: Converts the specified hours, minutes, and seconds to ticks.
; Syntax.........: _TimeToTicks([$iHours = @HOUR[, $iMins = @MIN[, $iSecs = @SEC]]])
; Parameters ....: $iHours - The hours.
;                  $iMins - The minutes.
;                  $iSecs - The seconds.
; Return values .: Success - Returns the number of ticks.
;                  Failure - 0
;                  @Error - 0 - No error.
;                  |1 - The specified hours, minutes, or seconds are not valid.
; Author ........: Marc <mrd at gmx de>
; Modified.......: SlimShady: added the default time and made parameters optional
; Remarks .......:
; Related .......: _TicksToTime
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _TimeToTicks($iHours = @HOUR, $iMins = @MIN, $iSecs = @SEC)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iTicks

	If StringIsInt($iHours) And StringIsInt($iMins) And StringIsInt($iSecs) Then
		$iTicks = 1000 * ((3600 * $iHours) + (60 * $iMins) + $iSecs)
		Return $iTicks
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_TimeToTicks

; #FUNCTION# ====================================================================================================================
; Name...........: _WeekNumberISO
; Description ...: Calculate the weeknumber of a given date.
; Syntax.........: _WeekNumberISO([$iYear = @YEAR[, $iMonth = @MON[, $iDay = @MDAY]]])
; Parameters ....: $iYear - Year value (default = current year)
;                  $iMonth    - Month value (default = current month)
;                  $iDay - Day value (default = current day)
; Return values .: Success - Returns week number of given date
;                  Failure - 0
;                  @Error - 0 - No error.
;                  | 1 - faulty parameters values
;                  |99 - On non-acceptable weekstart value
; Author ........: Tuape
; Modified.......: JdeB: modified to UDF standards & Doc., Change calculation logic.
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _WeekNumberISO($iYear = @YEAR, $iMonth = @MON, $iDay = @MDAY)
	Local $idow, $iDow0101

	; Check for erroneous input in $Day, $Month & $Year
	If $iDay > 31 Or $iDay < 1 Then
		SetError(1)
		Return -1
	ElseIf $iMonth > 12 Or $iMonth < 1 Then
		SetError(1)
		Return -1
	ElseIf $iYear < 1 Or $iYear > 2999 Then
		SetError(1)
		Return -1
	EndIf

	$idow = _DateToDayOfWeekISO($iYear, $iMonth, $iDay);
	$iDow0101 = _DateToDayOfWeekISO($iYear, 1, 1);

	If ($iMonth = 1 And 3 < $iDow0101 And $iDow0101 < 7 - ($iDay - 1)) Then
		;days before week 1 of the current year have the same week number as
		;the last day of the last week of the previous year
		$idow = $iDow0101 - 1;
		$iDow0101 = _DateToDayOfWeekISO($iYear - 1, 1, 1);
		$iMonth = 12
		$iDay = 31
		$iYear = $iYear - 1
	ElseIf ($iMonth = 12 And 30 - ($iDay - 1) < _DateToDayOfWeekISO($iYear + 1, 1, 1) And _DateToDayOfWeekISO($iYear + 1, 1, 1) < 4) Then
		; days after the last week of the current year have the same week number as
		; the first day of the next year, (i.e. 1)
		Return 1;
	EndIf

	Return Int((_DateToDayOfWeekISO($iYear, 1, 1) < 4) + 4 * ($iMonth - 1) + (2 * ($iMonth - 1) + ($iDay - 1) + $iDow0101 - $idow + 6) * 36 / 256)

EndFunc   ;==>_WeekNumberISO

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: _WeekNumber
; Description ...: Find out the week number of current date OR date given in parameters
; Syntax.........: _WeekNumber([$iYear = @YEAR[, $iMonth = @MON[, $iDay = @MDAY[, $iWeekStart = 1]]]])
; Parameters ....: $iYear      - Year value (default = current year)
;                  $iMonth    - Month value (default = current month)
;                  $iDay       - Day value (default = current day)
;                  $iWeekStart - Week starts from Sunday (1, default) or Monday (2)
; Return values .: Success - Returns week number of given date
;                  Failure - -1  and sets @ERROR to:
;                  | 1 - On faulty parameters
;                  |99 - On non-acceptable weekstart and uses default (Sunday) as starting day
; Author ........: JdeB
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _WeekNumber($iYear = @YEAR, $iMonth = @MON, $iDay = @MDAY, $iWeekStart = 1)
	Local $iDow0101, $iDow0101ny
	Local $iDate, $iStartWeek1, $iEndWeek1, $iEndWeek1Date, $iStartWeek1ny, $iStartWeek1Dateny
	Local $iCurrDateDiff, $iCurrDateDiffny

	; Check for erroneous input in $Day, $Month & $Year
	If $iDay > 31 Or $iDay < 1 Then
		SetError(1)
		Return -1
	ElseIf $iMonth > 12 Or $iMonth < 1 Then
		SetError(1)
		Return -1
	ElseIf $iYear < 1 Or $iYear > 2999 Then
		SetError(1)
		Return -1
	ElseIf $iWeekStart < 1 Or $iWeekStart > 2 Then
		SetError(2)
		Return -1
	EndIf
	;
	;$idow = _DateToDayOfWeekISO($iYear, $iMonth, $iDay);
	$iDow0101 = _DateToDayOfWeekISO($iYear, 1, 1);
	$iDate = $iYear & '/' & $iMonth & '/' & $iDay
	;Calculate the Start and End date of Week 1 this year
	If $iWeekStart = 1 Then
		If $iDow0101 = 6 Then
			$iStartWeek1 = 0
		Else
			$iStartWeek1 = -1 * $iDow0101 - 1
		EndIf
		$iEndWeek1 = $iStartWeek1 + 6
	Else
		$iStartWeek1 = $iDow0101 * - 1
		$iEndWeek1 = $iStartWeek1 + 6
	EndIf
	;$iStartWeek1Date = _DateAdd('d',$iStartWeek1,$iYear & '/01/01')
	$iEndWeek1Date = _DateAdd('d', $iEndWeek1, $iYear & '/01/01')
	;Calculate the Start and End date of Week 1 this Next year
	$iDow0101ny = _DateToDayOfWeekISO($iYear + 1, 1, 1);
	;  1 = start on Sunday / 2 = start on Monday
	If $iWeekStart = 1 Then
		If $iDow0101ny = 6 Then
			$iStartWeek1ny = 0
		Else
			$iStartWeek1ny = -1 * $iDow0101ny - 1
		EndIf
		;$IEndWeek1ny = $iStartWeek1ny + 6
	Else
		$iStartWeek1ny = $iDow0101ny * - 1
		;$IEndWeek1ny = $iStartWeek1ny + 6
	EndIf
	$iStartWeek1Dateny = _DateAdd('d', $iStartWeek1ny, $iYear + 1 & '/01/01')
	;$iEndWeek1Dateny = _DateAdd('d',$IEndWeek1ny,$iYear+1 & '/01/01')
	;number of days after end week 1
	$iCurrDateDiff = _DateDiff('d', $iEndWeek1Date, $iDate) - 1
	;number of days before next week 1 start
	$iCurrDateDiffny = _DateDiff('d', $iStartWeek1Dateny, $iDate)
	;
	; Check for end of year
	If $iCurrDateDiff >= 0 And $iCurrDateDiffny < 0 Then Return 2 + Int($iCurrDateDiff / 7)
	; > week 1
	If $iCurrDateDiff < 0 Or $iCurrDateDiffny >= 0 Then Return 1
EndFunc   ;==>_WeekNumber

; #NO_DOC_FUNCTION# =============================================================================================================
; Name...........: __DaysInMonth
; Description ...: returns an Array that contains the numbers of days per month
; Syntax.........: __DaysInMonth($iYear)
; Parameters ....: $iYear      - Year value
; Return values .: Success - Array that contains the numbers of days per month
;                  Failure - none
; Author ........: Jos van der Zande / Jeremy Landes
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func __DaysInMonth($iYear)
	Local $aiDays
	$aiDays = StringSplit("31,28,31,30,31,30,31,31,30,31,30,31", ",")
	If _DateIsLeapYear($iYear) Then $aiDays[2] = 29
	Return $aiDays
EndFunc   ;==>__DaysInMonth

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _Date_Time_CloneSystemTime
; Description ...: Clones a tagSYSTEMTIME structure
; Syntax.........: _Date_Time_CloneSystemTime($pSystemTime)
; Parameters ....: $pSystemTime - Pointer to a tagSYSTEMTIME structure
; Return values .: Success      - tagSYSTEMTIME structure containing the cloned system time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is used internally by Auto3Lib
; Related .......: $tagSYSTEMTIME
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _Date_Time_CloneSystemTime($pSystemTime)
	Local $tSystemTime1, $tSystemTime2

	$tSystemTime1 = DllStructCreate($tagSYSTEMTIME, $pSystemTime)
	$tSystemTime2 = DllStructCreate($tagSYSTEMTIME)
	DllStructSetData($tSystemTime2, "Month", DllStructGetData($tSystemTime1, "Month"))
	DllStructSetData($tSystemTime2, "Day", DllStructGetData($tSystemTime1, "Day"))
	DllStructSetData($tSystemTime2, "Year", DllStructGetData($tSystemTime1, "Year"))
	DllStructSetData($tSystemTime2, "Hour", DllStructGetData($tSystemTime1, "Hour"))
	DllStructSetData($tSystemTime2, "Minute", DllStructGetData($tSystemTime1, "Minute"))
	DllStructSetData($tSystemTime2, "Second", DllStructGetData($tSystemTime1, "Second"))
	DllStructSetData($tSystemTime2, "MSeconds", DllStructGetData($tSystemTime1, "MSeconds"))
	DllStructSetData($tSystemTime2, "DOW", DllStructGetData($tSystemTime1, "DOW"))
	Return $tSystemTime2
EndFunc   ;==>_Date_Time_CloneSystemTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_CompareFileTime
; Description ...: Compares two file times
; Syntax.........: _Date_Time_CompareFileTime($pFileTime1, $pFileTime2)
; Parameters ....: $pFileTime1  - Pointer to first $tagFILETIME structure
;                  $pFileTime2  - Pointer to second $tagFILETIME structure
; Return values .: Success      - One of the following values:
;                  |-1 - First file time is earlier than second file time
;                  | 0 - First file time is equal to second file time
;                  | 1 - First file time is later than second file time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_CompareFileTime($pFileTime1, $pFileTime2)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "int", "CompareFileTime", "ptr", $pFileTime1, "ptr", $pFileTime2)
	Return SetError(0, 0, $aResult[0])
EndFunc   ;==>_Date_Time_CompareFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_DOSDateTimeToFileTime
; Description ...: Converts MS-DOS date and time values to a file time
; Syntax.........: _Date_Time_DOSDateTimeToFileTime($iFatDate, $iFatTime)
; Parameters ....: $iFatDate    - The MS-DOS date, packed as follows:
;                  |Bits  0- 4 Day of the month (1?31)
;                  |Bits  5- 8 Month (1 = January, 2 = February, and so on)
;                  |Bits  9-15 Year offset from 1980 (add 1980 to get actual year)
;                  $iFatTime     - Ths MS-DOS time, packed as follows:
;                  |Bits  0- 4 Second divided by 2
;                  |Bits  5-10 Minute (0?59)
;                  |Bits 11-15 Hour (0?23 on a 24-hour clock)
; Return values .: Success      - $tagFILETIME structure that receives the converted file time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_FileTimeToDosDateTime, $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_DOSDateTimeToFileTime($iFatDate, $iFatTime)
	Local $pTime, $tTime, $aResult

	$tTime = DllStructCreate($tagFILETIME)
	$pTime = DllStructGetPtr($tTime)
	$aResult = DllCall("Kernel32.dll", "int", "DosDateTimeToFileTime", "ushort", $iFatDate, "ushort", $iFatTime, "ptr", $pTime)
	Return SetError($aResult[0] = 0, 0, $tTime)
EndFunc   ;==>_Date_Time_DOSDateTimeToFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_DOSDateToArray
; Description ...: Decode a DOS date to an array
; Syntax.........: _Date_Time_DOSDateToArray($iDosDate)
; Parameters ....: $iDosDate    - MS-DOS date, packed as follows:
;                  |Bits  0- 4 Day of the month (1?31)
;                  |Bits  5- 8 Month (1 = January, 2 = February, and so on)
;                  |Bits  9-15 Year offset from 1980 (add 1980 to get actual year)
; Return values .: Success      - Array with the following format:
;                  |[0] - Month
;                  |[1] - Day
;                  |[2] - Year
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_DOSTimeToArray
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_DOSDateToArray($iDosDate)
	Local $aDate[3]

	$aDate[0] = BitAND($iDosDate, 0x1F)
	$aDate[1] = BitAND(BitShift($iDosDate, 5), 0x0F)
	$aDate[2] = BitAND(BitShift($iDosDate, 9), 0x3F) + 1980
	Return $aDate
EndFunc   ;==>_Date_Time_DOSDateToArray

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_DOSDateTimeToArray
; Description ...: Decode a DOS date/time to an array
; Syntax.........: _Date_Time_DOSDateTimeToArray($iDosDate, $iDosTime)
; Parameters ....: $iDosDate    - MS-DOS date, packed as follows:
;                  |Bits  0- 4 Day of the month (1?31)
;                  |Bits  5- 8 Month (1 = January, 2 = February, and so on)
;                  |Bits  9-15 Year offset from 1980 (add 1980 to get actual year)
;                  $iDosTime    - MS-DOS date, packed as follows:
;                  |Bits  0- 4 Second divided by 2
;                  |Bits  5-10 Minute (0?59)
;                  |Bits 11-15 Hour (0?23 on a 24-hour clock)
; Return values .: Success      - Array with the following format:
;                  |[0] - Month
;                  |[1] - Day
;                  |[2] - Year
;                  |[3] - Hour
;                  |[4] - Minute
;                  |[5] - Second
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_DOSDateToArray, _Date_Time_DOSTimeToArray
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_DOSDateTimeToArray($iDosDate, $iDosTime)
	Local $aDate[6]

	$aDate[0] = BitAND($iDosDate, 0x1F)
	$aDate[1] = BitAND(BitShift($iDosDate, 5), 0x0F)
	$aDate[2] = BitAND(BitShift($iDosDate, 9), 0x3F) + 1980
	$aDate[5] = BitAND($iDosTime, 0x1F) * 2
	$aDate[4] = BitAND(BitShift($iDosTime, 5), 0x3F)
	$aDate[3] = BitAND(BitShift($iDosTime, 11), 0x1F)
	Return $aDate
EndFunc   ;==>_Date_Time_DOSDateTimeToArray

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_DOSDateTimeToStr
; Description ...: Decode a DOS date to a string
; Syntax.........: _Date_Time_DOSDateTimeToStr($iDosDate, $iDosTime)
; Parameters ....: $iDosDate    - MS-DOS date, packed as follows:
;                  |Bits  0- 4 Day of the month (1?31)
;                  |Bits  5- 8 Month (1 = January, 2 = February, and so on)
;                  |Bits  9-15 Year offset from 1980 (add 1980 to get actual year)
;                  $iDosTime    - MS-DOS date, packed as follows:
;                  |Bits  0- 4 Second divided by 2
;                  |Bits  5-10 Minute (0?59)
;                  |Bits 11-15 Hour (0?23 on a 24-hour clock)
; Return values .: Success      - Date/time string formatted as mm/dd/yyyy hh:mm:ss
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_DOSDateToStr, _Date_Time_DOSTimeToStr
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_DOSDateTimeToStr($iDosDate, $iDosTime)
	Local $aDate

	$aDate = _Date_Time_DOSDateTimeToArray($iDosDate, $iDosTime)
	Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $aDate[0], $aDate[1], $aDate[2], $aDate[3], $aDate[4], $aDate[5])
EndFunc   ;==>_Date_Time_DOSDateTimeToStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_DOSDateToStr
; Description ...: Decode a DOS date to a string
; Syntax.........: _Date_Time_DOSDateToStr($iDosDate)
; Parameters ....: $iDosDate    - MS-DOS date, packed as follows:
;                  |Bits  0- 4 Day of the month (1?31)
;                  |Bits  5- 8 Month (1 = January, 2 = February, and so on)
;                  |Bits  9-15 Year offset from 1980 (add 1980 to get actual year)
; Return values .: Success      - Date string formatted as mm/dd/yyyy
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_DOSTimeToStr
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_DOSDateToStr($iDosDate)
	Local $aDate

	$aDate = _Date_Time_DOSDateToArray($iDosDate)
	Return StringFormat("%02d/%02d/%04d", $aDate[0], $aDate[1], $aDate[2])
EndFunc   ;==>_Date_Time_DOSDateToStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_DOSTimeToArray
; Description ...: Decode a DOS time to an array
; Syntax.........: _Date_Time_DOSTimeToArray($iDosTime)
; Parameters ....: $iDosTime    - MS-DOS date, packed as follows:
;                  |Bits  0- 4 Second divided by 2
;                  |Bits  5-10 Minute (0?59)
;                  |Bits 11-15 Hour (0?23 on a 24-hour clock)
; Return values .: Success      - Array with the following format:
;                  |[0] - Hour
;                  |[1] - Minute
;                  |[2] - Second
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_DOSDateToArray
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_DOSTimeToArray($iDosTime)
	Local $aTime[3]

	$aTime[2] = BitAND($iDosTime, 0x1F) * 2
	$aTime[1] = BitAND(BitShift($iDosTime, 5), 0x3F)
	$aTime[0] = BitAND(BitShift($iDosTime, 11), 0x1F)
	Return $aTime
EndFunc   ;==>_Date_Time_DOSTimeToArray

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_DOSTimeToStr
; Description ...: Decode a DOS time to a string
; Syntax.........: _Date_Time_DOSTimeToStr($iDosTime)
; Parameters ....: $iDosTime    - MS-DOS date, packed as follows:
;                  |Bits  0- 4 Second divided by 2
;                  |Bits  5-10 Minute (0?59)
;                  |Bits 11-15 Hour (0?23 on a 24-hour clock)
; Return values .: Success       - Time string formatted as hh:mm:ss
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_DOSDateToStr
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_DOSTimeToStr($iDosTime)
	Local $aTime

	$aTime = _Date_Time_DOSTimeToArray($iDosTime)
	Return StringFormat("%02d:%02d:%02d", $aTime[0], $aTime[1], $aTime[2])
EndFunc   ;==>_Date_Time_DOSTimeToStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_EncodeFileTime
; Description ...: Encodes and returns a $tagFILETIME structure
; Syntax.........: _Date_Time_EncodeFileTime($iMonth, $iDay, $iYear[, $iHour = 0[, $iMinute = 0[, $iSecond = 0[, $iMSeconds = 0]]]])
; Parameters ....: $iMonth      - Month
;                  $iDay        - Day
;                  $iYear       - Year
;                  $iHour       - Hour
;                  $iMinute     - Minute
;                  $iSecond     - Second
;                  $iMSeconds   - Milliseconds
; Return values .: Return       - $tagFILETIME structure
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_EncodeSystemTime, $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_EncodeFileTime($iMonth, $iDay, $iYear, $iHour = 0, $iMinute = 0, $iSecond = 0, $iMSeconds = 0)
	Local $tSystemTime

	$tSystemTime = _Date_Time_EncodeSystemTime($iMonth, $iDay, $iYear, $iHour, $iMinute, $iSecond, $iMSeconds)
	Return _Date_Time_SystemTimeToFileTime(DllStructGetPtr($tSystemTime))
EndFunc   ;==>_Date_Time_EncodeFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_EncodeSystemTime
; Description ...: Encodes and returns a $tagSYSTEMTIME structure
; Syntax.........: _Date_Time_EncodeSystemTime($iMonth, $iDay, $iYear[, $iHour = 0[, $iMinute = 0[, $iSecond = 0[, $iMSeconds = 0]]]])
; Parameters ....: $iMonth      - Month
;                  $iDay        - Day
;                  $iYear       - Year
;                  $iHour       - Hour
;                  $iMinute     - Minute
;                  $iSecond     - Second
;                  $iMSecond    - Milliseconds
; Return values .: Success      - $tagSYSTEMTIME structure
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_EncodeFileTime, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_EncodeSystemTime($iMonth, $iDay, $iYear, $iHour = 0, $iMinute = 0, $iSecond = 0, $iMSeconds = 0)
	Local $tSystemTime

	$tSystemTime = DllStructCreate($tagSYSTEMTIME)
	DllStructSetData($tSystemTime, "Month", $iMonth)
	DllStructSetData($tSystemTime, "Day", $iDay)
	DllStructSetData($tSystemTime, "Year", $iYear)
	DllStructSetData($tSystemTime, "Hour", $iHour)
	DllStructSetData($tSystemTime, "Minute", $iMinute)
	DllStructSetData($tSystemTime, "Second", $iSecond)
	DllStructSetData($tSystemTime, "MSeconds", $iMSeconds)
	Return $tSystemTime
EndFunc   ;==>_Date_Time_EncodeSystemTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_FileTimeToArray
; Description ...: Decode a file time to an array
; Syntax.........: _Date_Time_FileTimeToArray(ByRef $tFileTime)
; Parameters ....: $tFileTime   - $tagFILETIME structure
; Return values .: Success      - Array with the following format:
;                  |[0] - Month
;                  |[1] - Day
;                  |[2] - Year
;                  |[3] - Hour
;                  |[4] - Minutes
;                  |[5] - Seconds
;                  |[6] - Milliseconds
;                  |[7] - Day of week
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_FileTimeToArray(ByRef $tFileTime)
	Local $tSystemTime

	$tSystemTime = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($tFileTime))
	Return _Date_Time_SystemTimeToArray($tSystemTime)
EndFunc   ;==>_Date_Time_FileTimeToArray

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_FileTimeToStr
; Description ...: Decode a file time to a date/time string
; Syntax.........: _Date_Time_FileTimeToStr(ByRef $tFileTime)
; Parameters ....: $tFileTime   - $tagFILETIME structure
; Return values .: Success      - Date/time string formatted as mm/dd/yyyy hh:mm:ss
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_FileTimeToStr(ByRef $tFileTime)
	Local $aDate

	$aDate = _Date_Time_FileTimeToArray($tFileTime)
	Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $aDate[0], $aDate[1], $aDate[2], $aDate[3], $aDate[4], $aDate[5])
EndFunc   ;==>_Date_Time_FileTimeToStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_FileTimeToDOSDateTime
; Description ...: Converts MS-DOS date and time values to a file time
; Syntax.........: _Date_Time_FileTimeToDOSDateTime($pFileTime)
; Parameters ....: $pFileTime   - Pointer to a $tagFILETIME structure containing the file time to convert to MS-DOS format
; Return values .: Success      - Array with the following format:
;                  |[0] - MS-DOS date, packed as follows:
;                  | Bits  0- 4 Day of the month (1?31)
;                  | Bits  5- 8 Month (1 = January, 2 = February, and so on)
;                  | Bits  9-15 Year offset from 1980 (add 1980 to get actual year)
;                  |[1] - MS-DOS time, packed as follows:
;                  | Bits  0- 4 Second divided by 2
;                  | Bits  5-10 Minute (0?59)
;                  | Bits 11-15 Hour (0?23 on a 24-hour clock)
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_FileTimeToLocalFileTime, _Date_Time_FileTimeToSystemTime, $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_FileTimeToDOSDateTime($pFileTime)
	Local $aDate[2], $aResult

	$aResult = DllCall("Kernel32.dll", "int", "FileTimeToDosDateTime", "ptr", $pFileTime, "int*", 0, "int*", 0)
	$aDate[0] = $aResult[2]
	$aDate[1] = $aResult[3]
	Return SetError($aResult[0] = 0, 0, $aDate)
EndFunc   ;==>_Date_Time_FileTimeToDOSDateTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_FileTimeToLocalFileTime
; Description ...: Converts a file time based on the Coordinated Universal Time to a local file time
; Syntax.........: _Date_Time_FileTimeToLocalFileTime($pFileTime)
; Parameters ....: $pFileTime   - Pointer to a $tagFILETIME structure containing the UTC based file time to be converted into a
;                  +local file time.
; Return values .: Success      - $tagFILETIME structure that contains the converted local file time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_FileTimeToDosDateTime, _Date_Time_FileTimeToSystemTime, $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_FileTimeToLocalFileTime($pFileTime)
	Local $tLocal, $aResult

	$tLocal = DllStructCreate($tagFILETIME)
	$aResult = DllCall("Kernel32.dll", "int", "FileTimeToLocalFileTime", "ptr", $pFileTime, "ptr", DllStructGetPtr($tLocal))
	Return SetError($aResult[0] = 0, 0, $tLocal)
EndFunc   ;==>_Date_Time_FileTimeToLocalFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_FileTimeToSystemTime
; Description ...: Converts a file time to system time format
; Syntax.........: _Date_Time_FileTimeToSystemTime($pFileTime)
; Parameters ....: $pFileTime   - Pointer to a $tagFILETIME structure containing the file time to convert to system date and time
;                  +format.
; Return values .: Success      - $tagSYSTEMTIME structure that contains the converted file time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_FileTimeToDosDateTime, _Date_Time_FileTimeToLocalFileTime, $tagFILETIME, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_FileTimeToSystemTime($pFileTime)
	Local $tSystTime, $aResult

	$tSystTime = DllStructCreate($tagSYSTEMTIME)
	$aResult = DllCall("Kernel32.dll", "int", "FileTimeToSystemTime", "ptr", $pFileTime, "ptr", DllStructGetPtr($tSystTime))
	Return SetError($aResult[0] = 0, 0, $tSystTime)
EndFunc   ;==>_Date_Time_FileTimeToSystemTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_GetFileTime
; Description ...: Retrieves the date and time that a file was created, accessed and modified
; Syntax.........: _Date_Time_GetFileTime($hFile)
; Parameters ....: $hFile       - Handle to the file for which dates and times are to be retrieved.  The file handle must have
;                  +been created using the CreateFile function with the GENERIC_READ access right.
; Return values .: Success      - Array with the following format:
;                  |[0] - $tagFILETIME structure with the date and time the file was created
;                  |[1] - $tagFILETIME structure with the date and time the file was accessed
;                  |[2] - $tagFILETIME structure with the date and time the file was modified
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Not all file systems can record creation and last access times and not all file systems  record  them  in  the
;                  same manner. For example, on FAT, create time has a resolution of 10 milliseconds, write time has a resolution
;                  of 2 seconds, and access time has a resolution of 1 day (really, the access date).  Therefore, the GetFileTime
;                  function may not return the same file time information set using SetFileTime.  NTFS delays updates to the last
;                  access time for a file by up to one hour after the last access.
; Related .......: _Date_Time_SetFileTime, $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_GetFileTime($hFile)
	Local $pCT, $pLA, $pLM, $aDate[3], $aResult

	$aDate[0] = DllStructCreate($tagFILETIME)
	$aDate[1] = DllStructCreate($tagFILETIME)
	$aDate[2] = DllStructCreate($tagFILETIME)
	$pCT = DllStructGetPtr($aDate[0])
	$pLA = DllStructGetPtr($aDate[1])
	$pLM = DllStructGetPtr($aDate[2])
	$aResult = DllCall("Kernel32.dll", "int", "GetFileTime", "hwnd", $hFile, "ptr", $pCT, "ptr", $pLA, "ptr", $pLM)
	Return SetError($aResult[0] = 0, 0, $aDate)
EndFunc   ;==>_Date_Time_GetFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_GetLocalTime
; Description ...: Retrieves the current local date and time
; Syntax.........: _Date_Time_GetLocalTime()
; Parameters ....:
; Return values .: Success      - $tagSYSTEMTIME structure with the current local date and time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_SetLocalTime, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_GetLocalTime()
	Local $tSystTime

	$tSystTime = DllStructCreate($tagSYSTEMTIME)
	DllCall("Kernel32.dll", "none", "GetLocalTime", "ptr", DllStructGetPtr($tSystTime))
	Return $tSystTime
EndFunc   ;==>_Date_Time_GetLocalTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_GetSystemTime
; Description ...: Retrieves the current system date and time expressed in UTC
; Syntax.........: _Date_Time_GetSystemTime()
; Parameters ....:
; Return values .: Success      - $tagSYSTEMTIME structure with the current system date and time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_SetSystemTime, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_GetSystemTime()
	Local $tSystTime

	$tSystTime = DllStructCreate($tagSYSTEMTIME)
	DllCall("Kernel32.dll", "none", "GetSystemTime", "ptr", DllStructGetPtr($tSystTime))
	Return $tSystTime
EndFunc   ;==>_Date_Time_GetSystemTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_GetSystemTimeAdjustment
; Description ...: Determines whether the system is applying periodic time adjustments
; Syntax.........: _Date_Time_GetSystemTimeAdjustment()
; Parameters ....:
; Return values .: Success      - Array with the following format:
;                  |[1] - The number of 100 nanosecond units added to the clock at each periodic time adjustment
;                  |[2] - The number of 100 nanosecond units between periodic time adjustments.  This interval is the time period
;                  +between a system's clock interrupts.
;                  |[3] -  True indicates that periodic time adjustment is disabled.  At each clock interrupt, the  system merely
;                  +adds the interval between clock interrupts to the clock.  If False, periodic time adjustment is being used to
;                  +adjust the clock.
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_SetSystemTimeAdjustment
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_GetSystemTimeAdjustment()
	Local $aInfo[3], $aResult

	$aResult = DllCall("Kernel32.dll", "int", "GetSystemTimeAdjustment", "int*", 0, "int*", 0, "int*", 0)
	$aInfo[0] = $aResult[1]
	$aInfo[1] = $aResult[2]
	$aInfo[2] = $aResult[3] <> 0
	Return SetError($aResult[0] = 0, 0, $aInfo)
EndFunc   ;==>_Date_Time_GetSystemTimeAdjustment

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_GetSystemTimeAsFileTime
; Description ...: Retrieves the current system date and time expressed in UTC
; Syntax.........: _Date_Time_GetSystemTimeAsFileTime()
; Parameters ....:
; Return values .: Success      - $tagFILETIME structure with the current system date and time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_GetSystemTimeAsFileTime()
	Local $tFileTime

	$tFileTime = DllStructCreate($tagFILETIME)
	DllCall("Kernel32.dll", "none", "GetSystemTimeAsFileTime", "ptr", DllStructGetPtr($tFileTime))
	Return $tFileTime
EndFunc   ;==>_Date_Time_GetSystemTimeAsFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_GetSystemTimes
; Description ...: Retrieves system timing information
; Syntax.........: _Date_Time_GetSystemTimes()
; Parameters ....:
; Return values .: Success      - Array with the following format:
;                  |[0] - $tagFILETIME structure with the total system idle time
;                  |[1] - $tagFILETIME structure with the total system kernel mode time
;                  |[2] - $tagFILETIME structure with the total system user mode time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Minimum OS: Windows XP, 2003, Vista or Longhorn
; Related .......: $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_GetSystemTimes()
	Local $pIdle, $pKernel, $pUser, $aInfo[3], $aResult

	$aInfo[0] = DllStructCreate($tagFILETIME)
	$aInfo[1] = DllStructCreate($tagFILETIME)
	$aInfo[2] = DllStructCreate($tagFILETIME)
	$pIdle = DllStructGetPtr($aInfo[0])
	$pKernel = DllStructGetPtr($aInfo[1])
	$pUser = DllStructGetPtr($aInfo[2])
	$aResult = DllCall("Kernel32.dll", "int", "GetSystemTimes", "ptr", $pIdle, "ptr", $pKernel, "ptr", $pUser)
	Return SetError($aResult[0] = 0, 0, $aInfo)
EndFunc   ;==>_Date_Time_GetSystemTimes

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_GetTickCount
; Description ...: Retrieves the number of milliseconds that have elapsed since Windows was started
; Syntax.........: _Date_Time_GetTickCount()
; Parameters ....:
; Return values .: Success      - Number of milliseconds that have elapsed since Windows was started
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: The elapsed time is stored as a DWORD value.  The time will wrap around to zero if Windows is run continuously
;                  for 49.7 days.
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_GetTickCount()
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "int", "GetTickCount")
	Return $aResult[0]
EndFunc   ;==>_Date_Time_GetTickCount

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_GetTimeZoneInformation
; Description ...: Retrieves the current time zone settings
; Syntax.........: _Date_Time_GetTimeZoneInformation()
; Parameters ....:
; Return values .: Success      - Array with the following format:
;                  |[0] - Daylight savings setting. Can be one of the following:
;                  |-1 - Failure
;                  | 0 - Daylight savings time is not used in the current time zone
;                  | 1 - Daylight savings time operating with standard time
;                  | 2 - Daylight savings time operating with daylight savings time
;                  |[1] - The current bias for local time translation on this computer.  The bias is the difference in
;                  +minutes between Coordinated Universal Time (UTC) and local time.  All translations between UTC and local time
;                  +use the following formula: UTC = local time + bias
;                  |[2] - The description for standard time
;                  |[3] - A $tagSYSTEMTIME structure that contains a date and local time when the transition from daylight saving
;                  |+time to standard time occurs.
;                  |[4] - The bias value to be used during local time translations that occur during standard time. This value is
;                  +added to the value of the Bias to form the bias used during standard time.  In most time zones, this value is
;                  |zero.
;                  |[5] - The description for daylight saving time
;                  |[6] - A $tagSYSTEMTIME structure that contains a date and local time when the transition from standard time to
;                  +daylight saving time occurs.
;                  |[7] - The bias value to be used during local time translations that occur during daylight saving  time.  This
;                  +value is added to the value of the Bias member to form the bias used during  daylight  saving  time.  In most
;                  +time zones this value is ?60.
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......:
; Related .......: _Date_Time_SetTimeZoneInformation, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_GetTimeZoneInformation()
	Local $tTimeZone, $aInfo[8], $aResult

	$tTimeZone = DllStructCreate($tagTIME_ZONE_INFORMATION)
	$aResult = DllCall("Kernel32.dll", "int", "GetTimeZoneInformation", "ptr", DllStructGetPtr($tTimeZone))
	$aInfo[0] = $aResult[0]
	$aInfo[1] = DllStructGetData($tTimeZone, "Bias")
	$aInfo[2] = _WinAPI_WideCharToMultiByte(DllStructGetPtr($tTimeZone, "StdName"))
	$aInfo[3] = _Date_Time_CloneSystemTime(DllStructGetPtr($tTimeZone, "StdDate"))
	$aInfo[4] = DllStructGetData($tTimeZone, "StdBias")
	$aInfo[5] = _WinAPI_WideCharToMultiByte(DllStructGetPtr($tTimeZone, "DayName"))
	$aInfo[6] = _Date_Time_CloneSystemTime(DllStructGetPtr($tTimeZone, "DayDate"))
	$aInfo[7] = DllStructGetData($tTimeZone, "DayBias")
	Return $aInfo
EndFunc   ;==>_Date_Time_GetTimeZoneInformation

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_LocalFileTimeToFileTime
; Description ...: Converts a local file time to a file time based on UTC
; Syntax.........: _Date_Time_LocalFileTimeToFileTime($pLocalTime)
; Parameters ....: $pLocalTime  - Pointer to a $tagFILETIME structure that specifies the local file time to be converted into a
;                  +UTC based file time.
; Return values .: Success      - $tagFILETIME structure with the converted UTC based file time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function uses the current settings for the time zone and daylight saving time.  Therefore, if it is
;                  daylight saving time, this function will take daylight saving time into account, even if the time you are
;                  converting is in standard time.
; Related .......: _Date_Time_FileTimeToLocalFileTime, $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_LocalFileTimeToFileTime($pLocalTime)
	Local $tFileTime, $aResult

	$tFileTime = DllStructCreate($tagFILETIME)
	$aResult = DllCall("Kernel32.dll", "int", "LocalFileTimeToFileTime", "ptr", $pLocalTime, "ptr", DllStructGetPtr($tFileTime))
	Return SetError($aResult[0] = 0, 0, $tFileTime)
EndFunc   ;==>_Date_Time_LocalFileTimeToFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SetFileTime
; Description ...: Sets the date and time that a file was created, accessed and modified
; Syntax.........: _Date_Time_SetFileTime($hFile, $pCreateTime, $pLastAccess, $pLastWrite)
; Parameters ....: $hFile       - Handle to the file.  The file handle must have been created using the CreateFile function with
;                  +the FILE_WRITE_ATTRIBUTES access right.
;                  $pCreateTime - Pointer to a $tagFILETIME structure that contains the new date and time the file was created.
;                  +This be 0 if the application does not need to set this information.
;                  $pLastAccess - Pointer to a $tagFILETIME structure that contains the new date and time the file was last
;                  +accessed.  The last access time includes the last time the file was written to, read from, or (in the case of
;                  +executable files) run. This can be 0 if the application does not need to set this  information.  To preserve
;                  +the existing last access time for a file even after accessing a file, call SetFileTime with this parameter
;                  +set to -1 before closing the file handle.
;                  $pLastWrite  - Pointer to a $tagFILETIME structure that contains the new date and time the file was last
;                  +written to. This can be 0 if the application does not want to set this information.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Not all file systems can record creation and last access times and not all file systems record them in the
;                  same manner. For example, on FAT, create time has a resolution of 10 milliseconds, write time has a resolution
;                  of 2 seconds, and access time has a resolution of 1 day (really, the access date).  Therefore, the GetFileTime
;                  function may not return the same file time information set using SetFileTime.  NTFS delays updates to the last
;                  access time for a file by up to one hour after the last access.
; Related .......: _Date_Time_GetFileTime, $tagFILETIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SetFileTime($hFile, $pCreateTime, $pLastAccess, $pLastWrite)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "int", "SetFileTime", "hwnd", $hFile, "ptr", $pCreateTime, "ptr", $pLastAccess, "ptr", $pLastWrite)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SetLocalTime
; Description ...: Sets the current local date and time
; Syntax.........: _Date_Time_SetLocalTime($pSystemTime)
; Parameters ....: $pSystemTime - Pointer to a $tagSYSTEMTIME structure that contains the new local date and time
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: The SetLocalTime function enables the SE_SYSTEMTIME_NAME privilege before changing the local time.
; Related .......: _Date_Time_GetLocalTime, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SetLocalTime($pSystemTime)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "int", "SetLocalTime", "ptr", $pSystemTime)
	If $aResult[0] = 0 Then Return SetError(True, 0, False)
	; The system uses UTC internally.  When you call SetLocalTime, the system uses the current time zone information to perform the
	; conversion, incuding the daylight saving time setting.  The system uses the daylight saving time setting of the current time,
	; not the new time you are setting.  This is a "feature" according to Microsoft.  In order to get around this, we have to  call
	; the function twice. The first call sets the internal time zone and the second call sets the actual time.
	$aResult = DllCall("Kernel32.dll", "int", "SetLocalTime", "ptr", $pSystemTime)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetLocalTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SetSystemTime
; Description ...: Sets the current system time and date, expressed in UTC
; Syntax.........: _Date_Time_SetSystemTime($pSystemTime)
; Parameters ....: $pSystemTime - Pointer to a $tagSYSTEMTIME structure that contains the new system date and time
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: The SetLocalTime function enables the SE_SYSTEMTIME_NAME privilege before changing the local time
; Related .......: _Date_Time_GetSystemTime, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SetSystemTime($pSystemTime)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "int", "SetSystemTime", "ptr", $pSystemTime)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetSystemTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SetSystemTimeAdjustment
; Description ...: Enables or disables periodic time adjustments to the system's time of day clock
; Syntax.........: _Date_Time_SetSystemTimeAdjustment($iAdjustment, $fDisabled)
; Parameters ....: $iAdjustment - The number of 100 nanosecond units added to the time of day clock at each clock interrupt if
;                  +periodic time adjustment is enabled.
;                  $fDisabled   - A value of True specifies that periodic time  adjustment is to be disabled.  The system is free
;                  +to adjust time of day using its own internal mechanisms.  The system's internal adjustment mechanisms may
;                  +cause the time-of-day clock to jump noticeably when adjustments are made.  A value of False specifies that
;                  +periodic time adjustment is to be enabled, and will be used to adjust the time of day clock.  The system will
;                  +not interfere with the time adjustment scheme, and will not attempt to synchronize time of day on its own.
;                  +The system will add the value of iAdjustment to the time of day at each clock interrupt.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......:
; Related .......: _Date_Time_GetSystemTimeAdjustment
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SetSystemTimeAdjustment($iAdjustment, $fDisabled)
	Local $hToken, $aResult

	; Enable system time privileged mode
	$hToken = _Security__OpenThreadTokenEx(BitOR($__DATECONSTANT_TOKEN_ADJUST_PRIVILEGES, $__DATECONSTANT_TOKEN_QUERY))
	_WinAPI_Check("_Date_Time_SetSystemTimeAjustment:OpenThreadTokenEx", @error, @extended)
	_Security__SetPrivilege($hToken, "SeSystemtimePrivilege", True)
	_WinAPI_Check("_Date_Time_SetSystemTimeAjustment:SetPrivilege:Enable", @error, @extended)

	; Set system time
	$aResult = DllCall("Kernel32.dll", "int", "SetSystemTimeAdjustment", "dword", $iAdjustment, "int", $fDisabled)

	; Disable system time privileged mode
	_Security__SetPrivilege($hToken, "SeSystemtimePrivilege", False)
	_WinAPI_Check("_Date_Time_SetSystemTimeAdjustment:SetPrivilege:Disable", @error, @extended)
	_WinAPI_CloseHandle($hToken)

	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetSystemTimeAdjustment

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SetTimeZoneInformation
; Description ...: Sets the current time zone settings
; Syntax.........: _Date_Time_SetTimeZoneInformation($iBias, $sStdName, $tStdDate, $iStdBias, $sDayName, $tDayDate, $iDayBias)
; Parameters ....: $iBias       - The current bias for local time translation on this computer.  The bias is the difference in
;                  +minutes between Coordinated Universal Time (UTC) and local time.  All translations between UTC and local time
;                  +use the following formula: UTC = local time + bias
;                  $sStdName    - The description for standard time
;                  $tStdDate    - A %tagSYSTEMTIME structure that contains a date and local time when the transition from
;                  +daylight saving time to standard time occurs.
;                  $iStdBias    - The bias value to be used during local time translations that occur during standard time.  This
;                  +value is added to the value of the Bias to form the bias used during standard time.  In most time zones, this
;                  +value is zero.
;                  $sDayName    - The description for daylight saving time
;                  $tDayDate    - A %tagSYSTEMTIME structure that contains a date and local time when the transition from
;                  +standard time to daylight saving time occurs.
;                  $iDayBias    - The bias value to be used during local time translation that occur during daylight saving time.
;                  +This value is added to the value of the Bias member to form the bias used during daylight saving time.  In
;                  +most time zones this value is ?60.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......:
; Related .......: _Date_Time_GetTimeZoneInformation, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SetTimeZoneInformation($iBias, $sStdName, $tStdDate, $iStdBias, $sDayName, $tDayDate, $iDayBias)
	Local $hToken, $tStdName, $tDayName, $tZoneInfo, $aResult

	$tStdName = _WinAPI_MultiByteToWideChar($sStdName)
	$tDayName = _WinAPI_MultiByteToWideChar($sDayName)
	$tZoneInfo = DllStructCreate($tagTIME_ZONE_INFORMATION)
	DllStructSetData($tZoneInfo, "Bias", $iBias)
	DllStructSetData($tZoneInfo, "StdName", DllStructGetData($tStdName, 1))
	_MemMoveMemory(DllStructGetPtr($tStdDate), DllStructGetPtr($tZoneInfo, "StdDate"), DllStructGetSize($tStdDate))
	DllStructSetData($tZoneInfo, "StdBias", $iStdBias)
	DllStructSetData($tZoneInfo, "DayName", DllStructGetData($tDayName, 1))
	_MemMoveMemory(DllStructGetPtr($tDayDate), DllStructGetPtr($tZoneInfo, "DayDate"), DllStructGetSize($tDayDate))
	DllStructSetData($tZoneInfo, "DayBias", $iDayBias)

	; Enable system time privileged mode
	$hToken = _Security__OpenThreadTokenEx(BitOR($__DATECONSTANT_TOKEN_ADJUST_PRIVILEGES, $__DATECONSTANT_TOKEN_QUERY))
	_WinAPI_Check("_Date_Time_SetSystemTimeAjustment:OpenThreadTokenEx", @error, @extended)
	_Security__SetPrivilege($hToken, "SeSystemtimePrivilege", True)
	_WinAPI_Check("_Date_Time_SetSystemTimeAjustment:SetPrivilege:Enable", @error, @extended)

	; Set time zone information
	$aResult = DllCall("Kernel32.dll", "int", "SetTimeZoneInformation", "ptr", DllStructGetPtr($tZoneInfo))

	; Disable system time privileged mode
	_Security__SetPrivilege($hToken, "SeSystemtimePrivilege", False)
	_WinAPI_Check("_Date_Time_SetSystemTimeAdjustment:SetPrivilege:Disable", @error, @extended)
	_WinAPI_CloseHandle($hToken)

	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetTimeZoneInformation

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SystemTimeToArray
; Description ...: Decode a system time to an array
; Syntax.........: _Date_Time_SystemTimeToArray(ByRef $tSystemTime)
; Parameters ....: $tSystemTime - $tagSYSTEMTIME structure
; Return values .: Success      - Array with the following format:
;                  |[0] - Month
;                  |[1] - Day
;                  |[2] - Year
;                  |[3] - Hour
;                  |[4] - Minutes
;                  |[5] - Seconds
;                  |[6] - Milliseconds
;                  |[7] - Day of week
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SystemTimeToArray(ByRef $tSystemTime)
	Local $aInfo[8]

	$aInfo[0] = DllStructGetData($tSystemTime, "Month")
	$aInfo[1] = DllStructGetData($tSystemTime, "Day")
	$aInfo[2] = DllStructGetData($tSystemTime, "Year")
	$aInfo[3] = DllStructGetData($tSystemTime, "Hour")
	$aInfo[4] = DllStructGetData($tSystemTime, "Minute")
	$aInfo[5] = DllStructGetData($tSystemTime, "Second")
	$aInfo[6] = DllStructGetData($tSystemTime, "MSeconds")
	$aInfo[7] = DllStructGetData($tSystemTime, "DOW")
	Return $aInfo
EndFunc   ;==>_Date_Time_SystemTimeToArray

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SystemTimeToDateStr
; Description ...: Decode a system time to a date string
; Syntax.........: _Date_Time_SystemTimeToDateStr(ByRef $tSystemTime)
; Parameters ....: $tSystemTime - $tagSYSTEMTIME structure
; Return values .: Success      - Date string formatted as mm/dd/yyyy
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_SystemTimeToTimeStr, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SystemTimeToDateStr(ByRef $tSystemTime)
	Local $aInfo

	$aInfo = _Date_Time_SystemTimeToArray($tSystemTime)
	Return StringFormat("%02d/%02d/%04d", $aInfo[0], $aInfo[1], $aInfo[2])
EndFunc   ;==>_Date_Time_SystemTimeToDateStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SystemTimeToDateTimeStr
; Description ...: Decode a system time to a date/time string
; Syntax.........: _Date_Time_SystemTimeToDateTimeStr(ByRef $tSystemTime)
; Parameters ....: $tSystemTime - $tagSYSTEMTIME structure
; Return values .: Success      - Date/time string formatted as mm/dd/yyyy hh:nn:ss
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_SystemTimeToDateStr, _Date_Time_SystemTimeToTimeStr, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SystemTimeToDateTimeStr(ByRef $tSystemTime)
	Local $aInfo

	$aInfo = _Date_Time_SystemTimeToArray($tSystemTime)
	Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $aInfo[0], $aInfo[1], $aInfo[2], $aInfo[3], $aInfo[4], $aInfo[5])
EndFunc   ;==>_Date_Time_SystemTimeToDateTimeStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SystemTimeToFileTime
; Description ...: Converts a system time to file time format
; Syntax.........: _Date_Time_SystemTimeToFileTime($pSystemTime)
; Parameters ....: $pSystemTime - Pointer to a $tagSYSTEMTIME structure to be converted.
; Return values .: Success      - $tagFILETIME array that contains the converted file time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: $tagFILETIME, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SystemTimeToFileTime($pSystemTime)
	Local $tFileTime, $aResult

	$tFileTime = DllStructCreate($tagFILETIME)
	$aResult = DllCall("Kernel32.dll", "int", "SystemTimeToFileTime", "ptr", $pSystemTime, "ptr", DllStructGetPtr($tFileTime))
	Return SetError($aResult[0] = 0, 0, $tFileTime)
EndFunc   ;==>_Date_Time_SystemTimeToFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SystemTimeToTimeStr
; Description ...: Decode a system time to a time string
; Syntax.........: _Date_Time_SystemTimeToTimeStr(ByRef $tSystemTime)
; Parameters ....: $tSystemTime - $tagSYSTEMTIME structure
; Return values .: Success      - Time string formatted as hh:mm:ss
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Date_Time_SystemTimeToDateStr, $tagSYSTEMTIME
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SystemTimeToTimeStr(ByRef $tSystemTime)
	Local $aInfo

	$aInfo = _Date_Time_SystemTimeToArray($tSystemTime)
	Return StringFormat("%02d:%02d:%02d", $aInfo[3], $aInfo[4], $aInfo[5])
EndFunc   ;==>_Date_Time_SystemTimeToTimeStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_SystemTimeToTzSpecificLocalTime
; Description ...: Converts a UTC time to a specified time zone's corresponding local time
; Syntax.........: _Date_Time_SystemTimeToTzSpecificLocalTime($pUTC[, $pTimeZone = 0])
; Parameters ....: $pUTC        - Pointer to a $tagSYSTEMTIME structure that specifies a time, in UTC. The function converts this
;                  +time to the specified time zone's local time.
;                  $pTimeZone   - Pointer to a $tagTIME_ZONE_INFORMATION structure that specifies the time zone of interest.  If
;                  +0, the function uses the currently active time zone.
; Return values .: Success      - $tagSYSTEMTIME containing the local time
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: $tagSYSTEMTIME, $tagTIME_ZONE_INFORMATION
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_SystemTimeToTzSpecificLocalTime($pUTC, $pTimeZone = 0)
	Local $tLocalTime, $aResult

	$tLocalTime = DllStructCreate($tagSYSTEMTIME)
	$aResult = DllCall("Kernel32.dll", "int", "SystemTimeToTzSpecificLocalTime", "ptr", $pTimeZone, "ptr", $pUTC, "ptr", DllStructGetPtr($tLocalTime))
	Return SetError($aResult[0] = 0, 0, $tLocalTime)
EndFunc   ;==>_Date_Time_SystemTimeToTzSpecificLocalTime

; #FUNCTION# ====================================================================================================================
; Name...........: _Date_Time_TzSpecificLocalTimeToSystemTime
; Description ...: Converts a local time to a time in UTC
; Syntax.........: _Date_Time_TzSpecificLocalTimeToSystemTime($pLocalTime[, $pTimeZone = 0])
; Parameters ....: $pLocalTime  - Pointer to a $tagSYSTEMTIME structure that specifies a local time.  The function converts this
;                  +time to the corresponding UTC time.
;                  $pTimeZone   - Pointer to a $tagTIME_ZONE_INFORMATION structure that specifies the time zone of interest.  If
;                  +0, the function uses the currently active time zone.
; Return values .: Success      - $tagSYSTEMTIME containing the time in UTC
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: $tagSYSTEMTIME, $tagTIME_ZONE_INFORMATION
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Date_Time_TzSpecificLocalTimeToSystemTime($pLocalTime, $pTimeZone = 0)
	Local $tUTC, $aResult

	$tUTC = DllStructCreate($tagSYSTEMTIME)
	$aResult = DllCall("Kernel32.dll", "int", "TzSpecificLocalTimeToSystemTime", "ptr", $pTimeZone, "ptr", $pLocalTime, "ptr", DllStructGetPtr($tUTC))
	Return SetError($aResult[0] = 0, 0, $tUTC)
EndFunc   ;==>_Date_Time_TzSpecificLocalTimeToSystemTime
