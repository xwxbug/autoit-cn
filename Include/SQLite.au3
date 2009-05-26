#include-once
#AutoIt3Wrapper_plugin_funcs=__SQLite_Inline_Version, __SQLite_Inline_Modified, __SQLite_Inline_SQLite3Dll

#include <Array.au3> 	; Using: _ArrayCreate(),_ArrayAdd(),_ArrayDelete(),_ArraySearch()
#include <File.au3> 	; Using: _TempFile()

; #INDEX# =======================================================================================================================
; Title .........: SQLite
; AutoIt Version : 3.2.4.9
; Language ......: English
; Description ...: Functions that assist access to an SQLite database.
; Author(s) .....: Fida Florian (piccaso), jchd, jpm
; Dll ...........: SQLite3.dll
; ===============================================================================================================================

; ------------------------------------------------------------------------------
; This software is provided 'as-is', without any express or
; implied warranty.  In no event will the authors be held liable for any
; damages arising from the use of this software.

; #CURRENT# =====================================================================================================================
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
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
;__SQLite_hChk
;__SQLite_hAdd
;__SQLite_hDel
;__SQLite_VersCmp
;__SQLite_hDbg
;__SQLite_ReportError
;__SQLite_szStringRead
;__SQLite_szFree
;__SQLite_StringToUtf8Struct
;__SQLite_Utf8StructToString
; ===============================================================================================================================

#comments-start
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
	29.11.05	Changed _SQLite_Display2DResult(), Better Formating for Larger Tables & Ability to Return the Result
	30.11.05	Changed _SQLite_GetTable2d(), Ability to Switch Dimensions
	30.11.05	Fixed _SQLite_Display2DResult() $iCellWidth was ignored
	03.12.05	Added _SQLite_QuerySingleRow()
	04.12.05	Changed Standard $hDB Handling (Thank you jpm)
	04.12.05	Fixed Return Values of _SQLite_LibVersion(),_SQLite_LastInsertRowID(),_SQLite_Changes(),_SQLite_TotalChanges()
	04.12.05	Changed _SQLite_Open() now opens a ':memory:' database if no name specified
	05.12.05	Changed _SQLite_FetchData() NULL Values will be Skipped
	10.12.05	Changed _SQLite_QuerySingleResult() now uses 'sqlite3_get_table' API
	13.12.05	Added _SQLite_SQLiteExe() Wrapper for SQLite3.exe
	29.03.06	Removed _SQLite_SetGlobalTimeout()
	29.03.06	Added _SQLite_SetTimeout()
	17.05.06	:cdecl to support autoit debugging version
	18.05.06	_SQLite_SQLiteExe() now Creates nonexistent Directories
	18.05.06	Fixed SyntaxCheck Warnings (_SQLite_GetTable2d())
	21.05.06	Added support for Default Keyword for all Optional parameters
	25.05.06	Added _SQLite_Encode()
	25.05.06	Changed _SQLite_QueryNoResult() -> _SQLite_Execute()
	25.05.06	Changed _SQLite_FetchData() Binary Mode
	26.05.06	Removed _SQLite_GlobalRecover() out-of-memory recovery is automatic since SQLite 3.3.0
	26.05.06	Changed @error Values & Improved error catching (see Function headers)
	31.05.06	jpm's Nice @error values setting
	04.06.06	Inline SQLite3.dll
	08.06.06	Changed _SQLite_Exec(), _SQLite_GetTable2d(), _SQLite_GetTable() Removed '$sErrorMsg' parameter
	08.06.06	Removed _SQLite_Execute() because _SQLite_Exec() was the same
	08.06.06	Cleaning _SQlite_Startup(). (jpm)
	23.09.06	Fixed _SQLite_Exec() Memory Leak on SQL error
	23.09.06	Added SQL Error Reporting (only in interpreted mode)
	23.09.06	Added _SQLite_Escape()
	24.09.06	Changed _SQLite_Escape(), Changed _SQLite_GetTable*() New szString Reading method, Result will no longer be truncated
	25.09.06	Fixed Bug in szString read procedure (_SQLite_GetTable*, _SQLite_QuerySingleRow, _SQLite_Escape)
	29.09.06	Faster szString Reading, Function Header corrections
	29.09.06	Changed _SQLite_Exec() Callback
	12.03.07	Changed _SQLite_Query() to use 'sqlite3_prepare_v2' API
	16.03.07	Fixed _SQLite_Open() not setting @error, Missing DllClose() in _SQLite_Shutdown(), Stack corruption in szString reading procedure
	17.03.07	Improved Error handling/Reporting
	08.07.07	Fixed Bug in version comparison procedure
	26.10.07	Fixed _SQLite_SQLiteExe() referencing by default "Extras\SQLite\SQlite3.exe"
	23.06.08	Fixed _SQLite_* misuse if _SQLite_Startup() failed
	23.01.09	Fixed memory leak on error -> __SQLite_szFree() internal function
	01.05.09	Changed _SQLite_*() functions dealing with AutoIt Strings (Unicode string) for queries and results, without ANSI conversion.
				Note: no point for a Unicode version of _SQLite_SQLiteEXE() since the DOS console doesn't handle Unicode. (jchd)
	02.05.09	Added _SQLite_Open() accepts a second parameter for read/write/create access mode. (jchd)
	04.05.09	Added _SQLite_Open() accepts a third parameter for UTF8/UTF16 encoding mode (Only use at creation time). (jpm)
				Warn: _SQLite_Open() is using now Filename that are Unicode as SQLite expects. Previous version was sending only Filenames with
					  ASCII characters so previously script can have create valid ASCII filenames no more unreachable.
#comments-end

; #CONSTANTS# ===================================================================================================================
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

