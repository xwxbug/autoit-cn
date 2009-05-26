#include-once

#include <WinAPI.au3>
#include <StructureConstants.au3>
#include <Date.au3>
#include <Security.au3>


; #INDEX# =======================================================================================================================
; Title .........: Event_Log
; AutoIt Version : 3.2.3++
; Language ......: English
; Description ...: Functions that assist Windows System logs.
; Description ...: When an error occurs, the system administrator or support technicians must determine what  caused  the  error,
;                  attempt to recover any lost data, and prevent the error from recurring.  It is helpful  if  applications,  the
;                  operating system, and other system services record important events such as low-memory conditions or excessive
;                  attempts to access a disk.  Then the system administrator can  use  the  event  log  to  help  determine  what
;                  conditions caused the error and the context in which it occurred.  By periodically viewing the event log,  the
;                  system administrator may be able to identify problems (such as a failing hard drive) before they cause damage.
; Author(s) .....: Paul Campbell (PaulIA), Gary Frost
; Dll ...........: AdvAPI32.dll
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $gsSourceName
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $EVENTLOG_SUCCESS = 0x00000000
Global Const $EVENTLOG_ERROR_TYPE = 0x00000001
Global Const $EVENTLOG_WARNING_TYPE = 0x00000002
Global Const $EVENTLOG_INFORMATION_TYPE = 0x00000004
Global Const $EVENTLOG_AUDIT_SUCCESS = 0x00000008
Global Const $EVENTLOG_AUDIT_FAILURE = 0x00000010
Global Const $EVENTLOG_SEQUENTIAL_READ = 0x00000001
Global Const $EVENTLOG_SEEK_READ = 0x00000002
Global Const $EVENTLOG_FORWARDS_READ = 0x00000004
Global Const $EVENTLOG_BACKWARDS_READ = 0x00000008

Global Const $__EVENTLOG_LOAD_LIBRARY_AS_DATAFILE = 0x02
Global Const $__EVENTLOG_FORMAT_MESSAGE_FROM_HMODULE = 0x0800
Global Const $__EVENTLOG_FORMAT_MESSAGE_IGNORE_INSERTS = 0x0200
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_EventLog__Backup
;_EventLog__Clear
;_EventLog__Close
;_EventLog__Count
;_EventLog__DeregisterSource
;_EventLog__Full
;_EventLog__Notify
;_EventLog__Oldest
;_EventLog__Open
;_EventLog__OpenBackup
;_EventLog__Read
;_EventLog__RegisterSource
;_EventLog__Report
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
;__EventLog_DecodeCategory
;__EventLog_DecodeComputer
;__EventLog_DecodeData
;__EventLog_DecodeDate
;__EventLog_DecodeDesc
;__EventLog_DecodeEventID
;__EventLog_DecodeSource
;__EventLog_DecodeStrings
;__EventLog_DecodeTime
;__EventLog_DecodeTypeStr
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Backup
; Description ...: Saves the event log to a backup file
; Syntax.........: _EventLog__Backup($hEventLog, $sFileName)
; Parameters ....: $hEventLog   - Handle to the event log
;                  $sFileName   - The name of the backup file
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: The function does not clear the event log.  The function fails if the user does not  have  the  SE_BACKUP_NAME
;                  privilege.
; Related .......: _EventLog__OpenBackup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Backup($hEventLog, $sFileName)
	Local $aResult

	$aResult = DllCall("AdvAPI32.dll", "int", "BackupEventLogA", "hwnd", $hEventLog, "str", $sFileName)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_EventLog__Backup

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Clear
; Description ...: Clears the event log
; Syntax.........: _EventLog__Clear($hEventLog, $sFileName)
; Parameters ....: $hEventLog   - Handle to the event log
;                  $sFileName   - The name of the backup file. If the name is blank, the current event log is not backed up.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function fails if the event log is empty or a file already exists with the same name as sFileName.  After
;                  this function returns, any handles that reference the cleared event log cannot be used to read the log.
; Related .......: _EventLog__Open
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Clear($hEventLog, $sFileName)
	Local $aResult, $fTemp = False

	If StringLen($sFileName) = 0 Then
		$sFileName = @TempDir & "\_EventLog_tempbackup.bak"
		$fTemp = True
	EndIf
	$aResult = DllCall("Advapi32.dll", "int", "ClearEventLogA", "hwnd", $hEventLog, "str", $sFileName)
	If $fTemp Then FileDelete($sFileName)
	Return $aResult[0] <> 0
