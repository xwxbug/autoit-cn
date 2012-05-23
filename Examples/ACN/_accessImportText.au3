#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:       示例 1
	描述:       导入TXT文本数据
	语法:       insert into 表名 SELECT * FROM [Text;FMT=Delimited;HDR=Yes;DATABASE=文本数据路径].[文本名#txt]
	需求:       schema.ini文件 (可通过ACCESS软件手动导出TXT数据作参考依据)
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb";数据库地址
$adTable = "Table2";表名
$TextPath = "C:\Users\Kodin\Desktop\";导入路径
$Text = "Table2";TXT数据文本

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$addfld.Execute("insert into " & $adTable & " SELECT * FROM [Text;FMT=Delimited;HDR=Yes;DATABASE=" & $TextPath & "].[" & $Text & "#txt]")
$addfld.close
