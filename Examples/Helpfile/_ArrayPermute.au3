; *****************************************************************************
; Example 1 - Declare a 1-dimensional array, return an Array of permutations
; *****************************************************************************
#include <Array.au3>

Dim $aArray[4] = [1, 2, 3, 4]
$aNewArray = _ArrayPermute($aArray, ",") ;Using Default Parameters
_ArrayDisplay($aNewArray, "Array Permuted")