EndFunc   ;==>_EventLog__Clear

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Close
; Description ...: Closes a read handle to the event log
; Syntax.........: _EventLog__Close($hEventLog)
; Parameters ....: $hEventLog   - Handle to the event log
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......:
; Related .......: _EventLog__Open, _EventLog__Notify, _EventLog__OpenBackup, _EventLog__Read, _EventLog__Report
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Close($hEventLog)
	Local $aResult

	$aResult = DllCall("AdvAPI32.dll", "int", "CloseEventLog", "hwnd", $hEventLog)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_EventLog__Close

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Count
; Description ...: Retrieves the number of records in the event log
; Syntax.........: _EventLog__Count($hEventLog)
; Parameters ....: $hEventLog   - A handle to the event log
; Return values .: Success      - Number of records in the event log
;                  Failure      - -1
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: The oldest record in an event log is not necessarily record number 1.  To determine the record number  of  the
;                  oldest record in an event log, use the _EventLog__Oldest function.
; Related .......: _EventLog__Oldest, _EventLog__Full
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Count($hEventLog)
	Local $tRecords, $aResult

	$tRecords = DllStructCreate("int")
	$aResult = DllCall("AdvAPI32.dll", "int", "GetNumberOfEventLogRecords", "hwnd", $hEventLog, "ptr", DllStructGetPtr($tRecords))
	If $aResult[0] = 0 Then DllStructSetData($tRecords, 1, -1)
	Return SetError($aResult[0] = 0, 0, DllStructGetData($tRecords, 1))
EndFunc   ;==>_EventLog__Count

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeCategory
; Description ...: Decodes an event category for an event record
; Syntax.........: __EventLog_DecodeCategory($tEventLog)
; Parameters ....: $tEventLog   - tagEVENTLOGRECORD structure
; Return values .: Success      - Event category
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeCategory($tEventLog)
	Return DllStructGetData($tEventLog, "EventCategory")
EndFunc   ;==>__EventLog_DecodeCategory

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeComputer
; Description ...: Decodes the computer name from an event log record
; Syntax.........: __EventLog_DecodeComputer($tEventLog)
; Parameters ....: $tEventLog   - tagEVENTLOGRECORD structure
; Return values .: Success      - Computer name
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeComputer($tEventLog)
	Local $tBuffer, $iOffset, $iLength

	; The buffer length doesn't need to extend past UserSidOffset since
	; the string appears before that.
	$iLength = (DllStructGetPtr($tEventLog) + _
		DllStructGetData($tEventLog, "UserSidOffset")) - 1
	; This points to the start of the variable length data.
	$iOffset = DllStructGetPtr($tEventLog) + DllStructGetSize($tEventLog)
	; Offset the buffer with the Source string length which appears right
	; before the Computer name.
	$iOffset += StringLen(__EventLog_DecodeSource($tBuffer)) + 1
	; Adjust the length to be a difference instead of absolute address.
	$iLength -= $iOffset
	; Adjust the buffer to point to the start of the Computer string.
	$tBuffer = DllStructCreate("char Text[" & $iLength & "]", $iOffset)
	Return DllStructGetData($tBuffer, "Text")
EndFunc   ;==>__EventLog_DecodeComputer

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeData
; Description ...: Decodes the event specific binary data from an event log record
; Syntax.........: __EventLog_DecodeData($tEventLog)
; Parameters ....: $tEventLog   - tagEVENTLOGRECORD structure
; Return values .: Success      - Array with the following format:
;                  |[0] - Number of bytes in array
;                  |[1] - Byte 1
;                  |[2] - Byte 2
;                  |[n] - Byte n
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeData($tEventLog)
	Local $iI, $pEventLog, $tBuffer, $iOffset, $iLength

	$pEventLog = DllStructGetPtr($tEventLog)
	$iOffset = DllStructGetData($tEventLog, "DataOffset")
	$iLength = DllStructGetData($tEventLog, "DataLength")
	$tBuffer = DllStructCreate("byte[" & $iLength & "]", $pEventLog + $iOffset)
	Local $aData[$iLength + 1]
	$aData[0] = $iLength
	For $iI = 1 To $iLength
		$aData[$iI] = DllStructGetData($tBuffer, 1, $iI)
	Next
	Return $aData
