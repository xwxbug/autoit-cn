该函数支持所有有效的VISA描述符 , 包括GPIB , TCP , VXI和串口装置(ASRL). 
VISA描述符的详细解释可参考备注部分. 
作为快捷方式也可使用包含GPIB设备地址号的字符串(如"20")代替键入完整描述符(如 , "GPIB::20::0") 
* INTEGER -> VISA会话句柄是由_viOpen返回的整数值. 
如果计划重复联系设备或装置建议使用_viOpen和VISA会话句柄代替描述符, 
否则多次的联系设备会导致打开和关闭联系链接的额外开销. 
一旦设备使用完毕记住使用_viClose关闭连接.   
 $s_command  执行的命令/查询(如"*IDN?"或"SOURCE:POWER -20 dBM") 
查询必须包含一个问号QUESTION标记(?) 
当命令为查询时函数自动等待设备应答(或操作超时)   
 $i_timeout_ms  可选: 操作的毫秒超时. 
只对于查询很重要. 
此为可选参数. 
如果未指定则使用最后设置的超时. 如果从未设置过则使用默认值(依赖于VISA工具). 
超时也可由_viSetTimeout函数单独设置. 
基于总线类型(GPIB , TCP , 等)超时可能无法设置为要求的精确值. 取而代之使用比所要求的超时值稍大的最接近的有效值.    
   
返回值 返回值依赖于命令是否是一个查询及操作是否成功. 
* 命令, 无查询: 
  
 成功:  返回0   
 失败:  如果无法打开VISA DLL返回-1   
  或表示VISA错误代码的非0值   
  (参见VISA程序员向导)   * 查询: 
  
 成功:  返回设备对查询的应答   
 失败:  如果无法打开VISA DLL返回-1   
  当VISA DLL返回意外数量的结果时返回-3   
  或表示VISA错误代码的非0值   
  (参见VISA程序员向导)   该函数通常在出错时设置@error为1. 
 
   
备注 * VISA查询只返回设备应答的首行. 多数情况下这不是问题 , 因为多数设备的应答只有一行. 
 
* 下面是常用VISA描述符的描述 
注意还有更多类型. 更多信息请参考VISA程序员向导(在www.ni.com上) 
可选部分用方括号标识([]). 
必须填充的部分以尖括号标出(<>). 
 
  
 接口  语法   ------------------------------------------------------------------------------- 
  
 GPIB INSTR  GPIB[board]::primary address[::secondary address][::INSTR]   
 GPIB INTFC  GPIB[board]::INTFC   
 TCPIP SOCKET  TCPIP[board]::host address::port::SOCKET   
 Serial INSTR  ASRL[board][::INSTR]   
 PXI INSTR  PXI[board]::device[::function][::INSTR]   
 VXI INSTR  VXI[board]::VXI logical address[::INSTR]   
 GPIB-VXI INSTR  GPIB-VXI[board]::VXI logical address[::INSTR]   
 TCPIP INSTR  TCPIP[board]::host address[::LAN device name][::INSTR]   GPIB关键字用于GPIB仪器 
TCPIP关键字用于TCP/IP联系. 
ASRL关键字用于串口仪器. 
PXI关键字用于PXI仪器. 
VXI关键字通过内置或MXI总线控制器用于VXI仪器. 
GPIB-VXI关键字通过GPIB-VXI控制器用于VXI仪器. 
 
下面所显示的为可选参数的默认值. 
 
可选部分                  默认值 
--------------------------------------- 
board                     0 
secondary address         none 
LAN device name           inst0 
 
资源字符串示例: 
----------------------------------------------------------------------- 
  
 GPIB::1::0::INSTR  基址1处的GPIB设备或GPIB接口0中的次要地址0   
 GPIB2::INTFC  GPIB接口2的接口或原始资源   
 TCPIP0::1.2.3.4::999::SOCKET  指向指定IP地址上端口999的原始TCP/IP   
 ASRL1::INSTR  连接到接口ASRL1的串口设备. VXI::MEMACC指向VXI接口的板级寄存器.   
 PXI::15::INSTR  总线0上的PXI设备号15   
 VXI0::1::INSTR  VXI接口VXI0中逻辑地位1处的VXI设备   
 GPIB-VXI::9::INSTR  GPIB-VXI受控系统中逻辑地址9处的VXI设备    
   
相关  _viFindGpib , _viOpen , _viClose , _viSetTimeout , _viGTL , _viGpibBusReset , _viSetAttribute  
   
示例  
 
 ;-假设将仪器设置到GPIB地址3 
 ; 如果一个设备有不同地址时将"GPIB::3::0"改变为相应的描述符. 
 ; 和调用_viOpen相同 
 ; 分别显示在独立模式下及在_viOpen和_viClose结合的模式下如何使用_viExecCommand函数. 
 ; 也可显示_viGTL函数 
 
 #include  <Visa.au3> 
 
 Dim  $h_session  =  0 
 
 ; 查询GPIB地址3处的仪器编号 
 MsgBox ( 0 ,  "Step 1" ,  "Simple GPIB query using a VISA Descriptor" ) 
 Dim  $s_answer  =  _viExecCommand ( "GPIB::3::0" ,  "*IDN?" ,  10000 )  ; 10秒超时 
 MsgBox ( 0 ,  "GPIB QUERY result" ,  $s_answer )  ; 显示应答 
 
 MsgBox ( 0 ,  "Step 2" ,  "Go to LOCAL using VISA Descriptor" ) 
 _viGTL ( "GPIB::1::0" )  ; 转至本地(退出远程控制模式) 
 
 MsgBox ( 0 ,  "Step 3" ,  "Simple GPIB query using a VISA address shortcut" ) 
 $s_answer  =  _viExecCommand ( "1" ,  "*IDN?" )  ; 地址必须是字符串 
 MsgBox ( 0 ,  "GPIB QUERY result" ,  $s_answer )  ; 显示应答 
 MsgBox ( 0 ,  "Info" ,  "Now let's use _viOpen and _viClose" ) 
 
 MsgBox ( 0 ,  "Step 4" ,  "Open the instrument connection with _viOpen" ) 
 Dim  $h_instr  =  _viOpen ( 3 ) 
 MsgBox ( 0 ,  "Instrument Handle obtained" ,   "$h_instr = "  &  $h_instr )  ; 显示会话句柄 
 ; 查询仪器 
 
 MsgBox ( 0 ,  "Step 5" ,  "Query the instrument using the VISA instrument handle" ) 
 $s_answer  =  _viExecCommand ( $h_instr ,  "*IDN?" )  ; $h_instr当前不是字符串! 
 MsgBox ( 0 ,  "GPIB QUERY result" ,  $s_answer )  ; 显示应答 
 ; 重新查询. 无需再次打开链接 
 
 MsgBox ( 0 ,  "Step 6" ,  "Query again. There is no need to OPEN the link again" ) 
 $s_answer  =  _viExecCommand ( $h_instr ,  "*IDN?" ) 
 MsgBox ( 0 ,  "GPIB QUERY result" ,  $s_answer )  ; 显示应答 
 
 MsgBox ( 0 ,  "Step 7" ,  "Go to LOCAL using VISA instrument handle" ) 
 _viGTL ( $h_instr ) ; 转至本地(可选) 
 
 MsgBox ( 0 ,  "Step 8" ,  "Close the Instrument connection using _viClose" ) 
 _viClose ( $h_instr )  ; 关闭仪器连接 
 
