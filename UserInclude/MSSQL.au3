; #CURRENT# =====================================================================================================================
;~ _MSSQL_Con                 ; 连接数据库
;~ _MSSQL_Query
;~ _MSSQL_End                 ; 关闭数据库连接
;~ _MSSQL_CreateTable         ; 在数据库中创建一个新表
;~ _MSSQL_CreateColumn        ; 在数据库中创建一个或多个新的列
;~ _MSSQL_AddRecord           ; 在数据库表中插入一个或多个新的数值
;~ _MSSQL_GetRecord           ; 在数据库表中获取一个或多个值
;~ _MSSQL_TableExist          ; 在数据库中检查表是否存在
;~ _MSSQL_ColumnExist         ; 在数据库表中检查列是否存在
;~ _MSSQL_ListAllColumns      ; 在数据库表中获取所有列名
;~ _MSSQL_ListAllTables       ; 在数据库中获取所有表名
;~ _MSSQL_GetColumninfo       ; 在数据库中获取表的相关信息
;~ _MSSQL_UpdateRecord        ; 在数据库表中修改指定列的数据
;~ _MSSQL_DeleteRecord        ; 在数据库表中删除数据
;~ _MSSQL_DropColumn          ; 在数据库表中删除指定的列
;~ _MSSQL_DropTable           ; 在数据库中删除一个表
;~ _MSSQL_ErrFunc             ; 错误信息
; ===============================================================================================================================


;===============================================================================
;
; 函数名称.........:    _MSSQL_CreateTable
; 描述.............:    在数据库中创建一个新表
; 语法.............:    _MSSQL_CreateTable($oConnectionObj, $sTable, $identity, $Columnname)
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
;                       $identity = [可选参数] Should there be a Primarykey (默认 = TRUE)
;                       $Columnname = [可选参数] If no Primarykey is created, name of the first Column
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $sTable already exists, @extended
;.........@extended:        |1 - $oConnectionObj is not an object
;                           |2 - $sTable already exists
;                           |3 - $aResult is not an array ( not happened yet, but maybe possible)
;                           |4 - Query Error, Query saved to @extended (Check permissions to sys.tables)
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================

Func _MSSQL_CreateTable($oConnectionObj, $sTable, $identity = True, $Columnname = "ID")
	Local $sPrimeKey = "ID", $str, $tableexist
	If IsObj($oConnectionObj) And Not @error Then
		$tableexist = _MSSQL_TableExist($oConnectionObj, $sTable)
		If $tableexist = 1 Then Return SetError(2, @error, 0)
		If $identity = True Then
			$str = "CREATE TABLE " & $sTable & " (" & $sPrimeKey & " int IDENTITY (1,1) PRIMARY KEY) ;"
		Else
			$str = "CREATE TABLE " & $sTable & " (" & $Columnname & ");"
		EndIf
		$oConnectionObj.execute($str)
		Return 1
	ElseIf @error Then
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_CreateTable