EndFunc   ;==>__EventLog_DecodeData

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeDate
; Description ...: Converts an event log time to a date string
; Syntax.........: __EventLog_DecodeDate($iEventTime)
; Parameters ....: $iEventTime  - Event log time to be converted
; Return values .: Success      - Date string in the format of mm/dd/yyyy
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeDate($iEventTime)
	Local $pInt64, $tInt64, $iMonth, $iDay, $iYear, $tFileTime, $tLocalTime, $tSystTime

	$tInt64 = DllStructCreate("int64")
	$pInt64 = DllStructGetPtr($tInt64)
	$tFileTime = DllStructCreate($tagFILETIME, $pInt64)
	DllStructSetData($tInt64, 1, ($iEventTime * 10000000) + 116444736000000000)
	$tLocalTime = _Date_Time_FileTimeToLocalFileTime(DllStructGetPtr($tFileTime))
	$tSystTime = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($tLocalTime))
	$iMonth = DllStructGetData($tSystTime, "Month")
	$iDay = DllStructGetData($tSystTime, "Day")
	$iYear = DllStructGetData($tSystTime, "Year")
	Return StringFormat("%02d/%02d/%04d", $iMonth, $iDay, $iYear)
EndFunc   ;==>__EventLog_DecodeDate

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeDesc
; Description ...: Decodes the description strings for an event record
; Syntax.........: __EventLog_DecodeDesc($tEventLog)
; Parameters ....: $tEventLog   - tagEVENTLOGRECORD structure
; Return values .: Success      - Description
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeDesc($tEventLog)
	Local $iI, $sKey, $hDLL, $iEventID, $iFlags, $sSource, $aMsgDLL, $sDesc, $pBuffer, $tBuffer, $aStrings

	$aStrings = __EventLog_DecodeStrings($tEventLog)
	$sSource = __EventLog_DecodeSource($tEventLog)
	$iEventID = DllStructGetData($tEventLog, "EventID")
	$sKey = "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\" & $gsSourceName & "\" & $sSource
	$aMsgDLL = StringSplit(_WinAPI_ExpandEnvironmentStrings(RegRead($sKey, "EventMessageFile")), ";")

	$sDesc = ""
	For $iI = 1 To $aMsgDLL[0]
		$hDLL = _WinAPI_LoadLibraryEx($aMsgDLL[$iI], $__EVENTLOG_LOAD_LIBRARY_AS_DATAFILE)
		If $hDLL = 0 Then ContinueLoop
		$tBuffer = DllStructCreate("char Text[4096]")
		$pBuffer = DllStructGetPtr($tBuffer)
		$iFlags = BitOR($__EVENTLOG_FORMAT_MESSAGE_FROM_HMODULE, $__EVENTLOG_FORMAT_MESSAGE_IGNORE_INSERTS)
		_WinAPI_FormatMessage($iFlags, $hDLL, $iEventID, 0, $pBuffer, 4096, 0)
		_WinAPI_FreeLibrary($hDLL)
		$sDesc &= DllStructGetData($tBuffer, "Text")
	Next

	If $sDesc = "" Then
		For $iI = 1 To $aStrings[0]
			$sDesc &= $aStrings[$iI]
		Next
	Else
		For $iI = 1 To $aStrings[0]
			$sDesc = StringReplace($sDesc, "%" & $iI, $aStrings[$iI])
		Next
	EndIf
	Return StringStripWS($sDesc, 3)
EndFunc   ;==>__EventLog_DecodeDesc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeEventID
; Description ...: Decodes an event ID for an event record
; Syntax.........: __EventLog_DecodeEventID($tEventLog)
; Parameters ....: $tEventLog   - tagEVENTLOGRECORD structure
; Return values .: Success      - Event ID
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeEventID($tEventLog)
	Return BitAND(DllStructGetData($tEventLog, "EventID"), 0x7FFF)
