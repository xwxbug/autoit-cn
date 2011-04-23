;*******************************************************************************
;	http://dundats.mvps.org/AutoIt/udf_code.aspx?udf=access
;
;   函数列表
;         _accessAddRecord();在现有的 MS Access 数据库表中添加新记录(单个或多个字段)
;         _accessClearTable();清除 MS Access 数据库指定的表内所有记录
;         _accessCompactDB();压缩 MS Access 数据库文件(*. mdb)
;         _accessCountFields();返回 MS Access 数据库表中的字段数
;         _accessCountRecords();返回 MS Access 数据库表中的记录数
;         _accessCreateDB();创建一个 MS Access 数据库(*. mdb)文件
;         _accessCreateTable();在现有的 MS Access 数据库中建立表
;         _accessDeleteRecord()搜索数据库字符串，并将搜索到的字符串(整列)数据删除
;         _accessDeleteTable();从 MS Access 数据库(*. mdb)文件中删除表
;         _accessGetVal();搜索数据库的第一个记录指定字符串，并返回搜索结果
;         _accessListFields();返回 MS Access 数据库中所指定的表中的所有字段名称
;         _accessListTables();返回 MS Access 数据库中所有的表名称
;         _accessQueryLike();搜索数据库中指定的表内的字段所包含指定的字符串(数据为空即搜索全部字符串)
;         _accessQueryStr();搜索数据库中的指定字符串，并返回搜索结果
;         _accessSaveXML();将 MS Access 数据库中指定的表将导出为XML文件
;         _accessTableCount();统计 MS Access 数据库中有多少个表
;         _accessUpdateRecord();搜索 MS Access 数据库中的表，并更新表中的数据记录
;
;*******************************************************************************

#include-once
#include <AccessConstants.au3>

; ------------------------------------------------------------------------------
; To Do List:
;     _accessAppendField()
;     _accessDeleteMulti()
;     _accessNumSearch()
; ------------------------------------------------------------------------------

;===============================================================================
; 函数名称:   _accessAddRecord()
; 描述:       在现有的 MS Access 数据库表添加新记录(单个或多个字段)
; 语法:       _accessAddRecord($adSource, $adTable)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
;             $rData - 将数据被添加到字段(必须是一个数组才能将数据添加到多个字段，数据必须输入相应的工作类型数据)
;             $adCol - 当数值等于0，而当$rData不是数组，将会添加数据至(默认为第一格)
; 需求:
; 返回值:     成功 - @Error = 0 记录已经添加到表内
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
; 例子:       yes
;===============================================================================

Func _accessAddRecord($adSource, $adTable, $rData, $adCol = 0)
	If Not IsArray($rData) Then
		$rData = StringSplit($rData, '|')
	EndIf
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	If Not IsObj($oADO) Then Return SetError(2, 0, 0)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	With $oRec
		.Open("SELECT * FROM " & $adTable, $oADO, $adOpenStatic, $adLockOptimistic)
		.AddNew
		If IsArray($rData) Then
			For $I = 1 To UBound($rData) - 1;$rData[0]
				$rData[$I] = StringStripWS($rData[$I], 1)
				.Fields.Item($I - 1) = $rData[$I]
			Next
		Else
			.Fields.Item($adCol) = $rData
		EndIf
		.Update
		.Close
	EndWith
	$oADO.Close
EndFunc   ;==>_accessAddRecord

;===============================================================================
; 函数名称:   _accessClearTable()
; 描述:       清除 MS Access 数据库指定的表内所有记录
; 语法:       _accessClearTable($adSource, $adTable)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
; 需求:
; 返回值:     成功 - @Error = 0
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:         这只会清除记录，无法删除表，无法清除表类型
; 修改:
;===============================================================================

Func _accessClearTable($adSource, $adTable)
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	If _accessCountRecords($adSource, $adTable) > 0 Then
		$oRec.CursorLocation = $adUseClient
		$oRec.Open("Delete * FROM " & $adTable, $oADO, $adOpenStatic, $adLockOptimistic)
	EndIf
	$oADO.Close
EndFunc   ;==>_accessClearTable

;===============================================================================
; 函数名称:   _accessCompactDB()
; 描述:       压缩 MS Access 数据库文件(*. mdb)
; 语法:       _accessCompactDB($adSource)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
; 需求:
; 返回值:     成功 - @Error = 0
;             失败 - @Error = 1
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 例子:
;===============================================================================

