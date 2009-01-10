; Include Version:1.78 (07.08.07)
#include-once

; ------------------------------------------------------------------------------
;
; AutoIt Version: 3.2.4.9
; Language:       English
; Description:    Functions that assist access to an SQLite database.
;
; ------------------------------------------------------------------------------
; This software is provided 'as-is', without any express or
; implied warranty.  In no event will the authors be held liable for any
; damages arising from the use of this software.

; function list
;===============================================================================
; _SQLite_Startup
; _SQLite_Shutdown
; _SQLite_Open
; _SQLite_Close
; _SQLite_GetTable
; _SQLite_Exec
; _SQLite_LibVersion
; _SQLite_LastInsertRowID
; _SQLite_GetTable2d
; _SQLite_Changes
; _SQLite_TotalChanges
; _SQLite_ErrCode
; _SQLite_ErrMsg
; _SQLite_Display2DResult
; _SQLite_FetchData
; _SQLite_Query
; _SQLite_SetTimeout
; _SQLite_SaveMode
; _SQLite_QueryFinalize
; _SQLite_QueryReset
; _SQLite_FetchNames
; _SQLite_QuerySingleRow
; _SQLite_SQLiteExe
; _SQLite_Encode
; _SQLite_Escape

#comments-start
	User Calltips:
	_SQLite_Startup([$sDll_Filename]) Loads SQLite3.dll
	_SQLite_Shutdown() Unloads SQLite3.dll
	_SQLite_Open([$sDatabase_Filename]) Opens Database, Sets Standard Handle, Returns Handle
	_SQLite_Close([$hDB]) Closes Database
	_SQLite_GetTable($hDB | -1 , $sSQL , ByRef $aResult , ByRef $iRows , ByRef $iColumns , [$iCharSize]) Executes $sSQL Query to $aResult, Returns Error Code
	_SQLite_Exec($hDB | -1 , $sSQL, [$sCallback = ""]) Executes $sSQL , Returns Error Code
	_SQLite_LibVersion() Returns Dll's Version No.
	_SQLite_LastInsertRowID($hDB) Returns Last INSERT ROWID
	_SQLite_GetTable2d($hDB | -1 , $sSQL , ByRef $aResult , ByRef $iRows , ByRef $iColumns , [$iCharSize], [$fSwichDimensions = False]) Executes $sSQL Query to $aResult, Returns Error Code
	_SQLite_Changes([$hDB]) Returns Number of Changes (Excluding Triggers) of The last Transaction
	_SQLite_TotalChanges([$hDB]) Returns Number of All Changes (Including Triggers) of all Transactions
	_SQLite_ErrCode([$hDB]) Returns Last Error Code (Numeric)
	_SQLite_ErrMsg([$hDB]) Returns Last Error Message
	_SQLite_Display2DResult($aResult , [$iCellWidth = 0], [$fReturn = False]) Returns or Prints a 2d Array to console
	_SQLite_FetchData($hQuery, ByRef $aRow, [$fBinary = False] ) Fetches Results From First/Next Row of $hQuery Query into $aRow, Returns Error Code
	_SQLite_Query($hDB | -1 , $sSQL , ByRef $hQuery) Prepares $sSql, Returns Error Code
	_SQLite_SetTimeout([$hDB = -1] , [$iTimeout = 1000]) Sets Timeout for busy handler
	_SQLite_SaveMode($fSaveModeState) Turn Savemode On or Off (boolean)
	_SQLite_QueryFinalize($hQuery) Finalizes a Query
	_SQLite_QueryReset($hQuery) Resets a Query
	_SQLite_FetchNames($hQuery, ByRef $aNames) Read out the Tablenames of a _SQLite_Query() based query
	_SQLite_QuerySingleRow($hDB | -1 , $sSQL , ByRef $aRow) Read out the first Row of the Result from the Specified query
	_SQLite_SQLiteExe( $sDatabaseFile , $sInput , ByRef $sOutput , [$sSQLiteExeFilename = "SQLite3.exe"] ) Executes commands in SQLite.exe
	_SQLite_Encode($vData) Returns Encoded String
	_SQLite_Escape($sString,[$iBuffSize]) Retruns Escaped String

	Changelog:
	26.11.05	Added _SQLite_QueryReset()
	26.11.05	Added _SQLite_QueryFinalize()
	26.11.05 	Added _SQLite_SaveMode()
	26.11.05 	Implemented SaveMode
	27.11.05	Renamed _SQLite_FetchArray() -> _SQLite_FetchData()
	27.11.05	Added _SQLite_FetchNames(), Example
	28.11.05	Removed _SQLite_Commit(), _SQLite_Close() handles $SQLITE_BUSY issues
	28.11.05	Added Function Headers
	28.11.05	Fixed Bug in _SQLite_Exec(), $sErrorMsg was set to 0 instead of 'Successful result'
	29.11.05	Changed _SQLite_Display2DResult(), Better Fromating for Lager Tables & Ability to Return the Result
	30.11.05	Changed _SQLite_GetTable2d(), Ability to Swich Dimensions
	30.11.05	Fixed _SQLite_Display2DResult() $iCellWidth was ignored
	03.12.05	Added _SQLite_QuerySingleRow()
	04.12.05	Changed Standard $hDB Handling (Thank you JPM)
	04.12.05	Fixed Return Values of _SQLite_LibVersion(),_SQLite_LastInsertRowID(),_SQLite_Changes(),_SQLite_TotalChanges()
	04.12.05	Changed _SQLite_Open() now opens a ':memory:' database if no name specified
	05.12.05	Changed _SQLite_FetchData() NULL Values will be Skipped
	10.12.05	Changed _SQLite_QuerySingleResult() now uses 'sqlite3_get_table' API
	13.12.05	Added _SQLite_SQLiteExe() Wrapper for SQLite3.exe
	29.03.06	Removed _SQLite_SetGlobalTimeout()
	29.03.06	Added _SQLite_SetTimeout()
	17.05.06	:cdecl to support autoit debugging version
	18.05.06	_SQLite_SQLiteExe() now Creates nonexistend Directory's
	18.05.06	Fixed SyntaxCheck Warnings (_SQLite_GetTable2d())
	21.05.06	Added support for Default Keyword for all Optional parameters
	25.05.06	Added _SQLite_Encode()
	25.05.06	Changed _SQLite_QueryNoResult() -> _SQLite_Execute()
	25.05.06	Changed _SQLite_FetchData() Binary Mode
	26.05.06	Removed _SQLite_GlobalRecover() out-of-memory recovery is automatic since SQLite 3.3.0
	26.05.06	Changed @error Values & Improved error catching (see Function headers)
	31.05.06	JPM's Nice @error values setting
	04.06.06	Inline SQLite3.dll
	08.06.06	Changed _SQLite_Exec(), _SQLite_GetTable2d(), _SQLite_GetTable() Removed '$sErrorMsg' parameter
	08.06.06	Removed _SQLite_Execute() because _SQLite_Exec() was the same
	08.06.06	Cleaning _SQlite_Startup(). (JPM)
	23.09.06	Fixed _SQLite_Exec() Memory Leak on SQL error
	23.09.06	Added SQL Error Reporting (only in interpreted mode)
	23.09.06	Added _SQLite_Escape()
	24.09.06	Changed _SQLite_Escape(), Changed _SQLite_GetTable*() New szString Reading method, Result will no longer be truncated
	25.09.06	Fixed Bug in szSring read procedure (_SQLite_GetTable*, _SQLite_QuerySingleRow, _SQLite_Escape)
	29.09.06	Faster szString Reading, Function Header corrections
	29.09.06	Changed _SQLite_Exec() Callback
	12.03.07	Changed _SQLite_Query() to use 'sqlite3_prepare_v2' API
	16.03.07	Fixed _SQLite_Open() not setting @error, Missing DllClose() in _SQLite_Shutdown(), Stack corruption in szString reading procedure
	17.03.07	Improved Error handling/Reporting
	08.07.07	Fixed Bug in version comparison procedure
	26.10.07	Fixed _SQLite_SQLiteExe() referencing by default "Extras\SQLite\SQlite3.exe"
	23.06.08	Fixed _SQLite_* misuse if _SQLite_Stratup() failed
