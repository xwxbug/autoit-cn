#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 1
	函数名称:    _accessListTables()
	描述:        读取数据库文件中所有的表名称
	语法:        _accessListTables($adSource)
	参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"

MsgBox(0, "搜索结果",  _accessListTables($adSource))
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 2
	描述:        读取数据库文件中所有的表名称
	参数:        OpenSchema 可返回 Recordset 对象，该对象包含有关数据源的模式信息。
	TABLE_TYPE = 表类型
	TABLE_NAME = 表名称
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$oList = ''

$oADO = ObjCreate("ADODB.Connection")
$oADO.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$oRec = $oADO.OpenSchema(20)
While Not $oRec.EOF
	If StringLen( $oRec("TABLE_TYPE" ).value) > 5 Then
		$oRec.movenext
		ContinueLoop
	EndIf
	MsgBox(0, "搜索结果", $oRec("TABLE_NAME" ).value)
	$oList = $oList & $oRec("TABLE_NAME" ).value & '|'
	$oRec.movenext
WEnd
MsgBox(0, "搜索结果", $oList)
$oADO.close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	例子:        示例 3
	函数名称:    _accessListTables()
	描述:        读取数据库文件中所有的表名称
	语法:        _accessListTables($adSource)
	参数:        $adSource  - 打开数据库文件的完整路径以及数据库文件名
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"

MsgBox(0, "搜索结果", _accessListTables($adSource))

Func _accessListTables($adSource)
	Local $oList = ''
	$oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	$oRec = $oADO.OpenSchema(20)
	While Not $oRec.EOF
		If StringLen( $oRec("TABLE_TYPE" ).value) > 5 Then;; Skip the hidden internal tables
			$oRec.movenext
			ContinueLoop
		EndIf
		$oList = $oList & $oRec("TABLE_NAME" ).value & '|'
		$oRec.movenext
	WEnd
	If $oList <> '' Then
		$oADO.close
		Return '|' & StringTrimRight($oList, 1)
	Else
		SetError(3, 0, 0)
		$oADO.close
		Return $oList
	EndIf
EndFunc   ;==>_accessListTables

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
