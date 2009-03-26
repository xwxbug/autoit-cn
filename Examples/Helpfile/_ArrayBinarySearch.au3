#include <Array.au3>

;===============================================================================
; 例子 1 (使用一个手动定义的数组)
;===============================================================================
Local $avArray[10]

$avArray[0] = "JPM"
$avArray[1] = "Holger"
$avArray[2] = "Jon"
$avArray[3] = "Larry"
$avArray[4] = "Jeremy"
$avArray[5] = "Valik"
$avArray[6] = "Cyberslug"
$avArray[7] = "Nutster"
$avArray[8] = "JdeB"
$avArray[9] = "Tylo"

; 对数组进行排序
_ArraySort($avArray)

; 显示排序后的数组
_ArrayDisplay($avArray, "$avArray 排序后 _ArraySort()")

; 查找存在的项目
$iKeyIndex = _ArrayBinarySearch($avArray, "Jon")
If Not @error Then
   MsgBox(0,'项目找到了',' 索引: ' & $iKeyIndex)
Else
   MsgBox(0,'项目未找到',' 错误: ' & @error)
EndIf

; 查找不存在的项目
$iKeyIndex = _ArrayBinarySearch($avArray, "Unknown")
If Not @error Then
   MsgBox(0,'项目找到了',' 索引: ' & $iKeyIndex)
Else
   MsgBox(0,'项目未找到',' 错误: ' & @error)
EndIf


;===============================================================================
; 例子 2 (使用一个 StringSplit() 函数返回的数组)
;===============================================================================
$avArray = StringSplit("a,b,d,c,e,f,g,h,i", ",")

; 对数组排序
_ArraySort($avArray, 0, 1) ; 从索引 1 开始,跳过 $avArray[0]

; 显示排序的数组
_ArrayDisplay($avArray, "$avArray 排序后 _ArraySort()")

 ; 开始于索引 1 跳过 $avArray[0]
$iKeyIndex = _ArrayBinarySearch($avArray, "c", 1)
If Not @error Then
   Msgbox(0,'项目找到了',' 索引: ' & $iKeyIndex)
Else
   Msgbox(0,'项目未找到',' 错误: ' & @error)
EndIf
