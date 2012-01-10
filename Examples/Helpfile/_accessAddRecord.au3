#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
	函数名称:   _accessAddRecord()
	描述:       在现有的数据库表文件中添加新记录（单个或多个字段）
	语法:       _accessAddRecord($adSource, $adTable, $rData,$adCol = 0)
	参数:       $adSource  - 打开数据库文件的完整路径以及数据库文件名
	$adTable - 搜索的表名称
	$rData - 将数据被添加到字段（必须是一个数组才能将数据添加到多个字段，数据必须输入相应的工作类型数据)
	$adCol - 当数值等于0，而当$rData不是数组，将会添加数据至（默认为第一格）
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#Include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$rData = "1 | ABC | DEF"
$adCol = 0

_accessAddRecord($adSource, $adTable, $rData, $adCol)
MsgBox(64, "提示", "添加新记录成功", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 2
	描述:       在现有的数据库表文件中添加新记录（单个或多个字段）
	语法:       INSERT INTO 表名称 VALUES (值1,值2,....')
	            INSERT INTO 表名称 (列1,列2,....') VALUES (值1,值2,....')
    说明:      	我们所使用的是向指定列插入数据。列名称一定要和值对应，还要注
	            意某些类型的值在写入的时候不能带有“ ' or  " ”,所以在插入数据
				的时候要注意('" & $rData1 & "','" & $rData2 & "')")内所要更
				新的值是否多加了“ ' or "  ”号。 
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table2"
$rData1 = "ABC"
$rData2 = "DEF"

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$addfld.Execute("insert into " & $adTable & " (name,pass) values('" & $rData1 & "','" & $rData2 & "')")
$addfld.close
MsgBox(64, "提示", "添加新记录成功", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
	函数名称:   _accessAddRecord()
	描述:       在现有的数据库表文件中添加新记录（单个或多个字段）
	语法:       _accessAddRecord($adSource, $adTable, $rData,$adCol = 0)
	参数:       $adSource  - 打开数据库文件的完整路径以及数据库文件名
	$adTable - 搜索的表名称
	$rData - 将数据被添加到字段（必须是一个数组才能将数据添加到多个字段，数据必须输入相应的工作类型数据)
	$adCol - 当数值等于0，而当$rData不是数组，将会添加数据至（默认为第一格）
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table3"
$rData = "1 | ABC | DEF"

_accessAddRecord($adSource, $adTable, $rData)
MsgBox(64, "提示", "添加新记录成功", 5)

Func _accessAddRecord($adSource, $adTable, $rData, $adCol = 0)
	If Not IsArray($rData) Then
		$rData = StringSplit($rData, '|')
	EndIf
	$oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	If Not IsObj($oADO) Then Return SetError(2, 0, 0)
	$oRec = _dbOpenRecordset()
	If IsObj($oRec) = 0 Then Return SetError(2)
	With $oRec
		.Open("SELECT * FROM " & $adTable, $oADO, 3, 3)
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
	$oADO.Close()
EndFunc   ;==>_accessAddRecord

Func _dbOpen($adSource)
	$oProvider = "Microsoft.Jet.OLEDB.4.0; "
	$objCheck = ObjCreate("Access.application")
	If IsObj($objCheck) Then
		$oVersion = $objCheck.Version
		If StringLeft($oVersion, 2) == "12" Then $oProvider = "Microsoft.ACE.OLEDB.12.0; "
	EndIf
	$oADO = ObjCreate("ADODB.Connection")
	$oADO.Provider = $oProvider
	$oADO.Open($adSource)
	Return $oADO
EndFunc   ;==>_dbOpen

Func _dbOpenRecordset()
	$oRec = ObjCreate("ADODB.Recordset")
	Return $oRec
EndFunc   ;==>_dbOpenRecordset
