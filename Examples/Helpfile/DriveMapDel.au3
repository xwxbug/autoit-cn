
; 使用当前用户映射 X: 驱动器到 \\myserver\stuff 
DriveMapAdd("X:", "\\myserver\stuff")

; 断开
DriveMapDel("X:")