#comments-end

Global Const $SQLITE_OK = 0   ; /* Successful result */
Global Const $SQLITE_ERROR = 1   ; /* SQL error or missing database */
Global Const $SQLITE_INTERNAL = 2   ; /* An internal logic error in SQLite */
Global Const $SQLITE_PERM = 3   ; /* Access permission denied */
Global Const $SQLITE_ABORT = 4   ; /* Callback routine requested an abort */
Global Const $SQLITE_BUSY = 5   ; /* The database file is locked */
Global Const $SQLITE_LOCKED = 6   ; /* A table in the database is locked */
Global Const $SQLITE_NOMEM = 7   ; /* A malloc() failed */
Global Const $SQLITE_READONLY = 8   ; /* Attempt to write a readonly database */
Global Const $SQLITE_INTERRUPT = 9   ; /* Operation terminated by sqlite_interrupt() */
Global Const $SQLITE_IOERR = 10   ; /* Some kind of disk I/O error occurred */
Global Const $SQLITE_CORRUPT = 11   ; /* The database disk image is malformed */
Global Const $SQLITE_NOTFOUND = 12   ; /* (Internal Only) Table or record not found */
Global Const $SQLITE_FULL = 13   ; /* Insertion failed because database is full */
Global Const $SQLITE_CANTOPEN = 14   ; /* Unable to open the database file */
Global Const $SQLITE_PROTOCOL = 15   ; /* Database lock protocol error */
Global Const $SQLITE_EMPTY = 16   ; /* (Internal Only) Database table is empty */
Global Const $SQLITE_SCHEMA = 17   ; /* The database schema changed */
Global Const $SQLITE_TOOBIG = 18   ; /* Too much data for one row of a table */
Global Const $SQLITE_CONSTRAINT = 19   ; /* Abort due to constraint violation */
Global Const $SQLITE_MISMATCH = 20   ; /* Data type mismatch */
Global Const $SQLITE_MISUSE = 21   ; /* Library used incorrectly */
Global Const $SQLITE_NOLFS = 22   ; /* Uses OS features not supported on host */
Global Const $SQLITE_AUTH = 23   ; /* Authorization denied */
Global Const $SQLITE_ROW = 100   ; /* sqlite_step() has another row ready */
Global Const $SQLITE_DONE = 101   ; /* sqlite_step() has finished executing */

Global Const $SQLITE_DBHANDLE = 1  ; /* (Internal Only) Database Handle (sqlite3*) */
Global Const $SQLITE_QUERYHANDLE = 2  ; /* (Internal Only) Query Handle (sqlite3_stmt*) */

#include <Array.au3> 	; Using: _ArrayCreate(),_ArrayAdd(),_ArrayDelete(),_ArraySearch()
#include <File.au3> 	; Using: _TempFile()

Global $g_hDll_SQLite = 0
Global $g_hDB_SQLite = 0
Global $g_avSafeMode_SQLite = _ArrayCreate(1, _ArrayCreate(''), _ArrayCreate(''), 0, _ArrayCreate(''))

;===============================================================================
;
; Function Name:	_SQLite_Startup
;
; Parameter(s):		$sDll_Filename - Optional, Dll Filename
; Description:      Loads SQLite.dll
; Requirement:		None
; Return Value(s):  On Success - Returns path to SQLite3.dll
;                   On Failure - Returns empty string
; @error Value(s):	1 - Error Loading Dll
;
; User CallTip:		_SQLite_Startup([$sDll_Filename]) Loads SQLite3.dll
; Author(s):		piccaso (Fida Florian), JPM
;
;===============================================================================

