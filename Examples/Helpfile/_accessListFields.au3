#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:        示例 1
 函数名称:    _accessListFields()
 描述:        打开数据库文件，读取指定表所有字段名称
 语法:        _accessListFields($adSource, $adTable)
 参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
              $adTable - 搜索的表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

MsgBox(0, "搜索结果", _accessListFields($adSource, $adTable))
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:        示例 2
 描述:        打开数据库文件，读取指定表所有字段名称
 语法:        SELECT * FROM 表名称
 参数:        $RS.fields.count = 字段总数
              $RS.fields($I).name = 字段名
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open("SELECT * FROM " & $adTable)

$Fc = $RS.fields.count
If $Fc > 0 Then
	$Rtn = ''
	For $I = 0 To $Fc - 1
		$Rtn &= $RS.fields($I).name & '|'
		MsgBox(0, "搜索结果", $RS.fields($I).name)
	Next
	MsgBox(0, "搜索结果", $Rtn)
EndIf

$RS.close
$addfld.Close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:        示例 3
 函数名称:    _accessListFields()
 描述:        打开数据库文件，读取指定表所有字段名称
 语法:        _accessListFields($adSource, $adTable)
 参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
              $adTable - 搜索的表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

MsgBox(0, "搜索结果", _accessListFields($adSource, $adTable))

Func _accessListFields($adSource,$adTable)
   Local $Rtn = ''
   $oADO = 'ADODB.Connection'
   If IsObj($oADO) Then
      $oADO = ObjGet('',$oADO)
   Else
      $oADO = _dbOpen($adSource)
   EndIf
   If IsObj($oADO) = 0 Then Return SetError(1)
   $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
   If IsObj($oRec) = 0 Then Return SetError(2)
   ;With $oRec
      $oRec.Open ($adTable , $oADO, 3, 3)
      $Fc = $oRec.fields.count
      If $Fc > 0 Then
         For $I = 0 to $Fc-1
            $Rtn &= $oRec.fields($I).name & '|'
         Next
      EndIf
      $oRec.Close
   ;EndWith
   $oADO.Close
   If $Rtn Then
      Return StringTrimRight($Rtn, 1)
   EndIf
EndFunc    ;<===> _accessListFields()

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
