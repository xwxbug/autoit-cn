#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiButton.au3>
#include <GuiImageList.au3>
#include <GuiStatusBar.au3>
#include <ComboConstants.au3>
#include <AVIConstants.au3>
#include <GuiTreeView.au3>
#include <Timers.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>

$Reg = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir");读取注册表AUTOIT V3安装目录
SplashImageOn("", $Reg & "\Examples\GUI\logo4.gif", 169, 68, -1, -1, 1);开启闪屏图片
;-----------------------------------------------------------------------------------------------
Local $aParts[3] = [200, 400, -1];定义状态栏

$Form1 = GUICreate("GUI例子", 720, 550, -1, -1, $WS_OVERLAPPEDWINDOW);创建一个 GUI 窗口
GUISetIcon(@SystemDir & "\mspaint.exe", 0);设置窗口图标
;-----------------------------------------------------------------------------------------------
$menu_A = GUICtrlCreateMenu("菜单1[&O]");创建一个菜单控件
$menu_A1 = GUICtrlCreateMenuItem("关于[&S]", $menu_A);创建一个菜单项目控件
GUICtrlCreateMenu("菜单2[&T]");创建一个菜单控件
;-----------------------------------------------------------------------------------------------

$contextMenu = GUICtrlCreateContextMenu();创建一个上下文菜单
GUICtrlCreateMenuItem("上下文菜单", $contextMenu);创建一个菜单项目控件
GUICtrlCreateMenuItem("", $contextMenu);创建一个菜单项目控件
$contextMenu1 = GUICtrlCreateMenuItem("关于[&P]", $contextMenu);创建一个菜单项目控件
;-----------------------------------------------------------------------------------------------
;创建一个静态标签(Label)控件
$Label_A1 = GUICtrlCreateLabel("", 180, 0, 1, 70, $SS_ETCHEDHORZ);竖线
$Label_A2 = GUICtrlCreateLabel("", 250, 0, 1, 70, $SS_ETCHEDHORZ);竖线
$Label_A3 = GUICtrlCreateLabel("", 320, 0, 1, 70, $SS_ETCHEDHORZ);竖线
$Label_A4 = GUICtrlCreateLabel("", 448, 0, 1, 70, $SS_ETCHEDHORZ);竖线
$Label_A5 = GUICtrlCreateLabel("", 530, 0, 1, 70, $SS_ETCHEDHORZ);竖线
$Label_A6 = GUICtrlCreateLabel("", 530, 69, 2000, 1, $SS_ETCHEDHORZ);横线

GUICtrlSetResizing($Label_A1, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_A2, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_A3, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_A4, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_A5, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_A6, $GUI_DOCKALL);设置某个控件的大小调整方式
;-----------------------------------------------------------------------------------------------
GUICtrlCreatePic($Reg & "\Examples\GUI\logo4.gif", 0, 0, 169, 68);设置图片

$CreateAvi1 = GUICtrlCreateAvi($Reg & "\Examples\GUI\sampleAVI.avi", 0, 200, 10, 32, 32, $ACS_AUTOPLAY);创建一个AVI视频剪辑控件
GUICtrlSetResizing($CreateAvi1, $GUI_DOCKALL);设置某个控件的大小调整方式

$CreateIcon1 = GUICtrlCreateIcon("shell32.dll", 2, 265, 10);创建一个图标(Icon)控件
GUICtrlSetResizing($CreateIcon1, $GUI_DOCKALL);设置某个控件的大小调整方式

$ButtonA_1 = GUICtrlCreateButton("1", 365, 5, 40, 40, $BS_ICON);创建一个图标按钮
GUICtrlSetImage($ButtonA_1, "shell32.dll", 5);设置指定控件的位图或图标
GUICtrlSetResizing($ButtonA_1, $GUI_DOCKALL);设置某个控件的大小调整方式

$ButtonA_2 = GUICtrlCreateButton("2", 470, 5, 40, 40, $BS_ICON);创建一个图标按钮
GUICtrlSetImage($ButtonA_2, "shell32.dll", 22);设置指定控件的位图或图标
GUICtrlSetResizing($ButtonA_2, $GUI_DOCKALL);设置某个控件的大小调整方式