Global Const $SQLITE_OPEN_READONLY = 0x01  ; /* Database opened as read-only */
Global Const $SQLITE_OPEN_READWRITE = 0x02  ; /* Database opened as read-write */
Global Const $SQLITE_OPEN_CREATE = 0x04  ; /* Database will be created if not exists */

Global Const $SQLITE_ENCODING_UTF8 = 0	; /* Database will be created if not exists with UTF8 encoding (default) */
Global Const $SQLITE_ENCODING_UTF16 = 1	; /* Database will be created if not exists with UTF16le encoding */
Global Const $SQLITE_ENCODING_UTF16be = 2	; /* Database will be created if not exists with UTF16be encoding (special usage) */

; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $g_hDll_SQLite = 0
Global $g_hDB_SQLite = 0
Global $g_avSafeMode_SQLite = _ArrayCreate(1, _ArrayCreate(''), _ArrayCreate(''), 0, _ArrayCreate(''))
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Startup
; Description ...: Loads SQLite.dll
; Syntax.........: _SQLite_Startup($sDll_Filename = "")
; Parameters ....: $sDll_Filename - Optional, Dll Filename
; Return values .: On Success - Returns path to SQLite3.dll
;                  On Failure - Returns empty string
;                   @error Value(s):	1 - Error Loading Dll
; Author ........: piccaso (Fida Florian)
; Modified.......: jpm
; Remarks .......: _SQLite_Startup([$sDll_Filename]) Loads SQLite3.dll
; ===============================================================================================================================
Func _SQLite_Startup($sDll_Filename = "")
	Local $fUseInline = True
	If IsKeyword($sDll_Filename) Or $sDll_Filename = "" Or $sDll_Filename = -1 Then
		If @AutoItX64 = 0 Then
			$sDll_Filename = "sqlite3.dll"
		Else
			$sDll_Filename = "sqlite3_x64.dll"
		EndIf
		Local $vInlineVersion = Call('__SQLite_Inline_Version')
		If @error Then $fUseInline = False
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
		Local $hFileDllOut = -1
		If $fUseInline Then
			$sDll_Filename = @SystemDir & "\" & $sDll_Filename
			If Not FileExists($sDll_Filename) Then
				$hFileDllOut = FileOpen($sDll_Filename, 2)
			EndIf
			If $hFileDllOut = -1 Then
				$sDll_Filename = _TempFile(@TempDir, "~", ".dll")
				$hFileDllOut = FileOpen($sDll_Filename, 2)
				If $hFileDllOut = -1 Then Return SetError(1, 0, "")
				_ArrayAdd($g_avSafeMode_SQLite[4], $sDll_Filename)
			EndIf
			FileWrite($hFileDllOut, __SQLite_Inline_SQLite3Dll())
			FileClose($hFileDllOut)
			FileSetTime($sDll_Filename, __SQLite_Inline_Modified(), 0)
		EndIf
	EndIf
	Local $hDll = DllOpen($sDll_Filename)
	If $hDll = -1 Then
		$g_hDll_SQLite = 0
		Return SetError(1, 0, "")
	Else
		$g_hDll_SQLite = $hDll
		Return $sDll_Filename
	EndIf
EndFunc   ;==>_SQLite_Startup

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Shutdown
; Description ...: Unloads SQLite Dll
; Syntax.........: _SQLite_Shutdown()
; Parameters ....:
; Return values .: None
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_Shutdown()
	If $g_hDll_SQLite > 0 Then DllClose($g_hDll_SQLite)
	$g_hDll_SQLite = 0
	If $g_avSafeMode_SQLite[3] > 0 Then DllClose($g_avSafeMode_SQLite[3])
	$g_avSafeMode_SQLite[3] = 0
	For $sTempFile In $g_avSafeMode_SQLite[4]
		If FileExists($sTempFile) Then FileDelete($sTempFile)
	Next
EndFunc   ;==>_SQLite_Shutdown

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Open
; Description ...: Opens a Database
; Syntax.........: _SQLite_Open($sDatabase_Filename = ":memory:", $iAccessMode = Default, $iEncoding = Default)
; Parameters ....: $sDatabase_Filename - Optional, Database Filename (uses ':memory:' db by default)
;                  $iAccessMode - Optional, access mode flags. Defaults to $SQLITE_OPEN_READWRITE + $SQLITE_OPEN_CREATE
;                  $iEncoding   - Optional, encoding mode flag. Defaults to $SQLITE_ENCODING_UTF8
; Return values .: Returns Database Handle
;                    @error Value(s):	   1 - Error Calling SQLite API 'sqlite3_open_v2'
;					  -1 - SQLite Reported an Error (Check @extended Value)
;                   @extended Value(s): Can be compared against $SQLITE_* Constants
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd, jpm
; ===============================================================================================================================
Func _SQLite_Open($sDatabase_Filename = Default, $iAccessMode = Default, $iEncoding = Default)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If IsKeyword($sDatabase_Filename) Then $sDatabase_Filename = ":memory:"
	Local $tFilename = __SQLite_StringToUtf8Struct($sDatabase_Filename)
	If IsKeyword($iAccessMode) Then $iAccessMode = BitOR($SQLITE_OPEN_READWRITE, $SQLITE_OPEN_CREATE)
	Local $OldBase = FileExists($sDatabase_Filename)	; encoding cannot be changed if base already exists
	If IsKeyword($iEncoding) Then
		$iEncoding = $SQLITE_ENCODING_UTF8
	EndIf
	Local $avRval
	$avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_open_v2", "ptr", DllStructGetPtr($tFilename), _ ; UTF-8 Database filename
					"long*", 0, _ ; OUT: SQLite db handle
					"int", $iAccessMode, _ ; database access mode
					"ptr", 0)
	If @error > 0 Then 	Return SetError(1, $SQLITE_MISUSE, 0) ; Dllcall error
	If $avRval[0] = $SQLITE_OK Then
		$g_hDB_SQLite = $avRval[2]
		__SQLite_hAdd($avRval[2], $SQLITE_DBHANDLE)
		If Not $OldBase Then
			Local $encoding[3] = ["8", "16", "16be"]
			_SQLite_Exec($avRval[2], 'PRAGMA encoding="UTF-' & $Encoding[$iEncoding] & '";')
		EndIf
		Return SetError(0, $avRval[0], $avRval[2])
	Else
		__SQLite_ReportError($avRval[2], "_SQLite_Open")
		_SQLite_Close($avRval[2])
		Return SetError(-1, $avRval[0], 0)
	EndIf
