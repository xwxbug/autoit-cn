#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <TreeViewConstants.au3>


_Main()

Func _Main()
	Local $maintree, $aboutitem, $generalitem, $toolsitem, $effectitem, $styleitem
	Local $cmditem, $miscitem, $descgroup, $effectsgroup, $effectstree
	Local $effect1, $effect2, $effect3, $effect4, $effect5
	Local $stylesgroup, $stylestree, $style1, $style2, $style3, $style4, $style5
	Local $aboutlabel, $cancelbutton, $msg

	#forceref $cmditem, $miscitem, $effect2, $effect4, $effect5, $style1, $style2, $style3

GUICreate("GUI 之 treeviews",340,200,-1,-1,BitOr($WS_MINIMIZEBOX,$WS_MAXIMIZEBOX,$WS_GROUP,$WS_CAPTION,$WS_POPUP,$WS_SYSMENU))

$maintree = GUICtrlCreateTreeView (10,10,120,150)
$aboutitem = GUICtrlCreateTreeViewItem ("关于",$maintree)
$generalitem = GUICtrlCreateTreeViewItem ("常规",$maintree)
$toolsitem = GUICtrlCreateTreeViewItem ("工具",$maintree)
$effectitem = GUICtrlCreateTreeViewItem ("效果",$generalitem)
$styleitem = GUICtrlCreateTreeViewItem ("样式",$generalitem)
$cmditem = GUICtrlCreateTreeViewItem ("命令行",$toolsitem)
$miscitem = GUICtrlCreateTreeViewItem ("其它",$toolsitem)

$descgroup = GUICtrlCreateGroup ("详细信息",140,105,180,55)
	GUICtrlSetState(-1, $GUI_HIDE)

$effectsgroup = GUICtrlCreateGroup ("效果",140,5,180,95)
	GUICtrlSetState(-1, $GUI_HIDE)
	$effectstree = GUICtrlCreateTreeView(150, 20, 160, 70, BitOR($TVS_CHECKBOXES, $TVS_DISABLEDRAGDROP), $WS_EX_CLIENTEDGE)
	GUICtrlSetState(-1, $GUI_HIDE)
$effect1 = GUICtrlCreateTreeViewItem ("效果 1",$effectstree)
$effect2 = GUICtrlCreateTreeViewItem ("效果 2",$effectstree)
$effect3 = GUICtrlCreateTreeViewItem ("效果 3",$effectstree)
$effect4 = GUICtrlCreateTreeViewItem ("效果 4",$effectstree)
$effect5 = GUICtrlCreateTreeViewItem ("效果 5",$effectstree)

$stylesgroup = GUICtrlCreateGroup ("样式",140,5,180,95)
	GUICtrlSetState(-1, $GUI_HIDE)
	$stylestree = GUICtrlCreateTreeView(150, 20, 160, 70, BitOR($TVS_CHECKBOXES, $TVS_DISABLEDRAGDROP), $WS_EX_CLIENTEDGE)
	GUICtrlSetState(-1, $GUI_HIDE)
$style1 = GUICtrlCreateTreeViewItem ("样式 1",$stylestree)
$style2 = GUICtrlCreateTreeViewItem ("样式 2",$stylestree)
$style3 = GUICtrlCreateTreeViewItem ("样式 3",$stylestree)
$style4 = GUICtrlCreateTreeViewItem ("样式 4",$stylestree)
$style5 = GUICtrlCreateTreeViewItem ("样式 5",$stylestree)

$aboutlabel = GUICtrlCreateLabel ("这只是一个treeview演示.",160,80,160,20)

$cancelbutton = GUICtrlCreateButton ("取消",130,170,70,20)
	GUISetState()

	GUICtrlSetState($effect1, $GUI_CHECKED)
	GUICtrlSetState($effect3, $GUI_CHECKED)
	GUICtrlSetState($style4, $GUI_CHECKED)
	GUICtrlSetState($style5, $GUI_CHECKED)

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = -3 Or $msg = -1 Or $msg = $cancelbutton
				ExitLoop
			Case $msg = $aboutitem
				GUICtrlSetState($descgroup, $GUI_HIDE)
				GUICtrlSetState($effectstree, $GUI_HIDE)
				GUICtrlSetState($effectsgroup, $GUI_HIDE)
				GUICtrlSetState($stylestree, $GUI_HIDE)
				GUICtrlSetState($stylesgroup, $GUI_HIDE)
				GUICtrlSetState($aboutlabel, $GUI_SHOW)

			Case $msg = $effectitem
				GUICtrlSetState($stylestree, $GUI_HIDE)
				GUICtrlSetState($stylesgroup, $GUI_HIDE)
				GUICtrlSetState($aboutlabel, $GUI_HIDE)
				GUICtrlSetState($effectsgroup, $GUI_SHOW)
				GUICtrlSetState($descgroup, $GUI_SHOW)
				GUICtrlSetState($effectstree, $GUI_SHOW)
				GUICtrlSetBkColor($effectstree, 0xD0F0F0)
				;GUIctrlSetState...($effectstree,$GUI_SHOW)

			Case $msg = $styleitem
				GUICtrlSetState($effectstree, $GUI_HIDE)
				GUICtrlSetState($effectsgroup, $GUI_HIDE)
				GUICtrlSetState($aboutlabel, $GUI_HIDE)
				GUICtrlSetState($stylesgroup, $GUI_SHOW)
				GUICtrlSetState($descgroup, $GUI_SHOW)
				;GUIctrlSetState.($stylestree,$GUI_SHOW)
				GUICtrlSetState($stylestree, $GUI_SHOW)
				GUICtrlSetColor($stylestree, 0xD00000)
				GUICtrlSetBkColor($stylestree, 0xD0FFD0)

		EndSelect
	WEnd

	GUIDelete()
	Exit
EndFunc   ;==>_Main