;创建一个静态标签(Label)控件
$Label_B1 = GUICtrlCreateLabel("图片例子", 120, 0, 55, 15)
$Label_B2 = GUICtrlCreateLabel("Avi例子", 195, 50)
$Label_B3 = GUICtrlCreateLabel("图标例子", 260, 50)
$Label_B4 = GUICtrlCreateLabel("文件夹选择对话框例子", 325, 50, 120, 17)
$Label_B5 = GUICtrlCreateLabel("图标按钮例子", 455, 50, 72, 17)
$Label_B6 = GUICtrlCreateLabel("AutoItCN 官方技术群", 550, 10, 150, 17)
$Label_B7 = GUICtrlCreateLabel("40672266", 565, 30, 150, 22)

GUICtrlSetResizing($Label_B1, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_B2, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_B3, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_B4, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_B5, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_B6, $GUI_DOCKALL);设置某个控件的大小调整方式
GUICtrlSetResizing($Label_B7, $GUI_DOCKALL);设置某个控件的大小调整方式

GUICtrlSetBkColor($Label_B4, 0x00FF00);设置指定控件的背景颜色
GUICtrlSetBkColor($Label_B5, 0xFFFF00);设置指定控件的背景颜色
GUICtrlSetColor($Label_B6, 0x0000ff) ;设置文本颜色
GUICtrlSetColor($Label_B7, 0xff0000) ;设置文本颜色

GUICtrlSetFont($Label_B6, 10, 400, 4) ;设置字体效果
GUICtrlSetFont($Label_B7, 18, 400, 0) ;设置字体效果
;-----------------------------------------------------------------------------------------------
;创建一个分组(Group)控件
$CreateGroup1 = GUICtrlCreateGroup("TreeView 控件例子", 10, 70, 200, 430)
GUICtrlSetResizing($CreateGroup1, 2 + 32 + 64 + 256);设置某个控件的大小调整方式

;创建一个TreeView控件
$hTreeView = GUICtrlCreateTreeView(20, 90, 180, 400, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_CLIENTEDGE)
GUICtrlSetResizing($hTreeView, 2 + 32 + 64 + 256);设置某个控件的大小调整方式

$menu_B = GUICtrlCreateContextMenu($hTreeView);创建上下文菜单(右键)
$menu_B1 = GUICtrlCreateMenuItem("读取方式(1)", $menu_B);创建一个菜单项目控件
$menu_B2 = GUICtrlCreateMenuItem("读取方式(2)", $menu_B);创建一个菜单项目控件
GUICtrlCreateMenuItem("", $menu_B);创建一个菜单项目控件
$menu_B3 = GUICtrlCreateMenuItem("读取方式(3)", $menu_B);创建一个菜单项目控件
;-----------------------------------------------------------------------------------------------
;创建一个分组(Group)控件
$CreateGroup2 = GUICtrlCreateGroup("ListView 控件例子", 220, 70, 490, 430)
GUICtrlSetResizing($CreateGroup2, $GUI_DOCKBORDERS);设置某个控件的大小调整方式

;创建一个组合列表框(ComboBox)控件
$Driver = GUICtrlCreateCombo("", 230, 270, 365, 21, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE))
GUICtrlSetResizing($Driver, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKMENUBAR);设置某个控件的大小调整方式

;创建一个 ListView 控件
$hListView1 = GUICtrlCreateListView("分区|类型|格式|可用空间|总大小", 230, 90, 365, 175)
_GUICtrlListView_SetExtendedListViewStyle($hListView1, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES));添加网格
_GUICtrlListView_SetColumn($hListView1, 0, "分区", 50, 2);设置列属性
_GUICtrlListView_SetColumn($hListView1, 1, "类型", 90, 2)
_GUICtrlListView_SetColumn($hListView1, 2, "格式", 60, 2)
_GUICtrlListView_SetColumn($hListView1, 3, "可用空间", 70, 2)
_GUICtrlListView_SetColumn($hListView1, 4, "总大小", 70, 2)
GUICtrlSetColor($hListView1, 0x0055ff);设置指定控件的文本颜色
GUICtrlSetResizing($hListView1, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKMENUBAR);设置某个控件的大小调整方式