EndFunc   ;==>__EventLog_DecodeEventID

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeSource
; Description ...: Decodes the event source from an event log record
; Syntax.........: __EventLog_DecodeSource($tEventLog)
; Parameters ....: $tEventLog   - tagEVENTLOGRECORD structure
; Return values .: Success      - Source name
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeSource($tEventLog)
	Local $tBuffer, $iOffset, $iLength

	; The buffer length doesn't need to extend past UserSidOffset since
	; the string appears before that.
	$iLength = (DllStructGetPtr($tEventLog) + _
		DllStructGetData($tEventLog, "UserSidOffset")) - 1
	; This points to the start of the variable length data.
	$iOffset = DllStructGetPtr($tEventLog) + DllStructGetSize($tEventLog)
	; Adjust the length to be a difference instead of absolute address.
	$iLength -= $iOffset
	; Initialize the buffer to the start of the variable length data
	$tBuffer = DllStructCreate("char Text[" & $iLength & "]", $iOffset)
	Return DllStructGetData($tBuffer, "Text")
EndFunc   ;==>__EventLog_DecodeSource

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeStrings
; Description ...: Decodes the insertion strings from an event log record
; Syntax.........: __EventLog_DecodeStrings($tEventLog)
; Parameters ....: $tEventLog   - tagEVENTLOGRECORD structure
; Return values .: Success      - Array with the following format:
;                  |[0] - Number of strings in array
;                  |[1] - String 1
;                  |[2] - String 2
;                  |[n] - String n
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeStrings($tEventLog)
	Local $iI, $tBuffer, $iNumStrs, $iOffset, $iDataOffset

	$iNumStrs = DllStructGetData($tEventLog, "NumStrings")
	$iOffset = DllStructGetPtr($tEventLog) + DllStructGetData($tEventLog, "StringOffset")
	; The data offset is used to calculate buffer sizes.
	$iDataOffset = DllStructGetPtr($tEventLog) + DllStructGetData($tEventLog, "DataOffset")
	$tBuffer = DllStructCreate("char Text[" & $iDataOffset - $iOffset & "]", $iOffset)

	Local $aStrings[$iNumStrs + 1]
	$aStrings[0] = $iNumStrs
	For $iI = 1 To $iNumStrs
		$aStrings[$iI] = DllStructGetData($tBuffer, "Text")
		$iOffset += StringLen($aStrings[$iI]) + 1
		$tBuffer = DllStructCreate("char Text[" & $iDataOffset - $iOffset & "]", $iOffset)
	Next
	Return $aStrings
EndFunc   ;==>__EventLog_DecodeStrings

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeTime
; Description ...: Converts an event log time to a date time
; Syntax.........: __EventLog_DecodeTime($iEventTime)
; Parameters ....: $iEventTime  - Event log time to be converted
; Return values .: Success      - Time string in the format of hh:mm:ss am/pm
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeTime($iEventTime)
	Local $pInt64, $tInt64, $iHours, $iMinutes, $iSeconds, $tFileTime, $tLocalTime, $tSystTime, $sAMPM = "AM"

	$tInt64 = DllStructCreate("int64")
	$pInt64 = DllStructGetPtr($tInt64)
	$tFileTime = DllStructCreate($tagFILETIME, $pInt64)
	DllStructSetData($tInt64, 1, ($iEventTime * 10000000) + 116444736000000000)
	$tLocalTime = _Date_Time_FileTimeToLocalFileTime(DllStructGetPtr($tFileTime))
	$tSystTime = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($tLocalTime))
	$iHours = DllStructGetData($tSystTime, "Hour")
	$iMinutes = DllStructGetData($tSystTime, "Minute")
	$iSeconds = DllStructGetData($tSystTime, "Second")
	If $iHours > 11 Then
		$sAMPM = "PM"
		$iHours = $iHours - 12
	EndIf
	Return StringFormat("%02d:%02d:%02d %s", $iHours, $iMinutes, $iSeconds, $sAMPM)