Func _accessCompactDB($adSource)
	If FileExists($adSource) Then
		Local $adDest = @TempDir & "\Temp.mdb"
		Local $obj = "JRO.JetEngine"
		If FileExists($adDest) Then FileDelete($adDest)
		If Not IsObj($obj) Then
			Local $oMDB = ObjCreate($obj)
		Else
			Local $oMDB = ObjGet($obj)
		EndIf
		If IsObj($oMDB) Then
			$oMDB.CompactDatabase("Provider = " & $adoProvider & "Data Source = " & $adSource, _
					"Provider = " & $adoProvider & "Data Source = " & $adDest)
			SetError(0)
		Else
			Return SetError(1)
		EndIf
		FileMove($adDest, $adSource, 1)
	EndIf
EndFunc   ;==>_accessCompactDB

;===============================================================================
; 函数名称:   _accessCountFields()
; 描述:       返回 MS Access 数据库表中的字段数
; 语法:       _accessCountFields($adSource, $adTable)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
; 需求:
; 返回值:     成功 - 返回表内的字段数
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:         典型用法如:
;             MsgBox(0,'字段数', '本表有<' & _accessCountFields($adSource, $adTable) & '>个字段数')
; 修改:
; 例子:
;===============================================================================

Func _accessCountFields($adSource, $adTable)
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	$oRec.open($adTable, $oADO, $adOpenStatic, $adLockOptimistic)
	Local $Fc = $oRec.fields.count
	$oRec.Close
	$oADO.Close
	Return $Fc
EndFunc   ;==>_accessCountFields

;===============================================================================
; 函数名称:   _accessCountRecords()
; 描述:       返回 MS Access 数据库表中的记录数
; 语法:       _accessCountRecords($adSource, $adTable)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
; 需求:
; 返回值:     成功 - 返回表中的记录数
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:         典型用法如:
;             MsgBox(0,'纪录数', '本表有<' & _accessCountRecords($adSource, $adTable) & '>条数据记录')
; 修改:
; 例子:
;===============================================================================

Func _accessCountRecords($adSource, $adTable)
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	$oRec.open("SELECT * FROM " & $adTable, $oADO, $adOpenStatic, $adLockOptimistic)
	If $oRec.recordcount <> 0 Then $oRec.MoveFirst
	Local $Rc = $oRec.recordcount
	$oRec.Close
	$oADO.Close
	Return $Rc
EndFunc   ;==>_accessCountRecords

;===============================================================================
; 函数名称:   _accessCreateDB ()
; 描述:       创建一个 MS Access 数据库(*. mdb)文件
; 语法:       _accessCreateDB ($adSource)
; 参数:       $adSource - 创建MS Access数据库的完整路径以及创建数据库的文件名
; 需求:
; 返回值:     无
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
;===============================================================================

Func _accessCreateDB($adSource)
	If StringRight($adSource, 4) <> '.mdb' Then $adSource &= '.mdb'
	If FileExists($adSource) Then
		Local $Fe = MsgBox(262196, 'File Exists', 'The file ' & $adSource & ' already exists.' & @CRLF & '' & @CRLF & 'Do you want to replace the existing file?')
		If $Fe = 6 Then
			FileDelete($adSource)
		Else
			Return
		EndIf
	EndIf
	Local $dbObj = ObjCreate('ADOX.Catalog')
	If IsObj($dbObj) Then
		$dbObj.Create('Provider = ' & $adoProvider & 'Data Source = ' & $adSource)
	Else
		MsgBox(262160, 'Error', 'Unable to create the requested object')
	EndIf
EndFunc   ;==>_accessCreateDB

;===============================================================================
; 函数名称:   _accessCreateTable()
; 描述:       在现有的 MS Access 数据库中建立表
; 语法:       _accessCreateTable($adSource, $adTable, $adCol)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
;             $adCol - 字段类型必须用分隔符'|'分割标头名称和字段类型
; 需求:
; 返回值:     成功 - @Error = 0
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        3 = 表已经存在
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:         字段类型是不区分大小写.
;             工作类型; TEXT(数值1-255)=文本, MEMO=备注, COUNTER=自动编号, INTEGER=数字,
;                       YESNO=是/否, DATETIME=日期时间, CURRENCY=货币，OLEOBJECT=OLE 对象
;             标头名称不能包含空格，但必须以一个空格作为分隔字段类型
;             要设置的文本字段中使用文本的最大字符数(<数值>) 其中 <数值> 最大是255个.
; 修改:
; 例子:       _accessCreateTable($adSource,$adTable,$aArray)
;===============================================================================