EndFunc   ;==>_SQLite_Open

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_GetTable
; Description ...: Passes Out a 1Dimensional Array Containing Tablenames and Data of Executed Query
; Syntax.........: _SQLite_GetTable($hDB, $sSQL, ByRef $aResult, ByRef $iRows, ByRef $iColumns, $iCharSize = -1)
; Parameters ....: $hDB - An Open Database, Use -1 To use Last Opened Database
;				   $sSQL - SQL Statement to be executed
;				   ByRef $aResult - Passes out the Result
;				   ByRef $iRows - Passes out the amount of 'data' Rows
;				   ByRef $iColumns - Passes out the amount of Columns
;				   $iCharSize - Optional, Specifies the maximal size of a Data Field
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;                    1 - Error Calling SQLite API 'sqlite3_get_table'
;					 2 - Error Calling SQLite API 'sqlite3_free_table'
;					 3 - Call Prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_GetTable($hDB, $sSQL, ByRef $aResult, ByRef $iRows, ByRef $iColumns, $iCharSize = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(3, 0, $SQLITE_MISUSE)
	If $iCharSize = 0 Or $iCharSize = "" Or $iCharSize < 1 Or IsKeyword($iCharSize) Then $iCharSize = -1
	Local $tSQL8 = __SQLite_StringToUtf8Struct($sSQL)
	Local $r = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_get_table", _
			"ptr", $hDB, _ ; An open database
			"ptr", DllStructGetPtr($tSQL8, 1), _ ; UTF-8 SQL to be executed
			"long*", 0, _ ; Result written to a char *[]  that this points to
			"long*", 0, _ ; Number of result rows written here
			"long*", 0, _ ; Number of result columns written here
			"long*", 0)   ; Error msg written here
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	Local $pResult = $r[3]
	$iRows = $r[4]
	$iColumns = $r[5]
	Local $struct1 = ""
	Local $iResultSize = (($iRows) + 1) * ($iColumns)
	For $i = 1 To $iResultSize - 1
		$struct1 &= "ptr;"
	Next
	$struct1 &= "ptr"
	Local $struct2 = DllStructCreate($struct1, $pResult)
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
	If @error > 0 Then SetError(2, @error) ; Dllcall error
	If $r[0] <> $SQLITE_OK Then
		__SQLite_ReportError($hDB, "_SQLite_GetTable", $sSQL)
		SetError(-1)
	EndIf
	__SQLite_szFree($r[6])
	Return $r[0]
EndFunc   ;==>_SQLite_GetTable

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Exec
; Description ...: Executes a SQLite Query, Does not handle Results
; Syntax.........:  _SQLite_Exec($hDB, $sSQL, $sCallBack = "")
; Parameters ....: $hDB - An Open Database, Use -1 To use Last Opened Database
;				   $sSQL - SQL Statement to be executed
;				   $sCallBack - Optional, Callback Function
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_exec'
;					 2 - Call Prevented by SaveMode
;					 3 - Error Processing Callback
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_Exec($hDB, $sSQL, $sCallBack = "")
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	If $sCallBack <> "" Then
		Local $iRows, $iColumns
		Local $aResult = "SQLITE_CALLBACK:" & $sCallBack
		Local $iRval = _SQLite_GetTable2d($hDB, $sSQL, $aResult, $iRows, $iColumns)
		If @error Then Return SetError(3, @error, $iRval)
		Return $iRval
	EndIf
	Local $tSQL8 = __SQLite_StringToUtf8Struct($sSQL)
	Local $avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_exec", _
			"ptr", $hDB, _ ; An open database
			"ptr", DllStructGetPtr($tSQL8, 1), _ ; SQL to be executed
			"ptr", 0, _ ; Callback function
			"ptr", 0, _ ; 1st argument to callback function
			"long*", 0) ; Error msg written here
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	If $avRval[0] <> $SQLITE_OK Then
		__SQLite_ReportError($hDB, "_SQLite_Exec", $sSQL)
		SetError(-1)
	EndIf
	__SQLite_szFree($avRval[5])
	Return $avRval[0]
EndFunc   ;==>_SQLite_Exec

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_LibVersion
; Description ...: Returns the version number of the library
; Syntax.........: _SQLite_LibVersion()
; Parameters ....:
; Return values .: Returns version number
;                  @error Value(s):	1 - Error Calling SQLite API 'sqlite3_libversion'
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_LibVersion()
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	Local $r = DllCall($g_hDll_SQLite, "str:cdecl", "sqlite3_libversion")
	If @error > 0 Then Return SetError(1, @error, 0) ; Dllcall error
	Return $r[0]