Func _SQLite_Startup($sDll_Filename = "") ; Loads SQLite Dll
	Local $hDll, $hFileDllOut = -1
	Local $fUseInline = True
	Local $vInlineVersion = Call('__' & 'SQLite_Inline_Version')
	If @error Then $fUseInline = False
	If IsKeyword($sDll_Filename) Or $sDll_Filename = "" Or $sDll_Filename = -1 Then
		$sDll_Filename = "sqlite3.dll"
		If __SQLite_VersCmp(@ScriptDir & "\" & $sDll_Filename, $vInlineVersion) = $SQLITE_OK Then
			$sDll_Filename = @ScriptDir & "\" & $sDll_Filename
			$fUseInline = False
		ElseIf __SQLite_VersCmp(@SystemDir & "\" & $sDll_Filename, $vInlineVersion) = $SQLITE_OK Then
			$sDll_Filename = @SystemDir & "\" & $sDll_Filename
			$fUseInline = False
		ElseIf __SQLite_VersCmp(@WindowsDir & "\" & $sDll_Filename, $vInlineVersion) = $SQLITE_OK Then
			$sDll_Filename = @WindowsDir & "\" & $sDll_Filename
			$fUseInline = False
		ElseIf __SQLite_VersCmp(@WorkingDir & "\" & $sDll_Filename, $vInlineVersion) = $SQLITE_OK Then
			$sDll_Filename = @WorkingDir & "\" & $sDll_Filename
			$fUseInline = False
		EndIf
		If $fUseInline Then
			$sDll_Filename = @SystemDir & "\SQLite3.dll"
			If Not FileExists($sDll_Filename) Then
				$hFileDllOut = FileOpen($sDll_Filename, 2)
			EndIf
			If $hFileDllOut = -1 Then
				$sDll_Filename = _TempFile(@TempDir, "~", ".dll")
				$hFileDllOut = FileOpen($sDll_Filename, 2)
				If $hFileDllOut = -1 Then Return SetError(1, 0, "")
				_ArrayAdd($g_avSafeMode_SQLite[4], $sDll_Filename)
			EndIf
			FileWrite($hFileDllOut, Call('__' & 'SQLite_Inline_SQLite3Dll'))
			FileClose($hFileDllOut)
			FileSetTime($sDll_Filename, Call('__' & 'SQLite_Inline_Modified'), 0)
		EndIf
	EndIf
	$hDll = DllOpen($sDll_Filename)
	If $hDll = -1 Then
		$g_hDll_SQLite = 0
		Return SetError(1, 0, "")
	Else
		$g_hDll_SQLite = $hDll
		Return $sDll_Filename
	EndIf
EndFunc   ;==>_SQLite_Startup

;===============================================================================
;
; Function Name:    _SQLite_Shutdown()
; Description:      Unloads SQLite Dll
; Return Value(s):  None
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Shutdown() ; Unloads SQLite Dll
	If $g_hDll_SQLite > 0 Then DllClose($g_hDll_SQLite)
	$g_hDll_SQLite = 0
	If $g_avSafeMode_SQLite[3] > 0 Then DllClose($g_avSafeMode_SQLite[3])
	$g_avSafeMode_SQLite[3] = 0
	For $sTempFile In $g_avSafeMode_SQLite[4]
		If FileExists($sTempFile) Then FileDelete($sTempFile)
	Next
EndFunc   ;==>_SQLite_Shutdown

;===============================================================================
;
; Function Name:      _SQLite_Open()
; Description:        Opens a Database
; Parameter(s):       $sDatabase_Filename - Optional, Database Filename (uses ':memory:' db by default)
; Return Value(s):    Returns Database Handle
; @error Value(s):	   1 - Error Calling SQLite API 'sqlite3_open'
;					  -1 - SQLite Reported an Error (Check @extended Value)
; @extended Value(s): Can be compared against $SQLITE_* Constants
; Author(s):          piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Open($sDatabase_Filename = ":memory:")
	Local $avRval
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If IsKeyword($sDatabase_Filename) Then $sDatabase_Filename = ":memory:"
	$avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_open", "str", $sDatabase_Filename _ ; Database filename
			, "long*", 0) ; OUT: SQLite db handle
	If @error > 0 Then
		Return SetError(1, $SQLITE_MISUSE, 0)
	ElseIf $avRval[0] = $SQLITE_OK Then
		$g_hDB_SQLite = $avRval[2]
		__SQLite_hAdd($avRval[2], $SQLITE_DBHANDLE)
		Return SetError(0, $avRval[0], $avRval[2])
	Else
		__SQLite_ReportError($avRval[2], "_SQLite_Open")
		_SQLite_Close($avRval[2])
		Return SetError(-1, $avRval[0], 0)
	EndIf
EndFunc   ;==>_SQLite_Open
;===============================================================================
;
; Function Name:    _SQLite_GetTable()
; Description:      Passes Out a 1Dimensional Array Containing Tablenames and Data of Executed Query
; Parameter(s):     $hDB - An Open Database, Use -1 To use Last Opened Database
;					$sSQL - SQL Statement to be executed
;					ByRef $aResult - Passes out the Result
;					ByRef $iRows - Passes out the amount of 'data' Rows
;					ByRef $iColumns - Passes out the amount of Columns
;					$iCharSize - Optional, Specifies the maximal size of a Data Field
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;                    1 - Error Calling SQLite API 'sqlite3_get_table'
;					 2 - Error Calling SQLite API 'sqlite3_free_table'
;					 3 - Call Prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_GetTable($hDB, $sSQL, ByRef $aResult, ByRef $iRows, ByRef $iColumns, $iCharSize = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(3, 0, $SQLITE_MISUSE)
	Local $r, $iResultSize, $i, $struct1, $struct2, $pResult
	If $iCharSize = 0 Or $iCharSize = "" Or $iCharSize < 1 Or IsKeyword($iCharSize) Then $iCharSize = -1
	$r = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_get_table", _
			"ptr", $hDB, _ ; An open database
			"str", $sSQL, _; SQL to be executed
			"long*", 0, _ ; Result written to a char *[]  that this points to
			"long*", 0, _ ; Number of result rows written here
			"long*", 0, _ ; Number of result columns written here
			"long*", 0)  ; Error msg written here
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE) ; Dll Calling Error
	EndIf
	$pResult = $r[3]
	$iRows = $r[4]
	$iColumns = $r[5]
	$iResultSize = (($iRows) + 1) * ($iColumns)
	For $i = 1 To $iResultSize - 1
		$struct1 &= "ptr;"
	Next
	$struct1 &= "ptr"
	$struct2 = DllStructCreate($struct1, $pResult)
	If Not IsArray($aResult) Then
		Dim $aResult[1]
	EndIf
	ReDim $aResult [$iResultSize + 1]
	$aResult[0] = $iResultSize
	For $i = 1 To $iResultSize
		;$aResult[$i] = DllStructGetData(DllStructCreate("char[" & $iCharSize & "]", DllStructGetData($struct2, $i)), 1)
		$aResult[$i] = __SQLite_szStringRead(DllStructGetData($struct2, $i), $iCharSize)
	Next
	DllCall($g_hDll_SQLite, "none:cdecl", "sqlite3_free_table", "ptr", $pResult) ; pointer to 'resultp' from sqlite3_get_table
	If @error > 0 Then SetError(2)
	If $r[0] <> $SQLITE_OK Then
		__SQLite_ReportError($hDB, "_SQLite_GetTable", $sSQL)
		SetError(-1)
	EndIf
	Return $r[0]
EndFunc   ;==>_SQLite_GetTable

;===============================================================================
;
; Function Name:    _SQLite_Exec()
; Description:      Executes a SQLite Query, Does not handle Results
; Parameter(s):     $hDB - An Open Database, Use -1 To use Last Opened Database
;					$sSQL - SQL Statement to be executed
;					$sCallBack - Optional, Callback Function
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_exec'
;					 2 - Call Prevented by SaveMode
;					 3 - Error Processing Callback
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Exec($hDB, $sSQL, $sCallBack = "")
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $avRval, $aResult, $iRows, $iColumns, $iRval
	If $sCallBack <> "" Then
		$aResult = "SQLITE_CALLBACK:" & $sCallBack
		$iRval = _SQLite_GetTable2d($hDB, $sSQL, $aResult, $iRows, $iColumns)
		If @error Then Return SetError(3, 0, $iRval)
		Return $iRval
	EndIf
	$avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_exec", _
			"ptr", $hDB, _ ; An open database
			"str", $sSQL, _ ; SQL to be executed
			"ptr", 0, _ ; Callback function
			"ptr", 0, _ ; 1st argument to callback function
			"long*", 0); Error msg written here
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE) ; DllCall Error
	EndIf
	If $avRval[0] <> $SQLITE_OK Then
		__SQLite_ReportError($hDB, "_SQLite_Exec", $sSQL)
		SetError(-1)
	EndIf
	If $avRval[5] <> 0 Then DllCall($g_hDll_SQLite, "none:cdecl", "sqlite3_free", "ptr", $avRval[5])
	Return $avRval[0]
