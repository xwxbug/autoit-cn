#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
	函数名称:    _accessCountRecords()
	描述:        打开数据库文件，读取指定表中的记录数。
	语法:        _accessCountRecords($adSource, $adTable)
	参数:        $adSource  打开数据库文件的完整路径以及数据库文件名
	             $adTable   搜索的表名称
	返回值:  	 成功: 返回表中的记录数 
                 失败: 返回出错信息
					   1 = 无法创建连接 
                       2 = 无法创建recordset对象 
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#include <Access.au3>
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

MsgBox(0, '查询纪录数', '表中共有【' & _accessCountRecords($adSource, $adTable) & '】条数据记录.')
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 2
	描述:        打开数据库文件，读取指定表中的记录数。
	语法:        SELECT COUNT(*) FROM " & 表名称
	参数:        $adSource  打开数据库文件的完整路径以及数据库文件名
	             $adTable   搜索的表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")

$RS.ActiveConnection = $addfld
$RS.Open("SELECT COUNT(*) FROM " & $adTable)
MsgBox(0, '查询纪录数', '表中共有【' & $RS.Fields(0).value & '】条数据记录.')
$RS.close
$addfld.Close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
	描述:        打开数据库文件，读取指定表中指定字段(列)的记录数。
	语法:        SELECT COUNT(id) FROM " & 表名称
	参数:        $adSource  打开数据库文件的完整路径以及数据库文件名
	             $adTable   搜索的表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")

$RS.ActiveConnection = $addfld
$RS.Open("SELECT COUNT(id) FROM " & $adTable)
MsgBox(0, '查询纪录数', '表中 id 列共有【' & $RS.Fields(0).value & '】条数据记录.')
$RS.close
$addfld.Close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 4
	函数名称:    _accessCountRecords()
	描述:        打开数据库文件，读取指定表中的记录数。
	语法:        _accessCountRecords($adSource, $adTable)
	参数:        $adSource  打开数据库文件的完整路径以及数据库文件名
	             $adTable   搜索的表名称
	返回值:  	 成功: 返回表中的记录数 
                 失败: 返回出错信息
					   1 = 无法创建连接 
                       2 = 无法创建recordset对象 
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

MsgBox(0, '查询纪录数', '表中共有【' & _accessCountRecords($adSource, $adTable) & '】条数据记录.')

Func _accessCountRecords($adSource, $adTable)
	$oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	$oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	$oRec.open("SELECT * FROM " & $adTable, $oADO, 3, 3)
	If $oRec.recordcount <> 0 Then $oRec.MoveFirst
	$Rc = $oRec.recordcount
	$oRec.Close
	$oADO.Close
	Return $Rc
EndFunc   ;==>_accessCountRecords

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