EndFunc   ;==>_SQLite_LibVersion

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_LastInsertRowID
; Description ...: Returns the ROWID of the most recent insert in the database
; Syntax.........: _SQLite_LastInsertRowID($hDB = -1)
; Parameters ....: $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return values .: Returns ROWID
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_last_insert_rowid'
; 					2 - Call Prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_LastInsertRowID($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, 0)
	Local $r = DllCall($g_hDll_SQLite, "long:cdecl", "sqlite3_last_insert_rowid", "ptr", $hDB)
	If @error > 0 Then Return SetError(1, @error, 0) ; Dllcall error
	Return $r[0]
EndFunc   ;==>_SQLite_LastInsertRowID

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Changes
; Description ...: Returns the number of database rows that were changed by the most recently completed query
; Syntax.........: _SQLite_Changes($hDB = -1)
; Parameters ....: $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return values .: Returns number of Changes
;                   @error Value(s):	1 - Error Calling SQLite API 'sqlite3_changes'
; 					2 - Call Prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_Changes($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, 0)
	Local $r = DllCall($g_hDll_SQLite, "long:cdecl", "sqlite3_changes", "ptr", $hDB)
	If @error > 0 Then Return SetError(1, @error, 0) ; Dllcall error
	Return $r[0]
EndFunc   ;==>_SQLite_Changes

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_TotalChanges
; Description ...: Returns the total number of database rows that have be modified, inserted, or deleted since the database connection was created
; Syntax.........: _SQLite_TotalChanges($hDB = -1)
; Parameters ....: $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return values .: Returns number of Total Changes
; @error Value(s):	1 - Error Calling SQLite API 'sqlite3_total_changes'
; 					2 - Call Prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_TotalChanges($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, 0)
	Local $r = DllCall($g_hDll_SQLite, "long:cdecl", "sqlite3_total_changes", "ptr", $hDB)
	If @error > 0 Then Return SetError(1, @error, 0) ; Dllcall error
	Return $r[0]
EndFunc   ;==>_SQLite_TotalChanges

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_ErrCode
; Description ...: Returns the error code for the most recent failed sqlite3_* API call
; Syntax.........: _SQLite_ErrCode($hDB = -1)
; Parameters ....: $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return values .: On Success - Return Value can be compared against $SQLITE_* Constants
;                  @error Value(s):	1 - Error Calling SQLite API 'sqlite3_errcode'
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_ErrCode($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return $SQLITE_MISUSE
	Local $r = DllCall($g_hDll_SQLite, "long:cdecl", "sqlite3_errcode", "ptr", $hDB)
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	Return $r[0]
EndFunc   ;==>_SQLite_ErrCode

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_ErrMsg
; Description ...: Returns a String describing in English the error condition for the most recent sqlite3_* API call
; Syntax.........: _SQLite_ErrMsg($hDB = -1)
; Parameters ....: $hDB - Optional, An Open Database, Default is the Last Opened Database
; Return values .: On Success - Returns Error message
;                   @error Value(s):	1 - Error Calling SQLite API 'sqlite3_errmsg16'
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_ErrMsg($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, 0)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return "Library used incorrectly"
	Local $r = DllCall($g_hDll_SQLite, "wstr:cdecl", "sqlite3_errmsg16", "ptr", $hDB)
	If @error > 0 Then Return SetError(1, @error, "Library used incorrectly") ; Dllcall error
	Return $r[0]
EndFunc   ;==>_SQLite_ErrMsg

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Display2DResult
; Description ...: Prints a 2Dimensional Array of data formated to Console
; Syntax.........: _SQLite_Display2DResult($aResult, $iCellWidth = 0, $nReturn = 0)
; Parameters ....: $aResult - The Array of data to be displayed
;				   $iCellWidth - Optional, Specifies the size of a Data Field
;				   $nReturn - Optional, If true The Formated String is returned
; Return values .: none or Formated String
;                   @error Value(s):	1 - $aResult is no Array or has wrong Dimension
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_Display2DResult($aResult, $iCellWidth = 0, $nReturn = 0)
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
			If $nReturn = 1 Then
				$sOut &= StringFormat(" %-" & $iCellWidthUsed & "s ", $aResult[$iCol][$iRow])
			ElseIf $nReturn = 0 Then
				ConsoleWrite(StringFormat(" %-" & $iCellWidthUsed & "s ", $aResult[$iCol][$iRow]))
			Else
				; can be used when sending to application such SCiTE configured with output.code.page=65001
				Local $tStr8 = __SQLite_StringToUtf8Struct(StringFormat(" %-" & $iCellWidthUsed & "s ", $aResult[$iCol][$iRow]))
				ConsoleWrite(DllStructGetData($tStr8, 1))
			EndIf
		Next
		If $nReturn = 1 Then
			$sOut &= @CRLF
		Else
			ConsoleWrite(@CR)
		EndIf
	Next
	If $nReturn Then Return $sOut
EndFunc   ;==>_SQLite_Display2DResult

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_GetTable2d
; Description ...: Passes Out a 2Dimensional Array Containing Column names and Data of Executed Unicode Query
; Syntax.........: _SQLite_GetTable2d($hDB, $sSQL, ByRef $aResult, ByRef $iRows, ByRef $iColumns, $iCharSize = -1, $fSwichDimensions = False)
; Parameters ....: $hDB - An Open Database, Use -1 To use Last Opened Database
;				   $sSQL - SQL Statement to be executed
;				   ByRef $aResult - Passes out the Result
;				   ByRef $iRows - Passes out the amount of 'data' Rows
;				   ByRef $iColumns - Passes out the amount of Columns
;				   $iCharSize - Optional, Specifies the maximal size of a Data Field
;				   $fSwichDimensions - Optional, Swiches Dimensions
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_get_table'
;					 2 - Error Calling SQLite API 'sqlite3_free_table'
;					 3 - Call Prevented by SaveMode
; Author ........: piccaso (Fida Florian), blink314
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_GetTable2d($hDB, $sSQL, ByRef $aResult, ByRef $iRows, ByRef $iColumns, $iCharSize = -1, $fSwichDimensions = False)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(3, 0, $SQLITE_MISUSE)
	Local $iResultSize, $struct1, $iColCnt, $iRowCnt, $sCallBack, $iCbRval
	If $iCharSize = 0 Or $iCharSize = "" Or $iCharSize < 1 Or IsKeyword($iCharSize) Then $iCharSize = -1
	If IsKeyword($fSwichDimensions) Then $fSwichDimensions = False
	Local $tSQL8 = __SQLite_StringToUtf8Struct($sSQL)
	Local $r = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_get_table", _
			"ptr", $hDB, _ ; An open database
			"ptr", DllStructGetPtr($tSQL8, 1), _ ; UTF-8 SQL to be executed
			"long*", 0, _ ; Result written to a char *[]  that this points to
			"long*", 0, _ ; Number of result rows written here
			"long*", 0, _ ; Number of result columns written here
			"long*", 0)   ; Error msg written here
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	Local $pResult = $r[3]
	$iRows = $r[4]
	$iColumns = $r[5]
	If $iColumns > 0 And $iRows > 0 Then
		$iResultSize = (($iRows) + 1) * ($iColumns)
		For $i = 1 To $iResultSize - 1
			$struct1 &= "ptr;"
		Next
		$struct1 &= "ptr"
		Local $struct2 = DllStructCreate($struct1, $pResult)
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
						Return SetError(99, $iCbRval, $r[0]) ; Internal only
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
	If @error > 0 Then SetError(2, @error) ; Dllcall error
	If $r[0] <> $SQLITE_OK Then
		__SQLite_ReportError($hDB, "_SQLite_GetTable2d or _SQLite_QuerySingleRow or _SQLite_Exec", $sSQL)
		__SQLite_szFree($r[6])
		SetError(-1)
	EndIf
	Return $r[0]