EndFunc   ;==>_SQLite_Exec

;===============================================================================
;
; Function Name:    _SQLite_LibVersion()
; Description:      Returns the version number of the library
; Return Value(s):  Returns version number
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_libversion'
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_LibVersion()
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	Local $r = DllCall($g_hDll_SQLite, "str:cdecl", "sqlite3_libversion")
	If @error > 0 Then
		Return SetError(1, 0, 0); DLLCall Error
	Else
		Return $r[0]
	EndIf
EndFunc   ;==>_SQLite_LibVersion

;===============================================================================
;
; Function Name:    _SQLite_LastInsertRowID()
; Description:      Returns the ROWID of the most recent insert in the database
; Parameter(s):     $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return Value(s):  Returns ROWID
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_last_insert_rowid'
; 					2 - Call Prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_LastInsertRowID($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, 0)
	Local $r = DllCall($g_hDll_SQLite, "long:cdecl", "sqlite3_last_insert_rowid", "ptr", $hDB)
	If @error > 0 Then
		Return SetError(1, 0, 0) ;DllCall Error
	Else
		Return $r[0]
	EndIf
EndFunc   ;==>_SQLite_LastInsertRowID

;===============================================================================
;
; Function Name:    _SQLite_Changes()
; Description:      Returns the number of database rows that were changed by the most recently completed query
; Parameter(s):     $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return Value(s):  Returns number of Changes
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_changes'
; 					2 - Call Prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Changes($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, 0)
	Local $r = DllCall($g_hDll_SQLite, "long:cdecl", "sqlite3_changes", "ptr", $hDB)
	If @error > 0 Then
		Return SetError(1, 0, 0) ;DllCall Error
	Else
		Return $r[0]
	EndIf
EndFunc   ;==>_SQLite_Changes

;===============================================================================
;
; Function Name:    _SQLite_TotalChanges()
; Description:      Returns the total number of database rows that have be modified, inserted, or deleted since the database connection was created
; Parameter(s):     $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return Value(s):  Returns number of Total Changes
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_total_changes'
; 					2 - Call Prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_TotalChanges($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, 0)
	Local $r = DllCall($g_hDll_SQLite, "long:cdecl", "sqlite3_total_changes", "ptr", $hDB)
	If @error > 0 Then
		Return SetError(1, 0, 0) ;DllCall Error
	Else
		Return $r[0]
	EndIf
EndFunc   ;==>_SQLite_TotalChanges

;===============================================================================
;
; Function Name:    _SQLite_ErrCode()
; Description:      Returns the error code for the most recent failed sqlite3_* API call
; Parameter(s):     $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return Value(s):  On Success - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_errcode'
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_ErrCode($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return $SQLITE_MISUSE
	Local $r = DllCall($g_hDll_SQLite, "long:cdecl", "sqlite3_errcode", "ptr", $hDB)
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE) ;DllCall Error
	Else
		Return $r[0]
	EndIf
EndFunc   ;==>_SQLite_ErrCode

