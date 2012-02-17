;- 这里假设您安装了仪器到 GPIB 地址 1
; 此例子演示如何使用 _viExecCommand 函数, 在单独模式和与
; _viOpen 和 _viClose 的组合.
; 此例子也展示了 _viGTL 函数

#include <Visa.au3>

Local $h_session = 0

; 查询在 GPIB 地址 3 的仪器 ID
MsgBox(4096, "Step 1", "Open the instrument connection with _viOpen")
Local $h_instr = _viOpen("GPIB::3::0")
MsgBox(4096, "Instrument Handle obtained", "$h_instr = " & $h_instr) ; 显示会话句柄
; 查询仪器

MsgBox(4096, "Step 2", "Query the instrument using the VISA instrument handle")
Local $s_answer = _viExecCommand($h_instr, "*IDN?") ; $h_instr 现在不是字符串!
MsgBox(4096, "GPIB QUERY result", $s_answer) ; 显示应答
; 再次查询. 不需要再次打开连接

MsgBox(4096, "Step 3", "Query again. There is no need to OPEN the link again")
$s_answer = _viExecCommand($h_instr, "*IDN?")
MsgBox(4096, "GPIB QUERY result", $s_answer) ; 显示应答

MsgBox(4096, "Step 4", "Close the instrument connection using _viClose")
_viClose($h_instr) ; 关闭仪器连接
