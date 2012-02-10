#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:      示例 1
	函数名称:    _accessGetVal()
	描述:        打开数据库文件，搜索指定的表中指定字段的第一个值,并返回搜索结果
	语法:        _accessGetVal($adSource,$adTable, $adCol)
	参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
	$adTable - 搜索的表名称
	$adCol - 当数值=0(搜索第一个字段索引)=1(搜索第二个字段索引)...
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = 1

MsgBox(0, "搜索结果", _accessGetVal($adSource, $adTable, $adCol))
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:      示例 2
	描述:        打开数据库文件，搜索指定的表中指定字段的第一个值,并返回搜索结果
	语法:        SELECT * FROM 表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = 1

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open("SELECT * FROM " & $adTable)
MsgBox(0, "搜索结果", $RS.Fields($adCol).value)
$RS.close
$addfld.Close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:      示例 3
	函数名称:    _accessGetVal()
	描述:        打开数据库文件，搜索指定的表中指定字段的第一个值,并返回搜索结果
	语法:        _accessGetVal($adSource,$adTable, $adCol)
	参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
	             $adTable - 搜索的表名称
	             $adCol - 当数值=0(搜索第一个字段索引)=1(搜索第二个字段索引)...
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = 1

MsgBox(0, "搜索结果", _accessGetVal($adSource, $adTable, $adCol))

Func _accessGetVal($adSource,$adTable, $adCol)
   Local $Val
   $oADO = 'ADODB.Connection'
   If IsObj($oADO) Then
      $oADO = ObjGet('',$oADO)
   Else
      $oADO = _dbOpen($adSource)
   EndIf
   If IsObj($oADO) = 0 Then Return SetError(1)
   $oRec = _dbOpenRecordset()
   If IsObj($oRec) = 0 Then Return SetError(2)
   $oRec.Open ("SELECT * FROM " & $adTable, $oADO, 3, 3)
   $Val = $oRec.Fields($adCol).Value
   $oRec.Close
   $oADO.Close()
   Return $Val
EndFunc

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