Func _accessCreateTable($adSource, $adTable, $adCol = '')
	Local $F_Out = ''
	If StringInStr(_accessListTables($adSource), $adTable & '|') Then Return SetError(3, 0, 0)
	If $adCol <> '' Then
		If Not IsArray($adCol) Then
			$adCol = StringSplit($adCol, '|')
		EndIf
		For $I = 1 To $adCol[0]
			If $I <> $adCol[0] Then $adCol[$I] = $adCol[$I] & ' ,'
			$F_Out &= $adCol[$I]
		Next
	EndIf
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	If $F_Out <> '' Then
		$oADO.Execute("CREATE TABLE " & $adTable & '(' & $F_Out & ')');;<<=== Create the table and the columns specified by $adCol
	Else
		$oADO.Execute("CREATE TABLE " & $adTable);;  <<==== No columns were specified so just create an empty table
	EndIf
	$oADO.Close
EndFunc   ;==>_accessCreateTable

;===============================================================================
; 函数名称:   _accessDeleteRecord()
; 描述:       搜索数据库字符串，并将搜索到的字符串(整列)数据删除
; 语法:       _adoDeleteRecord($adSource,$adTable, $adCol,$Find,[$adOcc])
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
;             $adCol - 搜索的字段名(请勿使用索引号)
;             $Find - 查找到的字符串
;             $adOcc - 如果设置的数值 = 1 删除第一个匹配的记录 (默认值)
;                      如果设置的数值 <> 1 删除所有匹配的记录
; 需求:
; 返回值:     成功 - @Error = 0
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:         Chr(28) 是一种不可见字符，用于避免字符串中容易冲突的字符
; 修改:
;===============================================================================

Func _accessDeleteRecord($adSource, $adTable, $adCol, $Find, $adOcc = 1)
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	Local $Search = $adCol & " = '" & $Find & Chr(39)
	With $oRec
		.CursorLocation = $adUseClient
		If $adOcc = 1 Then
			.Open("SELECT * FROM " & $adTable, $oADO, $adOpenStatic, $adLockOptimistic)
			.find($Search)
			.Delete()
			.close
		Else
			.Open("DELETE * FROM " & $adTable & " WHERE " & $adCol & " = '" & $Find & Chr(39), $oADO, $adOpenStatic, $adLockOptimistic)
		EndIf
	EndWith
	$oADO.Close
EndFunc   ;==>_accessDeleteRecord

;===============================================================================
; 函数名称:   _accessDeleteTable()
; 描述:       从 MS Access 数据库(*. mdb)文件中删除表
; 语法:       _accessDeleteTable($adSource, $adTable)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
; 需求:
; 返回值:     成功 - @Error = 0
;             失败 - 设置@Error
;                       1 = 无法创建连接
;                       2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
;===============================================================================

Func _accessDeleteTable($adSource, $adTable)
	Local $oADO = ObjCreate("ADODB.Connection")
	$oADO.Provider = $adoProvider
	$oADO.Open($adSource)
	$oADO.execute("DROP TABLE " & $adTable)
	$oADO.Close
EndFunc   ;==>_accessDeleteTable

;===============================================================================
; 函数名称:   _accessGetVal()
; 描述:       返回指定字段的第一个值
; 语法:       _accessGetVal($adSource,$adTable, $adCol)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
;             $adCol - 当数值=0(第一个字段索引)=1(第二个字段索引)...
; 需求:
; 返回值:     成功 - 返回指定字段的值
;             失败 - 返回一个空字符串并设置@Error
;                                          1 = 无法创建连接
;                                          2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
;===============================================================================

Func _accessGetVal($adSource, $adTable, $adCol)
	Local $Val
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset()
	If IsObj($oRec) = 0 Then Return SetError(2)
	$oRec.Open("SELECT * FROM " & $adTable, $oADO, $adOpenStatic, $adLockOptimistic)
	$Val = $oRec.Fields($adCol).Value
	$oRec.Close
	$oADO.Close
	Return $Val
EndFunc   ;==>_accessGetVal

;===============================================================================
; 函数名称:   _accessListFields()
; 描述:       返回 MS Access 数据库中所指定的表中的所有字段名称
; 语法:       _accessListFields($adSource, $adTable)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
; 需求:
; 返回值:     成功 - 返回一个把字段名以"|"分割的字符串
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
;===============================================================================

