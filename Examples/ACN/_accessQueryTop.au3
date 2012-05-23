#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:       示例 1
	描述:       指定读取需要返回的记录
	语法:       SELECT TOP 记录数 * FROM 表名 ORDER BY 列名
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb";数据库
$adTable = "Table2";表名
$adCol = "ID";列名
$number = "1";记录数

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open("SELECT TOP " & $number & " * FROM " & $adTable & " ORDER BY " & $adCol);显示最后一条记录
While Not $RS.eof And Not $RS.bof
	If @error = 1 Then ExitLoop
	MsgBox(0, "查询结果", $RS.Fields(0).value & "|" & $RS.Fields(1).value)
	$RS.movenext
WEnd
$RS.close
$addfld.Close
