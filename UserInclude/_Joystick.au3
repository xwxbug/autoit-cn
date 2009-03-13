#include <GUIConstants.au3>

Local $joy,$coor,$h,$s,$msg

$joy	= _JoyInit()

GUICreate("Joystick Test",300,300)
$h= GuiCtrlCreatelabel("",10,10,290,290)
GUISetState()

while 1
	$msg	= GUIGetMSG()
	$coor	= _GetJoy($joy,0)
	$s		= "Joystick(0):" & @CRLF & _
				"X: " & $coor[0] & @CRLF & _
				"Y: " & $coor[1] & @CRLF & _
				"Z: " & $coor[2] & @CRLF & _
				"R: " & $coor[3] & @CRLF & _
				"U: " & $coor[4] & @CRLF & _
				"V: " & $coor[5] & @CRLF & _
				"POV: " & $coor[6] & @CRLF & _
				"Buttons: " & $coor[7]
	GUICtrlSetData($h,$s,1)
	sleep(10)
	if $msg = $GUI_EVENT_CLOSE Then Exitloop
WEnd

_JoyClose($joy)

;======================================
;	_JoyInit()
;======================================
Func _JoyInit()
	Local $joy
	Global $JOYINFOEX_struct	= "dword[13]"

	$joy	= DllStructCreate($JOYINFOEX_struct)
	if @error Then Return 0
	DllStructSetData($joy,1,DllStructGetSize($joy),1)	;dwSize = sizeof(struct)
	DllStructSetData($joy,1,255,2)					;dwFlags = GetAll
	return $joy
EndFunc

;======================================
;	_GetJoy($lpJoy,$iJoy)
;	$lpJoy	Return from _JoyInit()
;	$iJoy	Joystick # 0-15
;	Return	Array containing X-Pos, Y-Pos, Z-Pos, R-Pos, U-Pos, V-Pos,POV
;			Buttons down
;
;			*POV This is a digital game pad, not analog joystick
;			65535	= Not pressed
;			0		= U
;			4500	= UR
;			9000	= R
;			Goes around clockwise increasing 4500 for each position
;======================================
Func _GetJoy($lpJoy,$iJoy)
	Local $coor,$ret

	Dim $coor[8]
	DllCall("Winmm.dll","int","joyGetPosEx","int",$iJoy,"ptr",DllStructGetPtr($lpJoy))
	if Not @error Then
		$coor[0]	= DllStructGetData($lpJoy,1,3)
		$coor[1]	= DllStructGetData($lpJoy,1,4)
		$coor[2]	= DllStructGetData($lpJoy,1,5)
		$coor[3]	= DllStructGetData($lpJoy,1,6)
		$coor[4]	= DllStructGetData($lpJoy,1,7)
		$coor[5]	= DllStructGetData($lpJoy,1,8)
		$coor[6]	= DllStructGetData($lpJoy,1,11)
		$coor[7]	= DllStructGetData($lpJoy,1,9)
	EndIf

	return $coor
EndFunc

;======================================
;	_JoyClose($lpJoy)
;	Free the memory allocated for the joystick struct
;======================================
Func _JoyClose($lpJoy)
DllCallbackFree($lpJoy)
EndFunc
