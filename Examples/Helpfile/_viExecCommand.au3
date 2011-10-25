;-假设将仪器设置到GPIB地址3
; 如果一个设备有不同地址时将"GPIB::3::0"改变为相应的描述符.
; 和调用_viOpen相同
; 分别显示在独立模式下及在_viOpen和_viClose结合的模式下如何使用_viExecCommand函数.
; 也可显示_viGTL函数

#include  <Visa.au3>

Dim $h_session = 0

; 查询GPIB地址3处的仪器编号
msgbox(0, "Step 1", "Simple GPIB query using a VISA Descriptor")
Dim $s_answer = _viExecCommand("GPIB::3::0", "*IDN?", 10000) ; 10秒超时
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答

msgbox(0, "Step 2", "Go to LOCAL using VISA Descriptor")
_viGTL("GPIB::1::0") ; 转至本地(退出远程控制模式)

msgbox(0, "Step 3", "Simple GPIB query using a VISA address shortcut")
$s_answer = _viExecCommand("1", "*IDN?") ; 地址必须是字符串
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答
msgbox(0, "Info", "Now let's use _viOpen and _viClose")

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
_viGTL($h_instr) ; 转至本地(可选)

msgbox(0, "Step 8", "Close the Instrument connection using _viClose")
_viClose($h_instr) ; 关闭仪器连接

