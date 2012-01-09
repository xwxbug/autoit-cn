;===============================================================================
; 例子:        示例 1
; 函数名称:    _accessCreateDB ()
; 描述:       创建一个数据库文件(*. mdb)
; 语法:        _accessCreateDB ($adSource)
; 参数:       $adSource  - 创建数据库文件的完整路径
;===============================================================================
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>
$mdb_data_path = @ScriptDir & "\DB1.mdb"

_accessCreateDB($mdb_data_path)
MsgBox(64, "提示", "建立数据库成功", 5)

;===============================================================================
; 例子:      示例 2
; 描述:      创建一个数据库文件(*. mdb)
; 说明:      ADOX是ADODB的对象扩展库，它的对象可用于创建、修改和删除数据库。
;            它还包含安全对象，可用于维护用户和组，以及授予和撤销对象的权限。
;            这里使用的对象：Catalog 是用于创建包含描述数据源模式目录的集合。
;            Create 创建新的目录。“Provider= Microsoft.Jet.OLEDB.4.0”表示数据库的类型，
;            “DataSource=" & $mdb_data_path”数据库创建的路径与名称。
;            最后是结束创建。(ActiveConnection指示目录所属的 ADO Connection 对象)
;===============================================================================
#AutoIt3Wrapper_UseX64 = n
$mdb_data_path = @ScriptDir & "\DB1.mdb"

If Not FileExists($mdb_data_path) Then;如果脚本所在目录没有发现数据库文件，则创建数据库文件，
	$newMdb = ObjCreate("ADOX.Catalog")
	$newMdb.Create("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $mdb_data_path);创建新的目录
	$newMdb.ActiveConnection.Close
	MsgBox(64, "提示", "建立数据库成功", 5)
Else
	MsgBox(64, "提示", "你已经建立了一个数据库了", 5)
EndIf
;===============================================================================
; 例子:        示例 3
; 函数名称:    _accessCreateDB ()
; 描述:       创建一个数据库文件(*. mdb)
; 语法:        _accessCreateDB ($adSource)
; 参数:       $adSource  - 创建数据库文件的完整路径
;===============================================================================
#AutoIt3Wrapper_UseX64 = n
$mdb_data_path = @ScriptDir & "\DB1.mdb"

_accessCreateDB($mdb_data_path)

Func _accessCreateDB($adSource)
	$oProvider = "Microsoft.Jet.OLEDB.4.0; "
	$objCheck = ObjCreate("Access.application")
	If IsObj($objCheck) Then
		$oVersion = $objCheck.Version
		If StringLeft($oVersion, 2) == "12" Then $oProvider = "Microsoft.ACE.OLEDB.12.0; "
	EndIf
	If StringRight($adSource, 4) <> '.mdb' Then $adSource &= '.mdb'
	If FileExists($adSource) Then
		$Fe = MsgBox(262196, '警告', '这个文件已经存在，是否替换这个文件？')
		If $Fe = 6 Then
			FileDelete($adSource)
			$dbObj = ObjCreate('ADOX.Catalog')
			If IsObj($dbObj) Then
				$dbObj.Create('Provider = ' & $oProvider & 'Data Source = ' & $adSource)
				MsgBox(64, "提示", "建立数据库成功", 5)
			Else
				MsgBox(262160, '错误', '创建失败！')
			EndIf
		EndIf
	Else
		$dbObj = ObjCreate('ADOX.Catalog')
		If IsObj($dbObj) Then
			$dbObj.Create('Provider = ' & $oProvider & 'Data Source = ' & $adSource)
			MsgBox(64, "提示", "建立数据库成功", 5)
		Else
			MsgBox(262160, '错误', '创建失败！')
		EndIf
	EndIf
EndFunc   ;==>_accessCreateDB