;===============================================================================
;
; 函数名称.........:    _MSSQL_CreateColumn
; 描述.............:    在数据库中创建一个或多个新的列
; 语法.............:    _MSSQL_CreateColumn($oConnectionObj, $sTable, $sColumn, $Null = "NULL", $sDataType = "VARCHAR(45)")
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
;                       $sColumn = 列名和类型
;                       $Null = [可选参数] Allow Zero (默认 = True)
;                       $sDataType = [可选参数] If $sColumn is an 1-D Array, sets the Columtype for all Columns (默认 = "VARCHAR(45)")
; 要求.............:    If $sColumn is an array, it has to be indexed 1,
;                           - If $sColumn is an 2-D Array, the Columnname has to be in $avArray[$i][0], the datatype has to be in $avArray[0][$i]
;                       If $sColumn is a String ist, it has to be formated like this:
;                           - "Name1 varchar(50),Name2 varchar(50),Name3 varchar(50),Name4  varchar(50),NameN Datatype"
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $sColumn has more than 2 dimensions
;                       |3 - A Columnname from $sColumn already exists in Database
;                           - The Columnname is saved in @extended
;                       |4 - A Columnname from $sColumn occurs more than 1 time in the $sColumn
;                           - The Columnname is saved in @extended
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_CreateColumn($oConnectionObj, $sTable, $sColumn, $Null = True, $sDataType = "VARCHAR(45)")
	Local $str, $Result, $Columnsplit, $Columnsplit2
	If IsObj($oConnectionObj) And Not @error Then
		If IsArray($sColumn) Then
			If UBound($sColumn, 2) = 2 Then
				$str = "ALTER TABLE " & $sTable & " ADD "
				If $Null = True Then
					For $i = 1 To UBound($sColumn) - 1
						If StringInStr($str, $sColumn[$i][0]) <> 0 Then Return SetError(4, $sColumn[$i][0], 0)
						$str &= "" & $sColumn[$i][0] & " " & $sColumn[$i][1] & " NULL,"
					Next
				Else
					For $i = 1 To UBound($sColumn) - 1
						If StringInStr($str, $sColumn[$i][0]) <> 0 Then Return SetError(4, $sColumn[$i][0], 0)
						$str &= "" & $sColumn[$i][0] & " " & $sColumn[$i][1] & ","
					Next
				EndIf
				For $i = 1 To UBound($sColumn) - 1
					$Result = _MSSQL_ColumnExist($oConnectionObj, $sTable, $sColumn[$i][0])
					If $Result = 1 Then Return SetError(3, $sColumn[$i][0], 0)
				Next

			ElseIf UBound($sColumn, 2) = 0 And @error = 2 Then
				$str = "ALTER TABLE " & $sTable & " ADD "
				If $Null = "Null" Then
					For $i = 1 To UBound($sColumn) - 1
						If StringInStr($str, $sColumn[$i]) <> 0 Then Return SetError(4, $sColumn[$i], 0)
						$str &= "" & $sColumn[$i] & " " & $sDataType & " NULL,"
					Next
				Else
					For $i = 1 To UBound($sColumn) - 1
						If StringInStr($str, $sColumn[$i]) <> 0 Then Return SetError(4, $sColumn[$i], 0)
						$str &= "" & $sColumn[$i] & " " & $sDataType & ","
					Next
				EndIf
				For $i = 1 To UBound($sColumn) - 1
					$Result = _MSSQL_ColumnExist($oConnectionObj, $sTable, $sColumn[$i])
					If $Result = 1 Then Return SetError(3, $sColumn[$i], 0)
				Next
			Else
				Return SetError(2, 0, 0)
			EndIf
			$str = StringTrimRight($str, 1) & ";"
			$oConnectionObj.execute($str)
		Else
			$str = "ALTER TABLE " & $sTable & " ADD " & $sColumn & ";"
			$Columnsplit = StringSplit($sColumn, ",")
			For $i = 1 To $Columnsplit[0]
				$Columnsplit2 = StringSplit($Columnsplit[$i], " ")
				$Result = _MSSQL_ColumnExist($oConnectionObj, $sTable, $Columnsplit2[1])
				If $Result = 1 Then Return SetError(3, $Columnsplit2[1], 0)
			Next
			$oConnectionObj.execute($str)
			Return 1
		EndIf
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_CreateColumn
;===============================================================================
;
; 函数名称.........:    _MSSQL_AddRecord
; 描述.............:    在数据库表中插入一个或多个新的数值
; 语法.............:    _MSSQL_AddRecord($oConnectionObj, $sTable, $Values, $UNIQUE, $condition)
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
;                       $Values = 要插入到表中的值
;                       $UNIQUE = [可选参数] 设置为 True 使用条件模式, 避免重复数据
;                       $condition = [可选参数] 条件模式, 如果避免重复数据的条件.
; 要求.............:    You need to add a Value for each Column in the Table
;                       If $Values is an Array , it has to be indexed 1,
;                       If $Values is a String , it has to be formated like this:
;                       - 'Value1', 'Value2', 'Value3', 'Value4', 'Value5', 'Value n'
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $condition was not set
;                       |3 - Only returned if $UNIQUE = True
;                               - All Values already in Database
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_AddRecord($oConnectionObj, $sTable, $Values, $UNIQUE = False, $condition = "")
	Local $str, $check
	If IsObj($oConnectionObj) And Not @error Then
		If IsArray($Values) Then
			If UBound($Values, 2) = 0 Then
				$str = "INSERT INTO " & $sTable & " VALUES('"
				For $grades = 1 To UBound($Values) - 1
					If $UNIQUE = False Then
						$str &= $Values[$grades] & "', '"
					Else
						If $condition = "" Then Return SetError(2, 0, 0)
						$check = _MSSQL_GetRecord($oConnectionObj, $sTable, "*", $condition)
						If @error = 4 Then
							$str &= $Values[$grades] & "', '"
						EndIf
					EndIf
				Next
				$str = StringTrimRight($str, 3) & ");"
				ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $str = ' & $str & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
				If StringRight($str, 7) = "VALUE);" Then Return SetError(3, 0, 0)
				$oConnectionObj.execute($str)
				Return 1
			Else
				For $rows = 1 To UBound($Values) - 1
					$str = "INSERT INTO " & $sTable & " VALUES('"
					For $grades = 1 To UBound($Values, 2) - 1
						If $UNIQUE = False Then
							$str &= $Values[$rows][$grades] & "', '"
						Else
							If $condition = "" Then Return SetError(2, 0, 0)
							$check = _MSSQL_GetRecord($oConnectionObj, $sTable, "*", $condition)
							If @error = 4 Then
								$str &= $Values[$rows][$grades] & "', '"
							EndIf
						EndIf
					Next
					$str = StringTrimRight($str, 3) & ");"
					ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $str = ' & $str & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
					If StringRight($str, 7) = "VALUE);" Then Return SetError(3, 0, 0)
					$oConnectionObj.execute($str)
				Next
				Return 1
			EndIf
		Else
			If $UNIQUE = False Then
				$str = "INSERT INTO " & $sTable & " VALUES(" & $Values & ");"
			Else
				If $condition = "" Then Return SetError(2, 0, 0)
				$check = _MSSQL_GetRecord($oConnectionObj, $sTable, "*", $condition)
				If @error = 4 Then
					$str = "INSERT INTO " & $sTable & " VALUES(" & $Values & ");"
				Else
					Return SetError(3, 0, 0)
				EndIf
			EndIf
			$oConnectionObj.execute($str)
			Return 1
		EndIf
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_AddRecord
;===============================================================================
;
; 函数名称.........:    _MSSQL_GetRecord
; 描述.............:    在数据库表中获取一个或多个值
; 语法.............:    _MSSQL_GetRecord($oConnectionObj, $sTable, $Columns = "*", $condition = "", $order = "")
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 需要查询的表名
;                       $sColumn = [可选参数] 需要显示的一个或多个列名 [ 默认 = "*" (所有的列)]
;                       $condition = [可选参数] 特殊情况，还可以通过 Where 有条件地从表中获取数据 [默认 = "" (所有的值)]
;                       $order = [可选参数] 根据指定的列对结果集进行排序 [默认 = "" (不排序)]
; 要求.............:    If $sColumn is an Array it has to be indexed 1,
;                           - $sColumn contains the Columns to read from
; 返回值(s)........:    成功 - Returns an array
;                                   - If you searched in only one column, $aResult is a 1-D Array, where $aResult[0] is the number of found values
;                                   - If you searched in more then one column, $aResult is multidimensional, where $aResult[0][n] is the number of found values
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $aResult is not an array ( not happened yet, but msaybe possible)
;                       |3 - $sColumn is not an 1-D array
;                       |4 - Query Error, Query saved to @extended
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_GetRecord($oConnectionObj, $sTable, $Columns = "*", $condition = "", $order = "")
	Local $str, $quer, $aResult, $iColumns, $iRows
	If IsObj($oConnectionObj) And Not @error Then
		If IsArray($Columns) Then
			If UBound($Columns, 2) - 1 <> 1 Then Return SetError(3, 0, 0)
			$str = "SELECT '"
			For $i = 1 To UBound($Columns) - 1
				$str &= $Columns[$i] & "','"
			Next
			If $order = "" Then
				$str = StringTrimRight($str, 2) & "FROM " & $sTable & " " & $condition & ";"
			Else
				$str = StringTrimRight($str, 2) & "FROM " & $sTable & " " & $condition & " ORDER BY " & $order & " ;"
			EndIf
			$quer = $oConnectionObj.execute($str)
			With $quer
				If Not .EOF Then
					$aResult = .GetRows()
					If IsArray($aResult) And UBound($aResult, 2) > 1 Then
						$iColumns = UBound($aResult, 2)
						$iRows = UBound($aResult)
						ReDim $aResult[$iRows + 1][$iColumns]
						For $x = $iRows To 1 Step -1
							For $y = 0 To $iColumns - 1
								$aResult[$x][$y] = $aResult[$x - 1][$y]
							Next
						Next
						For $i = 0 To $iColumns - 1
							$aResult[0][$i] = .Fields($i).Name
						Next
					ElseIf IsArray($aResult) And UBound($aResult, 2) = 1 Then
						$iRows = UBound($aResult)
						Local $bResult[$iRows + 1]
						For $x = $iRows To 1 Step -1
							$bResult[$x] = $aResult[$x - 1][0]
						Next
						$bResult[0] = $iRows
						Return $bResult
					Else
						Return SetError(2, 0, 0)
					EndIf
				Else
					Return SetError(4, $str, 0)
				EndIf
			EndWith
			Return $aResult
		Else
			If $order = "" Then
