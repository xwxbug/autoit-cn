
; 使用当前用户映射 X: 驱动器到 \\myserver\stuff 
DriveMapAdd("X:", "\\myserver\stuff")

; 获取映射详细信息
MsgBox(0, "驱动器 X: 映射到", DriveMapGet("X:"))

