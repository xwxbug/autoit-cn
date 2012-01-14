#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
	描述:       清除数据库文件指定表的所有记录
	语法:       _accessClearTable($adSource, $adTable)
	参数:       $adSource  - 打开数据库文件的完整路径以及数据库文件名
	$adTable - 搜索的表名称
	返回值:     0 = 成功，1 = 无法创建连接，2 = 无法创建recordset对象
	注:         这只会清除记录，无法删除表，无法清除表类型
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

_accessClearTable($adSource, $adTable)
MsgBox(64, "提示", "清除 " & $adTable & " 表记录成功.", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 2
	描述:       清除数据库文件指定表的所有记录
	语法:   	DELETE * FROM 表名(删除所有记录)
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$sQuery = "DELETE * FROM " & $adTable
$addfld.execute($sQuery)
$addfld.close
MsgBox(64, "提示", "清除 " & $adTable & " 表记录成功.", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
	描述:       清除数据库文件指定表的所有记录
	语法:       _accessClearTable($adSource, $adTable)
	参数:       $adSource  - 打开数据库文件的完整路径以及数据库文件名
	$adTable - 搜索的表名称
	返回值:     0 = 成功，1 = 无法创建连接，2 = 无法创建recordset对象
	注:         这只会清除记录，无法删除表，无法清除表类型
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

_accessClearTable($adSource, $adTable)
MsgBox(64, "提示", "清除 " & $adTable & " 表记录成功.", 5)

Func _accessClearTable($adSource, $adTable)
	$oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	$oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
	If IsObj($oRec) = 0 Then Return SetError(2)
	If _accessCountRecords($adSource, $adTable) > 0 Then
		$oRec.CursorLocation = 3
		$oRec.Open("Delete * FROM " & $adTable, $oADO, 3, 3)
	EndIf
	$oADO.Close()
EndFunc   ;==>_accessClearTable

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

