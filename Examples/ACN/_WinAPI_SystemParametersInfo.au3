#include <WinAPI.au3>

Local Const $SPI_GETWORKAREA = 48
Local $stRect = DllStructCreate($tagRect)
Local $iResult = _WinAPI_SystemParametersInfo($SPI_GETWORKAREA, 0, DllStructGetPtr($stRect), 0)
If $iResult Then
	msgbox(0, "Desktop Working Area ", "Left =" & _
			DllStructGetData($stRect, "left ") & @CRLF & " Top =" & _
			DllStructGetData($stRect, "top ") & @CRLF & " Right =" & _
			DllStructGetData($stRect, "right ") & @CRLF & " Bottom =" & _
			DllStructGetData($stRect, "bottom "))
Else
	msgbox(0, "Desktop Working Area ", "Faild to get Desktop work area ")
EndIf

