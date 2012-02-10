#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:        示例 1
 函数名称:    _accessTableCount()
 描述:       统计数据库文件中有多少个表
 语法:        _accessTableCount($adSource)
 参数:       $adSource  - 创建数据库文件的完整路径
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"

MsgBox(4096, '搜索结果', '在数据库中共有【' & _accessTableCount($adSource) & '】个表。')
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:        示例 2
 描述:       统计数据库文件中有多少个表
 说明:       本例子里面有2个可行方法，请自行选中合适的.
             本例子查询所得结果可能会和例子1和例子3不一样.
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"

$oADO = ObjCreate("ADODB.Connection")
$oADO.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
$oRec = $oADO.OpenSchema(20)

$oList_A = ''
$oList_B = ''
$A = 0
$B = 0
While Not $oRec.EOF
	;方法 1-----------------------------------------------------------------------
	If $oRec("TABLE_TYPE" ).value = "TABLE" Then
		$A += 1
	Else
		$oRec.movenext
		ContinueLoop
	EndIf
	$oList_A = $oList_A & "表" & $A & "=" & $oRec("TABLE_NAME" ).value & @CRLF
	;方法 2-----------------------------------------------------------------------
	If StringLen( $oRec("TABLE_TYPE" ).value) = 12 Then
		$oRec.movenext
		ContinueLoop
	EndIf

	If Not $oRec("TABLE_NAME" ).value = "" Then $B += 1
	$oList_B = $oList_B & "表" & $B & "=" & $oRec("TABLE_NAME" ).value & @CRLF
	;----------------------------------------------------------------------------
	$oRec.movenext
WEnd
MsgBox(4096, '方法1 搜索结果', '在数据库中共有【' & $A & '】个表。' & @CRLF & @CRLF & $oList_A)
MsgBox(4096, '方法2 搜索结果', '在数据库中共有【' & $B & '】个表。' & @CRLF & @CRLF & $oList_B)
$oADO.close
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:        示例 3
 函数名称:    _accessTableCount()
 描述:       统计数据库文件中有多少个表
 语法:        _accessTableCount($adSource)
 参数:       $adSource  - 创建数据库文件的完整路径
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"

MsgBox(4096, '搜索结果', '在数据库中共有【' & _accessTableCount($adSource) & '】个表。')

Func _accessTableCount($adSource)
	$T_Count = StringSplit(_accessListTables($adSource), '|')
	Return $T_Count[0]
EndFunc   ;==>_accessTableCount

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
		If StringLen( $oRec("TABLE_TYPE" ).value) > 5 Then
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
