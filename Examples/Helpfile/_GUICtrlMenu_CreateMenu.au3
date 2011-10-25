#include <GuiMenu.au3>
#include <GuiConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $iMemo
Global Enum $idNew = 1000, $idOpen, $idSave, $idExit, $idCut, $idCopy, $idPaste, $idAbout

_Main()

Func _Main()
	Local $hGUI, $hFile, $hEdit, $hHelp, $hMain

	; 创建界面
	$hGUI = GUICreate("Menu", 400, 300)

	; 创建文件菜单
	$hFile = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_InsertMenuItem($hFile, 0, "&New", $idNew)
	_GUICtrlMenu_InsertMenuItem($hFile, 1, "&Open", $idOpen)
	_GUICtrlMenu_InsertMenuItem($hFile, 2, "&Save", $idSave)
	_GUICtrlMenu_InsertMenuItem($hFile, 3, "", 0)
	_GUICtrlMenu_InsertMenuItem($hFile, 4, "E&xit", $idExit)

	; 创建编辑菜单
	$hEdit = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_InsertMenuItem($hEdit, 0, "&Cut", $idCut)
	_GUICtrlMenu_InsertMenuItem($hEdit, 1, "C&opy", $idCopy)
	_GUICtrlMenu_InsertMenuItem($hEdit, 2, "&Paste", $idPaste)

	; 创建帮助菜单
	$hHelp = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_InsertMenuItem($hHelp, 0, "&About", $idAbout)

	; 创建主菜单
	$hMain = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_InsertMenuItem($hMain, 0, "&File", 0, $hFile)
	_GUICtrlMenu_InsertMenuItem($hMain, 1, "&Edit", 0, $hEdit)
	_GUICtrlMenu_InsertMenuItem($hMain, 2, "&Help", 0, $hHelp)

	; 设置窗体菜单
	_GUICtrlMenu_SetMenu($hGUI, $hMain)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 276, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 辑环至用户退出
	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

	; 辑环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 菜单命令句柄
Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	Switch _WinAPI_LoWord($iwParam)
		Case $idNew
			MemoWrite("New")
		Case $idOpen
			MemoWrite("Open")
		Case $idSave
			MemoWrite("Save")
		Case $idExit
			Exit
		Case $idCut
			MemoWrite("Cut")
		Case $idCopy
			MemoWrite("Copy")
		Case $idPaste
			MemoWrite("Paste")
		Case $idAbout
			MemoWrite("About")
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_COMMAND

; 向memo控件写入消息
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

