
;-假设将仪器设置到GPIB地址3
; 如果一个设备有不同地址时将"GPIB::3::0"改变为相应的描述符.
; 和调用_viOpen相同
; 该例显示如何使用_viSetAttribute. 此例中使用_viSetAttribute代替_viSetTimeout设置一个_viExecCommand操作的GPIB延时.

#include  <Visa.au3>

Dim $h_session = 0

; 查询GPIB地址3处的仪器编号
msgbox(0, "Step 1", "Simple GPIB query with explicit TIMEOUT set")
Dim $s_answer = _viExecCommand("GPIB::3::0", "*IDN?", 10000) ; 10秒延时
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答

; 首先与使用_viSetAttribute函数相同:
msgbox(0, "Step 2", "_vOpen + timeout using _viSetAttribute + GPIB query")
Dim $h_instr = _viOpen(3)
; 注 - 与_viSetTimeout($h_instr ,  10000)相同
_viSetAttribute($h_instr, $VI_ATTR_TMO_VALUE, 10000) ; 10000 ms = 10 secs

$s_answer = _viExecCommand($h_instr, "*IDN?") ; 目前无需设置延时
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答

msgbox(0, "Step 3", "Close the Instrument connection using _viClose")
_viClose($h_instr) ; 关闭仪器连接