EndFunc   ;==>__EventLog_DecodeTime

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __EventLog_DecodeTypeStr
; Description ...: Decodes an event type to an event string
; Syntax.........: __EventLog_DecodeTypeStr($iEventType)
; Parameters ....: $iEventType  - Event type
; Return values .: Success      - String indicating the event type
;                  Failure      - Unknown event type ID
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __EventLog_DecodeTypeStr($iEventType)
	Select
		Case $iEventType = $EVENTLOG_SUCCESS
			Return "Success"
		Case $iEventType = $EVENTLOG_ERROR_TYPE
			Return "Error"
		Case $iEventType = $EVENTLOG_WARNING_TYPE
			Return "Warning"
		Case $iEventType = $EVENTLOG_INFORMATION_TYPE
			Return "Information"
		Case $iEventType = $EVENTLOG_AUDIT_SUCCESS
			Return "Success audit"
		Case $iEventType = $EVENTLOG_AUDIT_FAILURE
			Return "Failure audit"
		Case Else
			Return $iEventType
	EndSelect
EndFunc   ;==>__EventLog_DecodeTypeStr

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _EventLog__DecodeUserName
; Description ...: Decodes the user name from an event log record
; Syntax.........: _EventLog__DecodeUserName($tEventLog)
; Parameters ....: $tEventLog   - tagEVENTLOGRECORD structure
; Return values .: Success      - User name
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used internally
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _EventLog__DecodeUserName($tEventLog)
	Local $pEventLog, $pAcctSID, $aAcctInfo

	$pEventLog = DllStructGetPtr($tEventLog)
	If DllStructGetData($tEventLog, "UserSidLength") = 0 Then Return ""
	$pAcctSID = $pEventLog + DllStructGetData($tEventLog, "UserSidOffset")
	$aAcctInfo = _Security__LookupAccountSid($pAcctSID)
	Return $aAcctInfo[1]
EndFunc   ;==>_EventLog__DecodeUserName

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__DeregisterSource
; Description ...: Closes a write handle to the event log
; Syntax.........: _EventLog__DeregisterSource($hEventLog)
; Parameters ....: $hEventLog   - A handle to the event log
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......:
; Related .......: _EventLog__RegisterSource, _EventLog__Notify
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _EventLog__DeregisterSource($hEventLog)
	Local $aResult

	$aResult = DllCall("AdvAPI32.dll", "int", "DeregisterEventSource", "hwnd", $hEventLog)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_EventLog__DeregisterSource

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Full
; Description ...: Retrieves whether the event log is full
; Syntax.........: _EventLog__Full($hEventLog)
; Parameters ....: $hEventLog   - A handle to the event log
; Return values .: True         - Event log is full
;                  False        - Event log is not full
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......:
; Related .......: _EventLog__Count, _EventLog__Oldest
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Full($hEventLog)
	Local $pBuffer, $pNeeded, $tBuffer

	$tBuffer = DllStructCreate("int;int")
	$pBuffer = DllStructGetPtr($tBuffer, 1)
	$pNeeded = DllStructGetPtr($tBuffer, 2)
	DllCall("AdvAPI32.dll", "int", "GetEventLogInformation", "hwnd", $hEventLog, "int", 0, "ptr", $pBuffer, "int", 4, "ptr", $pNeeded)
	Return SetError(_WinAPI_GetLastError(), 0, DllStructGetData($tBuffer, 1) <> 0)
EndFunc   ;==>_EventLog__Full

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Notify
; Description ...: Enables an application to receive event notifications
; Syntax.........: _EventLog__Notify($hEventLog, $hEvent)
; Parameters ....: $hEventLog   - A handle to the event log
;                  $hEvent      - A handle to a manual-reset event object
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function does not work with remote handles. If the hEventLog parameter is the handle to an event log on a
;                  remote computer, this function returns zero, and GetLastError returns ERROR_INVALID_HANDLE.  When an event  is
;                  written to the log specified by hEventLog, the system uses the PulseEvent function to set the event  specified
;                  by the hEvent parameter to the signaled state. If the thread is not waiting on the event when the system calls
;                  PulseEvent, the thread will not receive the notification.  Therefore, you should create a separate  thread  to
;                  wait for notifications. Note that the system calls PulseEvent no more than once every five seconds. Therefore,
;                  even if more than one event log change occurs within a  five  second  interval,  you  will  only  receive  one
;                  notification.  The system will continue to notify you of changes until you close the handle to the event  log.
;                  To close the event log, use the _EventLog__Close or _EventLog__DeregisterSource function.
; Related .......: _EventLog__Close, _EventLog__DeregisterSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Notify($hEventLog, $hEvent)
	Local $aResult

	$aResult = DllCall("AdvAPI32.dll", "int", "NotifyChangeEventLog", "hwnd", $hEventLog, "hwnd", $hEvent)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_EventLog__Notify

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Oldest
; Description ...: Retrieves the absolute record number of the oldest record in the event log
; Syntax.........: _EventLog__Oldest($hEventLog)
; Parameters ....: $hEventLog   - A handle to the event log
; Return values .: Success      - Absolute record number of the oldest record in the event log
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: The oldest record in an event log is not necessarily record number 1
; Related .......: _EventLog__Count, _EventLog__Notify
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Oldest($hEventLog)
	Local $tBuffer

	$tBuffer = DllStructCreate("int")
	DllCall("AdvAPI32.dll", "int", "GetOldestEventLogRecord", "hwnd", $hEventLog, "ptr", DllStructGetPtr($tBuffer))
	Return SetError(_WinAPI_GetLastError(), 0, DllStructGetData($tBuffer, 1))
EndFunc   ;==>_EventLog__Oldest

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Open
; Description ...: Opens a handle to the event log
; Syntax.........: _EventLog__Open($sServerName, $sSourceName)
; Parameters ....: $sServerName - The UNC name of the server on where the event log will be opened.  If blank, the  operation  is
;                  +performed on the local computer.
;                  $sSourceName - The name of the log
; Return values .: Success      - The handle to the event log
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: To close the handle to the event log, use the _EventLog__Close function
; Related .......: _EventLog__Close, _EventLog__Clear, _EventLog__Read, _EventLog__Report
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Open($sServerName, $sSourceName)
	Local $aResult

	$gsSourceName = $sSourceName
	$aResult = DllCall("AdvAPI32.dll", "hwnd", "OpenEventLogA", "str", $sServerName, "str", $sSourceName)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0])
EndFunc   ;==>_EventLog__Open

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__OpenBackup
; Description ...: Opens a handle to a backup event log
; Syntax.........: _EventLog__OpenBackup($sServerName, $sFileName)
; Parameters ....: $sServerName - The UNC name of the server on where the event log will be opened.  If blank, the  operation  is
;                  +performed on the local computer.
;                  $sFileName   - The name of the backup file
; Return values .: Success      - The handle to the backup event log
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: If the backup filename specifies a remote server, $sServerName must be blank
; Related .......: _EventLog__Close, _EventLog__Backup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__OpenBackup($sServerName, $sFileName)
	Local $aResult

	$aResult = DllCall("AdvAPI32.dll", "hwnd", "OpenBackupEventLogA", "str", $sServerName, "str", $sFileName)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0])
