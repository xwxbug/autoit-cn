; *****************************************************************************
; 示例 - 声明一个一维数组, 并创建一个显示可能组合的数组
; *****************************************************************************
#include  <Array.au3>

Dim $aArray[5] = [1, 2, 3, 4, 5]

For $i = 1 To UBound($aArray)
	$aArrayCombo = _ArrayCombinations($aArray, $i, ", ")
	_arraydisplay($aArrayCombo, "iSet =" & $i)
Next

