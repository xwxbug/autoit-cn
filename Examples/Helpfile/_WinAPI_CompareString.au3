#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>
#include <WinAPISys.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>

If _WinAPI_GetVersion() < '6.1' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later.')
	Exit
EndIf

; Create array of strings ("Item*")
Local $Item[100]
For $i = 0 To UBound($Item) - 1
	$Item[$i] = 'Item' & Random(0, 100, 1)
Next

_ArrayDisplay($Item, 'Initial array')

; Simple array sorting
_ArraySort($Item)

_ArrayDisplay($Item, 'Simple sorting')

; Sort array (bubble sort) ignoring case sensitive and according to the digits
Local $Temp
For $i = 0 To UBound($Item) - 2
	For $j = $i + 1 To UBound($Item) - 1
		Switch _WinAPI_CompareString($LOCALE_INVARIANT, $Item[$i], $Item[$j], BitOR($NORM_IGNORECASE, $SORT_DIGITSASNUMBERS))
			Case $CSTR_GREATER_THAN
				$Temp = $Item[$i]
				$Item[$i] = $Item[$j]
				$Item[$j] = $Temp
			Case Else

		EndSwitch
	Next
Next

_ArrayDisplay($Item, 'bubble sort case insensitive')
