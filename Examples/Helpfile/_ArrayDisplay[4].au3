; a 2D array

#include <Array.au3>

Local $avArray[2][5] = [["JPM", "Holger", "Jon", "Larry", "Jeremy"],["Valik", "Cyberslug", "Nutster", "JdeB", "Tylo"]]
_ArrayDisplay($avArray, "$avArray as a 2D array")
_ArrayDisplay($avArray, "$avArray as a 2D array, transposed", -1, 1)
