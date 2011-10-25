#include  <GuiReBar.au3>
#include <WinAPI.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>

Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hInput, $btn_get, $hReBar, $hInstance, $sText
	; 创建界面
	$hGUI = GUICreate("WinAPI", 400, 396)

	$hInput = GUICtrlCreateInput("4209", 0, 0, 100, 20)

	; 创建伸缩条控件
	$hReBar = _GUICtrlReBar_Create($hGUI, BitOR($CCS_TOP, $WS_BORDER, $RBS_VARHEIGHT, $RBS_AUTOSIZE, $RBS_BANDBORDERS))

	$iMemo = GUICtrlCreateEdit("", 2, 55, 396, 200, BitOR($WS_VSCROLL, $WS_HSCROLL))
	GUICtrlSetFont($iMemo, 10, 400, 0, "Courier New")

	; 添加包含控件的区段
	_GUICtrlReBar_AddBand($hReBar, GUICtrlGetHandle($hInput), 120, 200, "String ID:")

	$btn_get = GUICtrlCreateButton("Get String", 0, 0, 90, 20)

	; 添加包含控件的区段
	_GUICtrlReBar_AddBand($hReBar, GUICtrlGetHandle($btn_get), 120, 200)

	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Exit
			Case $btn_get
				GUICtrlSetData($iMemo, "")
				$hInstance = _WinAPI_LoadLibraryEx("shell32.dll", $LOAD_LIBRARY_AS_DATAFILE)
				If $hInstance Then
					$sText = _WinAPI_LoadString($hInstance, GUICtrlRead($hInput))
					If Not @error Then
						MemoWrite('Got the String (chars:' & @extended &'):' & @CRLF & $sText)
					Else
						MemoWrite("Last Error Message:" & @CRLF & _WinAPI_GetLastErrorMessage())
					EndIf
					MemoWrite(@CRLF & "Success Freeing?" & _WinAPI_FreeLibrary($hInstance))
				EndIf
		EndSwitch
	WEnd
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