EndFunc   ;==>_EventLog__OpenBackup

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Read
; Description ...: Reads an entry from the event log
; Syntax.........: _EventLog__Read($hEventLog[, $fRead = True[, $fForward = True[, $iOffset = 0]]])
; Parameters ....: $hEventLog   - A handle to the event log
;                  $fRead       - If True, operation proceeds sequentially from the last call to this function using this handle.
;                  +If False, the read will operation proceeds from the record specified by the $iOffset parameter.
;                  $fForward    - If True, the log is read in date order. If False, the log is read in reverse date order.
;                  $iOffset     - The number of the event record at which the read operation  should  start.  This  parameter  is
;                  +ignored if fRead is True.
; Return values .: Success      - Array with the following format:
;                  |[ 0] - True on success, False on failure
;                  |[ 1] - Number of the record
;                  |[ 2] - Date at which this entry was submitted
;                  |[ 3] - Time at which this entry was submitted
;                  |[ 4] - Date at which this entry was received to be written to the log
;                  |[ 5] - Time at which this entry was received to be written to the log
;                  |[ 6] - Event identifier
;                  |[ 7] - Event type. This can be one of the following values:
;                  |  1 - Error event
;                  |  2 - Warning event
;                  |  4 - Information event
;                  |  8 - Success audit event
;                  | 16 - Failure audit event
;                  |[ 8] - Event type string
;                  |[ 9] - Event category
;                  |[10] - Event source
;                  |[11] - Computer name
;                  |[12] - Username
;                  |[13] - Event description
;                  |[14] - Event data array
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: When this function returns successfully, the read position in the event log  is  adjusted  by  the  number  of
;                  records read. Though multiple records can be read, this function returns one record at a time for sanity sake.
; Related .......: _EventLog__Close, _EventLog__Open
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Read($hEventLog, $fRead = True, $fForward = True, $iOffset = 0)
	Local $iReadFlags, $pBuffer, $tBuffer, $iBytesMin, $tEventLog, $aEvent[15], $aResult

	If $fRead Then
		$iReadFlags = $EVENTLOG_SEQUENTIAL_READ
	Else
		$iReadFlags = $EVENTLOG_SEEK_READ
	EndIf
	If $fForward Then
		$iReadFlags = BitOR($iReadFlags, $EVENTLOG_FORWARDS_READ)
	Else
		$iReadFlags = BitOR($iReadFlags, $EVENTLOG_BACKWARDS_READ)
	EndIf

	; First call gets the size for the buffer.  A fake buffer is passed because
	; the function demands the buffer be non-NULL even when requesting the size.
	$tBuffer = DllStructCreate("char[1]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$aResult = DllCall("AdvAPI32.dll", "int", "ReadEventLogA", "hwnd", $hEventLog, "dword", $iReadFlags, "dword", $iOffset, "ptr", _
			$pBuffer, "dword", 0, "dword*", 0, "dword*", 0)

	; Allocate the buffer and repeat the call obtaining the information.
	$iBytesMin = $aResult[7]
	$tBuffer = DllStructCreate("char[" & $iBytesMin + 1 & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$aResult = DllCall("AdvAPI32.dll", "int", "ReadEventLogA", "hwnd", $hEventLog, "dword", $iReadFlags, "dword", $iOffset, "ptr", _
			$pBuffer, "dword", $iBytesMin, "dword*", 0, "dword*", 0)
	If $aResult[0] = 0 Then Return SetError(_WinAPI_GetLastError(), 0, $aEvent)

	$tEventLog = DllStructCreate($tagEVENTLOGRECORD, $pBuffer)
	$aEvent[0] = ($aResult[0] <> 0)
	If $aEvent[0] Then
		$aEvent[ 1] = DllStructGetData($tEventLog, "RecordNumber")
		$aEvent[ 2] = __EventLog_DecodeDate(DllStructGetData($tEventLog, "TimeGenerated"))
		$aEvent[ 3] = __EventLog_DecodeTime(DllStructGetData($tEventLog, "TimeGenerated"))
		$aEvent[ 4] = __EventLog_DecodeDate(DllStructGetData($tEventLog, "TimeWritten"))
		$aEvent[ 5] = __EventLog_DecodeTime(DllStructGetData($tEventLog, "TimeWritten"))
		$aEvent[ 6] = __EventLog_DecodeEventID($tEventLog)
		$aEvent[ 7] = DllStructGetData($tEventLog, "EventType")
		$aEvent[ 8] = __EventLog_DecodeTypeStr(DllStructGetData($tEventLog, "EventType"))
		$aEvent[ 9] = __EventLog_DecodeCategory($tEventLog)
		$aEvent[10] = __EventLog_DecodeSource($tEventLog)
		$aEvent[11] = __EventLog_DecodeComputer($tEventLog)
		$aEvent[12] = _EventLog__DecodeUserName($tEventLog)
		$aEvent[13] = __EventLog_DecodeDesc($tEventLog)
		$aEvent[14] = __EventLog_DecodeData($tEventLog)
	EndIf
	Return $aEvent
EndFunc   ;==>_EventLog__Read

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__RegisterSource
; Description ...: Retrieves a registered handle to the specified event log
; Syntax.........: _EventLog__RegisterSource($sServerName, $sSourceName)
; Parameters ....: $sServerName - The UNC name of the server on where the event log will be opened.  If blank, the  operation  is
;                  +performed on the local computer.
;                  $sSourceName - The name of the event source whose handle is to be retrieved.  The source name must be a subkey
;                  +of a log under the Eventlog registry key.
; Return values .: Success      - The handle to an event log
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: If the source name cannot be found, the event logging service uses the Application log; it does not  create  a
;                  new source. Events are reported for the source, however, there are  no  message  and  category  message  files
;                  specified for looking up descriptions of the event identifiers for the source.  To close  the  handle  to  the
;                  event log, use the DeregisterEventSource function.
; Related .......: _EventLog__DeregisterSource
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _EventLog__RegisterSource($sServerName, $sSourceName)
	Local $aResult

	$gsSourceName = $sSourceName
	$aResult = DllCall("AdvAPI32.dll", "hwnd", "RegisterEventSourceA", "str", $sServerName, "str", $sSourceName)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0])
