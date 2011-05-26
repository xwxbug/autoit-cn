#include <GUIConstantsEx.au3>
#include <EditConstants.au3>

GUICreate("My GUI")  ; 创建一个居中显示的 GUI 窗口

Local $nEdit = GUICtrlCreateEdit("line 0", 10, 10)
GUICtrlCreateButton("Ok", 20, 200, 50)

GUISetState()

For $n = 1 To 5
	GUICtrlSetData($nEdit, @CRLF & "line " & $n)
Next


; 运行界面,直到窗口被关闭
Do
	Local $msg = GUIGetMsg()
	If $msg > 0 Then
		Local $a = GUICtrlRecvMsg($nEdit, $EM_GETSEL)
		GUICtrlSetState($nEdit, $GUI_FOCUS) ; set focus back on edit control

		; will display the wParam and lParam values return by the control
		MsgBox(0, "Current selection", StringFormat("start=%d end=%d", $a[0], $a[1]))
	EndIf
Until $msg = $GUI_EVENT_CLOSE