;===============================================================================
;
; Function Name:    _SQLite_ErrMsg()
; Description:      Returns a String describing in English the error condition for the most recent sqlite3_* API call
; Parameter(s):     $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return Value(s):  On Success - Returns Error message
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_errmsg'
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_ErrMsg($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return "Library used incorrectly"
	Local $r = DllCall($g_hDll_SQLite, "str:cdecl", "sqlite3_errmsg", "ptr", $hDB)
	If @error > 0 Then
		Return SetError(1, 0, "Library used incorrectly") ;DllCall Error
	Else
		Return $r[0]
	EndIf
EndFunc   ;==>_SQLite_ErrMsg

;===============================================================================
;
; Function Name:    _SQLite_Display2DResult()
; Description:      Prints a 2Dimensional Array formated to Console
; Parameter(s):     $aResult - The Array to be displayed
;					$iCellWidth - Optional, Specifies the size of a Data Field
;					$fReturn - Optional, If true The Formated String is returned
; Return Value(s):  none or Formated String
; @error Value(s):	1 - $aResult is no Array or has wrong Dimension
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Display2DResult($aResult, $iCellWidth = 0, $fReturn = False)
	Local $iCol, $iRow, $sOut, $aiCellWidth, $iCellWidthUsed
	If Not IsArray($aResult) Or UBound($aResult, 0) <> 2 Then
		Return SetError(1, 0, "")
	EndIf
	If $iCellWidth = 0 Or IsKeyword($iCellWidth) Then
		Dim $aiCellWidth[UBound($aResult, 2) ]
		For $iCol = 0 To UBound($aResult, 1) - 1
			For $iRow = 0 To UBound($aResult, 2) - 1
				If StringLen($aResult[$iCol][$iRow]) > $aiCellWidth[$iRow] Then
					$aiCellWidth[$iRow] = StringLen($aResult[$iCol][$iRow])
				EndIf
			Next
		Next
	EndIf
	For $iCol = 0 To UBound($aResult, 1) - 1
		For $iRow = 0 To UBound($aResult, 2) - 1
			If $iCellWidth = 0 Then
				$iCellWidthUsed = $aiCellWidth[$iRow]
			Else
				$iCellWidthUsed = $iCellWidth
			EndIf
			If $fReturn Then
				$sOut &= StringFormat(" %-" & $iCellWidthUsed & "s ", $aResult[$iCol][$iRow])
			Else
				ConsoleWrite(StringFormat(" %-" & $iCellWidthUsed & "s ", $aResult[$iCol][$iRow]))
			EndIf
		Next
		If $fReturn Then
			$sOut &= @CRLF
		Else
			ConsoleWrite(@CR)
		EndIf
	Next
	If $fReturn Then Return $sOut
EndFunc   ;==>_SQLite_Display2DResult

;===============================================================================
;
; Function Name:    _SQLite_GetTable2d()
; Description:      Passes Out a 2Dimensional Array Containing Tablenames and Data of Executed Query
; Parameter(s):     $hDB - An Open Database, Use -1 To use Last Opened Database
;					$sSQL - SQL Statement to be executed
;					ByRef $aResult - Passes out the Result
;					ByRef $iRows - Passes out the amount of 'data' Rows
;					ByRef $iColumns - Passes out the amount of Columns
;					$iCharSize - Optional, Specifies the maximal size of a Data Field
;					$fSwichDimensions - Optional, Swiches Dimensions
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_get_table'
;					 2 - Error Calling SQLite API 'sqlite3_free_table'
;					 3 - Call Prevented by SaveMode
; Author(s):        piccaso (Fida Florian), blink314
;
;===============================================================================
;
Func _SQLite_GetTable2d($hDB, $sSQL, ByRef $aResult, ByRef $iRows, ByRef $iColumns, $iCharSize = -1, $fSwichDimensions = False)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(3, 0, $SQLITE_MISUSE)
	Local $r, $iResultSize, $i, $struct1, $pResult, $struct2, $iColCnt, $iRowCnt, $sCallBack, $iCbRval
	If $iCharSize = 0 Or $iCharSize = "" Or $iCharSize < 1 Or IsKeyword($iCharSize) Then $iCharSize = -1
	If IsKeyword($fSwichDimensions) Then $fSwichDimensions = False
	$r = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_get_table", _
			"ptr", $hDB, _ ; An open database
			"str", $sSQL, _; SQL to be executed
			"long*", 0, _ ; Result written to a char *[]  that this points to
			"long*", 0, _ ; Number of result rows written here
			"long*", 0, _ ; Number of result columns written here
			"long*", 0)  ; Error msg written here
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE) ; Dll Calling Error
	EndIf
	$pResult = $r[3]
	$iRows = $r[4]
	$iColumns = $r[5]
	If $iColumns > 0 And $iRows > 0 Then
		$iResultSize = (($iRows) + 1) * ($iColumns)
		For $i = 1 To $iResultSize - 1
			$struct1 &= "ptr;"
		Next
		$struct1 &= "ptr"
		$struct2 = DllStructCreate($struct1, $pResult)
		If Not IsArray($aResult) Then
			If StringLeft($aResult, 16) = "SQLITE_CALLBACK:" Then $sCallBack = StringTrimLeft($aResult, 16)
			Dim $aResult[1][1]
		EndIf
		If $sCallBack <> "" Then
			ReDim $aResult [$iColumns]
			For $i = 1 To $iResultSize
				$aResult[$iColCnt] = __SQLite_szStringRead(DllStructGetData($struct2, $i), $iCharSize)
				$iColCnt += 1
				If ($i / $iColumns) = Round($i / $iColumns, 0) Then
					$iCbRval = Call($sCallBack, $aResult)
					If $iCbRval = $SQLITE_ABORT Or $iCbRval = $SQLITE_INTERRUPT Or @error Then
						DllCall($g_hDll_SQLite, "none:cdecl", "sqlite3_free_table", "ptr", $pResult) ; pointer to 'resultp' from sqlite3_get_table
						Return SetError(99, 0, $r[0]) ; Internal only
					EndIf
					$iColCnt = 0
				EndIf
			Next
		Else
			If Not $fSwichDimensions Then
				ReDim $aResult [$iRows + 1][$iColumns]
				For $i = 1 To $iResultSize
					$aResult[$iRowCnt][$iColCnt] = __SQLite_szStringRead(DllStructGetData($struct2, $i), $iCharSize)
					$iColCnt += 1
					If ($i / $iColumns) = Round($i / $iColumns, 0) Then
						$iRowCnt += 1
						$iColCnt = 0
					EndIf
				Next
			Else
				ReDim $aResult [$iColumns][$iRows + 1]
				For $i = 1 To $iResultSize
					$aResult[$iColCnt][$iRowCnt] = __SQLite_szStringRead(DllStructGetData($struct2, $i), $iCharSize)
					$iColCnt += 1
					If ($i / $iColumns) = Round($i / $iColumns, 0) Then
						$iRowCnt += 1
						$iColCnt = 0
					EndIf
				Next
			EndIf
		EndIf
	EndIf
	DllCall($g_hDll_SQLite, "none:cdecl", "sqlite3_free_table", "ptr", $pResult) ; pointer to 'resultp' from sqlite3_get_table
	If @error > 0 Then SetError(2)
	If $r[0] <> $SQLITE_OK Then
		__SQLite_ReportError($hDB, "_SQLite_GetTable2d or _SQLite_QuerySingleRow or _SQLite_Exec", $sSQL)
		SetError(-1)
	EndIf
	Return $r[0]
EndFunc   ;==>_SQLite_GetTable2d

;===============================================================================
;
; Function Name:    _SQLite_SetTimeout()
; Description:      Sets Timeout for busy handler
; Parameter(s):     $hDB - An Open Database, Use -1 To use Last Opened Database
;                   $iTimeout - Timeout [msec]
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_busy_timeout'
;					 2 - Call prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_SetTimeout($hDB = -1, $iTimeout = 1000)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $avRval
	If IsKeyword($iTimeout) Then $iTimeout = 1000
	$avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_busy_timeout", "ptr", $hDB, "int", $iTimeout)
	If @error > 0 Then
		SetError(1); DLLCall Error
	ElseIf $avRval[0] <> $SQLITE_OK Then
		SetError(-1)
	EndIf
	Return $avRval[0]
EndFunc   ;==>_SQLite_SetTimeout


;===============================================================================
;
; Function Name:    _SQLite_Query()
; Description:      Prepares a SQLite Query
; Parameter(s):     $hDB - An Open Database, Use -1 To use Last Opened Database
;					$sSQL - SQL Statement to be executed
;					ByRef $hQuery - Passes out a Query Handle
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_prepare_v2'
;					 2 - Call prevented by SafeMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Query($hDB, $sSQL, ByRef $hQuery)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $iRval
	$iRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_prepare_v2", _
			"ptr", $hDB, _
			"str", $sSQL, _
			"int", StringLen($sSQL), _
			"long*", 0, _
			"long*", 0)
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE)
	ElseIf $iRval[0] = $SQLITE_OK Then
		$hQuery = $iRval[4]
		__SQLite_hAdd($iRval[4], $SQLITE_QUERYHANDLE)
		Return $iRval[0]
	Else
		__SQLite_ReportError($hDB, "_SQLite_Query", $sSQL)
		Return SetError(-1, 0, $iRval[0])
	EndIf
EndFunc   ;==>_SQLite_Query

