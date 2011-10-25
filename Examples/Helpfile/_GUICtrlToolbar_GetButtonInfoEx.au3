
#include  <GuiToolbar.au3>
#include  <GuiConstantsEx.au3>
#include  <WindowsConstants.au3>
#include  <Constants.au3>

Opt('MustDeclareVars', 1)

$Debug_TB = False ; 检查传递给函数的类名,
设置为真并使用另一控件的句柄观察其工作
Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hToolbar, $tButton
	Local Enum $idNew = 1000, $idOpen, $idSave, $idHelp

	; 创建界面
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	$iMemo = GUICtrlCreateEdit("", 2, 36, 396, 262, $WS_VSCROLL)

	GUICtrlSetFont($iMemo, 10, 400, 0, "Courier New")

	GUISetState()

	;
	添加标准系统位图
	Switch _GUICtrlToolbar_GetBitmapFlags($hToolbar)
		Case 0

			_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_SMALL_COLOR)
		Case 2

			_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)
	EndSwitch

	; 添加按钮
	_GUICtrlToolbar_AddButton($hToolbar, $idNew, $STD_FILENEW)
	_GUICtrlToolbar_AddButton($hToolbar, $idOpen, $STD_FILEOPEN)
	_GUICtrlToolbar_AddButton($hToolbar, $idSave, $STD_FILESAVE)
	_GUICtrlToolbar_AddButtonSep($hToolbar)
	_GUICtrlToolbar_AddButton($hToolbar, $idHelp, $STD_HELP)

	;
	设置保存按钮信息
	$tButton = DllStructCreate($tagTBBUTTONINFO)
	DllStructSetData($tButton, "Mask", BitOR($TBIF_IMAGE, $TBIF_STATE, $TBIF_SIZE, $TBIF_LPARAM))

	DllStructSetData($tButton, "State", BitOR($TBSTATE_PRESSED, $TBSTATE_ENABLED))
	DllStructSetData($tButton, "Image", $STD_PRINT)
	DllStructSetData($tButton, "CX", 100)
	DllStructSetData($tButton, "Param", 1234)
	_GUICtrlToolbar_SetButtonInfoEx($hToolbar, $idSave, $tButton)

	;
	显示保存按钮信息
	$tButton = _GUICtrlToolbar_GetButtonInfoEx($hToolbar, $idSave)
	MemoWrite("Image index ....:" & DllStructGetData($tButton, "Image"))

	MemoWrite( "State flags ....:
	"  &  DllStructGetData ( $tButton ,  " State" ))

	MemoWrite( "Button width ...:
	"  &  DllStructGetData ( $tButton ,  " CX" ))

	MemoWrite( "Param ..........:
	"  &  DllStructGetData ( $tButton ,  " Param" ))


	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

