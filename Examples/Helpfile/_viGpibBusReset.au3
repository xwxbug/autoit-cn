; 此示例尝试在总线 "锁" 后 "复位" GPIB 总线. 这是很少见的,
; 不过当连接到总线的其中一个仪器崩溃时很可能发生这种情况

#include <Visa.au3>

_viGpibBusReset()
