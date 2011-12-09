; AutoIt GUI Example
; Created: 17/01/2005 - CyberSlug
; Modifed: 05/01/2011 - guinness

#include <GuiConstantsEx.au3>
#include <AVIConstants.au3>
#include <TreeViewConstants.au3>

; GUI
GUICreate("GUI例子", 400, 400)
GUISetIcon(@SystemDir & "\mspaint.exe", 0)


; 菜单 
$menu=GUICtrlCreateMenu("菜单1[&O]")
GUICtrlCreateMenuItem("下拉菜单[&S]",$menu)
GUICtrlCreateMenu("菜单2[&T]")
GUICtrlCreateMenu("菜单3[&R]")
GUICtrlCreateMenu("菜单4[&F]")

; CONTEXT MENU
Local $iContextMenu = GUICtrlCreateContextMenu()
GUICtrlCreateMenuItem("上下文菜单", $iContextMenu)
GUICtrlCreateMenuItem("", $iContextMenu) ; Separator
GUICtrlCreateMenuItem("属性[&P]", $iContextMenu)

; PIC
GUICtrlCreatePic("logo4.gif", 0, 0, 169, 68)
GUICtrlCreateLabel("图片例子:", 75, 1, 53, 15)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)


; AVI
GUICtrlCreateAvi("SampleAVI.avi", 0, 180, 10, 32, 32, $ACS_AUTOPLAY)
GUICtrlCreateLabel(" Avi例子", 170, 50)


; TAB
GUICtrlCreateTab(240, 0, 150, 70)
GUICtrlCreateTabItem("第一页")
GUICtrlCreateLabel("Tab 标签例子", 250, 40)
GUICtrlCreateTabItem("第二页")
GUICtrlCreateTabItem("第三页")
GUICtrlCreateTabItem("")

; COMBO
GUICtrlCreateCombo("组合框例子", 250, 80, 120, 100)

; PROGRESS
GUICtrlCreateProgress(60, 80, 150, 20)
GUICtrlSetData(-1, 60)
GUICtrlCreateLabel("进度条例子:", 5, 82)

; EDIT
GUICtrlCreateEdit(@CRLF & "  编辑框例子", 10, 110, 150, 70)

; LIST
GUICtrlCreateList("", 5, 190, 100, 90)
GUICtrlSetData(-1, "a.列表|b.例子|c.在|d.这里", "b.列表")

; ICON
GUICtrlCreateIcon("shell32.dll", 1, 175, 120)
GUICtrlCreateLabel("图标", 180, 160, 50, 20)

; LIST VIEW
Local $iListView = GUICtrlCreateListView("列表查看|例子|", 110, 190, 110, 80)
GUICtrlCreateListViewItem("A|一", $iListView)
GUICtrlCreateListViewItem("B|二", $iListView)
GUICtrlCreateListViewItem("C|三", $iListView)

; GROUP WITH RADIO BUTTONS
GUICtrlCreateGroup("组例子:", 230, 120)
GUICtrlCreateRadio("单选1", 250, 140, 80)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateRadio("单选2", 250, 165, 80)
GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

; UPDOWN
GUICtrlCreateLabel("上下例子", 350, 115)
GUICtrlCreateInput("42", 350, 130, 40, 20)
GUICtrlCreateUpdown(-1)

; LABEL
GUICtrlCreateLabel("绿色" & @CRLF & "标签例子", 350, 165, 40, 40)
GUICtrlSetBkColor(-1, 0x00FF00)

; SLIDER
GUICtrlCreateLabel("滑动条:", 235, 215)
GUICtrlCreateSlider(270, 210, 120, 30)
GUICtrlSetData(-1, 30)

; INPUT
GUICtrlCreateInput("输入框例子", 235, 255, 130, 20)

; DATE
GUICtrlCreateDate("", 5, 280, 200, 20)
GUICtrlCreateLabel("(日期选择例子)", 10, 305, 200, 20)

; BUTTON
GUICtrlCreateButton("按钮例子", 10, 330, 100, 30)

; CHECKBOX
GUICtrlCreateCheckbox("多选按钮", 130, 335, 80, 20)
GUICtrlSetState(-1, $GUI_CHECKED)

; TREEVIEW ONE
Local $iTreeView_1 = GUICtrlCreateTreeView(210, 290, 80, 80)
Local $iTreeItem = GUICtrlCreateTreeViewItem("树形列表", $iTreeView_1)
GUICtrlCreateTreeViewItem("项目1", $iTreeItem)
GUICtrlCreateTreeViewItem("项目2", $iTreeItem)
GUICtrlCreateTreeViewItem("子项目1", -1)
GUICtrlSetState($iTreeItem, $GUI_EXPAND)

; TREEVIEW TWO
Local $iTreeView_2 = GUICtrlCreateTreeView(295, 290, 103, 80, $TVS_CHECKBOXES)
GUICtrlCreateTreeViewItem("树形列表2", $iTreeView_2)
GUICtrlCreateTreeViewItem("使用", $iTreeView_2)
GUICtrlCreateTreeViewItem("多选按钮", $iTreeView_2)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateTreeViewItem("样式", $iTreeView_2)


; GUI MESSAGE LOOP
GUISetState(@SW_SHOW)
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd