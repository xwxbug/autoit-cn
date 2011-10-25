
; 该示例在总线"锁定"后尝试"重新设置"GPIB总线. 这种情况很少见,
; 但当连接到总线的仪器之一崩溃时有可能发生

#include  <Visa.au3>

_viGpibBusReset()