$menu_C = GUICtrlCreateContextMenu($hListView1);创建上下文菜单(右键)
$menu_C1 = GUICtrlCreateMenuItem("读取分区(1)", $menu_C);创建一个菜单项目控件
GUICtrlCreateMenuItem("", $menu_C);创建一个菜单项目控件
$menu_C2 = GUICtrlCreateMenuItem("读取类型(2)", $menu_C);创建一个菜单项目控件
;-----------------------------------------------------------------------------------------------
$ButtonB_1 = GUICtrlCreateButton("分区(&A)", 600, 90, 100, 30, $BS_PUSHLIKE);创建一个按钮控件
_GUICtrlButton_SetImageList($ButtonB_1, _set_button_image(1), 5);分配一个图像列表到按钮控件(小图标效果)
GUICtrlSetResizing($ButtonB_1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT);设置某个控件的大小调整方式

$ButtonB_2 = GUICtrlCreateButton("类型(&B)", 600, 125, 100, 30, $BS_PUSHLIKE);创建一个按钮控件
_GUICtrlButton_SetImageList($ButtonB_2, _set_button_image(2), 1);分配一个图像列表到按钮控件(小图标效果)
GUICtrlSetResizing($ButtonB_2, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT);设置某个控件的大小调整方式

$ButtonB_3 = GUICtrlCreateButton("格式(&C)", 600, 160, 100, 30, $BS_PUSHLIKE);创建一个按钮控件
_GUICtrlButton_SetImageList($ButtonB_3, _set_button_image(3), 5);分配一个图像列表到按钮控件(小图标效果)
GUICtrlSetResizing($ButtonB_3, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT);设置某个控件的大小调整方式

$ButtonB_4 = GUICtrlCreateButton("可用空间(&D)", 600, 230, 100, 30, $BS_PUSHLIKE);创建一个按钮控件
GUICtrlSetResizing($ButtonB_4, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT);设置某个控件的大小调整方式

$ButtonB_5 = GUICtrlCreateButton("总大小(&E)", 600, 195, 100, 30, $BS_PUSHLIKE);创建一个按钮控件
GUICtrlSetResizing($ButtonB_5, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT);设置某个控件的大小调整方式

$ButtonB_6 = GUICtrlCreateButton("<<-读取(&F)", 600, 265, 100, 30, $BS_PUSHLIKE);创建一个按钮控件
GUICtrlSetResizing($ButtonB_6, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT);设置某个控件的大小调整方式
;-----------------------------------------------------------------------------------------------
$hListView2 = GUICtrlCreateListView("", 230, 300, 365, 190, $WS_BORDER);;创建一个 ListView 控件 $WS_BORDER添加细边框
_GUICtrlListView_SetExtendedListViewStyle($hListView2, BitOR($LVS_EX_CHECKBOXES, $LVS_EX_FULLROWSELECT, $LVS_EX_DOUBLEBUFFER))
_GUICtrlListView_SetView($hListView2, 4);设置样式，可选(1、2、3、4)
GUICtrlSetResizing($hListView2, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM);设置某个控件的大小调整方式
;-----------------------------------------------------------------------------------------------
$ButtonC_1 = GUICtrlCreateButton("<<-读取", 600, 300, 100, 40);创建一个按钮控件
_GUICtrlButton_SetImageList($ButtonC_1, _set_button_image_max(3), 1);分配一个图像列表到按钮控件(大图标效果)
GUICtrlSetResizing($ButtonC_1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT);设置某个控件的大小调整方式

$CreateGroup3 = GUICtrlCreateGroup("选择表样式", 600, 350, 100, 140);创建一个分组(Group)控件
GUICtrlSetResizing($CreateGroup3, 4 + 32 + 64 + 256);设置某个控件的大小调整方式

$radio1 = GUICtrlCreateRadio("A", 630, 365, 30, 20);创建一个单选框(Radio)控件
GUICtrlSetResizing($radio1, 4 + 32 + 256);设置某个控件的大小调整方式

$radio2 = GUICtrlCreateRadio("B", 630, 395, 30, 20);创建一个单选框(Radio)控件
GUICtrlSetResizing($radio2, 4 + 32 + 256);设置某个控件的大小调整方式

$radio3 = GUICtrlCreateRadio("C", 630, 425, 30, 20);创建一个单选框(Radio)控件
GUICtrlSetResizing($radio3, 4 + 32 + 256);设置某个控件的大小调整方式