;===============================================================================
;
; Function Name:    _SQLite_FetchData()
; Description:      Fetches 1 Row of Data from a _SQLite_Query() based query
; Parameter(s):     $hQuery - Queryhandle passed out by _SQLite_Query()
;					ByRef $aRow - A 1 dimensional Array containing a Row of Data
;					$fBinary - Switch for Binary mode ($aRow will be a Array of Binary Strings)
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_step'
;					 2 - Error Calling SQLite API 'sqlite3_data_count'
;					 3 - Error Calling SQLite API 'sqlite3_column_text'
;					 4 - Error Calling SQLite API 'sqlite3_column_type'
;					 5 - Error Calling SQLite API 'sqlite3_column_bytes'
;					 6 - Error Calling SQLite API 'sqlite3_column_blob'
;					 7 - Call prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_FetchData($hQuery, ByRef $aRow, $fBinary = False)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hQuery, $SQLITE_QUERYHANDLE) = $SQLITE_OK Then Return SetError(7, 0, $SQLITE_MISUSE)
	If Not IsArray($aRow) Then
		Dim $aRow[1]
	EndIf
	Local $iRval_Step, $iRval_ColCnt, $sRval, $i, $iRval_coltype
	Local $iColBytes, $vResult, $vResultStruct
	Local $SQLITE_NULL = 5
	If IsKeyword($fBinary) Then $fBinary = False
	$iRval_Step = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_step", "ptr", $hQuery)
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE)
	ElseIf $iRval_Step[0] = $SQLITE_ROW Then
		$iRval_ColCnt = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_data_count", "ptr", $hQuery)
		If @error > 0 Then
			Return SetError(2, 0, $SQLITE_MISUSE)
		EndIf
		If $iRval_ColCnt[0] > 0 Then
			ReDim $aRow[$iRval_ColCnt[0]]
			For $i = 0 To $iRval_ColCnt[0] - 1
				If Not $fBinary Then
					$iRval_coltype = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_column_type", "ptr", $hQuery, "int", $i)
					If @error > 0 Then
						Return SetError(4, 0, $SQLITE_MISUSE)
					EndIf
					If $iRval_coltype[0] = $SQLITE_NULL Then
						$aRow[$i] = ""
						ContinueLoop
					EndIf
					$sRval = DllCall($g_hDll_SQLite, "str:cdecl", "sqlite3_column_text", "ptr", $hQuery, "int", $i)
					If @error > 0 Then
						Return SetError(3, 0, $SQLITE_MISUSE)
					EndIf
					$aRow[$i] = $sRval[0]
				Else
					$iColBytes = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_column_bytes", "ptr", $hQuery, "int", $i)
					If @error > 0 Then
						Return SetError(5, 0, $SQLITE_MISUSE)
					EndIf
					$vResult = DllCall($g_hDll_SQLite, "ptr:cdecl", "sqlite3_column_blob", "ptr", $hQuery, "int", $i)
					If @error > 0 Then
						Return SetError(6, 0, $SQLITE_MISUSE)
					EndIf
					$vResultStruct = DllStructCreate("byte[" & $iColBytes[0] & "]", $vResult[0])
					$aRow[$i] = Binary(DllStructGetData($vResultStruct, 1))
				EndIf
			Next
			Return $SQLITE_OK
		Else
			Return SetError(-1, 0, $SQLITE_EMPTY)
		EndIf
	Else ; incl. $SQLITE_DONE
		_SQLite_QueryFinalize($hQuery)
		If $iRval_Step[0] <> $SQLITE_OK Then SetError(-1)
		Return $iRval_Step[0]
	EndIf
EndFunc   ;==>_SQLite_FetchData

;===============================================================================
;
; Function Name:    _SQLite_Close()
; Description:      Closes a open Database, Waits until SQLite <> $SQLITE_BUSY until 'global Timeout' has elapsed
; Parameter(s):     $hDB - Optional Database Handle
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_close'
;					 2 - Call prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Close($hDB = -1) ; Closes Database
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $iRval
	$iRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_close", "ptr", $hDB) ; An open database
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE) ; Dll Calling Error
	ElseIf $iRval[0] = $SQLITE_OK Then
		$g_hDB_SQLite = 0
		__SQLite_hDel($hDB, $SQLITE_DBHANDLE)
		Return $iRval[0]
	EndIf
	__SQLite_ReportError($hDB, "_SQLite_Close")
	Return SetError(-1, 0, $iRval[0])
EndFunc   ;==>_SQLite_Close

;===============================================================================
;
; Function Name:    _SQLite_SaveMode()
; Description:      Disable or Enable Save Mode
; Parameter(s):     $fSaveModeState	- True or False to enable or disable SafeMode
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Returns $SQLITE_MISUSE
; @error Value(s):	1 - Error Interpreting $fSaveModeState Parameter
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_SaveMode($fSaveModeState) ; Turn Savemode On or Off (boolean)
	If $fSaveModeState = False Then
		$g_avSafeMode_SQLite[0] = False
	ElseIf $fSaveModeState = True Then
		$g_avSafeMode_SQLite[0] = True
	Else
		Return SetError(1, 0, $SQLITE_MISUSE)
	EndIf
	Return $SQLITE_OK
EndFunc   ;==>_SQLite_SaveMode

;===============================================================================
;
; Function Name:    _SQLite_QueryFinalize()
; Description:      Finalize _SQLite_Query() based query
; Parameter(s):     $hQuery	- Query Handle Generated by SQLite_Query()
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_finalize'
;					 2 - Call prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_QueryFinalize($hQuery)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hQuery, $SQLITE_QUERYHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_finalize", "ptr", $hQuery)
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE)
	EndIf
	__SQLite_hDel($hQuery, $SQLITE_QUERYHANDLE)
	If $avRval[0] <> $SQLITE_OK Then SetError(-1)
	Return $avRval[0]
EndFunc   ;==>_SQLite_QueryFinalize

;===============================================================================
;
; Function Name:    _SQLite_QueryReset()
; Description:      Reset a _SQLite_Query() based query
; Parameter(s):     $hQuery	- Query Handle Generated by SQLite_Query()
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_reset'
;					 2 - Call prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_QueryReset($hQuery)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hQuery, $SQLITE_QUERYHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_reset", "ptr", $hQuery)
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE)
	EndIf
	If $avRval[0] <> $SQLITE_OK Then SetError(-1)
	Return $avRval[0]
EndFunc   ;==>_SQLite_QueryReset