Func _accessListFields($adSource, $adTable)
	Local $Rtn = ''
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	;With $oRec
	$oRec.Open($adTable, $oADO, $adOpenStatic, $adLockOptimistic)
	Local $Fc = $oRec.fields.count
	If $Fc > 0 Then
		For $I = 0 To $Fc - 1
			$Rtn &= $oRec.fields($I).name & '|'
		Next
	EndIf
	$oRec.Close
	;EndWith
	$oADO.Close
	If $Rtn Then
		Return StringTrimRight($Rtn, 1)
	EndIf
EndFunc   ;==>_accessListFields

;===============================================================================
; 函数名称:   _accessListTables()
; 描述:       返回 MS Access 数据库中所有的表名称
; 语法:       _accessListTables($adSource)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
; 需求:
; 返回值:     成功 - 返回一个把表名以"|"分割的字符串
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        3 = 没有找到表名(返回一个空字符串)
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
;===============================================================================

Func _accessListTables($adSource)
	Local $oList = ''
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = $oADO.OpenSchema($adSchemaTables)
	While Not $oRec.EOF
		If StringLen( $oRec("TABLE_TYPE" ).value) > 5 Then;; Skip the hidden internal tables
			$oRec.movenext
			ContinueLoop
		EndIf
		$oList = $oList & $oRec("TABLE_NAME" ).value & '|'
		$oRec.movenext
	WEnd
	If $oList <> '' Then
		$oADO.close
		Return '|' & StringTrimRight($oList, 1)
	Else
		SetError(3, 0, 0)
		$oADO.close
		Return $oList
	EndIf
EndFunc   ;==>_accessListTables

;===============================================================================
; 函数名称:   _accessQueryLike()
; 描述:       搜索数据库中指定的表内的字段所包含指定的字符串
; 语法:       _accessQueryLike($adSource, $adTable, $adCol, $Find, [$adFull])
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
;             $adCol - 搜索的字段名(请勿使用索引)
;             $Find - 搜索的字符串(为空即搜索全部记录)
;             $adFull - 如果 = 1 使用Chr(28)作为分隔符. (默认)
;                       如果 <> 1 返回一个包含指定字段的每一条记录的数组
; 需求:       _accessCountFields()
; 返回值:     成功 - 返回一个包含符合条件的记录,每个字段名下值的数组,每条记录的信息以Chr(28)为分割的(分隔符请参照$adFull的说明)
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:         Chr(28) 是一种不可见字符 用于避免字符串中容易冲突的字符
;                     在Windows 2000中 "Like" 查询将失败
; 修改:
;===============================================================================

Func _accessQueryLike($adSource, $adTable, $adCol, $Find, $adFull = 1)
	Local $I, $Rtn
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	$oRec.Open("SELECT * FROM " & $adTable & " WHERE " & $adCol & " Like '%" & $Find & "%'", $oADO, $adOpenStatic, $adLockOptimistic)
	If $oRec.RecordCount < 1 Then
		Return SetError(1)
	Else
		SetError(0)
		$oRec.MoveFirst()
		;;MsgBox(0,'TEST', "Number of records: " & $oRec.RecordCount);;<<======  For testing only
		Do
			If $adFull = 1 Then
				For $I = 0 To _accessCountFields($adSource, $adTable) - 1
					;;MsgBox(0,'TEST 2 ', "Value of field " & $oRec.Fields($I).Name & ' is:' & @CRLF & @CRLF & $oRec.Fields($I).Value);;<<======  For testing only
					$Rtn = $Rtn & $oRec.Fields($I).Value & Chr(28);;<<====== Separate the fields with a non-printable character
				Next
			EndIf
			$Rtn = $Rtn & Chr(29);;<<====== Separate the records with a non-printable character
			$oRec.MoveNext()
		Until $oRec.EOF
		$oRec.Close
		$oADO.Close
		If $adFull = 1 Then Return StringSplit(StringTrimRight($Rtn, 2), Chr(29))
		Return StringSplit(StringTrimRight($Rtn, 1), Chr(29))
	EndIf
EndFunc   ;==>_accessQueryLike

;===============================================================================
; 函数名称:   _accessQueryStr()
; 描述:       搜索数据库中的指定字符串,并返回搜索结果
; 语法:       _accessQueryStr($adSource,$adTable, $adCol,$Find)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
;             $adCol - 搜索的字段名称 (请勿使用指数)
;             $Find - 搜索的字符串
; 需求:
; 返回值:     成功 - 返回指定字段的值
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
;===============================================================================

