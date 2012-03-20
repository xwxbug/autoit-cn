#include <MSSQL.au3>
#include <Array.au3>

$IP = "192.168.1.100"; IP地址
$USER = "sa"; 连接帐号
$PASS = ""; 连接密码
$DATABASE = "TESTDATA"; 数据库名

Example_1(); 示例 1

Example_2(); 示例 2

Func Example_1()
	; 表名
	$TableName_1 = "TestTable2"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 修改前
	$getrecord = _MSSQL_GetRecord($sqlCon, $TableName_1)
	_ArrayDisplay($getrecord)
	
	; 在数据库表中修改指定列的数据(整列修改)
	_MSSQL_UpdateRecord($sqlCon, $TableName_1, "TestColumn", "Value0")
	
	; 修改后
	$getrecord = _MSSQL_GetRecord($sqlCon, $TableName_1)
	_ArrayDisplay($getrecord)
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example_1

Func Example_2()
	; 表名
	$TableName_1 = "TestTable2"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 修改前
	$getrecord = _MSSQL_GetRecord($sqlCon, $TableName_1)
	_ArrayDisplay($getrecord)
	
	; 在数据库表中修改指定列的数据(按查询条件修改指定数据)
	_MSSQL_UpdateRecord($sqlCon, $TableName_1, "TestColumn", "123456789", "WHere TestColumn = 'Value1'")
	
	; 修改后
	$getrecord = _MSSQL_GetRecord($sqlCon, $TableName_1)
	_ArrayDisplay($getrecord)
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example_2
