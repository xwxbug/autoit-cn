#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
	函数名称:    _accessUpdateRecord()
	描述:        搜索数据库文件中的表，并更新表中的数据记录
	语法:        _accessUpdateRecord($adSource,$adTable,$adCol,$adQuery,$adcCol,$adData)
	参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
	$adTable - 搜索的表名称
	$adCol - 搜索的字段名
	$adQuery - 搜索的字符串
	$adcCol - 需要更新的字段名
	$adData - 更新后字符串，新的字符串将会储存在$adcCol
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$adQuery = "A"
$adcCol = "pass"
$adData = "A01"

_accessUpdateRecord($adSource, $adTable, $adCol, $adQuery, $adcCol, $adData)
MsgBox(0, "提示", "更新数据成功！")
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:       示例 2
	描述:       搜索数据库文件中的表，并更新表中的数据记录
	语法:       Update 表名 set 列名 = 新值 where 列名 = 某值
				Update 表名 set 列名 = 新值,列名 = 新值... where 列名 = 某值
	参数:       $adSource  - 打开数据库文件的完整路径以及数据库文件名
				$adTable - 搜索的表名称
	            $adCol - 搜索的字段名
	            $adQuery - 搜索的字符串
				$adcCol - 需要更新的字段名
				$adData - 更新后字符串，新的字符串将会储存在$adcCol
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$adQuery = "A"
$adcCol = "pass"
$adData = "A02"

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$addfld.execute("update " & $adTable & " set " & $adcCol & " = '" & $adData & "' where " & $adCol & " = '" & $adQuery & "'" )
$addfld.close
MsgBox(0, "提示", "更新数据成功！")
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
	函数名称:    _accessUpdateRecord()
	描述:        搜索数据库文件中的表，并更新表中的数据记录
	语法:        _accessUpdateRecord($adSource,$adTable,$adCol,$adQuery,$adcCol,$adData)
	参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
	$adTable - 搜索的表名称
	$adCol - 搜索的字段名
	$adQuery - 搜索的字符串
	$adcCol - 需要更新的字段名
	$adData - 更新后字符串，新的字符串将会储存在$adcCol
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$adQuery = "A"
$adcCol = "pass"
$adData = "A03"

_accessUpdateRecord($adSource, $adTable, $adCol, $adQuery, $adcCol, $adData)
MsgBox(0, "提示", "更新数据成功！")

Func _accessUpdateRecord($adSource, $adTable, $adCol, $adQuery, $adcCol, $adData)
	$adQuery = Chr(39) & $adQuery & Chr(39)
	$oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	$oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	$oRec.CursorLocation = 3
	$oRec.Open("SELECT * FROM " & $adTable, $oADO, 3, 3)
	If @error = 0 Then
		$strSearch = $adCol & ' = ' & $adQuery
		$oRec.Find($strSearch)
		$oRec($adcCol) = $adData
		$oRec.Update
		$oRec.Close()
	Else
		$oADO.Close()
		Return SetError(3, 0, 0)
	EndIf
	$oADO.Close()
EndFunc   ;==>_accessUpdateRecord

Func _dbOpen($adSource);打开数据库
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
