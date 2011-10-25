;-假设将仪器设置到GPIB地址3
; 如果一个设备有不同地址时将"GPIB::3::0"改变为相应的描述符.
; 和调用_viOpen相同
; 该例显示如何在VISA描述符和VISA设备句柄情况下使用_viGTL函数.
; 首先使用_viExecCommand强制设备进入"远程模式"

#include  <Visa.au3>

Dim $h_session = 0

; 查询GPIB地址3处的仪器编号
msgbox(0, "Step 1", "Simple GPIB query using a VISA Descriptor")
Dim $s_answer = _viExecCommand("GPIB::3::0", "*IDN?", 10)
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答

msgbox(0, "Step 2", "Go to LOCAL using VISA Descriptor")
_viGTL("GPIB::1::0") ; 转为本地(推出远程控制模式)

msgbox(0, "Step 4", "Open the instrument connection with _viOpen")
Dim $h_instr = _viOpen(3)
msgbox(0, "Instrument Handle obtained", "$h_instr =" & $h_instr) ; 显示会话句柄
; 查询仪器

msgbox(0, "Step 5", "Query the instrument using the VISA instrument handle")
$s_answer = _viExecCommand($h_instr, "*IDN?") ; $h_instr当前不是字符串!
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答
; 重新查询. 无需再次打开链接

msgbox(0, "Step 6", "Query again. There is no need to OPEN the link again")
$s_answer = _viExecCommand($h_instr, "*IDN?")
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答

msgbox(0, "Step 7", "Go to LOCAL using VISA instrument handle")
_viGTL($h_instr) ; 转为本地(此为可选)

msgbox(0, "Step 8", "Close the Instrument connection using _viClose")
_viClose($h_instr) ; 关闭仪器连接

