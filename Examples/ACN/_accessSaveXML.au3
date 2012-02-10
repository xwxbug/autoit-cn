#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
	函数名称:     _accessSaveXML()
	描述:         打开数据库文件，将指定的表导出为XML文件
	语法:         _accessSaveXML($adSource, $adTable[,$oFile])
	参数:         $adSource  - 打开数据库文件的完整路径以及数据库文件名
	$adTable - 搜索的表名称
	$oFile - 路径以及xml文件名 (默认扩展名.xml)
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$oFile = @ScriptDir & "\DB1.xml"

If FileExists($oFile) Then
	MsgBox(64, "创建失败", $oFile & " 文件已存在.")
Else
	_accessSaveXML($adSource, $adTable, $oFile)
	MsgBox(0, "提示", "创建成功.")
EndIf
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:         示例 2
	描述:         打开数据库文件，将指定的表导出为XML文件
	语法:         SELECT * FROM 表名
				  $RS.Save 把 Recordset 对象保存到 file 或 Stream 对象中。
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$oFile = @ScriptDir & "\DB1.xml"

$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$RS = ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open("SELECT * FROM " & $adTable)
$RS.MoveFirst()
If FileExists($oFile) Then
	MsgBox(64, "创建失败", $oFile & " 文件已存在.")
Else
	$RS.Save($oFile, 1)
	MsgBox(0, "提示", "创建成功.")
EndIf
$RS.close
$addfld.Close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
	函数名称:     _accessSaveXML()
	描述:         打开数据库文件，将指定的表导出为XML文件
	语法:         _accessSaveXML($adSource, $adTable[,$oFile])
	参数:         $adSource  - 打开数据库文件的完整路径以及数据库文件名
	              $adTable - 搜索的表名称
	              $oFile - 路径以及xml文件名 (默认扩展名.xml)
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$oFile = @ScriptDir & "\DB1.xml"

_accessSaveXML($adSource, $adTable, $oFile)

Func _accessSaveXML($adSource, $adTable, $oFile = '')
	If $oFile = '' Then $oFile = StringLeft($adSource, StringInStr($adSource, '\', 0, -1)) & $adTable & '.xml'
	If Not StringInStr($oFile, '\') Then $oFile = StringLeft($adSource, StringInStr($adSource, '\', 0, -1)) & $oFile
	If StringRight($oFile, 4) <> '.xml' Then $oFile &= '.xml'
	$oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	$oRec = _dbOpenRecordset()
	$oRec.Open("SELECT * FROM " & $adTable, $oADO, 3, 3)
	$oRec.MoveFirst()
	If FileExists($oFile) Then
		MsgBox(64, "创建失败", $oFile & " 文件已存在.")
	Else
		$oRec.Save($oFile, 1)
		MsgBox(0, "提示", "创建成功.")
	EndIf
	$oRec.Close()
	$oADO.Close()
EndFunc   ;==>_accessSaveXML

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