$radio4 = GUICtrlCreateRadio("D", 630, 455, 30, 20);创建一个单选框(Radio)控件
GUICtrlSetResizing($radio4, 4 + 32 + 256);设置某个控件的大小调整方式
;-----------------------------------------------------------------------------------------------
_DisksType();读取硬盘以及分区信息，并在TreeView控件上显示

$var = DriveGetDrive("ALL");返回一个含有指定驱动器盘符的数组
If Not @error Then
	For $i = 1 To $var[0]
		Dim $Vars[$var[0] + 1]

		$Vars[$i] = StringUpper($var[$i]);转换字符串为大写字母
		$DriveType = DriveGetType($var[$i]);驱动器的类型
		$DriveFile = DriveGetFileSystem($var[$i]);格式
		$DriveFree = DriveSpaceFree($var[$i]);可用空间
		$DriveFreeGB = ByteConversion($DriveFree);单位转换
		$DriveTotal = DriveSpaceTotal($var[$i]);总大小
		$DriveTotalGB = ByteConversion($DriveTotal);单位转换

		;修改组合列表框控件的数据
		GUICtrlSetData($Driver, $Vars[$i] & "  " & $DriveType & "  " & $DriveFile & "  " & $DriveFreeGB & "  " & $DriveTotalGB, _
				$Vars[1] & "  " & $DriveType & "  " & $DriveFile & "  " & $DriveFreeGB & "  " & $DriveTotalGB)

		If $DriveType = "Unknown" Then;判断驱动器是否 Unknown 类型

		ElseIf $DriveType = "Removable" Then;判断驱动器是否 Removable 类型
			$DriveTypeS = "可移动驱动器"
			;创建一个 ListView 项目控件
			GUICtrlCreateListViewItem($Vars[$i] & "|" & $DriveTypeS & "|" & $DriveFile & "|" & $DriveFreeGB & "|" & $DriveTotalGB, $hListView1)
			GUICtrlSetImage(-1, "shell32.dll", 8);设置指定控件的位图或图标

			GUICtrlCreateListViewItem("分区  " & $Vars[$i] & @CRLF & "[可用空间：" & $DriveFreeGB & "][总大小：" & $DriveTotalGB & "]", $hListView2)
			GUICtrlSetImage(-1, "shell32.dll", 8);设置指定控件的位图或图标
			; 建立分组1
			$x = _GUICtrlListView_GetCounterPage($hListView2) - 1;计算在可视区域中可垂直显示的项目数量
			_GUICtrlListView_EnableGroupView($hListView2);启用控件中的项目分组显示
			_GUICtrlListView_InsertGroup($hListView2, -1, 1, "Removable");插入分组
			_GUICtrlListView_SetItemGroupID($hListView2, $x, 1);设置项目分组编号

		ElseIf $DriveType = "Fixed" Then;判断驱动器是否 Fixed 类型
			$DriveTypeS = "固定驱动器"
			;创建一个 ListView 项目控件
			GUICtrlCreateListViewItem($Vars[$i] & "|" & $DriveTypeS & "|" & $DriveFile & "|" & $DriveFreeGB & "|" & $DriveTotalGB, $hListView1)
			GUICtrlSetImage(-1, "shell32.dll", 9);设置指定控件的位图或图标

			GUICtrlCreateListViewItem("分区  " & $Vars[$i] & @CRLF & "[可用空间：" & $DriveFreeGB & "][总大小：" & $DriveTotalGB & "]", $hListView2)
			GUICtrlSetImage(-1, "shell32.dll", 9);设置指定控件的位图或图标
			; 建立分组2
			$x = _GUICtrlListView_GetCounterPage($hListView2) - 1;计算在可视区域中可垂直显示的项目数量
			_GUICtrlListView_EnableGroupView($hListView2);启用控件中的项目分组显示
			_GUICtrlListView_InsertGroup($hListView2, -1, 2, "Fixed");插入分组
			_GUICtrlListView_SetItemGroupID($hListView2, $x, 2);设置项目分组编号

		ElseIf $DriveType = "Network" Then;判断驱动器是否 Network 类型
			$DriveTypeS = "网络驱动器"
			;创建一个 ListView 项目控件
			GUICtrlCreateListViewItem($Vars[$i] & "|" & $DriveTypeS & "|" & $DriveFile & "|" & $DriveFreeGB & "|" & $DriveTotalGB, $hListView1)
			GUICtrlSetImage(-1, "shell32.dll", 10)

			GUICtrlCreateListViewItem("分区  " & $Vars[$i] & @CRLF & "[可用空间：" & $DriveFreeGB & "][总大小：" & $DriveTotalGB & "]", $hListView2)
			GUICtrlSetImage(-1, "shell32.dll", 10);设置指定控件的位图或图标
			; 建立分组3
			$x = _GUICtrlListView_GetCounterPage($hListView2) - 1;计算在可视区域中可垂直显示的项目数量
			_GUICtrlListView_EnableGroupView($hListView2);启用控件中的项目分组显示
			_GUICtrlListView_InsertGroup($hListView2, -1, 3, "Network");插入分组
			_GUICtrlListView_SetItemGroupID($hListView2, $x, 3);设置项目分组编号

			$treeItemDrive = GUICtrlCreateTreeViewItem($Vars[$i], $hTreeView);创建一个 TreeView 控件项目
			GUICtrlSetImage($treeItemDrive, "shell32.dll", 10);设置指定控件的位图或图标

			$search = FileFindFirstFile($Vars[$i] & "\*.*");搜索分区所有文件
			If $search = -1 Then;检查搜索是否成功
			Else
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlCreateTreeViewItem($file, $treeItemDrive);创建一个 TreeView 控件项目
					GUICtrlSetImage(-1, "shell32.dll", 4);设置指定控件的位图或图标
				WEnd
			EndIf
			FileClose($search); 关闭搜索句柄
		ElseIf $DriveType = "CDROM" Then;判断驱动器是否 CDROM 类型
			$DriveTypeS = "光驱"
			;创建一个 ListView 项目控件
			GUICtrlCreateListViewItem($Vars[$i] & "|" & $DriveTypeS & "|" & $DriveFile & "|" & $DriveFreeGB & "|" & $DriveTotalGB, $hListView1)
			GUICtrlSetImage(-1, "shell32.dll", 12);设置指定控件的位图或图标

			GUICtrlCreateListViewItem("分区  " & $Vars[$i] & @CRLF & "[可用空间：" & $DriveFreeGB & "][总大小：" & $DriveTotalGB & "]", $hListView2)
			GUICtrlSetImage(-1, "shell32.dll", 12);设置指定控件的位图或图标
			;另外一种用法