;~ 				If $Columns = "*" Then
				$quer = $oConnectionObj.execute("SELECT " & $Columns & " FROM " & $sTable & " " & $condition & ";")
;~ 				Else
;~ 					$quer = $oConnectionObj.execute("SELECT '" & $Columns & "' FROM " & $sTable & " " & $condition & ";")
;~ 				EndIf
			Else
;~ 				If $Columns = "*" Then
				$quer = $oConnectionObj.execute("SELECT " & $Columns & " FROM " & $sTable & " " & $condition & " ORDER BY " & $order & " ;")
;~ 				Else
;~ 					$quer = $oConnectionObj.execute("SELECT '" & $Columns & "' FROM " & $sTable & " " & $condition & " ORDER BY " & $order & " ;")
;~ 				EndIf
			EndIf
			If Not $quer.EOF Then
				$aResult = $quer.GetRows()
				If IsArray($aResult) And UBound($aResult, 2) > 1 Then
					$iColumns = UBound($aResult, 2)
					$iRows = UBound($aResult)
					ReDim $aResult[$iRows + 1][$iColumns]
					For $x = $iRows To 1 Step -1
						For $y = 0 To $iColumns - 1
							$aResult[$x][$y] = $aResult[$x - 1][$y]
						Next
					Next
					For $i = 0 To $iColumns - 1
						$aResult[0][$i] = $quer.Fields($i).Name
					Next
				ElseIf IsArray($aResult) And UBound($aResult, 2) = 1 Then
					$iRows = UBound($aResult)
					Local $bResult[$iRows + 1]
					For $x = $iRows To 1 Step -1
						$bResult[$x] = $aResult[$x - 1][0]
					Next
					$bResult[0] = $iRows
					Return $bResult
				Else
					Return SetError(2, 0, 0)
				EndIf
			Else
				Return SetError(4, $str, 0)
			EndIf
			Return $aResult
		EndIf
	EndIf
	Return SetError(1, 0, 0)
