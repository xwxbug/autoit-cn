#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:      示例 1
	函数名称:   _accessDeleteTable()
	描述:      从数据库文件中删除表
	语法:       _accessDeleteTable($adSource, $adTable)
	参数:      $adSource  - 打开数据库文件的完整路径以及数据库文件名
	           $adTable - 搜索的表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

_accessDeleteTable($adSource, $adTable)
MsgBox(64, "提示", "删除表成功", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:      示例 2
	描述:      从数据库文件中删除表
	语法:      DROP TABLE 表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

$addtbl = ObjCreate("ADODB.Connection")
$addtbl.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$addtbl.Execute("DROP TABLE " & $adTable)
$addtbl.Close
MsgBox(64, "提示", "删除表成功", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:      示例 3
	函数名称:   _accessDeleteTable()
	描述:      从数据库文件中删除表
	语法:       _accessDeleteTable($adSource, $adTable)
	参数:      $adSource  - 打开数据库文件的完整路径以及数据库文件名
	           $adTable - 搜索的表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"

_accessDeleteTable($adSource, $adTable)
MsgBox(64, "提示", "删除表成功", 5)

Func _accessDeleteTable($adSource, $adTable)
   $oADO = ObjCreate("ADODB.Connection")
   $oADO.Provider = _adoProvider()
   $oADO.Open ($adSource)
   $oADO.execute ("DROP TABLE " & $adTable)
   $oADO.Close
EndFunc    ;<===> _accessDeleteTable()


Func _adoProvider()
   Local $oProvider = "Microsoft.Jet.OLEDB.4.0; "
   Local $objCheck = ObjCreate("Access.application")
   If IsObj($objCheck) Then
      Local $oVersion = $objCheck.Version
      If StringLeft($oVersion, 2) == "12" Then $oProvider="Microsoft.ACE.OLEDB.12.0; "
   EndIf
   Return $oProvider
EndFunc