 ;-假设将仪器设置到GPIB地址3 
 ; 如果一个设备有不同地址时将"GPIB::3::0"改变为相应的描述符. 
 ; 和调用_viOpen相同 
 ; 该例显示如何使用带有延时的_viExecCommand函数及如何调用_viSetTimeout代替. 
 
 #include  <Visa.au3> 
 
 Dim  $h_session  =  0 
 
 ; 查询GPIB地址3处的仪器编号 
 MsgBox ( 0  , "Step 1" ,  "Simple GPIB query with explicit TIMEOUT set" ) 
 Dim  $s_answer  =  _viExecCommand ( "GPIB::3::0" ,  "*IDN?" ,  10000 )  ; 10秒延时 
 MsgBox ( 0 , "GPIB QUERY result" ,  $s_answer )  ; 显示应答 
 
 ; 同样的当首先使用_viSetTimeout函数时: 
 MsgBox ( 0  , "Step 2" ,  "_vOpen + timeout using _viSetTimeout + GPIB query" ) 
 Dim  $h_instr  =  _viOpen ( 3 ) 
 _viSetTimeout ( $h_instr ,  10000 )  ; 10000 ms = 10 secs 
 $s_answer  =  _viExecCommand ( $h_instr ,  "*IDN?" )  ; 当前无需设置延时 
 MsgBox ( 0 ,  "GPIB QUERY result" ,  $s_answer )  ; 显示应答 
 
 MsgBox ( 0 ,  "Step 3" ,  "Close the Instrument connection using _viClose" ) 
 _viClose ( $h_instr )  ; 关闭仪器连接 
 
