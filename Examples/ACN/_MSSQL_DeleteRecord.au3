#include <MSSQL.au3>
#include <Array.au3>

$IP = "192.168.1.100"; IP地址
$USER = "sa"; 连接帐号
$PASS = ""; 连接密码
$DATABASE = "TESTDATA"; 数据库名

Example_1(); 示例

Example_2(); 示例

Func Example_1()
	; 表名
	$TableName_1 = "TestTable2"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 在数据库表中删除数据(删除所有数据)
	_MSSQL_DeleteRecord($sqlCon, $TableName_1)
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example_1

Func Example_2()
	; 表名
	$TableName_1 = "TestTable2"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 在数据库表中删除数据(按条件删除指定数据)
	_MSSQL_DeleteRecord($sqlCon, $TableName_1, "WHere TestColumn = '123456789'")
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example_2
