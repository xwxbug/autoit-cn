;- 这里假设您安装了仪器到 GPIB 地址 3.
; 如果您的仪器安装到了不同的地址, 则改变 "GPIB::3::0" 为
; 相应描述符. 进行对 _viOpen 的相同调用
; 此例子演示了如何使用含超时的 _viExecCommand 函数或如何
; 调用 _viSetTimeout 代替.

#include <Visa.au3>

Local $h_session = 0

; 查询在 GPIB 地址 3 的仪器 ID
MsgBox(4096, "Step 1", "Simple GPIB query with explicit TIMEOUT set")
Local $s_answer = _viExecCommand("GPIB::3::0", "*IDN?", 10000) ; 超时为 10 秒
MsgBox(4096, "GPIB QUERY result", $s_answer) ; 显示应答

; 这里相当于首先使用 _viSetTimeout 函数:
MsgBox(4096, "Step 2", "_vOpen + timeout using _viSetTimeout + GPIB query")
Local $h_instr = _viOpen(3)
_viSetTimeout($h_instr, 10000) ; 10000 毫秒 = 10 秒
$s_answer = _viExecCommand($h_instr, "*IDN?") ; 现在不需要设置超时
MsgBox(4096, "GPIB QUERY result", $s_answer) ; 显示应答

MsgBox(4096, "Step 3", "Close the Instrument connection using _viClose")
_viClose($h_instr) ; 关闭仪器连接
