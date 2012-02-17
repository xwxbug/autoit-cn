#include <Array.au3>

Local $avArray = StringSplit("4,2,06,8,12,5", ",")

MsgBox(4096,'最小字符串值(索引)', _ArrayMinIndex($avArray , 0, 1))
MsgBox(4096,'最小数学值(索引)', _ArrayMinIndex($avArray, 1, 1))
