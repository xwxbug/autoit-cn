#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:      示例 1
 函数名称:   _accessCreateTable()
 描述:      在现有的数据库文件中建立表
 语法:       _accessCreateTable($adSource, $adTable, $adCol)
 参数:      $adSource  - 打开数据库文件的完整路径以及数据库文件名
            $adTable - 搜索的表名称
            $adCol - 字段类型必须用分隔符'|'分割标头名称和字段类型
 类型:      1、TEXT(数值1-255)=文本：char(n)  n表示文本大小
            2、MEMO=备注
            3、COUNTER=自动编号
            4、INTEGER=数字
            5、YESNO=是/否 (bit)
            6、DATETIME=时间日期
            7、CURRENCY=货币
            8、OLEOBJECT=OLE 对象
            9、BYTE=字节型
            10、LONG=长整型
            11、SHORT=整型
            12、SONGLE=单精度
            13、DOUBLE=双精度
            14、BINARY=二进制
			15、primary key=设置索引为：有(无重复)
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table1"
$adCol = "id COUNTER primary key | name text(255) | pass text(255)"

_accessCreateTable($adSource, $adTable, $adCol);在DB1.mdb数据库中创建表
MsgBox(64, "提示", "创建表成功", 5)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:      示例 2
 描述:      在现有的数据库文件中建立表
 说明:      用ADODB的连接打开(Connection)对象，连接到指定的数据库并打开，
			 执行CREATE TABLE (创建新表)，名称为声明变量中的名称。
            用ADODB打开数据库，执行ALTERTABLE(修改数据库表)，
			 “ADDididentity(1,1)primarykey,namechar(255),passchar(255)”表示添加ID、name、pass数据列。
			 “identity(1,1)primarykey”是指此数据列为索引，“char(255)”是数据类型
			 （建议使用text 表示文本类型，使用char容易造成在没有安装Access的客户机上多出“…”的省略号，
			 因为指定的255字节会全部被显示），最后关闭本次连接。
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table2"

If FileExists($adSource) Then
	$addtbl = ObjCreate("ADODB.Connection")
	$addtbl.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $adSource)
	$addtbl.Execute("CREATE TABLE " & $adTable)
	$addtbl.Execute("ALTER TABLE " & $adTable & " ADD id identity(1, 1) primary key,name text(255) ,pass text(255)")
	$addtbl.Close
	MsgBox(64, "提示", "创建表成功", 5)
Else
	MsgBox(64, "错误", "数据库文件不存在", 5)
EndIf
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
 例子:      示例 3
 函数名称:   _accessCreateTable()
 描述:      在现有的数据库文件中建立表
 语法:       _accessCreateTable($adSource, $adTable, $adCol)
 参数:      $adSource  - 打开数据库文件的完整路径以及数据库文件名
            $adTable - 搜索的表名称
            $adCol - 字段类型必须用分隔符'|'分割标头名称和字段类型
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Table3"
$adCol = "id COUNTER primary key | name text(255) | pass text(255)"

_accessCreateTable($adSource, $adTable, $adCol)

Func _accessCreateTable($adSource, $adTable, $adCol = '');在数据库中创建表
	Local $F_Out = ''
	If StringInStr(_accessListTables($adSource), $adTable & '|') Then Return SetError(3, 0, 0)

	If $adCol <> '' Then
		If Not IsArray($adCol) Then
			$adCol = StringSplit($adCol, '|')
		EndIf
		For $I = 1 To $adCol[0]
			If $I <> $adCol[0] Then $adCol[$I] = $adCol[$I] & ' ,'
			$F_Out &= $adCol[$I]
		Next
	EndIf
	$oADO = 'ADODB.Connection'
	If IsObj($oADO) Then
		$oADO = ObjGet('', $oADO)
	Else
		$oADO = _dbOpen($adSource)
	EndIf
	If IsObj($oADO) = 0 Then Return SetError(1)
	If $F_Out <> '' Then
		$oADO.Execute("CREATE TABLE " & $adTable & '(' & $F_Out & ')');;<<=== 根据$adCol需求，创建表
		MsgBox(64, "提示", "创建表成功", 5)
	Else
		$oADO.Execute("CREATE TABLE " & $adTable);;  <<==== $adCol没有添加数据，将会创建一个空的表
	EndIf
	$oADO.Close()
EndFunc   ;==>_accessCreateTable

Func _accessListTables($adSource);返回数据库中所有的表名称
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
		If StringLen( $oRec("TABLE_TYPE" ).value) > 5 Then;; 忽略隐藏属性的表
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
