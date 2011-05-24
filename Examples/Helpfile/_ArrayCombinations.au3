; *****************************************************************************
; 例子 1 - 定义一个一维数组, 并创建一个数组显示可能的合并
; *****************************************************************************

#include <Array.au3>

Local $aArray[5] = [1, 2, 3, 4, 5]

For $i = 1 To UBound($aArray)
	Local $aArrayCombo = _ArrayCombinations($aArray, $i, ",")
	_ArrayDisplay($aArrayCombo, "iSet = " & $i)
Next