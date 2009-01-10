#include <GUIConstantsEx.au3>


_Main()

Func _Main()
	Local $filemenu, $fileitem, $recentfilesmenu, $separator1
	Local $exititem, $helpmenu, $aboutitem, $okbutton, $cancelbutton
	Local $msg, $file
	#forceref $separator1

GUICreate("GUI 菜单",300,200)

$filemenu = GuiCtrlCreateMenu ("文件(&F)")
$fileitem = GuiCtrlCreateMenuitem ("打开(&O)...",$filemenu)
$recentfilesmenu = GuiCtrlCreateMenu ("历史文件(&R)",$filemenu)
	$separator1 = GUICtrlCreateMenuItem("", $filemenu)
$exititem = GuiCtrlCreateMenuitem ("退出(&X)",$filemenu)
$helpmenu = GuiCtrlCreateMenu ("帮助(&H)")
$aboutitem = GuiCtrlCreateMenuitem ("关于(&A)",$helpmenu)

$okbutton = GuiCtrlCreateButton ("确定",50,130,70,20)

$cancelbutton = GuiCtrlCreateButton ("取消",180,130,70,20)

	GUISetState()

	While 1
		$msg = GUIGetMsg()


		Select
			Case $msg = $GUI_EVENT_CLOSE Or $msg = $cancelbutton
				ExitLoop

			Case $msg = $fileitem
			$file = FileOpenDialog("选择文件...",@TempDir,"所有文件(*.*)")
				If @error <> 1 Then GUICtrlCreateMenuItem($file, $recentfilesmenu)

			Case $msg = $exititem
				ExitLoop

			Case $msg = $okbutton
			MsgBox(0, "单击","您单击了[确定]按钮!")

			Case $msg = $aboutitem
			Msgbox(0,"关于","GUI 菜单测试")
		EndSelect
	WEnd

	GUIDelete()

	Exit
EndFunc   ;==>_Main