EndFunc   ;==>_EventLog__RegisterSource

; #FUNCTION# ====================================================================================================================
; Name...........: _EventLog__Report
; Description ...: Writes an entry at the end of the specified event log
; Syntax.........: _EventLog__Report($hEventLog, $iType, $iCategory, $iEventID, $sUserName, $sDesc, $aData)
; Parameters ....: $hEventLog   - A handle to the event log. As of Windows XP SP2, this cannot be a  handle to the Security log.
;                  $iType       - Event type. This can be one of the following values:
;                  | 0 - Success event
;                  | 1 - Error event
;                  | 2 - Warning event
;                  | 4 - Information event
;                  | 8 - Success audit event
;                  |16 - Failue audit event
;                  $iCategory   - The event category. This is source specific information the category can have any value.
;                  $iEventID    - The event identifier.  The event identifier specifies the entry in the message file  associated
;                  +with the event source.
;                  $sUserName   - User name for the event. This can be blank to indicate that no name is required.
;                  $sDesc       - Event description
;                  $aData       - Data array formated as follows:
;                  |[0] - Number of bytes in array
;                  |[1] - Byte 1
;                  |[2] - Byte 2
;                  |[n] - Byte n
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost (gafrost)
; Remarks .......: This function is used to log an event. The entry is written to the end of the configured log  for  the  source
;                  identified by the hEventLog parameter. This function adds the time, the entry's length, and the offsets before
;                  storing the entry in the log.
; Related .......: _EventLog__Close, _EventLog__Open
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _EventLog__Report($hEventLog, $iType, $iCategory, $iEventID, $sUserName, $sDesc, $aData)
	Local $iI, $pSID, $tSID, $pPtr, $tPtr, $iDesc, $pDesc, $tDesc, $iData, $pData, $tData, $aResult

	If $sUserName <> "" Then
		$tSID = _Security__GetAccountSid($sUserName)
		$pSID = DllStructGetPtr($tSID)
	EndIf

	$iData = $aData[0]
	$tData = DllStructCreate("byte[" & $iData & "]")
	$pData = DllStructGetPtr($tData)
	$iDesc = StringLen($sDesc) + 1
	$tDesc = DllStructCreate("char[" & $iDesc & "]")
	$pDesc = DllStructGetPtr($tDesc)
	$tPtr = DllStructCreate("ptr")
	$pPtr = DllStructGetPtr($tPtr)
	DllStructSetData($tPtr, 1, $pDesc)
	DllStructSetData($tDesc, 1, $sDesc)
	For $iI = 1 To $iData
		DllStructSetData($tData, 1, $aData[$iI], $iI)
	Next
	$aResult = DllCall("AdvAPI32.dll", "int", "ReportEventA", "hwnd", $hEventLog, "short", $iType, "short", $iCategory, "int", $iEventID, _
			"ptr", $pSID, "short", 1, "int", $iData, "ptr", $pPtr, "ptr", $pData)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_EventLog__Report
