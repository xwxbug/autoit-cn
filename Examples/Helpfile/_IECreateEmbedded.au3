; *******************************************************
; 示例1 - 获取COM错误以便外部历史集的'Back'及'Forward'不使脚本退出
;    (COM错误将送至控制台)
; *******************************************************
;
#include  <GUIConstantsEx.au3>
#include  <WindowsConstants.au3>
#include  <IE.au3>

_IEErrorHandlerRegister()

$oIE = _IECreateEmbedded()
GUICreate(" Embedded Web control Test ", 640, 580, _
		(@DesktopWidth - 640) / 2, (@DesktopHeight - 580) / 2, _
		$WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
$GUIActiveX = GUICtrlCreateObj($oIE, 10, 40, 600, 360)
$GUI_Button_Back = GUICtrlCreateButton(" Back ", 10, 420, 100, 30)
$GUI_Button_Forward = GUICtrlCreateButton(" Forward ", 120, 420, 100, 30)
$GUI_Button_Home = GUICtrlCreateButton(" Home ", 230, 420, 100, 30)
$GUI_Button_Stop = GUICtrlCreateButton(" Stop ", 340, 420, 100, 30)

GUISetState() ;显示GUI

_IENavigate($oIE, "http://www.autoitscript.com ")

; 等待用户关闭窗口
While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $msg = $GUI_Button_Home
			_IENavigate($oIE, "http://www.autoitscript.com ")
		Case $msg = $GUI_Button_Back
			_IEAction($oIE, "back ")
		Case $msg = $GUI_Button_Forward
			_IEAction($oIE, "forward ")
		Case $msg = $GUI_Button_Stop
			_IEAction($oIE, "stop ")
	EndSelect
WEnd

GUIDelete()

Exit