EndFunc   ;==>_SQLite_GetTable2d

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_SetTimeout
; Description ...: Sets Timeout for busy handler
; Syntax.........: _SQLite_SetTimeout($hDB = -1, $iTimeout = 1000)
; Parameters ....: $hDB - An Open Database, Use -1 To use Last Opened Database
;                  $iTimeout - Timeout [msec]
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_busy_timeout'
;					 2 - Call prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_SetTimeout($hDB = -1, $iTimeout = 1000)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	If IsKeyword($iTimeout) Then $iTimeout = 1000
	Local $avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_busy_timeout", "ptr", $hDB, "int", $iTimeout)
	If @error > 0 Then
		SetError(1, @error) ; Dllcall error
	ElseIf $avRval[0] <> $SQLITE_OK Then
		SetError(-1)
	EndIf
	Return $avRval[0]
EndFunc   ;==>_SQLite_SetTimeout

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Query
; Description ...: Prepares a SQLite Query
; Syntax.........: _SQLite_Query($hDB, $sSQL, ByRef $hQuery)
; Parameters ....: $hDB - An Open Database, Use -1 To use Last Opened Database
;				   $sSQL - SQL Statement to be executed
;				   ByRef $hQuery - Passes out a Query Handle
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_prepare16_v2'
;					 2 - Call prevented by SafeMode
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_Query($hDB, $sSQL, ByRef $hQuery)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $iRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_prepare16_v2", _
			"ptr", $hDB, _
			"wstr", $sSQL, _
			"int", -1, _
			"long*", 0, _ ; OUT: Statement handle
			"long*", 0)   ; OUT: Pointer to unused portion of zSql
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	If $iRval[0] = $SQLITE_OK Then
		$hQuery = $iRval[4]
		__SQLite_hAdd($iRval[4], $SQLITE_QUERYHANDLE)
		Return $iRval[0]
	Else
		__SQLite_ReportError($hDB, "_SQLite_Query", $sSQL)
		Return SetError(-1, 0, $iRval[0])
	EndIf
