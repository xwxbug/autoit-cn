;- 这里假设您安装了仪器到 GPIB 地址 3
; 如果您的仪器安装到了不同的地址, 则改变 "GPIB::3::0" 为
; 相应描述符. 进行对 _viOpen 的相同调用
; 此例子演示如何使用 _viExecCommand 函数, 在单独模式和与
; _viOpen 和 _viClose 的组合.
; 此例子也展示了 _viGTL 函数

#include <Visa.au3>

Local $h_session = 0

; 查询在 GPIB 地址 3 的仪器 ID
MsgBox(4096, "Step 1", "Simple GPIB query using a VISA Descriptor")
Local $s_answer = _viExecCommand("GPIB::3::0", "*IDN?", 10000) ; 超时为 10 秒
MsgBox(4096, "GPIB QUERY result", $s_answer) ; 显示应答

MsgBox(4096, "Step 2", "Go to LOCAL using VISA Descriptor")
_viGTL("GPIB::1::0") ; 到本地 (退出远程控制模式)

MsgBox(4096, "Step 3", "Simple GPIB query using a VISA address shortcut")
$s_answer = _viExecCommand("1", "*IDN?") ; 此地址必须是字符串
MsgBox(4096, "GPIB QUERY result", $s_answer) ; 显示应答
MsgBox(4096, "Info", "Now let's use _viOpen and _viClose")

MsgBox(4096, "Step 4", "Open the instrument connection with _viOpen")
Local $h_instr = _viOpen(3)
MsgBox(4096, "Instrument Handle obtained", "$h_instr = " & $h_instr) ; 显示会话句柄
; 查询仪器

MsgBox(4096, "Step 5", "Query the instrument using the VISA instrument handle")
$s_answer = _viExecCommand($h_instr, "*IDN?") ; $h_instr 现在不是字符串!
MsgBox(4096, "GPIB QUERY result", $s_answer) ; 显示应答
; 再次查询. 不需要再次打开连接

MsgBox(4096, "Step 6", "Query again. There is no need to OPEN the link again")
$s_answer = _viExecCommand($h_instr, "*IDN?")
MsgBox(4096, "GPIB QUERY result", $s_answer) ; 显示应答

MsgBox(4096, "Step 7", "Go to LOCAL using VISA instrument handle")
_viGTL($h_instr); 到本地 (这是可选的)

MsgBox(4096, "Step 8", "Close the Instrument connection using _viClose")
_viClose($h_instr) ; 关闭仪器连接
