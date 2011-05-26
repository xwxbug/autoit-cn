
; 使用当前用户映射 X: 驱动器到 \\myserver\stuff 
DriveMapAdd("X:", "\\myserver\stuff")

; 映射 X 磁盘到 \\myserver2\stuff2 ,使用用户名:"jon" ,域:"domainx" 密码:"tickle"
DriveMapAdd("X:", "\\myserver2\stuff2", 0, "domainx\jon", "tickle")
