#include <Array.au3>
;_ArrayPush(ByRef $avArray, $vValue[, $iDirection = 0])
;$avArray(需要改变的数组) 
;$vValue(选择参数:0=未部 1=顶部)


Local $avArrayTarget[9] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Local $avArraySource[2] = [100, 200]

_ArrayDisplay($avArrayTarget, "运行前")

_ArrayPush($avArrayTarget, $avArraySource);改变未部数组中的所有值
_ArrayDisplay($avArrayTarget, "运行后未部改变")

_ArrayPush($avArrayTarget, $avArraySource, 1);改变顶部数组中的所有值
_ArrayDisplay($avArrayTarget, "运行后顶部改变")

_ArrayPush($avArrayTarget, "我改变了", 1);改变顶部数组中的所有值
_ArrayDisplay($avArrayTarget, "运行后顶部字符改变")
