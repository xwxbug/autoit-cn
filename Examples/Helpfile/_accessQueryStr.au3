#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
    函数名称:    _accessQueryStr()
    描述:        搜索数据库中的指定字符串，并返回搜索结果
    语法:        _accessQueryStr($adSource,$adTable, $adCol,$Find)
    参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
                 $adTable - 搜索的表名称
                 $adCol - 搜索的字段名称 (请勿使用指数)
                 $Find - 搜索的字符串
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$Find = "A"

MsgBox(0, 0, _accessQueryStr($adSource, $adTable, $adCol, $Find));成功则返回字段的值，失败则返回空字符串
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 2
    描述:        搜索数据库中的指定字符串，并返回搜索结果
    语法:        SELECT * FROM " 表名 Where 字段名 = '字符串'
    参数:        $RS.Fields($adCol).Value = 返回搜索结果
                 Bof 和 Eof 分别指示指针指向头以前和尾以后。结果为True和False.
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$Find = "A"

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open("SELECT * FROM " & $adTable & " Where " & $adCol & " = " & "'" & $Find & "'")
If Not $RS.eof And Not $RS.bof Then
	MsgBox(0, "搜索结果", $RS.Fields($adCol).Value)
Else
	MsgBox(0, "搜索结果", "失败")
EndIf
$RS.close
$addfld.Close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
    函数名称:    _accessQueryStr()
    描述:        搜索数据库中的指定字符串，并返回搜索结果
    语法:        _accessQueryStr($adSource,$adTable, $adCol,$Find)
    参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
                 $adTable - 搜索的表名称
                 $adCol - 搜索的字段名称 (请勿使用指数)
                 $Find - 搜索的字符串
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "name"
$Find = "A"

MsgBox(0, 0, _accessQueryStr($adSource, $adTable, $adCol, $Find));成功则返回字段的值，失败则返回空字符串

Func _accessQueryStr($adSource,$adTable, $adCol,$Find)
   $Find = Chr(34) & String($Find) & Chr(34)
   $oADO = 'ADODB.Connection'
   If IsObj($oADO) Then
      $oADO = ObjGet('',$oADO)
   Else
      $oADO = _dbOpen($adSource)
   EndIf
   If IsObj($oADO) = 0 Then Return SetError(1)
   $oRec = _dbOpenRecordset();ObjCreate("ADODB.Recordset")
   If IsObj($oRec) = 0 Then Return SetError(2)
   $oRec.Open ("SELECT * FROM " & $adTable & " Where " & $adCol & " = " & $Find , $oADO, 3, 3)
   If $oRec.RecordCount > 0 Then
      $oRec.MoveFirst()
      Return $oRec.Fields($adCol).Value
   EndIf
   Return ''
EndFunc   ;<==> _accessQueryStr($adSource,$adTable, $adCol,$Find)

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