;===============================================================================
;
; Function Name:    _SQLite_FetchNames()
; Description:      Read out the Tablenames of a _SQLite_Query() based query
; Parameter(s):     $hQuery	- Query Handle Generated by SQLite_Query()
;                   ByRef $aNames - 1 Dimensional Array Containign the Table Names
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_data_count'
;					 2 - Error Calling SQLite API 'sqlite3_column_name'
;					 3 - Call prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_FetchNames($hQuery, ByRef $aNames)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hQuery, $SQLITE_QUERYHANDLE) = $SQLITE_OK Then Return SetError(3, 0, $SQLITE_MISUSE)
	Local $avDataCnt, $avColName, $iCnt
	If Not IsArray($aNames) Then Dim $aNames[1]
	$avDataCnt = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_column_count", "ptr", $hQuery)
	If @error > 0 Then
		Return SetError(1, 0, $SQLITE_MISUSE) ; DllCall Error (sqlite3_data_count)
	ElseIf $avDataCnt[0] > 0 Then
		ReDim $aNames[$avDataCnt[0]]
		For $iCnt = 0 To $avDataCnt[0] - 1
			$avColName = DllCall($g_hDll_SQLite, "str:cdecl", "sqlite3_column_name", "ptr", $hQuery, "int", $iCnt)
			If @error > 0 Then
				Return SetError(2, 0, $SQLITE_MISUSE); DllCall Error (sqlite3_column_name)
			EndIf
			$aNames[$iCnt] = $avColName[0]
		Next
		Return $SQLITE_OK
	Else
		Return SetError(-1, 0, $SQLITE_EMPTY)
	EndIf
EndFunc   ;==>_SQLite_FetchNames

;===============================================================================
;
; Function Name:    _SQLite_QuerySingleRow()
; Description:      Read out the first Row of the Result from the Specified query
; Parameter(s):     $hDB - An Open Database, Use -1 To use Last Opened Database
;					$sSQL - SQL Statement to be executed
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_get_table'
;					 2 - Error Calling SQLite API 'sqlite3_free_table'
;					 3 - Call Prevented by SaveMode
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_QuerySingleRow($hDB, $sSQL, ByRef $aRow)
	Local $aResult, $iRows, $iColumns, $iRval, $i, $iAu3Error
	$aRow = ""
	Dim $aRow[1]
	$iRval = _SQLite_GetTable2d($hDB, $sSQL, $aResult, $iRows, $iColumns)
	$iAu3Error = @error
	If $iRval = $SQLITE_OK And UBound($aResult, 0) > 0 Then
		ReDim $aRow[UBound($aResult, 2) ]
		For $i = 0 To UBound($aResult, 2) - 1
			$aRow[$i] = $aResult[1][$i]
		Next
	EndIf
	If $iAu3Error Then SetError($iAu3Error)
	Return $iRval
EndFunc   ;==>_SQLite_QuerySingleRow

;===============================================================================
;
; Function Name:    _SQLite_SQLiteExe()
; Description:      Executes commands in SQLite.exe
; Parameter(s):     $sDatabaseFile - Database Filename
;					$sInput - Commands for SQLite.exe
;					$sOutput - Raw Output from SQLite.exe
;					$sSQLiteExeFilename - optional, Path to SQlite3.exe (-1 is default)
; Return Value(s):  On Success - Returns $SQLITE_OK
;                   On Failure - Return Value can be compared against $SQLITE_* Constants
; @error Value(s):	1 - Cant create new Database
;					2 - SQLite3.exe not Found
;					3 - SQL error / Incomplete SQL
;					4 - Cant open input file
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_SQLiteExe($sDatabaseFile, $sInput, ByRef $sOutput, $sSQLiteExeFilename = -1, $fDebug = False)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	Local $sInputFile = _TempFile(), $sOutputFile = _TempFile(), $iRval = $SQLITE_OK, $nErrorLevel
	Local $hInputFile, $sCmd, $hNewFile
	If $sSQLiteExeFilename = -1 Or (IsKeyword($sSQLiteExeFilename) And $sSQLiteExeFilename = Default) Then
		$sSQLiteExeFilename = "SQLite3.exe"
		If Not FileExists($sSQLiteExeFilename) Then
			Local $i, $aTemp = StringSplit(@AutoItExe, "\")
			$sSQLiteExeFilename = ""
			For $i = 1 to $aTemp[0]-1
				$sSQLiteExeFilename &= $aTemp[$i] & "\"
			Next
			$sSQLiteExeFilename &= "Extras\SQLite\SQLite3.exe"
		EndIf
	EndIf
	If Not FileExists($sDatabaseFile) Then
		$hNewFile = FileOpen($sDatabaseFile, 2 + 8)
		If $hNewFile = -1 Then
			Return SetError(1, 0, $SQLITE_CANTOPEN) ; Cant Create new Database
		EndIf
		FileClose($hNewFile)
	EndIf
	$hInputFile = FileOpen($sInputFile, 2)
	If $hInputFile > -1 Then
		$sInput = ".output stdout" & @CRLF & $sInput
		FileWrite($hInputFile, $sInput)
		FileClose($hInputFile)
		$sCmd = @ComSpec & " /c " & FileGetShortName($sSQLiteExeFilename) & '  "' _
				 & FileGetShortName($sDatabaseFile) _
				 & '" > "' & FileGetShortName($sOutputFile) _
				 & '" < "' & FileGetShortName($sInputFile) & '"'
		$nErrorLevel = RunWait($sCmd, @WorkingDir, @SW_HIDE)
		If $fDebug = True Then
			Local $nErrorTemp = @error
			ConsoleWrite('@@ Debug(_SQLite_SQLiteExe) : $sCmd = ' & $sCmd & @LF & '>ErrorLevel: ' & $nErrorLevel & @LF)
			SetError($nErrorTemp)
		EndIf
		If @error = 1 Or $nErrorLevel = 1 Then
			$iRval = $SQLITE_MISUSE ; SQLite.exe not found
		Else
			$sOutput = FileRead($sOutputFile, FileGetSize($sOutputFile))
			If StringInStr($sOutput, "SQL error:", 1) > 0 Or StringInStr($sOutput, "Incomplete SQL:", 1) > 0 Then $iRval = $SQLITE_ERROR ; SQL error / Incomplete SQL
		EndIf
	Else
		$iRval = $SQLITE_CANTOPEN ; Cant open Input File
	EndIf
	If FileExists($sInputFile) Then FileDelete($sInputFile)
	Switch $iRval
		Case $SQLITE_MISUSE
			SetError(2)
		Case $SQLITE_ERROR
			SetError(3)
		Case $SQLITE_CANTOPEN
			SetError(4)
	EndSwitch
	Return $iRval
EndFunc   ;==>_SQLite_SQLiteExe

;===============================================================================
;
; Function Name:    _SQLite_Encode()
; Description:      Encodes Strings or Binary data for use in SQLite Query's
; Parameter(s):     $vData - Data To be encoded (String, Number or BinaryString)
; Return Value(s):  On Success - Returns Encoded String
;                   On Failure - Returns Empty String
; @error Value(s):	1 - Data could not be encoded
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Encode($vData)
	Local $iCnt, $vRval
	If IsNumber($vData) Then $vData = String($vData)
	If IsString($vData) Or IsBinary($vData) Then
		$vRval = "X'"
		If StringLower(StringLeft($vData, 2)) = "0x" And Not IsBinary($vData) Then
			; BinaryString would mess this up...
			For $iCnt = 1 To StringLen($vData)
				$vRval &= Hex(Asc(StringMid($vData, $iCnt)), 2)
			Next
		Else
			; BinaryString is Faster
			If Not IsBinary($vData) Then $vData = Binary($vData)
			$vRval &= Hex($vData)
		EndIf
		$vRval &= "'"
		Return $vRval
	EndIf
	Return SetError(1, 0, "")
EndFunc   ;==>_SQLite_Encode

;===============================================================================
;
; Function Name:    _SQLite_Escape()
; Description:      Escapes a String
; Parameter(s):		$sString - String to escape.
;					$iBuffSize - Optional
; Return Value(s):  On Success - Returns Escaped String
;                   On Failure - Returns Empty String
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_mprintf'
; Author(s):        piccaso (Fida Florian)
;
;===============================================================================
;
Func _SQLite_Escape($sString, $iBuffSize = Default)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, "")
	Local $aRval, $sResult
	$aRval = DllCall($g_hDll_SQLite, "ptr:cdecl", "sqlite3_mprintf", "str", "'%q'", "str", $sString)
	If @error > 0 Then Return SetError(1, 0, ""); DLLCall Error 'sqlite3_mprintf'
	If IsKeyword($iBuffSize) Or $iBuffSize < 1 Then $iBuffSize = -1
	$sResult = __SQLite_szStringRead($aRval[0], $iBuffSize)
	DllCall($g_hDll_SQLite, "none:cdecl", "sqlite3_free", "ptr", $aRval[0])
	Return $sResult
