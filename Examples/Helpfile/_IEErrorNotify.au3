; *******************************************************
; 示例 1 - 检查 _IEErrorNotify 的当前状态, 如果打开则关闭它, 反之打开它
; *******************************************************

#include <IE.au3>

If _IEErrorNotify() Then
	MsgBox(4096, "_IEErrorNotify Status", "Notification is ON, turning it OFF")
	_IEErrorNotify(False)
Else
	MsgBox(4096, "_IEErrorNotify Status", "Notification is OFF, turning it ON")
	_IEErrorNotify(True)
EndIf
