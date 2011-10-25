; *****************************************************************************
; 示例1 - 声明一个包含重复值的一维数组, 使用_ArrayUnique新建一个只包含唯一值的数组.
; *****************************************************************************
#include <Array.au3>

Dim $aArray[10] = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
_ArrayDisplay($aArray, "$aArray ")

$aNewArray = _ArrayUnique($aArray) ;使用默认参数
_ArrayDisplay($aNewArray, "$aNewArray represents the 1st Dimension of $aArray ")

; *****************************************************************************
; 示例2 - 声明一个包含重复值的二维数组, 使用_ArrayUnique新建一个只包含唯一值的一维数组.
; *****************************************************************************
#include <Array.au3>

Dim $aArray[6][2] = [[1, "A "],[2, "B "],[3, "C "],[1, "A "],[2, "B "],[3, "C "]]
_ArrayDisplay($aArray, "$aArray ")

$aNewArray = _ArrayUnique($aArray) ;使用默认参数
_ArrayDisplay($aNewArray, "$aNewArray represents the 1st Dimension of $aArray ")

$aNewArray = _ArrayUnique($aArray, 2) ;使用第二维
_ArrayDisplay($aNewArray, "$aNewArray represents the 2nd Dimension of $aArray ")

; *****************************************************************************
; 示例3 - 声明一个包含重复值的一维数组, 使用_ArrayUnique及大小写敏感新建一个只有唯一值的数组.
; *****************************************************************************
#include <Array.au3>

Dim $aArray[6][2] = [[1, "A "],[2, "B "],[3, "C "],[1, "a "],[2, "b "],[3, "c "]]
_ArrayDisplay($aArray, "$aArray ")

$aNewArray = _ArrayUnique($aArray, 1, 0, 1) ;使用默认参数, 且大小写敏感
_ArrayDisplay($aNewArray, "$aNewArray represents the 1st Dimension of $aArray ")

$aNewArray = _ArrayUnique($aArray, 2, 0, 1) ;使用默认参数，且大小写敏感
_ArrayDisplay($aNewArray, "$aNewArray represents the 2st Dimension of $aArray ")

; *****************************************************************************
; 示例4 - 声明一个包含重复值和 " | " 的一维数组，使用_ArrayUnique新建一个只包含唯一值的数组
; *****************************************************************************
#include <Array.au3>

Dim $aArray[6][2] = [[1, "|A "],[2, "B "],[3, "C "],[1, "|A "],[2, "B "],[3, "C "]]
Local $smsgbox

$aNewArray = _ArrayUnique($aArray, 2) ;使用第二维

For $i = 0 To $aNewArray[0]
	$smsgbox &= " [" & $i & " ]:" & $aNewArray[$i] & @CRLF
Next

; 必须改变参数以便在_ArrayDisplay中显示一个包含 " | " 的元素
_ArrayDisplay($aNewArray, "$aNewArray represents the 1st Dimension of $aArray ", -1, 0, "@ ")

