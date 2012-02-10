#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
    函数名称:    _accessQueryLike()
    描述:        搜索数据库中指定的表内的字段所包含指定的字符串(数据为空即搜索全部字符串)   
    语法:        _accessQueryLike($adSource,$adTable, $adCol,$Find, [$adFull])
    参数:        $adSource  打开数据库文件的完整路径以及数据库文件名
                 $adTable   搜索的表名称
                 $adCol     搜索的字段名(请勿使用索引)
                 $Find      搜索的字符串(为空即搜索全部记录)
                 $adFull    如果 = 1 使用Chr(28)作为分隔符. (默认)
							如果 <> 1 返回一个包含指定字段的每一条记录的数组
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
#include <Array.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "id"
$Find = ""
$adFull = 1

$yo = _accessQueryLike($adSource, $adTable, $adCol, $Find, $adFull)
_ArrayDisplay($yo, "读取表内所有数据")

$aRecord = StringSplit($yo[1], Chr(28))
_ArrayDisplay($aRecord, "读取指定某列所有数据")
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 2
	描述:       在数据库文件中读取表数据(读取所有列的数据)
	语法:       SELECT 列名称 FROM 表名称
	说明:       BOF 指示当前记录位置位于 Recordset 对象的第一个记录之前.
	            EOF 指示当前记录位置位于 Recordset 对象的最后一个记录之后.
	            BOF 和 EOF 属性返回布尔型值。使用 BOF 和 EOF 属性可确定 Recordset
	            对象是否包含记录，或者从一个记录移动到另一个记录时是否超出 Recordset
	            对象的限制。如果当前记录位于第一个记录之前，BOF 属性将返回 True (-1)，
				如果当前记录为第一个记录或位于其后则将返回 False (0)。
	            如果当前记录位于 Recordset 对象的最后一个记录之后 EOF 属性将返回 True，
	            而当前记录为 Recordset 对象的最后一个记录或位于其前，则将返回 False。
	            如果 BOF 或 EOF 属性为 True，则没有当前记录。
	            $RS.Fields(0).Value 是读取数据表中每一列第1个字段的值，它类
	            似数组，从0开始，往后面依此类推。
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open("Select * From " & $adTable)
While Not $RS.eof And Not $RS.bof
	If @error = 1 Then ExitLoop
	MsgBox(0, $RS.Fields(0).value, $RS.Fields(0).value & "|" & $RS.Fields(1).value & "|" & $RS.Fields(2).value)
	$RS.movenext
WEnd
$RS.close
$addfld.Close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
	函数名称:
	描述:       在数据库文件中读取表数据(读取指定列的数据)
	语法:       SELECT 列名称 FROM 表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "id,name,pass"
$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open("Select " & $adCol & " From " & $adTable)
While Not $RS.eof And Not $RS.bof
	If @error = 1 Then ExitLoop
	MsgBox(0, $RS.Fields(0).value, $RS.Fields(0).value & "|" & $RS.Fields(1).value & "|" & $RS.Fields(2).value)
	$RS.movenext
WEnd
$RS.close
$addfld.Close