EndFunc   ;==>_MSSQL_GetRecord
;===============================================================================
;
; 函数名称.........:    _MSSQL_TableExist
; 描述.............:    在数据库中检查表是否存在
; 语法.............:    _MSSQL_TableExist($oConnectionObj, $sTable)
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - Table not found
;                       |3 - Query Error, Query saved to @extended (Check Permissions on sys.tables)
;                           - also Returned when Table does not exist
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================

Func _MSSQL_TableExist($oConnectionObj, $sTable)
	Local $quer
	If IsObj($oConnectionObj) And Not @error Then
		$quer = $oConnectionObj.execute("SELECT TABLE_SCHEMA FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '" & $sTable & "';")
		If Not $quer.EOF Then
			Return 1
		Else
			Return SetError(3, "SELECT TABLE_SCHEMA FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '" & $sTable & "';", 0)
		EndIf
		Return SetError(2, 0, 0)
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_TableExist
;===============================================================================
;
; 函数名称.........:    _MSSQL_ColumnExist
; 描述.............:    在数据库表中检查列是否存在
; 语法.............:    _MSSQL_ColumnExist($oConnectionObj, $sTable, $sColumn)
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
;                       $sColumn = 列名
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - Column not found
;                       |3 - Table not found
;                       |3 - Query Error, Query saved to @extended (Check Permissions on sys.columns)
;                           - also Returned when Column does not exist
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_ColumnExist($oConnectionObj, $sTable, $sColumn)
	Local $quer
	If IsObj($oConnectionObj) And Not @error Then
		If Not _MSSQL_TableExist($oConnectionObj, $sTable) Then Return SetError(3, 0, 0)
		$quer = $oConnectionObj.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = '" & $sColumn & "' AND TABLE_NAME = '" & $sTable & "';")
		If Not $quer.EOF Then
			Return 1
		Else
			Return SetError(4, "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = '" & $sColumn & "' AND TABLE_NAME = '" & $sTable & "';", 0)
		EndIf
		Return SetError(2, 0, 0)
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_ColumnExist
;===============================================================================
;
; 函数名称.........:    _MSSQL_Con
; 描述.............:    连接数据库
; 语法.............:    _MSSQL_Con($scIP, $scUser, $scPass, $scDB)
; 参数(s)..........:    $scIP = IP地址
;                       $scUser = 用户名
;                       $scPass = 密码
;                       $scDB = 数据库
; 返回值(s)........:    成功 - Returns the Database-"handle"
;
;===============================================================================
Func _MSSQL_Con($scIP, $scUser, $scPass, $scDB)
	Local $sqlCon
	$sqlCon = ObjCreate("ADODB.Connection")
	$sqlCon.Open("Provider=SQLOLEDB; Data Source=" & $scIP & "; User ID=" & $scUser & "; Password=" & $scPass & "; database=" & $scDB & ";")
	Return $sqlCon
