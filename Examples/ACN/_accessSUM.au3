#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:       示例 1
	描述:       返回数值列的总数(求和)
	语法:       SELECT SUM(列名) FROM 表
	            SELECT SUM(列名),SUM(列名) FROM 表
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb";数据库
$adTable = "Table2";表名
$adCol = "ID";列名

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open("SELECT SUM(" & $adCol & ") FROM " & $adTable)
While Not $RS.eof And Not $RS.bof
	If @error = 1 Then ExitLoop
	MsgBox(0, "求和结果", $RS.Fields(0).value)
	$RS.movenext
WEnd
$RS.close
$addfld.Close
