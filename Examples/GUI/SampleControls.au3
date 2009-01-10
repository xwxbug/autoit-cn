; AutoIt 3.0.103 example
; 17 Jan 2005 - CyberSlug
; This script shows manual positioning of all controls;
;   there are much better methods of positioning...
#include <GuiConstantsEx.au3>
#include <AVIConstants.au3>
#include <TreeViewConstants.au3>

; GUI
GuiCreate("GUI例子", 400, 400)
GuiSetIcon(@SystemDir & "\mspaint.exe", 0)


; 菜单 
$menu=GuiCtrlCreateMenu("菜单1[&O]")
GUICtrlCreateMenuItem("下拉菜单[&S]",$menu)
GuiCtrlCreateMenu("菜单2[&T]")
GuiCtrlCreateMenu("菜单3[&R]")
GuiCtrlCreateMenu("菜单4[&F]")

; CONTEXT MENU
$contextMenu = GuiCtrlCreateContextMenu()
GuiCtrlCreateMenuItem("上下文菜单", $contextMenu)
GuiCtrlCreateMenuItem("", $contextMenu) ;separator
GuiCtrlCreateMenuItem("属性[&P]", $contextMenu)

; PIC
GuiCtrlCreatePic("logo4.gif",0,0, 169,68)
GuiCtrlCreateLabel("图片例子:", 75, 1, 55, 15)
GuiCtrlSetColor(-1,0xf11fff)


; AVI
GuiCtrlCreateAvi("sampleAVI.avi",0, 180, 10, 32, 32, $ACS_AUTOPLAY)
GuiCtrlCreateLabel(" Avi例子", 170, 50)


; TAB
GuiCtrlCreateTab(240, 0, 150, 70)
GuiCtrlCreateTabItem("第一页")
GuiCtrlCreateLabel("Tab 标签例子", 250, 40)
GuiCtrlCreateTabItem("第二页")
GuiCtrlCreateTabItem("第三页")
GuiCtrlCreateTabItem("")

; COMBO
GuiCtrlCreatecombo("组合框例子", 250, 80, 120, 100)

; PROGRESS
GuiCtrlCreateProgress(85, 80, 130, 20)
GuiCtrlSetData(-1, 60)
GuiCtrlCreateLabel("进度条例子:", 5, 82)

; EDIT
GuiCtrlCreateEdit(@CRLF & "  编辑框例子", 10, 110, 150, 70)

; LIST
GuiCtrlCreateList("", 5, 190, 100, 90)
GuiCtrlSetData(-1, "a.列表|b.例子|c.在|d.这里", "b.列表")

; ICON
GuiCtrlCreateIcon("shell32.dll", 2, 175, 120)
GuiCtrlCreateLabel("图标", 180, 160, 50, 20)

; LIST VIEW
$listView = GuiCtrlCreateListView("列表查看|例子|", 110, 190, 110, 80)
GuiCtrlCreateListViewItem("A|一", $listView)
GuiCtrlCreateListViewItem("B|二", $listView)
GuiCtrlCreateListViewItem("C|三", $listView)

; GROUP WITH RADIO BUTTONS
GuiCtrlCreateGroup("组例子:", 230, 120)
GuiCtrlCreateRadio("单选1", 250, 140, 80)
GuiCtrlSetState(-1, $GUI_CHECKED)
GuiCtrlCreateRadio("单选2", 250, 165, 80)
GUICtrlCreateGroup ("",-99,-99,1,1)  ;close group

; UPDOWN
GuiCtrlCreateLabel("上下例子", 350, 115)
GuiCtrlCreateInput("42", 350, 130, 40, 20)
GuiCtrlCreateUpDown(-1)

; LABEL
GuiCtrlCreateLabel("绿色" & @CRLF & "标签例子", 350, 165, 40, 40)
GuiCtrlSetBkColor(-1, 0x00FF00)

; SLIDER
GuiCtrlCreateLabel("滑动条:", 235, 215)
GuiCtrlCreateSlider(270, 210, 120, 30)
GuiCtrlSetData(-1, 30)

; INPUT
GuiCtrlCreateInput("输入框例子", 235, 255, 130, 20)

; DATE
GuiCtrlCreateDate("", 5, 280, 200, 20)
GuiCtrlCreateLabel("(日期选择例子)", 10, 305, 200, 20)

; BUTTON
GuiCtrlCreateButton("按钮例子", 10, 330, 100, 30)

; CHECKBOX
GuiCtrlCreateCheckbox("多选按钮", 130, 335, 80, 20)
GuiCtrlSetState(-1, $GUI_CHECKED)

; TREEVIEW ONE
$treeOne = GuiCtrlCreateTreeView(210, 290, 80, 80)
$treeItem = GuiCtrlCreateTreeViewItem("树形列表", $treeOne)
GuiCtrlCreateTreeViewItem("项目1", $treeItem)
GuiCtrlCreateTreeViewItem("项目2", $treeItem)
GuiCtrlCreateTreeViewItem("子项目1", -1)
GuiCtrlSetState($treeItem, $GUI_EXPAND)

; TREEVIEW TWO
$treeTwo = GuiCtrlCreateTreeView(295, 290, 103, 80, $TVS_CHECKBOXES)
GuiCtrlCreateTreeViewItem("树形列表2", $treeTwo)
GuiCtrlCreateTreeViewItem("使用", $treeTwo)
GuiCtrlCreateTreeViewItem("多选按钮", $treeTwo)
GuiCtrlSetState(-1, $GUI_CHECKED)
GuiCtrlCreateTreeViewItem("样式", $treeTwo)


; GUI MESSAGE LOOP
GuiSetState()
While GuiGetMsg() <> $GUI_EVENT_CLOSE
WEnd