EndFunc   ;==>_SQLite_Query

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_FetchData
; Description ...: Fetches 1 Row of Data from a _SQLite_Query() based query
; Syntax.........: _SQLite_FetchData($hQuery, ByRef $aRow, $fBinary = False)
; Parameters ....: $hQuery - Query handle passed out by _SQLite_Query()
;				   ByRef $aRow - A 1 dimensional Array containing a Row of Data
;				   $fBinary - Switch for Binary mode ($aRow will be a Array of Binary Strings)
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_step'
;					 2 - Error Calling SQLite API 'sqlite3_data_count'
;					 3 - Error Calling SQLite API 'sqlite3_column_text16'
;					 4 - Error Calling SQLite API 'sqlite3_column_type'
;					 5 - Error Calling SQLite API 'sqlite3_column_bytes'
;					 6 - Error Calling SQLite API 'sqlite3_column_blob'
;					 7 - Call prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_FetchData($hQuery, ByRef $aRow, $fBinary = False)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hQuery, $SQLITE_QUERYHANDLE) = $SQLITE_OK Then Return SetError(7, 0, $SQLITE_MISUSE)
	If Not IsArray($aRow) Then
		Dim $aRow[1]
	EndIf
	Local $SQLITE_NULL = 5
	If IsKeyword($fBinary) Then $fBinary = False
	Local $iRval_Step = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_step", "ptr", $hQuery)
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	If $iRval_Step[0] = $SQLITE_ROW Then
		Local $iRval_ColCnt = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_data_count", "ptr", $hQuery)
		If @error > 0 Then Return SetError(2, @error, $SQLITE_MISUSE) ; Dllcall error
		If $iRval_ColCnt[0] > 0 Then
			ReDim $aRow[$iRval_ColCnt[0]]
			For $i = 0 To $iRval_ColCnt[0] - 1
				If Not $fBinary Then
					Local $iRval_coltype = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_column_type", "ptr", $hQuery, "int", $i)
					If @error > 0 Then Return SetError(4, @error, $SQLITE_MISUSE) ; Dllcall error
					If $iRval_coltype[0] = $SQLITE_NULL Then
						$aRow[$i] = ""
						ContinueLoop
					EndIf
					Local $sRval = DllCall($g_hDll_SQLite, "wstr:cdecl", "sqlite3_column_text16", "ptr", $hQuery, "int", $i)
					If @error > 0 Then Return SetError(3, @error, $SQLITE_MISUSE) ; Dllcall error
					$aRow[$i] = $sRval[0]
				Else
					Local $iColBytes = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_column_bytes", "ptr", $hQuery, "int", $i)
					If @error > 0 Then Return SetError(5, @error, $SQLITE_MISUSE) ; Dllcall error
					Local $vResult = DllCall($g_hDll_SQLite, "ptr:cdecl", "sqlite3_column_blob", "ptr", $hQuery, "int", $i)
					If @error > 0 Then Return SetError(6, @error, $SQLITE_MISUSE) ; Dllcall error
					Local $vResultStruct = DllStructCreate("byte[" & $iColBytes[0] & "]", $vResult[0])
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

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Close
; Description ...: Closes a open Database, Waits until SQLite <> $SQLITE_BUSY until 'global Timeout' has elapsed
; Syntax.........: _SQLite_Close($hDB = -1)
; Parameters ....: $hDB - Optional Database Handle
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_close'
;					 2 - Call prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_Close($hDB = -1)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hDB, $SQLITE_DBHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $iRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_close", "ptr", $hDB) ; An open database
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	If $iRval[0] = $SQLITE_OK Then
		$g_hDB_SQLite = 0
		__SQLite_hDel($hDB, $SQLITE_DBHANDLE)
		Return $iRval[0]
	EndIf
	__SQLite_ReportError($hDB, "_SQLite_Close")
	Return SetError(-1, 0, $iRval[0])
EndFunc   ;==>_SQLite_Close

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_SaveMode
; Description ...: Disable or Enable Save Mode
; Syntax.........: _SQLite_SaveMode($fSaveModeState)
; Parameters ....: $fSaveModeState	- True or False to enable or disable SafeMode
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Returns $SQLITE_MISUSE
;                   @error Value(s):	1 - Error Interpreting $fSaveModeState Parameter
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_SaveMode($fSaveModeState)
	If $fSaveModeState = False Then
		$g_avSafeMode_SQLite[0] = False
	ElseIf $fSaveModeState = True Then
		$g_avSafeMode_SQLite[0] = True
	Else
		Return SetError(1, 0, $SQLITE_MISUSE)
	EndIf
	Return $SQLITE_OK
EndFunc   ;==>_SQLite_SaveMode

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_QueryFinalize
; Description ...: Finalize _SQLite_Query() based query
; Syntax.........: _SQLite_QueryFinalize($hQuery)
; Parameters ....: $hQuery	- Query Handle Generated by SQLite_Query()
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_finalize'
;					 2 - Call prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_QueryFinalize($hQuery)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hQuery, $SQLITE_QUERYHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_finalize", "ptr", $hQuery)
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	__SQLite_hDel($hQuery, $SQLITE_QUERYHANDLE)
	If $avRval[0] <> $SQLITE_OK Then SetError(-1)
	Return $avRval[0]
EndFunc   ;==>_SQLite_QueryFinalize

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_QueryReset
; Description ...: Reset a _SQLite_Query() based query
; Syntax.........: _SQLite_QueryReset($hQuery)
; Parameters ....: $hQuery	- Query Handle Generated by SQLite_Query()
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_reset'
;					 2 - Call prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_QueryReset($hQuery)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hQuery, $SQLITE_QUERYHANDLE) = $SQLITE_OK Then Return SetError(2, 0, $SQLITE_MISUSE)
	Local $avRval = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_reset", "ptr", $hQuery)
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	If $avRval[0] <> $SQLITE_OK Then SetError(-1)
	Return $avRval[0]
EndFunc   ;==>_SQLite_QueryReset

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_FetchNames
; Description ...: Read out the Column names of a _SQLite_Query() based query
; Syntax.........: _SQLite_FetchNames($hQuery, ByRef $aNames)
; Parameters ....: $hQuery	- Query Handle Generated by SQLite_Query()
;                  ByRef $aNames - 1 Dimensional Array Containing the Column Names
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_column_count'
;					 2 - Error Calling SQLite API 'sqlite3_column_name16'
;					 3 - Call prevented by SaveMode
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_FetchNames($hQuery, ByRef $aNames)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	If Not __SQLite_hChk($hQuery, $SQLITE_QUERYHANDLE) = $SQLITE_OK Then Return SetError(3, 0, $SQLITE_MISUSE)
	If Not IsArray($aNames) Then Dim $aNames[1]
	Local $avDataCnt = DllCall($g_hDll_SQLite, "int:cdecl", "sqlite3_column_count", "ptr", $hQuery)
	If @error > 0 Then Return SetError(1, @error, $SQLITE_MISUSE) ; Dllcall error
	If $avDataCnt[0] > 0 Then
		ReDim $aNames[$avDataCnt[0]]
		Local $avColName
		For $iCnt = 0 To $avDataCnt[0] - 1
			$avColName = DllCall($g_hDll_SQLite, "wstr:cdecl", "sqlite3_column_name16", "ptr", $hQuery, "int", $iCnt)
			If @error > 0 Then Return SetError(2, @error, $SQLITE_MISUSE) ; Dllcall error
			$aNames[$iCnt] = $avColName[0]
		Next
		Return $SQLITE_OK
	Else
		Return SetError(-1, 0, $SQLITE_EMPTY)
	EndIf
EndFunc   ;==>_SQLite_FetchNames

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_QuerySingleRow
; Description ...: Read out the first Row of the Result from the Specified query
; Syntax.........:  _SQLite_QuerySingleRow($hDB, $sSQL, ByRef $aRow)
; Parameters ....: $hDB - An Open Database, Use -1 To use Last Opened Database
;				   $sSQL - SQL Statement to be executed
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                   @error Value(s):	-1 - SQLite Reported an Error (Check Return value)
;					 1 - Error Calling SQLite API 'sqlite3_get_table'
;					 2 - Error Calling SQLite API 'sqlite3_free_table'
;					 3 - Call Prevented by SaveMode
; Author ........: piccaso (Fida Florian), jchd
; ===============================================================================================================================
Func _SQLite_QuerySingleRow($hDB, $sSQL, ByRef $aRow)
	Local $aResult, $iRows, $iColumns
	$aRow = ""
	Dim $aRow[1]
	Local $iRval = _SQLite_GetTable2d($hDB, $sSQL, $aResult, $iRows, $iColumns)
	Local $iAu3Error = @error
	If $iRval = $SQLITE_OK And UBound($aResult, 0) > 0 Then
		ReDim $aRow[UBound($aResult, 2) ]
		For $i = 0 To UBound($aResult, 2) - 1
			$aRow[$i] = $aResult[1][$i]
		Next
	EndIf
	If $iAu3Error Then SetError($iAu3Error)
	Return $iRval
EndFunc   ;==>_SQLite_QuerySingleRow

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_SQLiteExe
; Description ...: Executes commands in SQLite.exe
; Syntax.........: _SQLite_SQLiteExe($sDatabaseFile, $sInput, ByRef $sOutput, $sSQLiteExeFilename = -1, $fDebug = False)
; Parameters ....: $sDatabaseFile - Database Filename
;				   $sInput - Commands for SQLite.exe
;				   $sOutput - Raw Output from SQLite.exe
;				   $sSQLiteExeFilename - optional, Path to SQlite3.exe (-1 is default)
; Return values .: On Success - Returns $SQLITE_OK
;                  On Failure - Return Value can be compared against $SQLITE_* Constants
;                  @error Value(s):	1 - Can't create new Database
;					2 - SQLite3.exe not Found
;					3 - SQL error / Incomplete SQL
;					4 - Can't open input file
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
Func _SQLite_SQLiteExe($sDatabaseFile, $sInput, ByRef $sOutput, $sSQLiteExeFilename = -1, $fDebug = False)
	If $g_hDll_SQLite = 0 Then Return SetError(1, 0, $SQLITE_MISUSE)
	Local $sInputFile = _TempFile(), $sOutputFile = _TempFile(), $iRval = $SQLITE_OK
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
		Local $hNewFile = FileOpen($sDatabaseFile, 2 + 8)
		If $hNewFile = -1 Then
			Return SetError(1, 0, $SQLITE_CANTOPEN) ; Can't Create new Database
		EndIf
		FileClose($hNewFile)
	EndIf
	Local $hInputFile = FileOpen($sInputFile, 2)
	If $hInputFile > -1 Then
		$sInput = ".output stdout" & @CRLF & $sInput
		FileWrite($hInputFile, $sInput)
		FileClose($hInputFile)
		Local $sCmd = @ComSpec & " /c " & FileGetShortName($sSQLiteExeFilename) & '  "' _
				 & FileGetShortName($sDatabaseFile) _
				 & '" > "' & FileGetShortName($sOutputFile) _
				 & '" < "' & FileGetShortName($sInputFile) & '"'
		Local $nErrorLevel = RunWait($sCmd, @WorkingDir, @SW_HIDE)
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
		$iRval = $SQLITE_CANTOPEN ; Can't open Input File
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

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Encode
; Description ...: Encodes Strings or Binary data for use in SQLite Query's
; Syntax.........: _SQLite_Encode($vData)
; Parameters ....: $vData - Data To be encoded (String, Number or BinaryString)
; Return values .: On Success - Returns Encoded String
;                  On Failure - Returns Empty String
;                   @error Value(s):	1 - Data could not be encoded
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_Encode($vData)
	If IsNumber($vData) Then $vData = String($vData)
	If IsString($vData) Or IsBinary($vData) Then
		Local $vRval = "X'"
		If StringLower(StringLeft($vData, 2)) = "0x" And Not IsBinary($vData) Then
			; BinaryString would mess this up...
			For $iCnt = 1 To StringLen($vData)
				$vRval &= Hex(Asc(StringMid($vData, $iCnt, 1)), 2)
			Next
		Else
			; BinaryString is Faster
			If Not IsBinary($vData) Then $vData = StringToBinary($vData, 4)
			$vRval &= Hex($vData)
		EndIf
		$vRval &= "'"
		Return $vRval
	EndIf
	Return SetError(1, 0, "")
EndFunc   ;==>_SQLite_Encode

