#include <MSSQL.au3>

$IP = "192.168.1.100"; IP地址
$USER = "sa"; 连接帐号
$PASS = ""; 连接密码
$DATABASE = "TESTDATA"; 数据库名

Example_1(); 示例 1

Example_2(); 示例 2

Func Example_1()
	; 表名
	$TableName_1 = "TestTable1"
	
	; 连接数据库.
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 在数据库中创建表,默认自动生成 ID 列
	_MSSQL_CreateTable($sqlCon, $TableName_1)
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example_1

Func Example_2()
	; 表名
	$TableName_2 = "TestTable2"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 在数据库中创建表的同时创建相应的列
	_MSSQL_CreateTable($sqlCon, $TableName_2, True, "ID INT,Name varchar(255),Pass varchar(255)")
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example_2
