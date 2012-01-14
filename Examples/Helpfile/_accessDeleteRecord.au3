#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:      示例 1
	函数名称:  _accessDeleteRecord()
	描述:      搜索数据库字符串，并将搜索到的字符串(整列)数据删除
	语法:      _adoDeleteRecord($adSource,$adTable, $adCol,$Find,[$adOcc])
	参数:      $adSource  - 打开数据库文件的完整路径以及数据库文件名
	           $adTable - 搜索的表名称
	           $adCol - 搜索的字段名（请勿使用指数）
	           $Find - 查找到的字符串
	           $adOcc - 如果设置的数值 = 1 删除第一个匹配的记录 (Default)
	           如果设置的数值 <> 1 删除所有匹配的记录
	           返回值:    成功: 从表中删除记录，并返回0
						失败: 设置@Error
	                              1 = 无法创建连接
	                              2 = 无法创建recordset对象
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$Find = "A"
$adOcc = "1"

_accessDeleteRecord($adSource, $adTable, $adCol, $Find, $adOcc)
MsgBox(64, "提示", "数据删除成功.", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 2
	描述:       搜索数据库字符串，并将搜索到的字符串(整列)数据删除
	语法:   	DELETE FROM 表名 WHERE 列名称 = 值(删除所有匹配的记录)
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$Find = "A"

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$sQuery = "DELETE FROM " & $adTable & " WHERE " & $adCol & " = " & " '" & $Find & "'"
$addfld.execute($sQuery)
$addfld.close
MsgBox(64, "提示", "数据删除成功.", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:      示例 3
	函数名称:  _accessDeleteRecord()
	描述:      搜索数据库字符串，并将搜索到的字符串(整列)数据删除
	语法:      _adoDeleteRecord($adSource,$adTable, $adCol,$Find,[$adOcc])
	参数:      $adSource  - 打开数据库文件的完整路径以及数据库文件名
	           $adTable - 搜索的表名称
	           $adCol - 搜索的字段名（请勿使用指数）
	           $Find - 查找到的字符串
	           $adOcc - 如果设置的数值 = 1 删除第一个匹配的记录 (Default)
	           如果设置的数值 <> 1 删除所有匹配的记录
	           返回值:    成功: 从表中删除记录，并返回0
						失败: 设置@Error
	                              1 = 无法创建连接
	                              2 = 无法创建recordset对象
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$Find = "A"

_accessDeleteRecord($adSource, $adTable, $adCol, $Find)
MsgBox(0, "提示", "数据删除成功.")

Func _accessDeleteRecord($adSource,$adTable, $adCol,$Find,$adOcc = 1)
   $oADO = 'ADODB.Connection'
   If IsObj($oADO) Then
      $oADO = ObjGet('',$oADO)
   Else
      $oADO = _dbOpen($adSource)
   EndIf
   If IsObj($oADO) = 0 Then Return SetError(1)
   $oRec = _dbOpenRecordset()
   If IsObj($oRec) = 0 Then Return SetError(2)
   $Search = $adCol & " = '" & $Find & Chr(39)
   With $oRec
      .CursorLocation = 3
      If $adOcc = 1 Then
         .Open ("SELECT * FROM " & $adTable , $oADO, 3, 3)
         .find($Search)
         .Delete()
         .close
      Else
         .Open("DELETE * FROM " & $adTable & " WHERE " & $adCol & " = '" & $Find & Chr(39), $oADO, 3, 3)
      EndIf
   EndWith
   $oADO.Close()
EndFunc    ;<===> _accessDeleteRecord()

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
