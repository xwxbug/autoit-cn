; *****************************************************************************
; 示例 1 - 声明一个包含重复值的一维数组.
; 使用 _ArrayUnique 创建一个仅包含唯一值的新数组.
; *****************************************************************************

#include <Array.au3>

Local $aArray[10] = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
_ArrayDisplay($aArray, "$aArray")
Local $aNewArray = _ArrayUnique($aArray) ;使用默认参数
_ArrayDisplay($aNewArray, "$aNewArray represents the 1st Dimension of $aArray")

; ******************************************************************************************
; 示例 2 - 声明一个包含重复值的二维数组.
; 使用 _ArrayUnique 创建一个仅包含唯一值的新的一维数组.
; ******************************************************************************************

#include <Array.au3>

Dim $aArray[6][2] = [[1, "A"],[2, "B"],[3, "C"],[1, "A"],[2, "B"],[3, "C"]]
_ArrayDisplay($aArray, "$aArray")
$aNewArray = _ArrayUnique($aArray) ;使用默认参数
_ArrayDisplay($aNewArray, "$aNewArray represents the 1st Dimension of $aArray")

$aNewArray = _ArrayUnique($aArray, 2) ;使用第二维
_ArrayDisplay($aNewArray, "$aNewArray represents the 2nd Dimension of $aArray")

; *****************************************************************************************
; 示例 3 - 声明一个包含重复值的一维数组.
; 使用 _ArrayUnique 且区分大小写创建一个仅包含唯一值的新数组.
; *****************************************************************************************

#include <Array.au3>

Dim $aArray[6][2] = [[1, "A"],[2, "B"],[3, "C"],[1, "a"],[2, "b"],[3, "c"]]
_ArrayDisplay($aArray, "$aArray")
$aNewArray = _ArrayUnique($aArray, 1, 0, 1) ;使用默认参数,且区分大小写
_ArrayDisplay($aNewArray, "$aNewArray represents the 1st Dimension of $aArray")

$aNewArray = _ArrayUnique($aArray, 2, 0, 1) ;使用默认参数,且区分大小写
_ArrayDisplay($aNewArray, "$aNewArray represents the 2st Dimension of $aArray")

; *****************************************************************************************
; 示例 4 - 声明一个包含重复值和 "|" 的一维数组.
; 使用 _ArrayUnique 创建一个仅包含唯一值的新数组.
; *****************************************************************************************

#include <Array.au3>

Dim $aArray[6][2] = [[1, "|A"],[2, "B"],[3, "C"],[1, "|A"],[2, "B"],[3, "C"]]
Local $sMsgBox

$aNewArray = _ArrayUnique($aArray, 2) ;使用第二维

For $i = 0 To $aNewArray[0]
	$sMsgBox &= "[" & $i & "]: " & $aNewArray[$i] & @CRLF
Next

;必须改变参数才可以在 _ArrayDisplay 中显示包含 "|" 的元素
_ArrayDisplay($aNewArray, "$aNewArray represents the 1st Dimension of $aArray", -1, 0, "@")