; #FUNCTION# ====================================================================================================================
; Name...........: _SQLite_Escape
; Description ...: Escapes a String
; Syntax.........: _SQLite_Escape($sString, $iBuffSize = Default)
; Parameters ....: $sString - String to escape.
;				   $iBuffSize - Optional
; Return values .: On Success - Returns Escaped String
;                  On Failure - Returns Empty String
;                   @error Value(s):	1 - Error Calling SQLite API 'sqlite3_mprintf'
; Author ........: piccaso (Fida Florian)
; Modified.......: jchd
; ===============================================================================================================================
Func _SQLite_Escape($sString, $iBuffSize = Default)
	If $g_hDll_SQLite = 0 Then Return SetError(1, $SQLITE_MISUSE, "")
	Local $tSQL8 = __SQLite_StringToUtf8Struct($sString)
	Local $aRval = DllCall($g_hDll_SQLite, "ptr:cdecl", "sqlite3_mprintf", "str", "'%q'", "ptr", DllStructGetPtr($tSQL8, 1))
	If @error > 0 Then Return SetError(1, 0, "") ; Dllcall error
	If IsKeyword($iBuffSize) Or $iBuffSize < 1 Then $iBuffSize = -1
	Local $sResult = __SQLite_szStringRead($aRval[0], $iBuffSize)
	DllCall($g_hDll_SQLite, "none:cdecl", "sqlite3_free", "ptr", $aRval[0])
	Return $sResult
EndFunc   ;==>_SQLite_Escape

#region		SQLite.au3 Internal Functions
; $g_avSafeMode_SQLite[0] -> Savemode State (boolean)
; $g_avSafeMode_SQLite[1] -> Array containing known $hDB handles
; $g_avSafeMode_SQLite[2] -> Array containing known $hQuery handles
; $g_avSafeMode_SQLite[3] -> pseudo dll handle for 'msvcrt.dll'
; $g_avSafeMode_SQLite[4] -> Array of Temp Files

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __xxx
; Author ........: piccaso (Fida Florian)
; ===============================================================================================================================
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
	ConsoleWrite("State : " & $g_avSafeMode_SQLite[0] & @CR)
	Local $aTmp = $g_avSafeMode_SQLite[1]
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
	Local $sOut = "!   SQLite.au3 Error" & @LF
	$sOut &= "--> Function: " & $sFunction & @LF
	If $sQuery <> "" Then $sOut &= "--> Query:    " & $sQuery & @LF
	$sOut &= "--> Error:    " & $sError & @LF
	ConsoleWrite($sOut & @LF)
	If Not IsKeyword($vReturnValue) Then Return $vReturnValue
EndFunc   ;==>__SQLite_ReportError

Func __SQLite_szStringRead($iszPtr, $iLen = -1)
    If $iszPtr = 0 Then Return ""
    If $iLen < 1 Then
        If $g_avSafeMode_SQLite[3] < 1 Then $g_avSafeMode_SQLite[3] = DllOpen("msvcrt.dll")
        Local $aStrLen = DllCall($g_avSafeMode_SQLite[3], "int:cdecl", "strlen", "ptr", $iszPtr)
        If @error Then Return SetError(1, @error, "") ; Dllcall error
        $iLen = $aStrLen[0] + 1
    EndIf
    Local $vszString = DllStructCreate("byte[" & $iLen & "]", $iszPtr)
    If @error Then Return SetError(2, @error, "")
    Return SetError(0, $iLen, __SQLite_Utf8StructToString($vszString))
EndFunc   ;==>__SQLite_szStringRead

Func __SQLite_szFree($Ptr, $err = @error)
	If $Ptr <> 0 Then DllCall($g_hDll_SQLite, "none:cdecl", "sqlite3_free", "ptr", $Ptr)
	SetError($err)
EndFunc   ;==>__SQLite_szFree

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __SQLite_StringToUtf8Struct
; Description ...: Causes a toolbar to be resized
; Syntax.........: __SQLite_StringToUtf8Struct($sString)
; Parameters ....: $sString     - String to be converted
; Return values .: Success      - Utf8 structure
;                  Failure      - Set @error
; Author ........: jchd
; Modified.......: jpm
; ===============================================================================================================================
Func __SQLite_StringToUtf8Struct($sString)
	Local $aResult = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", 65001, "dword", 0, "wstr", $sString, "int", -1, _
								"ptr", 0, "int", 0, "ptr", 0, "ptr", 0)
	If @error Then Return SetError(1, @error, "") ; Dllcall error
	Local $tText = DllStructCreate("char[" & $aResult[0] & "]")
	$aResult = DllCall("Kernel32.dll", "int", "WideCharToMultiByte", "uint", 65001, "dword", 0, "wstr", $sString, "int", -1, _
							"ptr", DllStructGetPtr($tText), "int", $aResult[0], "ptr", 0, "ptr", 0)
	If @error Then Return SetError(2, @error, "") ; Dllcall error
	Return($tText)
EndFunc   ;==>__SQLite_StringToUtf8Struct

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __SQLite_Utf8StructToString
; Description ...: Causes a toolbar to be resized
; Syntax.........: __SQLite_Utf8StructToString($tText)
; Parameters ....: $tText       - Uft8 Structure
; Return values .: Success      - String converted
;                  Failure      - Set @error
; Author ........: jchd
; Modified.......: jpm
; ===============================================================================================================================
Func __SQLite_Utf8StructToString($tText)
	Local $aResult = DllCall("kernel32.dll", "int", "MultiByteToWideChar", "uint", 65001, "dword", 0, "ptr", DllStructGetPtr($tText), "int", -1, _
								"ptr", 0, "int", 0)
	If @error Then Return SetError(1, @error, "") ; Dllcall error
	Local $tWstr = DllStructCreate("wchar[" & $aResult[0] & "]")
	$aResult = DllCall("Kernel32.dll", "int", "MultiByteToWideChar", "uint", 65001, "dword", 0, "ptr", DllStructGetPtr($tText), "int", -1, _
						"wstr", DllStructGetPtr($tWstr), "int", $aResult[0])
	If @error Then Return SetError(2, @error, "") ; Dllcall error
	Return($aResult[5])
EndFunc   ;==>__SQLite_Utf8StructToString

#endregion 	SQLite.au3 Internal Functions
