#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
	函数名称:    _accessCountFields()
	描述:        读取数据库文件中，指定表中的字段数
	语法:        _accessCountFields($adSource, $adTable)
	参数:        $adSource  打开数据库文件的完整路径以及数据库文件名
	             $adTable   搜索的表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$yo = _accessCountFields($adSource, $adTable)
MsgBox(0, "提示", $adTable & "表中有【" & $yo & "】个字段.")
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 2
	描述:        读取数据库文件中，指定表中的字段数
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.open($adTable, $addfld, 3, 3)
MsgBox(0, "提示", $adTable & "表中有【" & $RS.Fields.count & "】个字段.")
$RS.close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
	函数名称:    _accessCountFields()
	描述:        读取数据库文件中，指定表中的字段数
	语法:        _accessCountFields($adSource, $adTable)
	参数:        $adSource  打开数据库文件的完整路径以及数据库文件名
	             $adTable   搜索的表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$yo = _accessCountFields($adSource, $adTable)
MsgBox(0, "提示", $adTable & "表中有【" & $yo & "】个字段.")

Func _accessCountFields($adSource,$adTable)
   $oADO = 'ADODB.Connection'
   If IsObj($oADO) Then
      $oADO = ObjGet('',$oADO)
   Else
      $oADO = _dbOpen($adSource)
   EndIf
   If IsObj($oADO) = 0 Then Return SetError(1)
   $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
   If IsObj($oRec) = 0 Then Return SetError(2)
   $oRec.open ($adTable , $oADO, 3, 3)
   $Fc = $oRec.fields.count
   $oRec.Close
   $oADO.Close
   Return $Fc
EndFunc    ;<===> _accessCountFields()

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