;~ 				_GUICtrlListView_AddItem($hListView2, "分区：" & $Vars[$i] & "|类型：" & $DriveTypeS & "|格式：" & $DriveFile & @CRLF & "可用空间：" & $DriveFreeGB & "|总大小：" & $DriveTotalGB, 4)
;~ 				GUICtrlSetImage(-1, "shell32.dll", 12);设置指定控件的位图或图标
			; 建立分组4
			$x = _GUICtrlListView_GetCounterPage($hListView2) - 1;计算在可视区域中可垂直显示的项目数量
			_GUICtrlListView_EnableGroupView($hListView2);启用控件中的项目分组显示
			_GUICtrlListView_InsertGroup($hListView2, -1, 4, "CDROM");插入分组
			_GUICtrlListView_SetItemGroupID($hListView2, $x, 4);设置项目分组编号

			$treeItemDrive = GUICtrlCreateTreeViewItem($Vars[$i], $hTreeView);创建一个 TreeView 控件项目
			GUICtrlSetImage($treeItemDrive, "shell32.dll", 12);设置指定控件的位图或图标

			$search = FileFindFirstFile($Vars[$i] & "\*.*");搜索分区所有文件
			If $search = -1 Then;检查搜索是否成功
			Else
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlCreateTreeViewItem($file, $treeItemDrive);创建一个 TreeView 控件项目
					GUICtrlSetImage(-1, "shell32.dll", 4);设置指定控件的位图或图标
				WEnd
			EndIf
			FileClose($search); 关闭搜索句柄
		ElseIf $DriveType = "RAMDiskk" Then;判断驱动器是否 RAMDiskk 类型
			$DriveTypeS = "内存盘"
			;创建一个 ListView 项目控件
			GUICtrlCreateListViewItem($Vars[$i] & "|" & $DriveTypeS & "|" & $DriveFile & "|" & $DriveFreeGB & "|" & $DriveTotalGB, $hListView1)
			GUICtrlSetImage(-1, "shell32.dll", 8);设置指定控件的位图或图标

			GUICtrlCreateListViewItem("分区  " & $Vars[$i] & @CRLF & "[可用空间：" & $DriveFreeGB & "][总大小：" & $DriveTotalGB & "]", $hListView2)
			GUICtrlSetImage(-1, "shell32.dll", 8);设置指定控件的位图或图标
			; 建立分组5
			$x = _GUICtrlListView_GetCounterPage($hListView2) - 1;计算在可视区域中可垂直显示的项目数量
			_GUICtrlListView_EnableGroupView($hListView2);启用控件中的项目分组显示
			_GUICtrlListView_InsertGroup($hListView2, -1, 5, "RAMDiskk");插入分组
			_GUICtrlListView_SetItemGroupID($hListView2, $x, 5);设置项目分组编号
		EndIf
	Next