EndFunc   ;==>_MSSQL_Con
;===============================================================================
;
; 函数名称.........:    _MSSQL_Query
; 描述.............:    Send a Query to the Database
; 语法.............:    _MSSQL_Query($iSQLCon, $iQuery)
; 参数(s)..........:    $iSQLCon = $oConnectionObj = Object, returned by _MSSQL_Con
;                       $iQuery = MSSQL Query
; 返回值(s)........:    成功 - Returns the Response from the server
;
;===============================================================================
Func _MSSQL_Query($iSQLCon, $iQuery)
	If IsObj($iSQLCon) Then
		Return $iSQLCon.execute($iQuery)
	EndIf
EndFunc   ;==>_MSSQL_Query
;===============================================================================
;
; 函数名称.........:    _MSSQL_End
; 描述.............:    关闭数据库连接
; 语法.............:    _MSSQL_End($sqlCon)
; 参数(s)..........:    $sqlCon = $oConnectionObj = Object, returned by _MSSQL_Con
; 返回值(s)........:    -
;
;===============================================================================
Func _MSSQL_End($sqlCon)
	If IsObj($sqlCon) Then
		$sqlCon.close
	EndIf
EndFunc   ;==>_MSSQL_End
;===============================================================================
;
; 函数名称.........:    _MSSQL_ListAllColumns
; 描述.............:    在数据库表中获取所有列名
; 语法.............:    _MSSQL_ListAllColumns($oConnectionObj, $sTable)
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
; 返回值(s)........:    成功 - Returns an Array
;                       - $aResult[0] returns the number of Columns
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $aResult is not an array ( not happened yet, but maybe possible)
;                       |3 - $sTable does not exist
;                       |4 - Query Error, Query saved to @extended
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_ListAllColumns($oConnectionObj, $sTable)
	Local $quer, $aResult, $iRows
	If IsObj($oConnectionObj) And Not @error Then
		If Not _MSSQL_TableExist($oConnectionObj, $sTable) Then Return SetError(3, 0, 0)
		$quer = $oConnectionObj.execute("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" & $sTable & "';")
		If Not $quer.EOF Then
			$aResult = $quer.GetRows()
			If IsArray($aResult) And UBound($aResult, 2) = 1 Then
				$iRows = UBound($aResult)
				Local $bResult[$iRows + 1]
				For $x = $iRows To 1 Step -1
					$bResult[$x] = $aResult[$x - 1][0]
				Next
				$bResult[0] = $iRows
				Return $bResult
			Else
				Return SetError(2, 0, 0)
			EndIf
		Else
			Return SetError(4, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" & $sTable & "';", 0)
		EndIf
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_ListAllColumns
;===============================================================================
;
; 函数名称.........:    _MSSQL_ListAllTables
; 描述.............:    在数据库中获取所有表名
; 语法.............:    _MSSQL_ListAllTables($oConnectionObj)
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
; 返回值(s)........:    成功 - Returns an 2-D Array
;                                   - $Return[0][0]  = number of tables
;                                   - $Return[$i][n] = 表名
;                                   - $Return[$i][n] = Table Type
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $aResult is not an array ( not happened yet, but maybe possible)
;                       |3 - No permissions to INFORMATION_SCHEMA.TABLES
;                           - also returned, if no Tables exist at all
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_ListAllTables($oConnectionObj)
	Local $quer, $aResult, $iColumns, $iRows
	If IsObj($oConnectionObj) And Not @error Then
		$quer = $oConnectionObj.execute("SELECT TABLE_NAME, TABLE_TYPE FROM INFORMATION_SCHEMA.TABLES;")
		If Not $quer.EOF Then
			$aResult = $quer.GetRows()
			If IsArray($aResult) And UBound($aResult, 2) = 2 Then
				$iColumns = UBound($aResult, 2)
				$iRows = UBound($aResult)
				ReDim $aResult[$iRows + 1][$iColumns]
				For $x = $iRows To 1 Step -1
					For $y = 0 To $iColumns - 1
						$aResult[$x][$y] = $aResult[$x - 1][$y]
					Next
				Next
				$aResult[0][0] = $iRows
				$aResult[0][1] = ""
				Return $aResult
			Else
				Return SetError(2, 0, 0)
			EndIf
		Else
			Return SetError(3, 0, 0)
		EndIf
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_ListAllTables
;===============================================================================
;
; 函数名称.........:    _MSSQL_GetColumninfo
; 描述.............:    获取数据库中表的相关信息
; 语法.............:    _MSSQL_GetColumninfo($oConnectionObj, $sTable, $sColumn = "Allcolumns")
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
;                       $sColumn = [可选参数] 列名 (默认 = 所有列)
; 返回值(s)........:    成功 - Returns an multidimensional Array
;                       - $Return[$i][0] = Name of the Column
;                       - $Return[$i][1] = Allow Zero
;                       - In $Return[$i][2] = Datatype
;                       - In $Return[$i][3] = Max Character Lenght
;                       - In $Return[$i][4] = COLLATION NAME (i.E. latin1)
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $aResult is not an array ( not happened yet, but maybe possible)
;                       |3 - $sTable or $sColumn does not exist
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_GetColumninfo($oConnectionObj, $sTable, $sColumn = "Allcolumns")
	Local $quer, $aResult, $iColumns, $iRows
	If IsObj($oConnectionObj) And Not @error Then
		If $sColumn = "Allcolumns" Then
			$quer = $oConnectionObj.execute("SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, COLLATION_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" & $sTable & "';")
		Else
			$quer = $oConnectionObj.execute("SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, COLLATION_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" & $sTable & "' AND COLUMN_NAME = '" & $sColumn & "';")
		EndIf
		If Not $quer.EOF Then
			$aResult = $quer.GetRows()
			If IsArray($aResult) And UBound($aResult, 2) > 1 Then
				$iColumns = UBound($aResult, 2)
				$iRows = UBound($aResult)
				ReDim $aResult[$iRows + 1][$iColumns]
				For $x = $iRows To 1 Step -1
					For $y = 0 To $iColumns - 1
						$aResult[$x][$y] = $aResult[$x - 1][$y]
					Next
				Next
				For $i = 0 To $iColumns - 1
					$aResult[0][$i] = $quer.Fields($i).Name
				Next
				Return $aResult
			Else
				Return SetError(2, 0, 0)
			EndIf
		Else
			Return SetError(3, 0, 0)
		EndIf
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_GetColumninfo
;===============================================================================
;
; 函数名称.........:    _MSSQL_UpdateRecord
; 描述.............:    在数据库表中修改指定列的数据
; 语法.............:    _MSSQL_UpdateRecord($oConnectionObj, $sTable, $sColumn , $sValue, $condition = "")
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
;                       $sColumn = 列名
;                       $sValue = 新值
;                       $condition = [可选参数] 查询的条件,可指定某值为查询内容 [默认 = "" (不按条件查询)]
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $sTable does not exist
;                       |3 - $sColumn does not exist
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_UpdateRecord($oConnectionObj, $sTable, $sColumn, $sValue, $condition = "")
	Local $tableexist, $columnexist, $str, $quer
	If IsObj($oConnectionObj) And Not @error Then
		$tableexist = _MSSQL_TableExist($oConnectionObj, $sTable)
		If $tableexist = 0 Then Return SetError(2, 0, 0)
		$columnexist = _MSSQL_ColumnExist($oConnectionObj, $sTable, $sColumn)
		If $columnexist = 0 Then Return SetError(3, 0, 0)
		If $condition = "" Then
;~ 			$str = "UPDATE " & $sTable & " SET " & $sColumn & " = " & $sValue & ";"
			$str = "UPDATE " & $sTable & " SET " & $sColumn & " = '" & $sValue & "';"
			$quer = $oConnectionObj.execute($str)
		Else
			$str = "UPDATE " & $sTable & " SET " & $sColumn & " = " & $sValue & " " & $condition & ";"
			$quer = $oConnectionObj.execute($str)
		EndIf
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_UpdateRecord
;===============================================================================
;
; 函数名称.........:    _MSSQL_DeleteRecord
; 描述.............:    在数据库表中删除数据
; 语法.............:    _MSSQL_DeleteRecord($oConnectionObj, $sTable, $condition = "")
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
;                       $condition = [可选参数] 可通过 WHERE 条件方式删除 [默认 = "" (删除所有数据)]
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $sTable does not exist
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_DeleteRecord($oConnectionObj, $sTable, $condition = "")
	Local $tableexist, $columnexist, $str, $quer
	If IsObj($oConnectionObj) And Not @error Then
		$tableexist = _MSSQL_TableExist($oConnectionObj, $sTable)
		If $tableexist = 0 Then Return SetError(2, 0, 0)
		If $condition = "" Then
			$str = "DELETE FROM " & $sTable & ";"
			$quer = $oConnectionObj.execute($str)
		Else
			$str = "DELETE FROM " & $sTable & " " & $condition & ";"
			$quer = $oConnectionObj.execute($str)
		EndIf
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_DeleteRecord

;===============================================================================
;
; 函数名称.........:    _MSSQL_DropTable
; 描述.............:    在数据库中删除一个表
; 语法.............:    _MSSQL_DropTable($oConnectionObj, $sTable)
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $sTable does not exist
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_DropTable($oConnectionObj, $sTable)
	If IsObj($oConnectionObj) And Not @error Then
		If Not _MSSQL_TableExist($oConnectionObj, $sTable) Then Return SetError(2, 0, 0)
		$str = "DROP TABLE " & $sTable & ";"
		$quer = $oConnectionObj.execute($str)
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_DropTable
;===============================================================================
;
; 函数名称.........:    _MSSQL_DropColumn
; 描述.............:    在数据库表中删除指定的列
; 语法.............:    _MSSQL_DropColumn($oConnectionObj, $sTable)
; 参数(s)..........:    $oConnectionObj = Object, returned by _MSSQL_Con
;                       $sTable = 表名
; 返回值(s)........:    成功 - 1
;                       失败 - 0, sets @error
;                       |1 - $oConnectionObj is not an object
;                       |2 - $sTable does not exist
;                       |3 - $sColumn does not exist
; 作者.............:    TheLuBu <LuBu@veytal.com>
;
;===============================================================================
Func _MSSQL_DropColumn($oConnectionObj, $sTable, $sColumn)
	If IsObj($oConnectionObj) And Not @error Then
		If Not _MSSQL_TableExist($oConnectionObj, $sTable) Then Return SetError(2, 0, 0)
		If Not _MSSQL_ColumnExist($oConnectionObj, $sTable, $sColumn) Then Return SetError(3, 0, 0)
		$str = "ALTER TABLE " & $sTable & " DROP COLUMN " & $sColumn & ";"
		$quer = $oConnectionObj.execute($str)
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_MSSQL_DropColumn

;===============================================================================
; 函数名...........:    _MSSQL_ErrFunc()
; 说明.............:    错误信息
;===============================================================================

Global $SQLError = ObjEvent("AutoIt.Error", "_MSSQL_ErrFunc")

Func _MSSQL_ErrFunc()
	Local $HexNumber
	$HexNumber = Hex($SQLError.number, 8)
	MsgBox(0, "COM Error Test", "We intercepted a COM Error !" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $SQLError.description & @CRLF & _
			"err.windescription:" & @TAB & $SQLError.windescription & @CRLF & _
			"err.number is: " & @TAB & $HexNumber & @CRLF & _
			"err.lastdllerror is: " & @TAB & $SQLError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $SQLError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $SQLError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $SQLError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $SQLError.helpcontext _
			)
	SetError(1)
EndFunc   ;==>_MSSQL_ErrFunc