EndFunc   ;==>_SQLite_Escape

#region		SQLite.au3 Internal Functions
; $g_avSafeMode_SQLite[0] -> Savemode State (boolean)
; $g_avSafeMode_SQLite[1] -> Array containing known $hDB handles
; $g_avSafeMode_SQLite[2] -> Array containing known $hQuery handles
; $g_avSafeMode_SQLite[3] -> pseudo dll handle for 'msvcrt.dll'
; $g_avSafeMode_SQLite[4] -> Array of Temp Files

Func __SQLite_hChk(ByRef $hGeneric, $iHandleType)
	If $hGeneric = -1 Or $hGeneric = "" Or IsKeyword($hGeneric) Then
		If $iHandleType = $SQLITE_DBHANDLE Then
			$hGeneric = $g_hDB_SQLite
		Else
			Return $SQLITE_ERROR
		EndIf
	EndIf
	If $g_avSafeMode_SQLite[0] = False Then
		Return $SQLITE_OK
	ElseIf _ArraySearch($g_avSafeMode_SQLite[$iHandleType], $hGeneric) > 0 Then
		Return $SQLITE_OK
	EndIf
	Return $SQLITE_ERROR
EndFunc   ;==>__SQLite_hChk

Func __SQLite_hAdd($hGeneric, $iHandleType)
	_ArrayAdd($g_avSafeMode_SQLite[$iHandleType], $hGeneric)
EndFunc   ;==>__SQLite_hAdd

Func __SQLite_hDel($hGeneric, $iHandleType)
	Local $iElement = _ArraySearch($g_avSafeMode_SQLite[$iHandleType], $hGeneric)
	If $iElement > 0 Then
		_ArrayDelete($g_avSafeMode_SQLite[$iHandleType], $iElement)
	EndIf
EndFunc   ;==>__SQLite_hDel

Func __SQLite_VersCmp($sFile, $sVersion)
	Local $avRval = DllCall($sFile, "int:cdecl", "sqlite3_libversion_number")
	If @error Then Return $SQLITE_CORRUPT ; Not SQLite3.dll or Not found
	If $avRval[0] >= $sVersion Then Return $SQLITE_OK ; Version OK
	Return $SQLITE_MISMATCH ; Version Older
EndFunc   ;==>__SQLite_VersCmp

Func __SQLite_hDbg()
	Local $i, $aTmp
	ConsoleWrite("State : " & $g_avSafeMode_SQLite[0] & @CR)
	$aTmp = $g_avSafeMode_SQLite[1]
	For $i = 0 To UBound($aTmp) - 1
		ConsoleWrite("$g_avSafeMode_SQLite[hDB]     -> [" & $i & "]" & $aTmp[$i] & @CR)
	Next
	$aTmp = $g_avSafeMode_SQLite[2]
	For $i = 0 To UBound($aTmp) - 1
		ConsoleWrite("$g_avSafeMode_SQLite[hQuery]  -> [" & $i & "]" & $aTmp[$i] & @CR)
	Next
EndFunc   ;==>__SQLite_hDbg

Func __SQLite_ReportError($hDB, $sFunction, $sQuery = Default, $sError = Default, $vReturnValue = Default)
	If @Compiled Then Return
	If IsKeyword($sError) Then $sError = _SQLite_ErrMsg($hDB)
	If IsKeyword($sQuery) Then $sQuery = ""
	Local $sOut
	$sOut &= "!   SQLite.au3 Error" & @LF
	$sOut &= "--> Function: " & $sFunction & @LF
	If $sQuery <> "" Then $sOut &= "--> Query:    " & $sQuery & @LF
	$sOut &= "--> Error:    " & $sError & @LF
	ConsoleWrite($sOut & @LF)
	If Not IsKeyword($vReturnValue) Then Return $vReturnValue
EndFunc   ;==>__SQLite_ReportError

Func __SQLite_szStringRead($iszPtr, $iLen = -1)
    Local $aStrLen, $vszString
    If $iszPtr = 0 Then Return ""
    If $iLen < 1 Then
        If $g_avSafeMode_SQLite[3] < 1 Then $g_avSafeMode_SQLite[3] = DllOpen("msvcrt.dll")
        $aStrLen = DllCall($g_avSafeMode_SQLite[3], "int:cdecl", "strlen", "ptr", $iszPtr)
        If @error Then Return SetError(1, 0, "")
        $iLen = $aStrLen[0] + 1
    EndIf
    $vszString = DllStructCreate("char[" & $iLen & "]", $iszPtr)
    If @error Then Return SetError(2, 0, "")
    Return SetError(0, $iLen, DllStructGetData($vszString, 1))
EndFunc   ;==>__SQLite_szStringRead
#endregion 	SQLite.au3 Internal Functions
