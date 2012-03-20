#include <MSSQL.au3>
#include <Array.au3>

$IP = "192.168.1.100"; IP地址
$USER = "sa"; 连接帐号
$PASS = ""; 连接密码
$DATABASE = "TESTDATA"; 数据库名

Example(); 示例

Func Example()
	; 表名
	$TableName_1 = "TestTable2"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)

	; 在数据库表中获取一个或多个值
	$getrecord = _MSSQL_GetRecord($sqlCon, $TableName_1)
	_ArrayDisplay($getrecord)

	; 在数据库表中获取所有列，并对指定的结果集进行重新排序
	$getrecord = _MSSQL_GetRecord($sqlCon, $TableName_1, "*", "", "TestColumn")
	_ArrayDisplay($getrecord)
	
	; 在数据库表中获取指定的列，并对指定的结果集进行重新排序
	$getrecord = _MSSQL_GetRecord($sqlCon, $TableName_1, "ID,TestColumn", "", "ID")
	_ArrayDisplay($getrecord)

	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example
