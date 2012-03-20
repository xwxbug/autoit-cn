; 使用当前用户账户，将网络共享文件夹'\\myserver\stuff'映射到指定驱动器'X:'中.
DriveMapAdd("X:", "\\myserver\stuff")

; 使用指定的用户账户(用户名:"jon" ,域:"domainx",密码:"tickle")，将网络共享文件夹'\\myserver\stuff'映射到指定驱动器'X:'中.
DriveMapAdd("X:", "\\myserver2\stuff2", 0, "domainx\jon", "tickle")
