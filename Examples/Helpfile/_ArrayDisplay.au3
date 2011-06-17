#include <Array.au3>

;===============================================================================
; 例子 1
;===============================================================================
Local $asControls = StringSplit(WinGetClassList("[active]", ""), @LF)
_ArrayDisplay($asControls, "活动窗口包含的'类'列表")

;===============================================================================
; 例子 2 (使用一个手动定义的数组)
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

_ArrayDisplay($avArray, "$avArray 为一维数组")
_ArrayDisplay($avArray, "$avArray 为颠倒的一维数组", -1, 1)

;===============================================================================
; 例子 3 (使用一个 StringSplit() 函数返回的数组)
;===============================================================================
$avArray = StringSplit(WinGetClassList("", ""), @LF)
_ArrayDisplay($avArray, "$avArray 为一个活动窗口包含的'类'列表")

;===============================================================================
; Example 4 (a 2D array)
;===============================================================================
Local $avArray[2][5] = [["JPM", "Holger", "Jon", "Larry", "Jeremy"],["Valik", "Cyberslug", "Nutster", "JdeB", "Tylo"]]
_ArrayDisplay($avArray, "$avArray 为二维数组")
_ArrayDisplay($avArray, "$avArray 为二维数组, 颠倒的", -1, 1)