EndIf

;-----------------------------------------------------------------------------------------------
;状态栏
$StatusBar1 = _GUICtrlStatusBar_Create($Form1, $aParts)
_GUICtrlStatusBar_SetText($StatusBar1, today() & "  " & StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC))
_GUICtrlStatusBar_SetText($StatusBar1, @TAB & "系统：" & @OSVersion, 1)
_GUICtrlStatusBar_SetText($StatusBar1, @TAB & "计算机名：" & @ComputerName, 2)
_GUICtrlStatusBar_SetIcon($StatusBar1, 0, _WinAPI_LoadShell32Icon(1));设置状态栏图标
_GUICtrlStatusBar_SetIcon($StatusBar1, 1, _WinAPI_LoadShell32Icon(2));设置状态栏图标
_Timer_SetTimer($Form1, 1000, "_UpdateStatusBarClock") ; 创建计时器
GUIRegisterMsg($WM_SIZE, "WM_SIZE");调整状态栏位置

Sleep(500)
SplashOff();关闭闪屏图片
GUISetState(@SW_SHOW)

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Label_B6;点击弹出主页
			GUICtrlSetColor($Label_B6, 0xEE7621);改变字体颜色
			ShellExecute("http://www.autoit.net.cn");打开ACN主页
		Case $menu_A1
			MsgBox(266304, "关于", "演示制作：kodin")
		Case $contextMenu1
			MsgBox(266304, "关于", "演示制作：kodin")
		Case $menu_B1;读取(1)
			$TEXT = StringReplace(_GUICtrlTreeView_GetTree($hTreeView), _GUICtrlTreeView_GetText($hTreeView), "");读取方式1
			$location = StringInStr($TEXT, "|", 0, 2);检查某个字符串是否含有给定的子串
			If $location = 0 Then
				$item = GUICtrlRead($hTreeView);读取控件
				If $item = 0 Then
					MsgBox(262160, "错误", "没有选择")
				Else
					$TEXT = GUICtrlRead($item, 1)
					If $TEXT = "" Then
					Else
						MsgBox(266304, "提示", $TEXT)
					EndIf
				EndIf
			Else
				;方法1
				$array = StringRegExp($TEXT, '\|(.+)\|(.+)', 3);检查字串是否符合给定的正则表达式
				For $i = 1 To UBound($array) - 1
					MsgBox(266304, "方法1", $array[0] & "\" & $array[1])
				Next
			EndIf
		Case $menu_B2;读取(2)
			$TEXT = _GUICtrlTreeView_GetTree($hTreeView);读取方式1
			$location = StringInStr($TEXT, "|", 0, 2);检查某个字符串是否含有给定的子串
			If $location = 0 Then
				$item = GUICtrlRead($hTreeView);读取控件
				If $item = 0 Then
					MsgBox(262160, "错误", "没有选择")
				Else
					$TEXT = GUICtrlRead($item, 1)
					If $TEXT = "" Then
					Else
						MsgBox(266304, "提示", $TEXT)
					EndIf
				EndIf
			Else
				;方法2
				$array = StringRegExp($TEXT, '\|(.+)', 3);检查字串是否符合给定的正则表达式
				For $i = 0 To UBound($array) - 1
					$text_out = StringRegExpReplace($array[$i], '\|', '\\')	;基于正则表达式的文本替换
					MsgBox(266304, "方法2", $text_out)
				Next
			EndIf
		Case $menu_B3;读取(3)
			$item = GUICtrlRead($hTreeView);读取控件
			If $item = 0 Then
				MsgBox(262160, "错误", "没有选择")
			Else
				$TEXT = GUICtrlRead($item, 1)
				If $TEXT = "" Then
				Else
					MsgBox(266304, "提示", $TEXT)
				EndIf
			EndIf
		Case $menu_C1;读取(1)
			$ListTxt0 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 0)
			If $ListTxt0 = "" Then
				MsgBox(262160, "错误", "未选择！")
			Else
				MsgBox(266304, "提示", $ListTxt0)
			EndIf
		Case $menu_C2;读取(2)
			$ListTxt0 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 1)
			If $ListTxt0 = "" Then
				MsgBox(262160, "错误", "未选择！")
			Else
				MsgBox(266304, "提示", $ListTxt0)
			EndIf
		Case $ButtonA_1
			$Folder = FileSelectFolder("请选择路径", "", 4);显示一个文件夹选择对话框
			If @error Then
				MsgBox(266304, "提示", "没有选择")
			Else
				MsgBox(266304, "提示", $Folder)
			EndIf
		Case $ButtonA_2
			MsgBox(266304, "提示", "图标按钮例子")
		Case $ButtonB_1;分区
			$ListTxt0 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 0)
			If $ListTxt0 = "" Then
				MsgBox(262160, "错误", "未选择分区！")
			Else
				MsgBox(266304, "提示", $ListTxt0)
			EndIf
		Case $ButtonB_2;类型
			$ListTxt0 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 0)
			If $ListTxt0 = "" Then
				MsgBox(262160, "错误", "未选择分区！")
			Else
				$ListTxt1 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 1)
				MsgBox(266304, "提示 " & $ListTxt0, $ListTxt1)
			EndIf
		Case $ButtonB_3;格式
			$ListTxt0 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 0)
			If $ListTxt0 = "" Then
				MsgBox(262160, "错误", "未选择分区！")
			Else
				$ListTxt2 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 2)
				If $ListTxt2 = "" Then
					MsgBox(266304, "提示 " & $ListTxt0, "未知格式")
				Else
					MsgBox(266304, "提示 " & $ListTxt0, $ListTxt2)
				EndIf
			EndIf
		Case $ButtonB_4;可用空间
			$ListTxt0 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 0)
			If $ListTxt0 = "" Then
				MsgBox(262160, "错误", "未选择分区！")
			Else
				$ListTxt3 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 3)
				MsgBox(266304, "提示 " & $ListTxt0, $ListTxt3)
			EndIf
		Case $ButtonB_5;总大小
			$ListTxt0 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 0)
			If $ListTxt0 = "" Then
				MsgBox(262160, "错误", "未选择分区！")
			Else
				$ListTxt4 = _GUICtrlListView_GetItemText($hListView1, _GUICtrlListView_GetNextItem($hListView1), 4)
				MsgBox(266304, "提示 " & $ListTxt0, $ListTxt4)
			EndIf
		Case $ButtonB_6;读取
			$DriverRead = GUICtrlRead($Driver)
			MsgBox(266304, "提示", $DriverRead)
		Case $ButtonC_1;读取
			For $i = _GUICtrlListView_GetTopIndex($hListView2) To _GUICtrlListView_GetCounterPage($hListView2);列表视图最高可见项的索引 to 可见项索引的总数
				$CI = $i + 1
				$Checked = _GUICtrlListView_GetItemChecked($hListView2, $i);返回列表视图控件项目的选中状态
				If $Checked = True Then
					MsgBox(266304, "提示", $var[$CI])
				EndIf
			Next
		Case $radio1
			_GUICtrlListView_SetBkColor($hListView2, $CLR_MONEYGREEN);设置控件背景色
			_GUICtrlListView_SetTextColor($hListView2, $CLR_BLACK);设置控件中的文本色
			_GUICtrlListView_SetTextBkColor($hListView2, $CLR_MONEYGREEN);设置控件中文本的背景色
			_GUICtrlListView_SetOutlineColor($hListView2, 0x0000FF);设置边框色
			_GUICtrlListView_SetView($hListView2, 1);设置样式，可选(1、2、3、4)
		Case $radio2
			_GUICtrlListView_SetBkColor($hListView2, $CLR_NONE);设置控件背景色
			_GUICtrlListView_SetTextColor($hListView2, $CLR_BLACK);设置控件中的文本色
			_GUICtrlListView_SetTextBkColor($hListView2, $CLR_NONE);设置控件中文本的背景色
			_GUICtrlListView_SetView($hListView2, 2);设置样式，可选(1、2、3、4)
		Case $radio3
			_GUICtrlListView_SetView($hListView2, 3);设置样式，可选(1、2、3、4)
		Case $radio4
			_GUICtrlListView_SetView($hListView2, 4);设置样式，可选(1、2、3、4)
	EndSwitch
