#include <MSSQL.au3>

$IP = "192.168.1.100"; IP地址
$USER = "sa"; 连接帐号
$PASS = ""; 连接密码
$DATABASE = "TESTDATA"; 数据库名

Example_1(); 示例 1 在数据库表中插入一个数值

Example_2(); 示例 1 在数据库表中插入一组数值

Func Example_1()
	; 表名
	$TableName_1 = "TestTable1"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 在数据库中创建表,默认自动生成 ID 列
	_MSSQL_CreateTable($sqlCon, $TableName_1)
	
	; 创建一个或多个新的列
	_MSSQL_CreateColumn($sqlCon, $TableName_1, "TestColumn VARCHAR(150)")
	
	; 在数据库表中插入一个数值,使用条件方式,避免插入重复数据
	_MSSQL_AddRecord($sqlCon, $TableName_1, "'Value9'", True, "WHERE TestColumn = 'Value9'")
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example_1

Func Example_2()
	Dim $TestArray1[10]
	$TestArray1[1] = "VALUE1"
	$TestArray1[2] = "Value2"
	$TestArray1[3] = "Value3"
	$TestArray1[4] = "Value4"
	$TestArray1[5] = "Value5"
	$TestArray1[6] = "Value6"
	$TestArray1[7] = "Value7"
	$TestArray1[8] = "Value8"
	$TestArray1[9] = "123456789"
	
	; 表名
	$TableName_2 = "TestTable2"
	
	; 连接数据库
	$sqlCon = _MSSQL_Con($IP, $USER, $PASS, $DATABASE)
	
	; 在数据库中创建表,默认自动生成 ID 列
	_MSSQL_CreateTable($sqlCon, $TableName_2)
	
	; 创建一个或多个新的列
	_MSSQL_CreateColumn($sqlCon, $TableName_2, "TestColumn VARCHAR(150)")
	
	; 在数据库表中插入一组数值,由于没有使用条件方式,会出现重复数据
	For $i = 1 To UBound($TestArray1) - 1
		_MSSQL_AddRecord($sqlCon, $TableName_2, "'" & $TestArray1[$i] & "'")
	Next
	
	; 关闭数据库连接
	_MSSQL_End($sqlCon)
EndFunc   ;==>Example_2