Func _accessQueryStr($adSource, $adTable, $adCol, $Find)
	$Find = Chr(34) & String($Find) & Chr(34)
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	$oRec.Open("SELECT * FROM " & $adTable & " Where " & $adCol & " = " & $Find, $oADO, $adOpenStatic, $adLockOptimistic)
	If $oRec.RecordCount > 0 Then
		$oRec.MoveFirst()
		Return $oRec.Fields($adCol).Value
	EndIf
	Return ''
EndFunc   ;==>_accessQueryStr

;===============================================================================
; 函数名称:   _accessSaveXML()
; 描述:       将 MS Access 数据库中指定的表将导出为XML文件
; 语法:       _accessSaveXML($adSource, $adTable[,$oFile])
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
;             $oFile - 路径以及xml文件名 (默认扩展名.xml)
; 需求:
; 返回值:     无
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
;===============================================================================

Func _accessSaveXML($adSource, $adTable, $oFile = '')
	If $oFile = '' Then $oFile = StringLeft($adSource, StringInStr($adSource, '\', 0, -1)) & $adTable & '.xml'
	If Not StringInStr($oFile, '\') Then $oFile = StringLeft($adSource, StringInStr($adSource, '\', 0, -1)) & $oFile
	If StringRight($oFile, 4) <> '.xml' Then $oFile &= '.xml'
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset()
	$oRec.Open("SELECT * FROM " & $adTable, $oADO, $adOpenStatic, $adLockOptimistic)
	$oRec.MoveFirst()
	$oRec.Save($oFile, $adPersistXML)
	$oRec.Close
	$oADO.Close
EndFunc   ;==>_accessSaveXML

;===============================================================================
; 函数名称:   _accessTableCount()
; 描述:       统计在 MS Access 数据库中有多少个表
; 语法:       _accessTableCount($adSource)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
; 需求:
; 返回值:     成功 - 返回表的数量
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
; 例子:       MsgBox(4096, '表', '在数据库中有<' & _accessTableCount($adSource) & '>个表')
;===============================================================================

Func _accessTableCount($adSource)
	Local $T_Count = StringSplit(_accessListTables($adSource), '|')
	Return $T_Count[0]
EndFunc   ;==>_accessTableCount

;===============================================================================
; 函数名称:   _accessUpdateRecord()
; 描述:       搜索MS Access数据库中的表，并更新表中的数据记录
; 语法:       _accessUpdateRecord($adSource,$adTable,$adCol,$adQuery,$adcCol,$adData)
; 参数:       $adSource - 打开数据库文件的完整路径以及数据库文件名
;             $adTable - 搜索的表名称
;             $adCol - 搜索的字段名
;             $adQuery - 搜索的字符串
;             $adcCol - 更新后字段名
;             $adData - 更新后字符串，新的字符串将会储存在$adcCol
; 需求:
; 返回值:     成功 - 更新表
;             失败 - 设置@Error
;                        1 = 无法创建连接
;                        2 = 无法创建recordset对象
;                        3 = 更新失败,无法打开记录
; 作者:       George (GEOSoft) Gedye
; 本地化:     Kodin
; 注:
; 修改:
;===============================================================================

Func _accessUpdateRecord($adSource, $adTable, $adCol, $adQuery, $adcCol, $adData)
	$adQuery = Chr(39) & $adQuery & Chr(39)
	Local $oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	Local $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	$oRec.CursorLocation = $adUseClient
	$oRec.Open("SELECT * FROM " & $adTable, $oADO, $adOpenStatic, $adLockOptimistic)
	If @error = 0 Then
		$oRec.Find($adCol & ' = ' & $adQuery)
		$oRec($adcCol) = $adData
		$oRec.Update
		$oRec.Close
	Else
		$oADO.Close
		Return SetError(3, 0, 0)
	EndIf
	$oADO.Close
EndFunc   ;==>_accessUpdateRecord

Func _dbOpenRecordset()
	Local $oRec = ObjCreate("ADODB.Recordset")
	Return $oRec
EndFunc   ;==>_dbOpenRecordset

;;  Private Functions

Func _dbOpen($adSource)
	Local $oADO = ObjCreate("ADODB.Connection")
	$oADO.Provider = $adoProvider
	$oADO.Open($adSource)
	Return $oADO
EndFunc   ;==>_dbOpen