WEnd

;单位转换
Func ByteConversion($lBytes)
	If $lBytes < 1024 Then
		Return Round($lBytes, 2) & "MB"
	ElseIf $lBytes < 1048576 Then
		Return Round($lBytes / 1024, 2) & "GB"
	EndIf
EndFunc   ;==>ByteConversion

;按钮图像处理(小图标)
Func _set_button_image($icon_index)
	Local $hImage_Temp = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage_Temp, "Shell32.dll", $icon_index)
	Return $hImage_Temp
EndFunc   ;==>_set_button_image

;按钮图像处理(大图标)
Func _set_button_image_max($icon_index)
	Local $hImage_Temp = _GUIImageList_Create(32, 32, 5, 3, 6)
	_GUIImageList_AddIcon($hImage_Temp, "Shell32.dll", $icon_index, True)
	Return $hImage_Temp
EndFunc   ;==>_set_button_image_max

;返回当前时间
Func _UpdateStatusBarClock($hWnd, $msg, $iIDTimer, $dwTime)
	_GUICtrlStatusBar_SetText($StatusBar1, today() & "  " & StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC))
EndFunc   ;==>_UpdateStatusBarClock

;返回当前日期
Func today()
	Return (@YEAR & "年" & @MON & "月" & @MDAY & "日")
