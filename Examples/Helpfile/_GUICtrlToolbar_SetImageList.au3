
#include  <GuiToolbar.au3>
#include  <GuiImageList.au3>
#include  <WinAPI.au3>
#include  <GuiConstantsEx.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_TB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作
Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hToolbar, $hNormal, $hDisabled, $hHot
	Local Enum $idNew = 1000, $idOpen, $idSave, $idHelp
	Local Enum $idRed = 1000, $idGreen, $idBlue


	; 创建界面
	$hGUI = GUICreate("Toolbar", 400, 300)

	GUISetBkColor(0xffff00)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	$iMemo = GUICtrlCreateEdit("", 2, 36, 396, 262, $WS_VSCROLL)

	GUICtrlSetFont($iMemo, 10, 400, 0, "Courier New")

	GUISetState()

	;
	创建普通图像列表
	$hNormal = _GUIImageList_Create(32, 24)

	_GUIImageList_Add($hNormal, _WinAPI_CreateSolidBitmap($hGUI, 0xFF0000, 32, 24))

	_GUIImageList_Add($hNormal, _WinAPI_CreateSolidBitmap($hGUI, 0x00FF00, 32, 24))

	_GUIImageList_Add($hNormal, _WinAPI_CreateSolidBitmap($hGUI, 0x0000FF, 32, 24))

	_GUICtrlToolbar_SetImageList($hToolbar, $hNormal)

	;
	创建禁用图像列表
	$hDisabled = _GUIImageList_Create(32, 24)

	_GUIImageList_Add($hDisabled, _WinAPI_CreateSolidBitmap($hGUI, 0xCCCCCC, 32, 24))

	_GUIImageList_Add($hDisabled, _WinAPI_CreateSolidBitmap($hGUI, 0xCCCCCC, 32, 24))

	_GUIImageList_Add($hDisabled, _WinAPI_CreateSolidBitmap($hGUI, 0xCCCCCC, 32, 24))

	_GUICtrlToolbar_SetDisabledImageList($hToolbar, $hDisabled)

	;
	创建活跃图像列表
	$hHot = _GUIImageList_Create(32, 24)

	_GUIImageList_Add($hHot, _WinAPI_CreateSolidBitmap($hGUI, 0x111111, 32, 24))

	_GUIImageList_Add($hHot, _WinAPI_CreateSolidBitmap($hGUI, 0x888888, 32, 24))

	_GUIImageList_Add($hHot, _WinAPI_CreateSolidBitmap($hGUI, 0xAAAAAA, 32, 24))

	_GUICtrlToolbar_SetHotImageList($hToolbar, $hHot)

	; 添加按钮
	_GUICtrlToolbar_AddButton($hToolbar, $idRed, 0)
	_GUICtrlToolbar_AddButton($hToolbar, $idGreen, 1)
	_GUICtrlToolbar_AddButton($hToolbar, $idBlue, 2)

	; 禁用蓝色按钮
	_GUICtrlToolbar_EnableButton($hToolbar, $idBlue, False)

	; 显示图像列表句柄
	MemoWrite("Disabled list handle .: 0x" & Hex( _GUICtrlToolbar_GetDisabledImageList($hToolbar)))
	MemoWrite("Hot list handle ......: 0x" & Hex( _GUICtrlToolbar_GetHotImageList($hToolbar)))

	MemoWrite( "Normal list handle
	...: 0x"  &  Hex ( _GUICtrlToolbar_GetImageList ( $hToolbar )))


	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite


