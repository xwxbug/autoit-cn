#include <Array.au3>

;===============================================================================
; 示例 1 (使用一维数组)
;===============================================================================
Local $avArray[10] = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

_ArrayDisplay($avArray, "默认排序方式" )
_ArraySort($avArray)
_ArrayDisplay($avArray, "升序排列方式" )
_ArraySort($avArray, 1)
_ArrayDisplay($avArray, "降序排列方式" )
_ArraySort($avArray, 0, 3, 6)
_ArrayDisplay($avArray, "插值排序方式 3 to 6" )

;===============================================================================
; 示例 2 (使用二维数组)
;===============================================================================
Local $avArray[5][3] = [ _
		[5, 20, 8], _
		[4, 32, 7], _
		[3, 16, 9], _
		[2, 35, 0], _
		[1, 19, 6]]

_ArrayDisplay($avArray, "默认排序方式" )
_ArraySort($avArray, 0, 0, 0, 0)
_ArrayDisplay($avArray, "副索引0升序排列方式" )
_ArraySort($avArray, 0, 0, 0, 1)
_ArrayDisplay($avArray, "副索引1升序排列方式" )
_ArraySort($avArray, 0, 0, 0, 2)
_ArrayDisplay($avArray, "副索引2升序排列方式" )