EndFunc   ;==>today

;调整状态栏位置
Func WM_SIZE($hWnd, $msg, $wParam, $lParam)
	_GUICtrlStatusBar_Resize($StatusBar1)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE

Func _DisksType();读取硬盘以及分区
	Dim $a[1]
	Local $x = 0
	$strComputer = "localhost"
	$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
	$colDiskDrives = $objWMIService.ExecQuery("SELECT * FROM Win32_DiskDrive")
	For $objDrive In $colDiskDrives
		ReDim $a[UBound($a) + 1]
		$a[$x] = GUICtrlCreateTreeViewItem($objDrive.Caption, $hTreeView);创建一个 TreeView 控件项目
		GUICtrlSetImage($a[$x], "shell32.dll", 9);设置图标
		GUICtrlSetColor($a[$x], 0x0000ff);设置字体颜色
		GUICtrlSetState($a[$x], BitOR($GUI_EXPAND, $GUI_DEFBUTTON));设置字体效果
		$strDeviceID = StringReplace($objDrive.DeviceID, "\", "\\");替换字符串中的指定子串
		$colPartitions = $objWMIService.ExecQuery _
				("ASSOCIATORS OF {Win32_DiskDrive.DeviceID=""" & _
				$strDeviceID & """} WHERE AssocClass = " & _
				"Win32_DiskDriveToDiskPartition")

		For $objPartition In $colPartitions
			$colLogicalDisks = $objWMIService.ExecQuery _
					("ASSOCIATORS OF {Win32_DiskPartition.DeviceID=""" & _
					$objPartition.DeviceID & """} WHERE AssocClass = " & _
					"Win32_LogicalDiskToPartition")

			For $objLogicalDisk In $colLogicalDisks
				$DriveTreeView = GUICtrlCreateTreeViewItem($objLogicalDisk.DeviceID, $a[$x]);创建一个 TreeView 控件项目
				$search = FileFindFirstFile($objLogicalDisk.DeviceID & "\*.*");搜索分区所有文件
				If $search = -1 Then;检查搜索是否成功
				Else
					While 1
						$file = FileFindNextFile($search)
						If @error Then ExitLoop
						GUICtrlCreateTreeViewItem($file, $DriveTreeView);创建一个 TreeView 控件项目
						GUICtrlSetImage(-1, "shell32.dll", 4);设置指定控件的位图或图标
					WEnd
				EndIf
				FileClose($search); 关闭搜索句柄
			Next
		Next
		$x += 1
	Next
EndFunc   ;==>_DisksType