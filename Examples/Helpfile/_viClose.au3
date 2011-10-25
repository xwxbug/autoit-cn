
;-假设将仪器设置到GPIB地址1
; 分别显示在独立模式下及在_viOpen和_viClose结合的模式下如何使用_viExecCommand函数.
; 也可显示_viGTL函数

#include  <Visa.au3>

Dim $h_session = 0

; 查询GPIB地址3处的仪器编号
msgbox(0, "Step 1", "Open the instrument connection with _viOpen")
Dim $h_instr = _viOpen("GPIB::3::0")
msgbox(0, "Instrument Handle obtained", "$h_instr =" & $h_instr) ; 显示会话句柄
; 查询仪器

msgbox(0, "Step 2", "Query the instrument using the VISA instrument handle")
$s_answer = _viExecCommand($h_instr, "*IDN?") ; $h_instr当前不是字符串!
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答
; 重新查询. 无需再次打开链接

msgbox(0, "Step 3", "Query again. There is no need to OPEN the link again")
$s_answer = _viExecCommand($h_instr, "*IDN?")
msgbox(0, "GPIB QUERY result", $s_answer) ; 显示应答

msgbox(0, "Step 4", "Close the instrument connection using _viClose")
_viClose($h_instr) ; 关闭仪器连接

