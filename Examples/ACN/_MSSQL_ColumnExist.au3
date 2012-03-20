#include <MSSQL.au3>

$IP = "192.168.1.100"; IP地址
$USER = "sa"; 连接帐号
$PASS = ""; 连接密码
$DATABASE = "TESTDATA"; 数据库名

Example(); 示例

Func Example()
	; 表名
	$TableName_1 = "TestTable1"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 在数据库中检查表是否存在
	$ColumnExist = _MSSQL_ColumnExist($sqlCon, $TableName_1, "ID")
	If $ColumnExist = 1 Then
		MsgBox(4096, "列存在", "返回值= " & $ColumnExist)
	Else
		MsgBox(4096, "列不存在", "返回值= " & $ColumnExist)
	EndIf
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example

