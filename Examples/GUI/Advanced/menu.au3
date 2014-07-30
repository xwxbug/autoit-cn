#include <Constants.au3>
#include <GUIConstantsEx.au3>

_Main()

Func _Main()
	Local $idFileMenu, $idFileItem, $idRecentFilesMenu, $idSeparator1
	Local $idExitItem, $idHelpMenu, $idAboutItem, $idOkButton, $idCancelButton
	Local $iMsg, $sFile
	#forceref $idSeparator1

	GUICreate("GUI 菜单",300,200)

	$idFileMenu = GUICtrlCreateMenu("文件(&F)")
	$idFileItem = GUICtrlCreateMenuItem("打开(&O)...", $idFileMenu)
	$idRecentFilesMenu = GUICtrlCreateMenu("历史文件(&R)", $idFileMenu)
	$idSeparator1 = GUICtrlCreateMenuItem("", $idFileMenu)
	$idExitItem = GUICtrlCreateMenuItem("退出(&X)", $idFileMenu)
	$idHelpMenu = GUICtrlCreateMenu("帮助(&H)")
	$idAboutItem = GUICtrlCreateMenuItem("关于(&A)", $idHelpMenu)

	$idOkButton = GUICtrlCreateButton("确定", 50, 130, 70, 20)

	$idCancelButton = GUICtrlCreateButton("取消", 180, 130, 70, 20)

	GUISetState()

	While 1
		$iMsg = GUIGetMsg()

		Select
			Case $iMsg = $GUI_EVENT_CLOSE Or $iMsg = $idCancelButton
				ExitLoop

			Case $iMsg = $idFileItem
			$sFile = FileOpenDialog("选择文件...",@TempDir,"所有文件(*.*)")
				If @error <> 1 Then GUICtrlCreateMenuItem($sFile, $idRecentFilesMenu)

			Case $iMsg = $idExitItem
				ExitLoop

			Case $iMsg = $idOkButton
			MsgBox($MB_SYSTEMMODAL, "单击","您单击了[确定]按钮!")

			Case $iMsg = $idAboutItem
			MsgBox($MB_SYSTEMMODAL,"关于","GUI 菜单测试")
		EndSelect
	WEnd

	GUIDelete()

	Exit
EndFunc   ;==>_Main
