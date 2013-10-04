#include <GUIConstantsEx.au3>
#include <Constants.au3>

_Main()

Func _Main()
	Local $filemenu, $fileitem, $recentfilesmenu, $separator1
	Local $exititem, $helpmenu, $aboutitem, $okbutton, $cancelbutton
	Local $msg, $file
	#forceref $separator1

GUICreate("GUI 菜单",300,200)

$filemenu = GUICtrlCreateMenu ("文件(&F)")
$fileitem = GUICtrlCreateMenuItem ("打开(&O)...",$filemenu)
$recentfilesmenu = GUICtrlCreateMenu ("历史文件(&R)",$filemenu)
	$separator1 = GUICtrlCreateMenuItem("", $filemenu)
$exititem = GUICtrlCreateMenuItem ("退出(&X)",$filemenu)
$helpmenu = GUICtrlCreateMenu ("帮助(&H)")
$aboutitem = GUICtrlCreateMenuItem ("关于(&A)",$helpmenu)

$okbutton = GUICtrlCreateButton ("确定",50,130,70,20)

$cancelbutton = GUICtrlCreateButton ("取消",180,130,70,20)

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
			MsgBox($MB_SYSTEMMODAL, "单击","您单击了[确定]按钮!")

			Case $msg = $aboutitem
			MsgBox($MB_SYSTEMMODAL,"关于","GUI 菜单测试")
		EndSelect
	WEnd

	GUIDelete()

	Exit
EndFunc   ;==>_Main
