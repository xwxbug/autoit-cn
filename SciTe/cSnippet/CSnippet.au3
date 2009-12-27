#NoTrayIcon
#Region ;**** 参数创建于 AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=filetype1.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Help in Managing Code Snippets, Original Concept/Code by MikeOsdx, Help interfacing with SciTE by JdeB
#AutoIt3Wrapper_Res_Description=Code Snippet for SciTE
#AutoIt3Wrapper_Res_Fileversion=1.0.5.12
#AutoIt3Wrapper_Res_LegalCopyright=GaryFrost
#AutoIt3Wrapper_Res_Field=CompanyName|aka gafrost
#AutoIt3Wrapper_Res_Field=OriginalFilename|CSnippet.exe
#AutoIt3Wrapper_Res_Field=Release Date|01/19/2006
#AutoIt3Wrapper_Res_Field=Update Date|12/04/2007
#AutoIt3Wrapper_Res_Field=Internal Name|CSnippet.exe
#AutoIt3Wrapper_Res_Field=Status|Release
#AutoIt3Wrapper_useupx=n
#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7
#EndRegion ;**** 参数创建于 AutoIt3Wrapper_GUI ****

;Code Snippet for SciTE
#include <GUIConstantsEx.au3>
#include <file.au3>
#include <array.au3>
#include <Inet.au3>
#include <Misc.au3>
#include <GuiComboBox.au3>
#include <GuiEdit.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <SliderConstants.au3>
#include <GuiStatusBar.au3>
#include <GuiToolBar.au3>
#include <GuiToolTip.au3>
#include <GuiTreeView.au3>
#include 'Includes\WinAnimate.au3'
#include "Includes\Menus.au3"
#include 'Includes\CommCtrl.au3'
#include "Includes\_XMLDomWrapper.au3"

Opt("MustDeclareVars", 1)
Opt("WinTitleMatchMode", 2)

;~ ;Register COPYDATA message.
GUIRegisterMsg($WM_COPYDATA, "_Scite_MY_WM_COPYDATA")
Global $CodeEdit, $CodeFilter, $btnDelSnippet, $Trans_slider, $Btn_Search, $chk_fuzzy
Global $Ilegal_chars[9] = ['\', '/', ':', '*', '?', '"', '<', '>', '|']
Global $SnippetName, $SnippetCat, $EnableEdit
Global $tmp_sel, $tmp_name, $tmp_cat, $export_folder
Global $RetrievedRaw, $RetrievedClean, $New_Flag, $CatRaw, $CatName
Global $View, $g_szVersion, $ClipEvent = 0, $Init_Preview = False
Global $snips_dir = IniRead($file, "~xx123Data", "SnipsDir", @ScriptDir & "\Snips")
Global $sub_dirs = Int(IniRead($file, "~xx123Data", "SubDirs", '0'))
Global Const $Cursor_WAIT = 15
Global Const $Cursor_ARROW = 2

_StartUp()

Func _StartUp()
	Local $cmdLine_Raw, $Dir, $Dir2
	$g_szVersion = "Code Snippet 1.0.5.12 for SciTE"
	Local $copy_file = @ScriptDir & "\copy.ini"
	
	If StringInStr($cmdlineraw, "/CreateSnippet") Then  ;Creat Snippet request from Scite
		$cmdLine_Raw = _GetCurrentSciteSelection()
		If StringLen($cmdLine_Raw) > 0 Then
			IniWrite($copy_file, "CMDtmp", "Value", $cmdLine_Raw)
			IniWrite($copy_file, "CMDtmp", "New", 1)
		EndIf
	ElseIf StringInStr($cmdlineraw, "/Restart") Then  ;restarted make sure 1st instance is closed before continuing
		WinWaitClose($g_szVersion)
	EndIf
	
	If WinExists($g_szVersion) Then Exit ; It's already running
	AutoItWinSetTitle($g_szVersion)
	
	If Not ProcessExists("SciTe.exe") Then
		$Dir = StringInStr(@ScriptDir, "\", 0, -1)
		$Dir2 = StringLeft(@ScriptDir, $Dir)
		Run($Dir2 & "\SciTe.exe", $Dir2)
	EndIf
	$View = Int(IniRead($file, "~xx123Data", "View", 0))
	If Not FileExists($snips_dir) Then DirCreate($snips_dir)
	If $View = 1 Then
		_MainListView($copy_file)
	Else
		_MainTreeView($copy_file)
	EndIf
EndFunc   ;==>_StartUp

#region Begin ListView Gui section
Func _MainListView(ByRef $copy_file)
	#region Begin Delcare Local Variables
	Local $menuFile, $menuItemNewSnippet, $menuItemNewCategory, $menuItemInsert, $menuItemSelectTreeView
	Local $ContextMenuListView, $menuItemAddNewSnippet, $menuConfig, $PosX, $PosY, $PosW, $PosH
	Local $menuDocking, $menuItemDockLeft, $menuItemDockRight, $menuItemImport, $menuItemExport
	Local $menuItemPreview, $menuItemInsertToSciTE, $menuItemRenameSnippet, $menuItemDeleteSnippet, $menuItemSnippets
	Local $menuItemImportSnippet, $menuItemExportSnippet, $menuItemClipBoard, $menuItemSendToClipBoard, $menuItemToolTip
	Local $menuItemCopyClipBoard, $menuItemClipGet, $old_name, $Confirm, $Selected_Cat, $CMDtmp, $CmdClean
	Local $btnSaveSnippet, $btnCloseSnippet, $btnNewCat, $btnRenameCat, $btnDeleteCat, $btn_InsertScite, $btn_ClipBoard
	Local $WinPos, $dtaRename, $SciTE, $Transparency, $msg, $import_folder, $Clip_Timer = 0, $cat_group
	Local $hImage
	#endregion End Declare Local Variables
	$export_folder = IniRead($file, "~xx123Data", "ExportDir", @ScriptDir)
	$import_folder = IniRead($file, "~xx123Data", "ImportDir", @ScriptDir)
	
	_SizeWindow($PosX, $PosY, $PosW, $PosH, $file) ;Retrieve pos and size of window from INI
	WinWaitActive("SciTE", "Source", 30)
	$SciTE = WinGetHandle("SciTE", "Source")
	$main_GUI = GUICreate("Code Snippet", $PosW, $PosH + 17, $PosX, $PosY, BitOR($WS_THICKFRAME, $WS_SIZEBOX, $WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS), $WS_EX_MDICHILD, $SciTE)
	GUIRegisterMsg($WM_GETMINMAXINFO, "MY_WM_GETMINMAXINFO")
	$hMenuFont = _CreateMenuFont ($main_GUI, 'MS Sans Serif') ; Create a usable font for using in ownerdrawn menus
	WinSetOnTop($main_GUI, "", 1)
	
	; remember last clip viewer in queue and set our GUI as first in queue
	$origHWND = DllCall("user32.dll", "hwnd", "SetClipboardViewer", "hwnd", $main_GUI)
	$origHWND = $origHWND[0]
	
	; Register the messages for building and drawing ownerdrawn items
	GUIRegisterMsg($WM_MEASUREITEM, 'WM_MEASUREITEM_Event') ; Called by system at first for presetting the item properties
	GUIRegisterMsg($WM_DRAWITEM, 'WM_DRAWITEM_Event') ; Called by system to paint our items
	
	GUISetIcon(@SystemDir & "\clipbrd.exe", 0, $main_GUI)
	$menuFile = GUICtrlCreateMenu("文件[&F]")
	$menuItemInsert = _GUICtrlCreateMenuItem ('插入片断到 SCITE', $menuFile, 'shell32.dll', 100)
	$menuItemNewSnippet = _GUICtrlCreateMenuItem ('添加代码为片断', $menuFile, 'shell32.dll', 84)
	_GUICtrlCreateMenuItem ('', $menuFile) ; Separator
	$menuItemClipBoard = _GUICtrlCreateMenuItem ('复制到剪切板', $menuFile, @SystemDir & "\clipbrd.exe", 0)
	$menuItemClipGet = _GUICtrlCreateMenuItem ('从剪切板复制', $menuFile, @SystemDir & "\clipbrd.exe", 1)
	_GUICtrlCreateMenuItem ('', $menuFile) ; Separator
	$menuItemNewCategory = _GUICtrlCreateMenuItem ('创建一个新种类', $menuFile, 'shell32.dll', 54)
	_GUICtrlCreateMenuItem ('', $menuFile) ; Separator
	$menuItemImport = _GUICtrlCreateMenuItem ('输入 <- Au3', $menuFile, 'shell32.dll', 155)
	$menuItemExport = _GUICtrlCreateMenuItem ('输出 -> Au3', $menuFile, 'shell32.dll', 132)
	_GUICtrlCreateMenuItem ('', $menuFile) ; Separator
	$menuItemExit = _GUICtrlCreateMenuItem ('退出[&X]', $menuFile, 'shell32.dll', 27)
	
	$menuConfig = GUICtrlCreateMenu("设置[&C]")
	$menuItemSnippets = _GUICtrlCreateMenuItem ("选择片断文件夹", $menuConfig, 'shell32.dll', 38)
	_GUICtrlCreateMenuItem ('', $menuConfig) ; Separator
	$menuItemSelectTreeView = _GUICtrlCreateMenuItem ('修改到树状列表', $menuConfig, 'shell32.dll', 41)

	_GUICtrlCreateMenuItem ('', $menuConfig) ; Separator
	$menuItemToolTip = _GUICtrlCreateMenuItem('显示 "剪切板文本" ',$menuConfig)
	$chk_ToolTips = Int(IniRead($file, "~xx123Data", "Show ToolTips", 1))
	If $chk_ToolTips = 1 Then
		GUICtrlSetState($menuItemToolTip, $GUI_CHECKED)
	Else
		GUICtrlSetState($menuItemDockRight, $GUI_UNCHECKED)
	EndIf
	
	_GUICtrlCreateMenuItem ('', $menuConfig) ; Separator
	$menuDocking = _GUICtrlCreateMenu ('窗口位置', $menuConfig, 'shell32.dll', 98)
	$menuItemDockLeft = _GUICtrlCreateMenuItem ("左方", $menuDocking)
	$menuItemDockRight = _GUICtrlCreateMenuItem ("右方", $menuDocking)
	$DockItPos = IniRead($file, "~xx123Data", "Dock", 1)
	If $DockItPos = 1 Then
		GUICtrlSetState($menuItemDockLeft, $GUI_CHECKED)
	Else
		GUICtrlSetState($menuItemDockRight, $GUI_CHECKED)
	EndIf
	
	$h_ToolBar = _GuiCtrlToolBar_Create ($main_GUI, $BTNS_BUTTON)
	$hToolTip = _GUIToolTip_Create($h_ToolBar)
	_GUICtrlToolbar_SetToolTips($h_ToolBar, $hToolTip)
    ; Create normal image list
    $hImage = _GUIImageList_Create(17, 17, 5, 4)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 59)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 58)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 205)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 23)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 27)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 133)
    _GUICtrlToolbar_SetImageList($h_ToolBar, $hImage)
	
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_PASTE, 0)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_PASTE, "粘贴到SciTE")
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_COPY, 1)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_COPY, "从SciTE复制")
    _GUICtrlToolbar_AddButtonSep($h_ToolBar)
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_NEW, 2)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_NEW, "新分类")
    _GUICtrlToolbar_AddButtonSep($h_ToolBar)
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_ABOUT, 3)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_ABOUT, "关于 Snippet Holder")
    _GUICtrlToolbar_AddButtonSep($h_ToolBar)
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_EXIT, 4)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_EXIT, "退出 Snippet Holder")
	
	$cat_group = GUICtrlCreateGroup("分类", 5, 30, $PosW - 10, 60)
	$btnNewCat = GUICtrlCreateButton("新建", 70, 40, 30, 15)
	GUICtrlSetResizing($btnNewCat, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	$btnRenameCat = GUICtrlCreateButton("重命名", 110, 40, 30, 15)
	GUICtrlSetState($btnRenameCat, $GUI_DISABLE)
	GUICtrlSetResizing($btnRenameCat, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	$btnDeleteCat = GUICtrlCreateButton("删除", 150, 40, 30, 15)
	GUICtrlSetState($btnDeleteCat, $GUI_DISABLE)
	GUICtrlSetResizing($btnDeleteCat, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	$CodeFilter = GUICtrlCreateCombo("列出所有", 10, 60, $PosW - 20, 120, $CBS_DROPDOWNLIST)
	GUICtrlSetResizing($CodeFilter, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKRIGHT + $GUI_DOCKHEIGHT)
	GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group
	GUICtrlSetResizing($cat_group, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKRIGHT + $GUI_DOCKHEIGHT)
	
	$ib_search = GUICtrlCreateInput("", 10, 95, 100, 20)
	GUICtrlSetResizing($ib_search, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	$chk_fuzzy = GUICtrlCreateCheckbox("Fuzzy", 120, 95, 45, 20)
	GUICtrlSetResizing($chk_fuzzy, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	GUICtrlSetState($chk_fuzzy, $GUI_CHECKED)
	
	$Btn_Search = GUICtrlCreateButton("搜索", 170, 95, 60, 20)
	GUICtrlSetState($Btn_Search, $GUI_DISABLE)
	GUICtrlSetResizing($Btn_Search, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	
	$ListView = GUICtrlCreateListView("Entry Name|Category", 8, 130, $PosW - 42, $PosH - 160, BitOR($LVS_SORTASCENDING, $LVS_SINGLESEL))
	_GUICtrlListView_SetColumnWidth($ListView, 0, 100)
	_GUICtrlListView_SetColumnWidth($ListView, 1, 100)
	GUICtrlSendMsg($ListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
	GUICtrlSendMsg($ListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_FULLROWSELECT, $LVS_EX_FULLROWSELECT)
	GUICtrlSetResizing($ListView, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)
	
	$ContextMenuListView = GUICtrlCreateContextMenu($ListView)
	$menuItemInsertToSciTE = GUICtrlCreateMenuitem("发送到 SCITE", $ContextMenuListView)
	$menuItemAddNewSnippet = GUICtrlCreateMenuitem("在这里添加新片断", $ContextMenuListView)
	GUICtrlCreateMenuitem("", $ContextMenuListView)
	$menuItemSendToClipBoard = GUICtrlCreateMenuitem("发送到剪切板", $ContextMenuListView)
	$menuItemCopyClipBoard = GUICtrlCreateMenuitem("从剪切板复制", $ContextMenuListView)
	GUICtrlCreateMenuitem("", $ContextMenuListView)
	$menuItemPreview = GUICtrlCreateMenuitem("查看/编辑/删除片断", $ContextMenuListView)
	GUICtrlCreateMenuitem("", $ContextMenuListView)
	$menuItemImportSnippet = GUICtrlCreateMenuitem("输入 <- Au3", $ContextMenuListView)
	$menuItemExportSnippet = GUICtrlCreateMenuitem("输出 -> Au3", $ContextMenuListView)
	GUICtrlCreateMenuitem("", $ContextMenuListView)
	$menuItemRenameSnippet = GUICtrlCreateMenuitem("重命名片断", $ContextMenuListView)
	$menuItemDeleteSnippet = GUICtrlCreateMenuitem("删除片断", $ContextMenuListView)
	
	$Trans_slider = GUICtrlCreateSlider($PosW - 28, 130, 20, $PosH - 160, $TBS_VERT, $WS_EX_CLIENTEDGE)
	GUICtrlSetLimit($Trans_slider, 255, 62)  ; change min/max value
	GUICtrlSetData($Trans_slider, Int(IniRead($file, "~xx123Data", "Transparency", 255))); set cursor
	$Transparency = Int((((Int(GUICtrlRead($Trans_slider)) / 255) * 100) - 100) * - 1)
	WinSetTrans($main_GUI, "", Int(GUICtrlRead($Trans_slider)))
	GUICtrlSetResizing($Trans_slider, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH)
	
	; create a child window that can slide out from the left/right
	$GUI_Edit = GUICreate("源文件 查看/编辑 片断", 622, 506, -1, -1, $WS_CAPTION, -1, $main_GUI)
	$EnableEdit = GUICtrlCreateCheckbox("编辑源文件", 25, 10, 75, 15)
	$btn_InsertScite = GUICtrlCreateButton("插入到 SciTE", 25, 35, 120, 20)
	$btn_ClipBoard = GUICtrlCreateButton("复制到剪切板", 150, 35, 120, 20)
	
	$CodeEdit = GUICtrlCreateEdit("", 8, 70, 601, 371, -1, $WS_EX_CLIENTEDGE)
	GUICtrlCreateLabel("片断名称:", 344, 11, 85, 17)
	$SnippetName = GUICtrlCreateInput("", 432, 8, 177, 21)
	GUICtrlCreateLabel("片断分类:", 344, 41, 85, 17)
	$SnippetCat = GUICtrlCreateCombo("", 432, 38, 177, 120)
	$btnSaveSnippet = GUICtrlCreateButton("保存片断", 75, 460, 113, 33)
	GUICtrlSetState($btnSaveSnippet, $GUI_DISABLE)
	$btnDelSnippet = GUICtrlCreateButton("删除片断", 260, 460, 113, 33)
	$btnCloseSnippet = GUICtrlCreateButton("取消", 434, 460, 113, 33)
	
	_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
	
	$StatusBar = _GuiCtrlStatusBar_Create($main_GUI, -1, -1)
	_GuiCtrlStatusBar_SetSimple($StatusBar)
	GUICtrlSetResizing($StatusBar, $GUI_DOCKSTATEBAR)
	
	GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, True, 0)
	GUICtrlSetBkColor($CodeEdit, 0xFFFFFF)
	GUISetState(@SW_HIDE, $GUI_Edit)
	
	GUISwitch($main_GUI)
	$WinPos = WinGetPos($main_GUI)
	$x1 = $WinPos[0]
	$y1 = $WinPos[1]
	GUISetState(@SW_SHOW, $main_GUI)
	
	$tmp_sel = $LV_ERR
	If $DockItPos Then
		_KeepWindowsDocked($GUI_Edit, $main_GUI, $Dock, $x1, $x2, $y1, $y2)
	Else
		_KeepWindowsDocked($main_GUI, $GUI_Edit, $Dock, $x1, $x2, $y1, $y2)
	EndIf
	;Register WM_NOTIFY  events
	GUIRegisterMsg($WM_NOTIFY, "WM_Notify_Events")
	;Register WM_COMMAND  events
	GUIRegisterMsg($WM_COMMAND, "MY_WM_COMMAND")
	;Register clipboard  events
	GUIRegisterMsg($WM_DRAWCLIPBOARD, "OnClipBoardChange")
	GUIRegisterMsg($WM_CHANGECBCHAIN, "OnClipBoardViewerChange")
	;Register resize/move events
	GUIRegisterMsg($WM_MOVE, "_WinMoved")
	GUIRegisterMsg($WM_SIZE, "_WinResized")
	
	$dll_mem = DllOpen(@SystemDir & "\psapi.dll")
	If $dll_mem <> - 1 Then AdlibRegister("_ReduceMemory", 60000)
	While 1
		
		$msg = GUIGetMsg()
		
		Select
			;-----------------------------------------------------------------------------------------
			;This case statement exits
			Case $msg = $menuItemExit Or $msg = $GUI_EVENT_CLOSE
				Exit
				
			Case $msg = $CodeFilter
				;----------------------------------------------------------------------------------------------
				;This Case will show either all snippet names or just the names from a specific category
				GUICtrlSetData($CodeEdit, "")
				$tmp_sel = $LV_ERR
				If GUICtrlRead($CodeFilter) = "List All" Then
					_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
					GUICtrlSetState($btnRenameCat, $GUI_DISABLE)
					GUICtrlSetState($btnDeleteCat, $GUI_DISABLE)
				Else
					_IniGetSectionsListView($ListView, $CodeFilter, $file)
					GUICtrlSetState($btnRenameCat, $GUI_ENABLE)
					GUICtrlSetState($btnDeleteCat, $GUI_ENABLE)
				EndIf
				
			Case $msg = $Btn_Search
				_LocateSnippet($ListView, GUICtrlRead($ib_search), BitAND(GUICtrlRead($chk_fuzzy), $GUI_CHECKED))
				
			Case $msg = $Trans_slider
				IniWrite($file, "~xx123Data", "Transparency", GUICtrlRead($Trans_slider))
				
			Case $msg = $menuItemImport Or $msg = $menuItemImportSnippet
				If ImportSnippet($main_GUI, $import_folder) Then
					_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
					$tmp_sel = $LV_ERR
				EndIf
				
			Case $msg = $menuItemExport Or $msg = $menuItemExportSnippet
				_ExportSnippet()
				
			Case $msg = $menuItemSnippets
				_SetSnippetDir()
				
			Case $msg = $menuItemSelectTreeView
				IniWrite($file, "~xx123Data", "View", 0)
				Run('"' & @ScriptDir & '\CSnippet.exe" /Restart')
				Exit
			
			Case $msg = $menuItemToolTip
				$chk_ToolTips = ToggleCheck($menuItemToolTip)
				IniWrite($file, "~xx123Data", "Show ToolTips", $chk_ToolTips)


			Case $msg = $menuItemDockLeft Or $msg = $menuItemDockRight
				$DockItPos = ToggleCheck($menuItemDockLeft)
				ToggleCheck($menuItemDockRight)
				IniWrite($file, "~xx123Data", "Dock", $DockItPos)
				
				;----------------------------------------------------------------------------------------------
				;This Case will create a new Section Name in the Snippets.ini file which will then be
				;Read as a new Category in the ListView
			Case $msg = $menuItemNewCategory	Or $msg = $btnNewCat
				_NewCategory()
				
				;----------------------------------------------------------------------------------------------
				;This Case will add a new Key name and Key Value into the Snippets.ini file
				;Any CRLF's that are found will be replaced with a "Substitute" character so they will fit on
				; one line in the ini file
				;This data will then be read as a new Snippet and added to the ListView under the proper Category
			Case $msg = $menuItemNewSnippet Or $msg = $menuItemAddNewSnippet
				_NewSnippet($btnSaveSnippet)
				
			Case $msg = $menuItemClipGet Or $msg = $menuItemCopyClipBoard
				_ClipGet()
				
				;----------------------------------------------------------------------------------------------------
				;This Case will add a stored snippet into the SciTE Scintilla1 control at the current cursor location
				;The INI file is read and the "Substitute" character is replaced with the origional CRLF's and then
				; pasted into SciTE
			Case $msg = $btn_InsertScite
				_CopyToScite()
				
			Case $msg = $btn_ClipBoard
				_CopyToClipBoard()
				
			Case $msg = $menuItemInsertToSciTE Or $msg = $menuItemInsert
				_SendToSciTE()
				
			Case $msg = $menuItemSendToClipBoard Or $msg = $menuItemClipBoard
				_SendToClipBoard()
				
			Case $msg = $menuItemPreview
				_PreviewSnippet()
				
			Case $msg = $menuItemRenameSnippet
				If Not _GUICtrlEdit_GetModify($CodeEdit) Then
					_ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
					$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
					$old_name = _GUICtrlListView_GetItemText($ListView, $tmp_sel)
					$tmp_cat = _GUICtrlListView_GetItemText($ListView, $tmp_sel, 1)
					$dtaRename = InputBox("重命名片断", "请输入一个新的名称", $old_name, "", 240, 60)
					If @error == 0 Then
						IniDelete($file, $tmp_cat, $old_name & Chr(160))
						IniWrite($file, $tmp_cat, $dtaRename & Chr(160), "")
						FileMove($snips_dir & '\' & $tmp_cat & '\' & $old_name & '.xml', $snips_dir & '\' & $tmp_cat & '\' & $dtaRename & '.xml', 1)
						_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
						$tmp_sel = $LV_ERR
					EndIf
				Else
					MsgBox(16 + 262144, "错误", "请先保存片断")
				EndIf
				
			Case $msg = $menuItemDeleteSnippet
				$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
				$tmp_name = _GUICtrlListView_GetItemText($ListView, $tmp_sel)
				$tmp_cat = _GUICtrlListView_GetItemText($ListView, $tmp_sel, 1)
				$Confirm = MsgBox(52 + 262144, "Confirm Snippet Delete", "Are you sure you want to Delete the Snippet " & $tmp_name)
				If $Confirm = 6 Then
					IniDelete($file, $tmp_cat, $tmp_name & Chr(160))
					FileDelete($snips_dir & "\" & $tmp_cat & '\' & $tmp_name & '.xml')
					_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
					$tmp_sel = $LV_ERR
				EndIf

				;-----------------------------------------------------------------------------------------
				;This Case statement is used to rename a Category
			Case $msg = $btnRenameCat
				If GUICtrlRead($CodeFilter) = "List All" Then
					MsgBox(16 + 262144, "Error", "Please select a Category to Rename")
				ElseIf Not _GUICtrlEdit_GetModify($CodeEdit) Then
					$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
					$old_name = GUICtrlRead($CodeFilter)
					$dtaRename = InputBox("Rename Category", "Please type the new Category Name", $old_name, "", 240, 60)
					If @error == 0 Then
						If Not IniRenameSection($file, $old_name, $dtaRename, 0) Then
							IniReadSection($file, $old_name)
							If @error Then
								IniWrite($file, $old_name, "dummy" & Chr(160), 0)
								If Not IniRenameSection($file, $old_name, $dtaRename, 0) Then
									MsgBox(16 + 262144, "Error", "Rename Failed")
								Else
									IniDelete($file, $dtaRename, "dummy" & Chr(160))
									DirMove($snips_dir & '\' & $old_name, $snips_dir & '\' & $dtaRename, 1)
								EndIf
							EndIf
						EndIf
						GUICtrlSetData($CodeEdit, "", "")
						_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
						_GuiCtrlStatusBar_SetText($StatusBar, "", $SB_SIMPLEID)
						$tmp_sel = $LV_ERR
					EndIf
				Else
					MsgBox(16 + 262144, "Error", "Save Snippet first")
				EndIf
				
				;-----------------------------------------------------------------------------------------
				;This Case statement is used to delete a Category
			Case $msg = $btnDeleteCat
				If GUICtrlRead($CodeFilter) = "List All" Then
					MsgBox(16 + 262144, "Error", "Please select a Category to Delete")
				Else
					$tmp_cat = GUICtrlRead($CodeFilter)
					$Confirm = MsgBox(52 + 262144, "Confirm Category Delete", "Are you sure you want to Delete the Category " & $tmp_cat)
					If $Confirm = 6 Then
						IniDelete($file, $tmp_cat)
						GUICtrlSetData($CodeEdit, "", "")
						GUICtrlSetData($CodeFilter, "List All")
						_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
						$tmp_sel = $LV_ERR
					EndIf
				EndIf
				
				;-----------------------------------------------------------------------------------------
				;This Case statement is used to delete a snippet
			Case $msg = $btnDelSnippet
				_DeleteSnippet($btnSaveSnippet)
				
			Case $msg = $EnableEdit
				_EnableDisableEdit($btnSaveSnippet)
				
			Case $msg = $SnippetCat
				$Selected_Cat = GUICtrlRead($SnippetCat)
				If $Selected_Cat <> $tmp_cat Then
					_GUICtrlEdit_SetModify($CodeEdit, True)
					GUICtrlSetState($btnSaveSnippet, $GUI_ENABLE)
				EndIf
				
			Case $msg = $btnSaveSnippet
				_SaveSnippet($btnSaveSnippet)
				
			Case $msg = $btnCloseSnippet
				_ClosePreview($btnSaveSnippet)
				
			Case $msg = $GUI_EVENT_PRIMARYDOWN And Not $Init_Preview; this is for hiding the Edit/View Script window
				If BitAND(WinGetState($main_GUI), 8) And _
						Not _GUICtrlEdit_GetModify($CodeEdit) And _
						BitAND(WinGetState($GUI_Edit), 2) Then _ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)

			Case $msg = $GUI_EVENT_PRIMARYDOWN And $Init_Preview
				$Init_Preview = False

			Case $ClipEvent = 1
				_GetClipBoardData()
				
			Case WinExists("Alt+Shift+c 'copy into Snippet Holder'" & @LF & "Alt+Shift+t 'close this tip window'" & @LF & "Alt+Shift+r 'Run'" & @LF & "Alt+Shift+b 'beta Run'") = 1
				If Not $Clip_Timer Then $Clip_Timer = @SEC
				If @SEC > $Clip_Timer + 10 Then
					ToolTip("")
					$Clip_Timer = 0
				EndIf
				
			Case $Transparency <> Int((((Int(GUICtrlRead($Trans_slider)) / 255) * 100) - 100) * - 1)
				$Transparency = Int((((Int(GUICtrlRead($Trans_slider)) / 255) * 100) - 100) * - 1)
				_GuiCtrlStatusBar_SetText($StatusBar, "Transparency %" & $Transparency, $SB_SIMPLEID)
				WinSetTrans($main_GUI, "", Int(GUICtrlRead($Trans_slider)))
				
			Case ProcessExists("SciTE.exe") = 0
				Exit
				
				;Check for any new snippet added to the INI from the Command line
			Case FileExists($copy_file) = 1
				_GetNewSnippet($CMDtmp, $CmdClean, $btnSaveSnippet, $copy_file)
				
			Case BitAND(WinGetState($GUI_Edit), 2) = 2 And _
					($tmp_cat <> GUICtrlRead($SnippetCat) Or $tmp_name <> GUICtrlRead($SnippetName)) Or _
					_GUICtrlEdit_GetModify($CodeEdit) > 0 And BitAND(GUICtrlGetState($btnSaveSnippet), $GUI_DISABLE) = $GUI_DISABLE
				GUICtrlSetState($btnSaveSnippet, $GUI_ENABLE)
		EndSelect
	WEnd
EndFunc   ;==>_MainListView

Func ListView_Click()
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then	_DebugPrint ("$NM_CLICK")
	;----------------------------------------------------------------------------------------------
	If Not _GUICtrlEdit_GetModify($CodeEdit) Then _ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
EndFunc   ;==>ListView_Click

Func ListView_DoubleClick()
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then	_DebugPrint ("$NM_DBLCLK")
	;----------------------------------------------------------------------------------------------
	If Not _GUICtrlEdit_GetModify($CodeEdit) Then
		$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
		If $tmp_sel <> - 1 Then
			$tmp_name = _GUICtrlListView_GetItemText($ListView, $tmp_sel)
			$tmp_cat = _GUICtrlListView_GetItemText($ListView, $tmp_sel, 1)
			If $tmp_cat = "" Then $tmp_cat = GUICtrlRead($CodeFilter)
			GUICtrlSetData($CodeEdit, LoadSnippet($tmp_cat, $tmp_name))
			GUICtrlSetData($SnippetName, $tmp_name)
			_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
			_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
			_GUICtrlEdit_SetModify($CodeEdit, False)
			GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, True, 0)
			GUICtrlSetState($EnableEdit, $GUI_UNCHECKED)
			_ShowPreview($GUI_Edit, $DockItPos, $Dock)
			$Init_Preview = True
		EndIf
	EndIf
EndFunc   ;==>ListView_DoubleClick

;===================================================================================
;Retrieve the key names for a specific section from the Snippets.ini file
;The data will then be populated into the ListView in the GUIMain window
;===================================================================================
Func _IniGetSectionsListView(ByRef $ListView, ByRef $CodeFilter, ByRef $file)
	Local $PosW = WinGetPos($main_GUI, "")
	Local $Section = GUICtrlRead($CodeFilter)
	GUISetState(@SW_LOCK)
		Local $iCount = _GUICtrlListView_GetItemCount($ListView)
		For $x = $iCount -1 To 0 Step -1
			GUICtrlDelete(_GUICtrlListView_GetItemParam($ListView, $x))
		Next
;~ 	_GUICtrlListView_DeleteAllItems($ListView)
	Local $var = IniReadSection($file, $Section)
	If Not @error Then
		For $i = 1 To $var[0][0]
			$var[$i][0] = StringReplace($var[$i][0], Chr(160), "")
			GUICtrlCreateListViewItem($var[$i][0] & "|" & $Section, $ListView)
		Next
	EndIf
	_GUICtrlListView_SetColumnWidth($ListView, 0, $PosW[2] - 55)
	_GUICtrlListView_HideColumn($ListView, 1)
	GUISetState(@SW_UNLOCK)
EndFunc   ;==>_IniGetSectionsListView

;===================================================================================
;Retrieve all section names and key names from the Snippets.ini file
;This will ignore only the ~xx123Data section in the INI
;The data will then be populated into the ListView in the GUIMain window
;===================================================================================
Func _IniGetSectionNamesListView(ByRef $ListView, ByRef $CodeFilter, ByRef $SnippetCat, ByRef $file)
	If GUICtrlRead($CodeFilter) <> "List All" Then
		_IniGetSectionsListView($ListView, $CodeFilter, $file)
		Return
	EndIf
	Local $varx = IniReadSectionNames($file)
	Local $tmp_combo = "|List All|", $var
	If Not @error Then
		If $sub_dirs == 0 Then _MoveToSubDirs($varx)
		GUISetState(@SW_LOCK)
		Local $iCount = _GUICtrlListView_GetItemCount($ListView)
		For $x = $iCount -1 To 0 Step -1
			GUICtrlDelete(_GUICtrlListView_GetItemParam($ListView, $x))
		Next
;~ 		_GUICtrlListView_DeleteAllItems($ListView)
		For $x = 1 To $varx[0]
			If $varx[$x] <> "~xx123Data" Then
				$tmp_combo = $tmp_combo & $varx[$x] & "|"
				$var = IniReadSection($file, $varx[$x])
				If Not @error Then
					If IsArray($var) Then
						For $i = 1 To $var[0][0]
							$var[$i][0] = StringReplace($var[$i][0], Chr(160), "")
							GUICtrlCreateListViewItem($var[$i][0] & "|" & $varx[$x], $ListView)
						Next
					EndIf
				EndIf
			EndIf
		Next
		$tmp_combo = StringTrimRight($tmp_combo, 1)
		GUICtrlSetData($CodeFilter, $tmp_combo, "List All")
		GUICtrlSetData($SnippetCat, StringReplace($tmp_combo, "List All|", ""))
		_GUICtrlListView_SetColumnWidth($ListView, 1, 100)
		GUISetState(@SW_UNLOCK)
	EndIf
EndFunc   ;==>_IniGetSectionNamesListView

Func _Input_Changed()
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then	_DebugPrint ("Input Changed:" & GUICtrlRead($ib_search))
	;----------------------------------------------------------------------------------------------
	If StringLen(GUICtrlRead($ib_search)) And BitAND(GUICtrlGetState($Btn_Search), $GUI_DISABLE) Then
		GUICtrlSetState($Btn_Search, $GUI_ENABLE)
		GUICtrlSetState($Btn_Search, $GUI_DEFBUTTON)
	ElseIf StringLen(GUICtrlRead($ib_search)) = 0 And BitAND(GUICtrlGetState($Btn_Search), $GUI_ENABLE) Then
		GUICtrlSetState($Btn_Search, $GUI_DISABLE)
	EndIf
EndFunc   ;==>_Input_Changed
#endregion End ListView Gui section

#region Begin TreeView Gui section
Func _MainTreeView(ByRef $copy_file)
	#region Begin Delcare Local Variables
	Local $menuFile, $menuItemNewSnippet, $menuItemNewCategory, $menuItemInsert, $menuItemListView
	Local $ContextMenuTreeView, $menuItemAddNewSnippet, $menuConfig, $menuItemToolTip
	Local $menuDocking, $menuItemDockLeft, $menuItemDockRight
	Local $menuItemPreview, $menuItemInsertToSciTE, $menuItemRenameSnippet, $menuItemDeleteSnippet
	Local $menuTreeViewColor, $menuItemImport, $menuItemExport, $menuItemSnippets, $menuItemImportSnippet, $menuItemExportSnippet
	Local $menuItemClipBoard, $menuItemSendToClipBoard, $Confirm, $Selected_Cat, $CMDtmp, $CmdClean
	Local $menuItemCopyClipBoard, $menuItemClipGet, $PosX, $PosY, $PosW, $PosH
	Local $btnSaveSnippet, $btnCloseSnippet, $btn_InsertScite, $btn_ClipBoard, $Clip_Timer = 0
	Local $WinPos, $dtaRename, $SciTE, $import_folder, $Selected, $Parent, $color, $Transparency, $msg
	Local $hImage
	#endregion End Declare Local Variables
	$LineColor = 0xDC143C
	$BackColor = 0x40e0d0
	$ForeColor = 0x000000
	If Not FileExists(@ScriptDir & '\filetype1.ico') Then FileInstall('filetype1.ico', @ScriptDir & '\filetype1.ico')
	$export_folder = IniRead($file, "~xx123Data", "ExportDir", @ScriptDir)
	$import_folder = IniRead($file, "~xx123Data", "ImportDir", @ScriptDir)
	
	_SizeWindow($PosX, $PosY, $PosW, $PosH, $file) ;Retrieve pos and size of window from INI
	WinWaitActive("SciTE", "Source", 30)
	$SciTE = WinGetHandle("SciTE", "Source")
	$main_GUI = GUICreate("Code Snippet", $PosW, $PosH + 17, $PosX, $PosY, BitOR($WS_THICKFRAME, $WS_SIZEBOX, $WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS), $WS_EX_MDICHILD, $SciTE)
	GUIRegisterMsg($WM_GETMINMAXINFO, "MY_WM_GETMINMAXINFO")
	
	; remember last clip viewer in queue and set our GUI as first in queue
	$origHWND = DllCall("user32.dll", "hwnd", "SetClipboardViewer", "hwnd", $main_GUI)
	$origHWND = $origHWND[0]
	
	$hMenuFont = _CreateMenuFont ($main_GUI, 'MS Sans Serif') ; Create a usable font for using in ownerdrawn menus
	
	; Register the messages for building and drawing ownerdrawn items
	GUIRegisterMsg($WM_MEASUREITEM, 'WM_MEASUREITEM_Event') ; Called by system at first for presetting the item properties
	GUIRegisterMsg($WM_DRAWITEM, 'WM_DRAWITEM_Event') ; Called by system to paint our items
	
	GUISetIcon(@SystemDir & "\clipbrd.exe", 0, $main_GUI)
	
	$menuFile = GUICtrlCreateMenu("文件[&F]")
	$menuItemInsert = _GUICtrlCreateMenuItem ('插入片断到 SCITE', $menuFile, 'shell32.dll', 100)
	$menuItemNewSnippet = _GUICtrlCreateMenuItem ('添加 SCITE 代码作为片断', $menuFile, 'shell32.dll', 84)
	_GUICtrlCreateMenuItem ('', $menuFile) ; Separator
	$menuItemClipBoard = _GUICtrlCreateMenuItem ('复制到剪切板', $menuFile, @SystemDir & "\clipbrd.exe", 0)
	$menuItemClipGet = _GUICtrlCreateMenuItem ('从剪切板复制', $menuFile, @SystemDir & "\clipbrd.exe", 1)
	_GUICtrlCreateMenuItem ('', $menuFile) ; Separator
	$menuItemNewCategory = _GUICtrlCreateMenuItem ('创建新的类型', $menuFile, 'shell32.dll', 54)
	_GUICtrlCreateMenuItem ('', $menuFile) ; Separator
	$menuItemImport = _GUICtrlCreateMenuItem ('输入 <- Au3', $menuFile, 'shell32.dll', 155)
	$menuItemExport = _GUICtrlCreateMenuItem ('输出 -> Au3', $menuFile, 'shell32.dll', 132)
	_GUICtrlCreateMenuItem ('', $menuFile) ; Separator
	$menuItemExit = _GUICtrlCreateMenuItem ('退出[&X]', $menuFile, 'shell32.dll', 27)
	
	$menuConfig = GUICtrlCreateMenu("设置[&C]")
	$menuItemSnippets = _GUICtrlCreateMenuItem ("选择片断文件夹", $menuConfig, 'shell32.dll', 38)
	_GUICtrlCreateMenuItem ('', $menuConfig) ; Separator
	$menuItemListView = _GUICtrlCreateMenuItem ('List View', $menuConfig, 'shell32.dll', 39)
	
	_GUICtrlCreateMenuItem ('', $menuConfig) ; Separator
	$menuItemToolTip = _GUICtrlCreateMenuItem('Show "New Clip Text"',$menuConfig)
	$chk_ToolTips = Int(IniRead($file, "~xx123Data", "Show ToolTips", 1))
	If $chk_ToolTips = 1 Then
		GUICtrlSetState($menuItemToolTip, $GUI_CHECKED)
	Else
		GUICtrlSetState($menuItemToolTip, $GUI_UNCHECKED)
	EndIf
	
	_GUICtrlCreateMenuItem ('', $menuConfig) ; Separator
	$menuDocking = _GUICtrlCreateMenu ('显示位置', $menuConfig, 'shell32.dll', 98)
	$menuItemDockLeft = _GUICtrlCreateMenuItem ("左方", $menuDocking)
	$menuItemDockRight = _GUICtrlCreateMenuItem ("右方", $menuDocking)
	$DockItPos = IniRead($file, "~xx123Data", "Dock", 1)
	If $DockItPos = 1 Then
		GUICtrlSetState($menuItemDockLeft, $GUI_CHECKED)
	Else
		GUICtrlSetState($menuItemDockRight, $GUI_CHECKED)
	EndIf
	
	_GUICtrlCreateMenuItem ('', $menuConfig) ; Separator
	$menuTreeViewColor = _GUICtrlCreateMenu ('选择树形列表颜色', $menuConfig, 'shell32.dll', 161)
	$menuTreeViewBKColor = _GUICtrlCreateMenuItem ('背景色', $menuTreeViewColor)
	$menuTreeViewFGColor = _GUICtrlCreateMenuItem ("前景色", $menuTreeViewColor)
	$menuTreeViewLineColor = _GUICtrlCreateMenuItem ("行线颜色", $menuTreeViewColor)
	
	$h_ToolBar = _GuiCtrlToolBar_Create ($main_GUI, $BTNS_BUTTON)
	$hToolTip = _GUIToolTip_Create($h_ToolBar)
	_GUICtrlToolbar_SetToolTips($h_ToolBar, $hToolTip)
    ; Create normal image list
    $hImage = _GUIImageList_Create(17, 17, 5, 4)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 59)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 58)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 205)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 78)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 23)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 27)
    _GUIImageList_AddIcon ($hImage, @SystemDir & "\shell32.dll", 133)
    _GUICtrlToolbar_SetImageList($h_ToolBar, $hImage)

    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_PASTE, 0)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_PASTE, "粘贴到SciTE")
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_COPY, 1)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_COPY, "从SciTE复制")
    _GUICtrlToolbar_AddButtonSep($h_ToolBar)
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_NEW, 2)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_NEW, "新分类")
    _GUICtrlToolbar_AddButtonSep($h_ToolBar)
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_ABOUT, 4)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_ABOUT, "关于 Snippet Holder")
    _GUICtrlToolbar_AddButtonSep($h_ToolBar)
    _GUICtrlToolbar_AddButton($h_ToolBar, $IDM_EXIT, 5)
	 _GUICtrlToolbar_SetButtonText($h_ToolBar, $IDM_EXIT, "退出 Snippet Holder")

	$BackColor = IniRead($file, "~xx123Data", "BackColor", $BackColor)
	$LineColor = IniRead($file, "~xx123Data", "LineColor", $LineColor)
	$ForeColor = IniRead($file, "~xx123Data", "ForeColor", $ForeColor)
	
	$ib_search = GUICtrlCreateInput("", 10, 30, 100, 20)
	GUICtrlSetResizing($ib_search, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	
	$chk_fuzzy = GUICtrlCreateCheckbox("Fuzzy", 120, 30, 45, 20)
	GUICtrlSetState($chk_fuzzy, $GUI_CHECKED)
	GUICtrlSetResizing($chk_fuzzy, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	
	$Btn_Search = GUICtrlCreateButton("搜索", 170, 30, 60, 20)
	GUICtrlSetState($Btn_Search, $GUI_DISABLE)
	GUICtrlSetResizing($Btn_Search, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)
	
	$TreeView = GUICtrlCreateTreeView(5, 55, $PosW - 30, $PosH - 85, _
			BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_CLIENTEDGE)
	_GUICtrlTreeView_SetBkColor($TreeView, $BackColor)
	_GUICtrlTreeView_SetTextColor($TreeView, $ForeColor)
	_GUICtrlTreeView_SetLineColor($TreeView, $LineColor)
	$ContextMenuTreeView = GUICtrlCreateContextMenu($TreeView)
	$menuItemInsertToSciTE = GUICtrlCreateMenuitem("Send to SCITE", $ContextMenuTreeView)
	$menuItemAddNewSnippet = GUICtrlCreateMenuitem("Add new Snippet Here", $ContextMenuTreeView)
	GUICtrlCreateMenuitem("", $ContextMenuTreeView)
	$menuItemSendToClipBoard = GUICtrlCreateMenuitem("Send to ClipBoard", $ContextMenuTreeView)
	$menuItemCopyClipBoard = GUICtrlCreateMenuitem("Copy From ClipBoard", $ContextMenuTreeView)
	GUICtrlCreateMenuitem("", $ContextMenuTreeView)
	$menuItemPreview = GUICtrlCreateMenuitem("View/Edit/Delete Snippet", $ContextMenuTreeView)
	GUICtrlCreateMenuitem("", $ContextMenuTreeView)
	$menuItemImportSnippet = GUICtrlCreateMenuitem("Import <- Au3", $ContextMenuTreeView)
	$menuItemExportSnippet = GUICtrlCreateMenuitem("Export -> Au3", $ContextMenuTreeView)
	GUICtrlCreateMenuitem("", $ContextMenuTreeView)
	$menuItemRenameSnippet = GUICtrlCreateMenuitem("Rename Selection", $ContextMenuTreeView)
	$menuItemDeleteSnippet = GUICtrlCreateMenuitem("Delete Selection", $ContextMenuTreeView)
	GUICtrlSetResizing($TreeView, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)
	
	$Trans_slider = GUICtrlCreateSlider($PosW - 23, 55, 20, $PosH - 85, $TBS_VERT, $WS_EX_CLIENTEDGE)
	GUICtrlSetLimit($Trans_slider, 255, 62)  ; change min/max value
	GUICtrlSetData($Trans_slider, Int(IniRead($file, "~xx123Data", "Transparency", 255))); set cursor
	$Transparency = Int((((Int(GUICtrlRead($Trans_slider)) / 255) * 100) - 100) * - 1)
	WinSetTrans($main_GUI, "", Int(GUICtrlRead($Trans_slider)))
	GUICtrlSetResizing($Trans_slider, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH)
	
	; create a child window that can slide out from the left/right
	$GUI_Edit = GUICreate("Source Code View/Edit Snippet", 622, 506, -1, -1, $WS_CAPTION, -1, $main_GUI)
	$EnableEdit = GUICtrlCreateCheckbox("Edit Source", 25, 10, 75, 15)
	$btn_InsertScite = GUICtrlCreateButton("Insert Into SciTE", 25, 35, 120, 20)
	$btn_ClipBoard = GUICtrlCreateButton("Copy To ClipBoard", 150, 35, 120, 20)
	$CodeEdit = GUICtrlCreateEdit("", 8, 70, 601, 371, BitOR($ES_MULTILINE, $ES_LEFT, $ES_AUTOHSCROLL, $WS_VSCROLL, $WS_HSCROLL), $WS_EX_CLIENTEDGE)
	GUICtrlCreateLabel("Snippet Name:", 344, 11, 85, 17)
	$SnippetName = GUICtrlCreateInput("", 432, 8, 177, 21)
	GUICtrlCreateLabel("Snippet Category", 344, 41, 85, 17)
	$SnippetCat = GUICtrlCreateCombo("", 432, 38, 177, 120)
	$btnSaveSnippet = GUICtrlCreateButton("Save Snippet", 75, 460, 113, 33)
	GUICtrlSetState($btnSaveSnippet, $GUI_DISABLE)
	$btnDelSnippet = GUICtrlCreateButton("Delete Snippet", 260, 460, 113, 33)
	$btnCloseSnippet = GUICtrlCreateButton("Cancel", 434, 460, 113, 33)
	
	_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
	
	$StatusBar = _GuiCtrlStatusBar_Create($main_GUI, -1, -1)
	_GuiCtrlStatusBar_SetSimple($StatusBar)
	GUICtrlSetResizing($StatusBar, $GUI_DOCKSTATEBAR)
	
	GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, True, 0)
	GUICtrlSetBkColor($CodeEdit, 0xFFFFFF)
	GUISetState(@SW_HIDE, $GUI_Edit)
	
	GUISwitch($main_GUI)
	$WinPos = WinGetPos($main_GUI)
	$x1 = $WinPos[0]
	$y1 = $WinPos[1]
	
	GUISetState(@SW_SHOW, $main_GUI)
	
	If $DockItPos Then
		_KeepWindowsDocked($GUI_Edit, $main_GUI, $Dock, $x1, $x2, $y1, $y2)
	Else
		_KeepWindowsDocked($main_GUI, $GUI_Edit, $Dock, $x1, $x2, $y1, $y2)
	EndIf
	;Register WM_NOTIFY  events
	GUIRegisterMsg($WM_NOTIFY, "WM_Notify_Events")
	;Register WM_COMMAND  events
	GUIRegisterMsg($WM_COMMAND, "MY_WM_COMMAND")
	;Register clipboard  events
	GUIRegisterMsg($WM_DRAWCLIPBOARD, "OnClipBoardChange")
	GUIRegisterMsg($WM_CHANGECBCHAIN, "OnClipBoardViewerChange")
	;Register resize/move events
	GUIRegisterMsg($WM_MOVE, "_WinMoved")
	GUIRegisterMsg($WM_SIZE, "_WinResized")
	
	$dll_mem = DllOpen(@SystemDir & "\psapi.dll")
	If $dll_mem <> - 1 Then AdlibRegister("_ReduceMemory", 60000)
	While 1
		
		$msg = GUIGetMsg()
		
		Select
			;-----------------------------------------------------------------------------------------
			;This case statement exits
			Case $msg = $menuItemExit Or $msg = $GUI_EVENT_CLOSE
				Exit
				
			Case $msg = $Btn_Search
				_LocateSnippet($TreeView, GUICtrlRead($ib_search), BitAND(GUICtrlRead($chk_fuzzy), $GUI_CHECKED))
				
			Case $msg = $Trans_slider
				IniWrite($file, "~xx123Data", "Transparency", GUICtrlRead($Trans_slider))
				
			Case $msg = $menuTreeViewBKColor
				$color = _ChooseColor(2, $BackColor, 2) ; default color selected using RGB hex value
				If Not @error Then
					$BackColor = $color
					_GUICtrlTreeView_SetBkColor($TreeView, $BackColor)
					IniWrite($file, "~xx123Data", "BackColor", $BackColor)
				EndIf
				
			Case $msg = $menuTreeViewLineColor
				$color = _ChooseColor(2, $LineColor, 2) ; default color selected using RGB hex value
				If Not @error Then
					$LineColor = $color
					_GUICtrlTreeView_SetLineColor($TreeView, $LineColor)
					IniWrite($file, "~xx123Data", "LineColor", $LineColor)
				EndIf
				
			Case $msg = $menuTreeViewFGColor
				$color = _ChooseColor(2, $ForeColor, 2) ; default color selected using RGB hex value
				If Not @error Then
					$ForeColor = $color
					_GUICtrlTreeView_SetTextColor($TreeView, $ForeColor)
					IniWrite($file, "~xx123Data", "ForeColor", $ForeColor)
				EndIf
				
			Case $msg = $menuItemImport Or $msg = $menuItemImportSnippet
				If ImportSnippet($main_GUI, $import_folder) Then _IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
				
			Case $msg = $menuItemExport Or $msg = $menuItemExportSnippet
				_ExportSnippet()
				
			Case $msg = $menuItemSnippets
				_SetSnippetDir()
				
			Case $msg = $menuItemListView
				IniWrite($file, "~xx123Data", "View", 1)
				Run('"' & @ScriptDir & '\CSnippet.exe" /Restart')
				Exit

			Case $msg = $menuItemToolTip
				$chk_ToolTips = ToggleCheck($menuItemToolTip)
				IniWrite($file, "~xx123Data", "Show ToolTips", $chk_ToolTips)

			Case $msg = $menuItemDockLeft Or $msg = $menuItemDockRight
				$DockItPos = ToggleCheck($menuItemDockLeft)
				ToggleCheck($menuItemDockRight)
				IniWrite($file, "~xx123Data", "Dock", $DockItPos)
				
				;----------------------------------------------------------------------------------------------
				;This Case will create a new Section Name in the Snippets.ini file which will then be
				;Read as a new Category
			Case $msg = $menuItemNewCategory
				_NewCategory()
				
				;----------------------------------------------------------------------------------------------
				;This Case will add a new Key name and Key Value into the Snippets.ini file
				;Any CRLF's that are found will be replaced with a "Substitute" character so they will fit on
				; one line in the ini file
				;This data will then be read as a new Snippet and added to the ListView under the proper Category
			Case $msg = $menuItemNewSnippet Or $msg = $menuItemAddNewSnippet
				_NewSnippet($btnSaveSnippet)
				
			Case $msg = $menuItemClipGet Or $msg = $menuItemCopyClipBoard
				_ClipGet()
				
				;----------------------------------------------------------------------------------------------------
				;This Case will add a stored snippet into the SciTE Scintilla1 control at the current cursor location
				;The INI file is read and the "Substitute" character is replaced with the origional CRLF's and then
				; pasted into SciTE
			Case $msg = $btn_InsertScite
				_CopyToScite()
				
			Case $msg = $btn_ClipBoard
				_CopyToClipBoard()
				
			Case $msg = $menuItemInsert Or $msg = $menuItemInsertToSciTE
				_SendToSciTE()
				
			Case $msg = $menuItemSendToClipBoard Or $msg = $menuItemClipBoard
				_SendToClipBoard()
				
			Case $msg = $menuItemPreview
				_PreviewSnippet()
				
				;-----------------------------------------------------------------------------------------
				;This Case statement is used to rename a Category/Snippet
			Case $msg = $menuItemRenameSnippet
				$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
				If $Selected == "" Then
					MsgBox(16 + 262144, "Error", "Please select a Snippet")
				ElseIf StringRight($Selected, 1) <> Chr(160) Then
					$dtaRename = InputBox("Rename Category", "Please type the new Category Name", $Selected, "", 240, 60)
					If StringLen($dtaRename) Then
						If Not IniRenameSection($file, $Selected, $dtaRename, 0) Then
							IniReadSection($file, $Selected)
							If @error Then
								IniWrite($file, $Selected, "dummy" & Chr(160), 0)
								If Not IniRenameSection($file, $Selected, $dtaRename, 0) Then
									MsgBox(16 + 262144, "Error", "Rename Failed")
								Else
									IniDelete($file, $dtaRename, "dummy" & Chr(160))
									DirMove($snips_dir & '\' & $Selected, $snips_dir & '\' & $dtaRename, 1)
								EndIf
							EndIf
						EndIf
						If @error Then MsgBox(16 + 262144, "Error", "Rename Failed")
						_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
					EndIf
				Else
					$Parent = _GUICtrlTreeView_GetText($TreeView,_GUICtrlTreeView_GetParentParam($TreeView))
					$dtaRename = InputBox("Rename Snippet", "Please type the new Snippet Name", StringReplace($Selected,Chr(160),""), "", 240, 60)
					If StringLen($dtaRename) Then
						$RetrievedRaw = IniRead($file, $Parent, $Selected, "")
						IniDelete($file, $Parent, $Selected)
						IniWrite($file, $Parent, $dtaRename & Chr(160), "")
						FileMove($snips_dir & '\' & $Parent & '\' & StringReplace($Selected, Chr(160), "") & '.xml', $snips_dir & '\' & $Parent & '\' & $dtaRename & '.xml', 1)
						_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
					EndIf
				EndIf
				
				;-----------------------------------------------------------------------------------------
				;This Case statement is used to delete a Category/Snippet
			Case $msg = $menuItemDeleteSnippet
				$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
				If $Selected == "" Then
					MsgBox(16 + 262144, "Error", "Please select a Snippet or Category to Delete")
				ElseIf StringRight($Selected, 1) <> Chr(160) Then
					$Confirm = MsgBox(52 + 262144, "Confirm Category Delete", "Are you sure you want to Delete the Category " & $Selected)
					If $Confirm = 6 Then
						IniDelete($file, $Selected)
						_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
					EndIf
				Else
					$Confirm = MsgBox(52 + 262144, "Confirm Snippet Delete", "Are you sure you want to Delete the Snippet " & $Selected)
					If $Confirm = 6 Then
						$Parent = _GUICtrlTreeView_GetText($TreeView,_GUICtrlTreeView_GetParentParam($TreeView))
						IniDelete($file, $Parent, $Selected)
						FileDelete($snips_dir & "\" & StringReplace($Parent, Chr(160), "") & '\' & $Selected & '.xml')
						_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
					EndIf
				EndIf
				
				;-----------------------------------------------------------------------------------------
				;This Case statement is used to delete a snippet
			Case $msg = $btnDelSnippet
				_DeleteSnippet($btnSaveSnippet)
				
			Case $msg = $EnableEdit
				_EnableDisableEdit($btnSaveSnippet)
				
			Case $msg = $SnippetCat
				$Selected_Cat = GUICtrlRead($SnippetCat)
				If $Selected_Cat <> $tmp_cat Then
					_GUICtrlEdit_SetModify($CodeEdit, True)
					GUICtrlSetState($btnSaveSnippet, $GUI_ENABLE)
				EndIf
				
			Case $msg = $btnSaveSnippet
				_SaveSnippet($btnSaveSnippet)
				
			Case $msg = $btnCloseSnippet
				_ClosePreview($btnSaveSnippet)
				
			Case $msg = $GUI_EVENT_PRIMARYDOWN And Not $Init_Preview; this is for hiding the Edit/View Script window
				If BitAND(WinGetState($main_GUI), 8) And _
						Not _GUICtrlEdit_GetModify($CodeEdit) And _
						BitAND(WinGetState($GUI_Edit), 2) Then _ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)

			Case $msg = $GUI_EVENT_PRIMARYDOWN And $Init_Preview
				$Init_Preview = False

			Case $ClipEvent = 1
				_GetClipBoardData()
				
			Case WinExists("Alt+Shift+c 'copy into Snippet Holder'" & @LF & "Alt+Shift+t 'close this tip window'" & @LF & "Alt+Shift+r 'Run'" & @LF & "Alt+Shift+b 'beta Run'") = 1
				If Not $Clip_Timer Then $Clip_Timer = @SEC
				If @SEC > $Clip_Timer + 10 Then
					ToolTip("")
					$Clip_Timer = 0
				EndIf
				
			Case $Transparency <> Int((((Int(GUICtrlRead($Trans_slider)) / 255) * 100) - 100) * - 1)
				$Transparency = Int((((Int(GUICtrlRead($Trans_slider)) / 255) * 100) - 100) * - 1)
				_GuiCtrlStatusBar_SetText($StatusBar, "Transparency %" & $Transparency, $SB_SIMPLEID)
				WinSetTrans($main_GUI, "", Int(GUICtrlRead($Trans_slider)))
				
			Case ProcessExists("SciTE.exe") = 0
				Exit
				
				;Check for any new snippet added to the INI from the Command line
			Case FileExists($copy_file) = 1
				_GetNewSnippet($CMDtmp, $CmdClean, $btnSaveSnippet, $copy_file)
				
			Case BitAND(WinGetState($GUI_Edit), 2) = 2 And _
					($tmp_cat <> GUICtrlRead($SnippetCat) Or $tmp_name <> GUICtrlRead($SnippetName)) Or _
					_GUICtrlEdit_GetModify($CodeEdit) > 0 And BitAND(GUICtrlGetState($btnSaveSnippet), $GUI_DISABLE) = $GUI_DISABLE
				GUICtrlSetState($btnSaveSnippet, $GUI_ENABLE)
		EndSelect
	WEnd
EndFunc   ;==>_MainTreeView

Func TreeView_Click()
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then	_DebugPrint ("TreeView_Click")
	;----------------------------------------------------------------------------------------------
	If Not _GUICtrlEdit_GetModify($CodeEdit) Then _ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
EndFunc   ;==>TreeView_Click

Func TreeView_DoubleClick()
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then	_DebugPrint ("TreeView_DoubleClick")
	;----------------------------------------------------------------------------------------------
	Local $Selected, $Parent
	If Not _GUICtrlEdit_GetModify($CodeEdit) Then
		$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
		If $Selected == "" Or StringRight($Selected, 1) <> Chr(160) Then
			MsgBox(16 + 262144, "Error", "Please select a Snippet")
		Else
			$tmp_name = StringReplace($Selected, Chr(160), "")
			$Parent = _GUICtrlTreeView_GetText($TreeView,_GUICtrlTreeView_GetParentParam($TreeView))
			$tmp_cat = $Parent
			GUICtrlSetData($CodeEdit, LoadSnippet($tmp_cat, $Selected))
			GUICtrlSetData($SnippetName, $tmp_name)
			_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
			_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
			GUICtrlSetState($EnableEdit, $GUI_UNCHECKED)
			_GUICtrlEdit_SetModify($CodeEdit, False)
			GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, True, 0)
			_ShowPreview($GUI_Edit, $DockItPos, $Dock)
			$Init_Preview = True
		EndIf
	EndIf
EndFunc   ;==>TreeView_DoubleClick

;===================================================================================
;Retrieve all section names and key names from the Snippets.ini file
;This will ignore only the ~xx123Data section in the INI
;The data will then be populated into the TreeView in the GUIMain window
;===================================================================================
Func _IniGetSectionNamesTreeView(ByRef $TreeView, ByRef $SnippetCat, ByRef $file)
	Local $tmp_combo = "|"
	GUISetState(@SW_LOCK)
	_GUICtrlTreeView_DeleteAll($TreeView)
	Local $varx = IniReadSectionNames($file)
	If Not @error Then
		If $sub_dirs == 0 Then _MoveToSubDirs($varx)
		For $x = 1 To $varx[0]
			If $varx[$x] <> "~xx123Data" Then
				$tmp_combo = $tmp_combo & $varx[$x] & "|"
				Local $TreeView2 = GUICtrlCreateTreeViewItem($varx[$x], $TreeView)
				GUICtrlSetImage($TreeView2, 'shell32.dll', -4, 4)
				GUICtrlSetImage($TreeView2, 'shell32.dll', -111, 2)
				Local $var = IniReadSection($file, $varx[$x])
				If Not @error Then
					For $i = 1 To $var[0][0]
						Local $item = GUICtrlCreateTreeViewItem($var[$i][0], $TreeView2)
						GUICtrlSetImage($item, @ScriptDir & "\filetype1.ico", 0)
					Next
				EndIf
			EndIf
		Next
	EndIf
	_GUICtrlTreeView_Sort($TreeView)
	$tmp_combo = StringTrimRight($tmp_combo, 1)
	GUICtrlSetData($SnippetCat, $tmp_combo)
	GUISetState(@SW_UNLOCK)
EndFunc   ;==>_IniGetSectionNamesTreeView
#endregion End TreeView Gui section

#region Begin Helper functions section
Func ToolBar_Click($index)
	Local $Selected, $NewText
	Switch $index
		Case 0
			;----------------------------------------------------------------------------------------------
			If $DebugIt Then	_DebugPrint ("ToolBar PASTE Selected")
			;----------------------------------------------------------------------------------------------
			If $View = 1 Then
				If _GUICtrlListView_GetSelectedCount($ListView) > 0 Then
					$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
					$tmp_name = _GUICtrlListView_GetItemText($ListView, $tmp_sel) & Chr(160)
					$tmp_cat = _GUICtrlListView_GetItemText($ListView, $tmp_sel, 1)
					_InsertIntoScite(LoadSnippet($tmp_cat, $tmp_name))
					If BitAND(WinGetState($GUI_Edit), 2) Then _ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
				Else
					MsgBox(16 + 262144, "Error", "Please select a Snippet")
				EndIf
			Else
				$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
				If $Selected == "" Or StringRight($Selected, 1) <> Chr(160) Then
					MsgBox(16 + 262144, "Error", "Please select a Snippet")
				Else
					Local $tmp_name = $Selected
					Local $Parent = _GUICtrlTreeView_GetText($TreeView,_GUICtrlTreeView_GetParentParam($TreeView))
					_InsertIntoScite(LoadSnippet($Parent, $Selected))
					If BitAND(WinGetState($GUI_Edit), 2) Then _ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
				EndIf
			EndIf
		Case 1
			;----------------------------------------------------------------------------------------------
			If $DebugIt Then	_DebugPrint ("ToolBar COPY Selected")
			;----------------------------------------------------------------------------------------------
			If $View = 1 Then
				If Not BitAND(WinGetState($GUI_Edit), 2) Then
					$New_Flag = 1
					$NewText = _GetCurrentSciteSelection(1)
					$tmp_name = ""
					$tmp_cat = ""
					If StringLen($NewText) > 0 Then
						GUICtrlSetData($CodeEdit, $NewText, "")
						GUICtrlSetData($SnippetName, $tmp_name)
						_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
						_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
						_GUICtrlEdit_SetModify($CodeEdit, True)
						GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, False, 0)
						GUICtrlSetState($EnableEdit, $GUI_CHECKED)
						GUICtrlSetState($btnDelSnippet, $GUI_DISABLE)
						_ShowPreview($GUI_Edit, $DockItPos, $Dock)
					Else
						MsgBox(16 + 262144, "Error", "No code selected")
					EndIf
				Else
					MsgBox(64 + 262144, "Preview", "Close Snippet Preview before selecting another.")
				EndIf
			Else
				If Not BitAND(WinGetState($GUI_Edit), 2) Then
					$New_Flag = 1
					$NewText = _GetCurrentSciteSelection(1)
					$tmp_name = ""
					$tmp_cat = ""
					If StringLen($NewText) > 0 Then
						GUICtrlSetData($CodeEdit, $NewText, "")
						GUICtrlSetData($SnippetName, $tmp_name)
						_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
						_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
						_GUICtrlEdit_SetModify($CodeEdit, True)
						GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, False, 0)
						GUICtrlSetState($EnableEdit, $GUI_CHECKED)
						GUICtrlSetState($btnDelSnippet, $GUI_DISABLE)
						_ShowPreview($GUI_Edit, $DockItPos, $Dock)
					Else
						MsgBox(16 + 262144, "Error", "No code selected")
					EndIf
				Else
					MsgBox(64 + 262144, "Preview", "Close Snippet Preview before selecting another.")
				EndIf
			EndIf
		Case 2 ;divider
		Case 3
			;----------------------------------------------------------------------------------------------
			If $DebugIt Then	_DebugPrint ("ToolBar NEW Selected")
			;----------------------------------------------------------------------------------------------
			$CatRaw = InputBox("New Category", "Please type the new Category Name", "", "", 240, 60)
			If StringLen($CatRaw) Then
				$CatName = $CatRaw & Chr(160) & Chr(160)
				IniWrite($file, $CatName, "", "")
				IniDelete($file, $CatName, "")
				If $View = 1 Then
					_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
				Else
					_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
				EndIf
			EndIf
		Case 4 ;divider
		Case 5
			;----------------------------------------------------------------------------------------------
			If $DebugIt Then	_DebugPrint ("ToolBar ABOUT Selected")
			;----------------------------------------------------------------------------------------------
			_About("About Snippet", $main_GUI, $g_szVersion)
		Case 6 ;divider
		Case 7
			;----------------------------------------------------------------------------------------------
			If $DebugIt Then	_DebugPrint ("ToolBar EXIT Selected")
			;----------------------------------------------------------------------------------------------
			Exit
	EndSwitch
EndFunc   ;==>ToolBar_Click

Func ToggleCheck($control_ID)
	Local $state = GUICtrlRead($control_ID)
	If BitAND($state, $GUI_CHECKED) Then
		$state = $GUI_UNCHECKED
	Else
		$state = $GUI_CHECKED
	EndIf
	GUICtrlSetState($control_ID, $state)
	Return BitAND($state, $GUI_CHECKED)
EndFunc   ;==>ToggleCheck

Func _SnippetExists(ByRef $SnippetCat, ByRef $SnippetName, ByRef $file)
	Local $verifyName, $n, $newName
	$newName = GUICtrlRead($SnippetName)
	;ensure the $newName does not overwrite a current snippet
	$verifyName = IniReadSection($file, GUICtrlRead($SnippetCat))
	If IsArray($verifyName) Then
		For $n = 1 To $verifyName[0][0]
			If $verifyName[$n][0] == $newName & Chr(160) Then
				MsgBox(64 + 262144, "Duplicate Name", "This snippet name already exists")
				Return 1
			EndIf
		Next
	EndIf
EndFunc   ;==>_SnippetExists

Func _ShowPreview(ByRef $GUI_Edit, ByRef $DockItPos, ByRef $Dock, $show = 1)
	If $show Then
		If $DockItPos Then
			_WinAnimate ($GUI_Edit, $AW_SLIDE_IN_RIGHT, 200)
		Else
			_WinAnimate ($GUI_Edit, $AW_SLIDE_IN_LEFT, 200)
		EndIf
		GUISetState(@SW_SHOW, $GUI_Edit)
		$Dock = 2
	Else
		If $DockItPos Then
			_WinAnimate ($GUI_Edit, $AW_SLIDE_OUT_RIGHT, 200)
		Else
			_WinAnimate ($GUI_Edit, $AW_SLIDE_OUT_LEFT, 200)
		EndIf
		GUISetState(@SW_HIDE, $GUI_Edit)
	EndIf
EndFunc   ;==>_ShowPreview

Func _CheckEdit(ByRef $CodeEdit, ByRef $tmp_cat, ByRef $tmp_name, ByRef $file, $check_cat, $check_name)
	Local $s_category, $s_key
	If $tmp_cat <> $check_cat Or $tmp_name <> $check_name Then _GUICtrlEdit_SetModify($CodeEdit, True)
	If StringLen($check_cat) Then
		$s_category = $check_cat
	ElseIf StringLen($tmp_cat) Then
		$s_category = $tmp_cat
	Else
		MsgBox(16 + 262144, "Error", "Category Required")
		Return
	EndIf
	If StringLen($check_name) Then
		_GUICtrlEdit_SetModify($CodeEdit, True)
		$s_key = $check_name
	ElseIf StringLen($tmp_name) Then
		$s_key = $tmp_name
	Else
		MsgBox(16 + 262144, "Error", "Snippet Name Required")
		Return
	EndIf
	If _GUICtrlEdit_GetModify($CodeEdit) Then
		IniDelete($file, $tmp_cat, $tmp_name & Chr(160))
		If FileExists($snips_dir & '\' & $tmp_cat & '\' & $tmp_name & '.xml') Then FileDelete($snips_dir & '\' & $tmp_cat & '\' & $tmp_name & '.xml')
		IniWrite($file, $s_category, $s_key & Chr(160), "")
		SaveSnippet($s_category, $s_key, GUICtrlRead($CodeEdit))
		_GUICtrlEdit_SetModify($CodeEdit, False)
	EndIf
EndFunc   ;==>_CheckEdit

Func SaveSnippet($s_CatName, $s_Name, $code)
	Local $sFile = $snips_dir & '\' & $s_CatName & '\' & $s_Name & '.xml'
	If Not FileExists($snips_dir & '\' & $s_CatName) Then DirCreate($snips_dir & '\' & $s_CatName)
	If FileExists($sFile) Then FileDelete($sFile)
	While @error = 0
		_XMLCreateFile ($sFile, "Snippet", True)
		_XMLFileOpen ($sFile)
		_XMLCreateCDATA ("Code", $code)
		Return
	WEnd
	MsgBox(4096 + 262144, "Error", _XMLError ())
EndFunc   ;==>SaveSnippet

Func LoadSnippet($s_CatName, $s_Name)
	Local $s_TempName = $s_Name
	If StringRight($s_Name, 1) = Chr(160) Then $s_TempName = StringTrimRight($s_TempName, 1)
	Local $sFile = $snips_dir & '\' & $s_CatName & '\' & $s_TempName & '.xml', $s_code, $x, $t_code
	If FileExists($sFile) Then
		_XMLFileOpen ($sFile)
		If @error Then				
			MsgBox(4096 + 262144, "Error", _XMLError ())
			Return ""
		EndIf
		$t_code = _XMLGetValue ("//Code")
		If @error Then				
			MsgBox(4096 + 262144, "Error", _XMLError ())
			Return ""
		EndIf
		If IsArray($t_code) Then
			For $x = 0 To UBound($t_code) - 1
				$s_code = $s_code & StringReplace(StringReplace($t_code[$x], @CR, "", 0), @LF, @CRLF, 0)
			Next
		EndIf
		Return $s_code
	EndIf
	Return ""
EndFunc   ;==>LoadSnippet

Func	ImportSnippet ($main_GUI, $import_folder)
	Local $gui_import, $input_import, $btn_select, $cmb_Category, $btn_Ok, $btn_Cancel, $import_msg
	Local $tmp_name, $tmp_combo = "|List All|"
	Local $szDrive, $szDir, $szFName, $szExt, $split_path, $imported = 0
	Local $varx = IniReadSectionNames($file)
	
	GUISetState(@SW_DISABLE, $main_GUI)
	$gui_import = GUICreate("Import AutoIt3 Script", 441, 131, -1, -1, -1, BitOR($WS_EX_ACCEPTFILES, $WS_EX_WINDOWEDGE), $main_GUI)
	GUISetIcon('shell32.dll', 155, $gui_import)
	GUICtrlCreateLabel("File to Import", 24, 16, 64, 17)
	$input_import = GUICtrlCreateInput("", 96, 16, 257, 21)
	$btn_select = GUICtrlCreateButton("....", 368, 16, 49, 25, 0)
	$cmb_Category = GUICtrlCreateCombo("", 96, 48, 137, 21)
	GUICtrlCreateLabel("Category", 24, 48, 46, 17)
	$btn_Ok = GUICtrlCreateButton("Ok", 144, 88, 49, 25, 0)
	GUICtrlSetState($btn_Ok, $GUI_DISABLE)
	$btn_Cancel = GUICtrlCreateButton("Cancel", 232, 88, 49, 25, 0)
	If Not @error Then
		For $x = 1 To $varx[0]
			If $varx[$x] <> "~xx123Data" Then $tmp_combo = $tmp_combo & $varx[$x] & "|"
		Next
		$tmp_combo = StringTrimRight($tmp_combo, 1)
		GUICtrlSetData($cmb_Category, StringReplace($tmp_combo, "List All|", ""))
	EndIf
	GUISetState(@SW_SHOW, $gui_import)
	While 1
		$import_msg = GUIGetMsg()
		Select
			Case $import_msg = $btn_Cancel
				ExitLoop
			Case $import_msg = $btn_Ok
				SaveSnippet(GUICtrlRead($cmb_Category), $szFName, FileRead($tmp_name))
				$tmp_name = GUICtrlRead($cmb_Category)
				IniDelete($file, $tmp_name, $szFName & Chr(160))
				IniWrite($file, $tmp_name, $szFName & Chr(160), "")
				$imported = 1
				ExitLoop
			Case $import_msg = $btn_select
				$tmp_name = FileOpenDialog("Select File to Import", "", "AutoIt3 (*.au3)", 1 + 2)
				If @error Then
					MsgBox(4096 + 262144, "", "No File chosen")
				Else
					$split_path = _PathSplit($tmp_name, $szDrive, $szDir, $szFName, $szExt)
					$import_folder = $split_path[1] & "\" & $split_path[2]
					IniWrite($file, "~xx123Data", "ImportDir", $import_folder)
					GUICtrlSetData($input_import, $tmp_name)
				EndIf
			Case Else
				If (GUICtrlRead($input_import) = "" Or GUICtrlRead($cmb_Category) = "") And BitAND(GUICtrlGetState($btn_Ok), $GUI_ENABLE) Then
					GUICtrlSetState($btn_Ok, $GUI_DISABLE)
				ElseIf GUICtrlRead($input_import) <> "" And GUICtrlRead($cmb_Category) <> "" And BitAND(GUICtrlGetState($btn_Ok), $GUI_DISABLE) Then
					GUICtrlSetState($btn_Ok, $GUI_ENABLE)
				EndIf
		EndSelect
	WEnd
	GUISetState(@SW_ENABLE, $main_GUI)
	GUISwitch($main_GUI)
	GUIDelete($gui_import)
	GUISetState(@SW_SHOW, $main_GUI)
	Return $imported
EndFunc   ;==>ImportSnippet 

;=====================================================================================
;Retrieve the x,y coords and the width and height
;that has been stored in the Snippets.ini file from the _OnExit() function
;=====================================================================================
Func _SizeWindow(ByRef $PosX, ByRef $PosY, ByRef $PosW, ByRef $PosH, ByRef $file)
	$PosX = IniRead($file, "~xx123Data", "X", @DesktopWidth - 205)
	$PosY = IniRead($file, "~xx123Data", "Y", 25)
	$PosW = IniRead($file, "~xx123Data", "W", 240)
	$PosH = IniRead($file, "~xx123Data", "H", 528)
EndFunc   ;==>_SizeWindow

Func _KeepWindowsDocked(ByRef $GUI1, ByRef $GUI2, ByRef $Dock, ByRef $x1, ByRef $x2, ByRef $y1, ByRef $y2)
	Local $p_win1 = WinGetPos($GUI1)
	Local $p_win2 = WinGetPos($GUI2)
	If (($p_win1[0] <> $x1 Or $p_win1[1] <> $y1) And BitAND(WinGetState($GUI1), 2) Or $Dock = 2) Then
		$x1 = $p_win1[0]
		$y1 = $p_win1[1]
		$x2 = $p_win1[2] + $x1
		$y2 = $y1
;~ 		_GUICtrlCreateGradientTriColor ($Black, $Purple, $Green, 0, 0, $p_win1[2], $p_win1[3], $G_HORIZONTAL)
		WinMove($GUI2, "", $x2, $y2)
		$Dock = 1
	ElseIf (($p_win2[0] <> $x2 Or $p_win2[1] <> $y2) And BitAND(WinGetState($GUI2), 2)) Then
		$x2 = $p_win2[0]
		$y2 = $p_win2[1]
		$x1 = $p_win2[0] - $p_win1[2]
		$y1 = $y2
		WinMove($GUI1, "", $x1, $y1)
	ElseIf ($p_win1[0] <> $x1 Or $p_win1[1] <> $y1) And BitAND(WinGetState($GUI1), 16) Then
		WinSetState($GUI2, "", @SW_MINIMIZE)
	ElseIf ($p_win2[0] <> $x2 Or $p_win2[1] <> $y2) And BitAND(WinGetState($GUI2), 16) Then
		WinSetState($GUI1, "", @SW_MINIMIZE)
	ElseIf ($p_win1[0] <> $x1 Or $p_win1[1] <> $y1) And BitAND(WinGetState($GUI1), 2) Then
		WinSetState($GUI2, "", @SW_RESTORE)
	ElseIf ($p_win2[0] <> $x2 Or $p_win2[1] <> $y2) And BitAND(WinGetState($GUI2), 2) Then
		WinSetState($GUI1, "", @SW_RESTORE)
	EndIf
EndFunc   ;==>_KeepWindowsDocked

Func _ReduceMemory()
	Local $ai_Return = DllCall($dll_mem, 'int', 'EmptyWorkingSet', 'long', -1)
	If @error Then Return SetError(@error,@error, 1)
	Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory

Func _IsBadName($s_Name)
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then	_DebugPrint ($s_Name)
	;----------------------------------------------------------------------------------------------
	Local $x
	For $x = 0 To UBound($Ilegal_chars) - 1
		If StringInStr($s_Name, $Ilegal_chars[$x]) Then Return 1
	Next
	Return 0
EndFunc   ;==>_IsBadName

Func _MoveToSubDirs($varx)
	For $x = 1 To $varx[0]
		If $varx[$x] <> "~xx123Data" Then
			Local $var = IniReadSection($file, $varx[$x])
			If Not @error Then
				DirCreate($snips_dir & '\' & $varx[$x])
				For $i = 1 To $var[0][0]
					$var[$i][0] = StringReplace($var[$i][0], Chr(160), "")
					FileMove($snips_dir & '\' & $var[$i][0] & '.xml', $snips_dir & '\' & $varx[$x] & '\' & $var[$i][0] & '.xml')
				Next
			EndIf
		EndIf
	Next
	IniWrite($file, "~xx123Data", "SubDirs", 1)
EndFunc   ;==>_MoveToSubDirs

Func _SetClipEvent()
	HotKeySet("!+c", "_ClipEvent")
	HotKeySet("!+t", "_CloseToolTip")
	HotKeySet("!+b", "_BetaRunClip")
	HotKeySet("!+r", "_RunClip")
EndFunc   ;==>_SetClipEvent

Func _ClipEvent()
	$ClipEvent = 1
	ToolTip("")
EndFunc   ;==>_ClipEvent

Func _CloseToolTip()
	ToolTip("")
	HotKeySet("!+c")
	HotKeySet("!+b")
	HotKeySet("!+r")
EndFunc   ;==>_CloseToolTip

Func _BetaRunClip()
	FileOpen(@TempDir & "\SciTE-temp.au3", 2)
	FileWrite(@TempDir & "\SciTE-temp.au3", $Clip_Text)
	FileClose(@TempDir & "\SciTE-temp.au3")
	_CloseToolTip()
	Run("..\SciTe.exe " & @TempDir & "\SciTE-temp.au3")
	Sleep(1000)
	Local $Scite_hwnd = WinGetHandle("DirectorExtension")
	_SciTE_Send_Command(0, $Scite_hwnd, "menucommand:1100")
EndFunc   ;==>_BetaRunClip

Func _RunClip()
	FileOpen(@TempDir & "\SciTE-temp.au3", 2)
	FileWrite(@TempDir & "\SciTE-temp.au3", $Clip_Text)
	FileClose(@TempDir & "\SciTE-temp.au3")
	_CloseToolTip()
	Run("..\SciTe.exe " & @TempDir & "\SciTE-temp.au3")
	Sleep(1000)
	Local $Scite_hwnd = WinGetHandle("DirectorExtension")
	_SciTE_Send_Command(0, $Scite_hwnd, "menucommand:303")
EndFunc   ;==>_RunClip

Func _GetNewSnippet(ByRef $CMDtmp, ByRef $CmdClean, ByRef $btnSaveSnippet, ByRef $copy_file)
	Local $NewText
	Sleep(100)
	$CMDtmp = IniRead($copy_file, "CMDtmp", "New", 0)
	If $CMDtmp = 1 Then
		$New_Flag = 1
		$NewText = IniRead($copy_file, "CMDtmp", "Value", "Unable to Retrieve Text")
		$CmdClean = StringReplace($NewText, Chr(26), Chr(13) & Chr(10), 0)
		IniDelete($copy_file, "CMDtmp")
		$tmp_name = ""
		$tmp_cat = ""
		GUICtrlSetData($CodeEdit, $CmdClean, "")
		GUICtrlSetData($SnippetName, $tmp_name)
		_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
		_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
		_GUICtrlEdit_SetModify($CodeEdit, True)
		GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, False, 0)
		GUICtrlSetState($EnableEdit, $GUI_CHECKED)
		GUICtrlSetState($btnSaveSnippet, $GUI_ENABLE)
		GUICtrlSetState($btnDelSnippet, $GUI_DISABLE)
		_ShowPreview($GUI_Edit, $DockItPos, $Dock)
	EndIf
	FileDelete($copy_file)
EndFunc   ;==>_GetNewSnippet

Func _GetClipBoardData()
	Local $NewText
	If Not BitAND(WinGetState($GUI_Edit), 2) Then
		$New_Flag = 1
		$NewText = $Clip_Text
		$tmp_name = ""
		$tmp_cat = ""
		If StringLen($NewText) > 0 Then
			GUICtrlSetData($CodeEdit, $NewText, "")
			GUICtrlSetData($SnippetName, $tmp_name)
			_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
			_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
			_GUICtrlEdit_SetModify($CodeEdit, True)
			GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, False, 0)
			GUICtrlSetState($EnableEdit, $GUI_CHECKED)
			GUICtrlSetState($btnDelSnippet, $GUI_DISABLE)
			_ShowPreview($GUI_Edit, $DockItPos, $Dock)
		Else
			MsgBox(16 + 262144, "Error", "No code selected")
		EndIf
	Else
		MsgBox(64 + 262144, "Preview", "Close Snippet Preview before selecting another.")
	EndIf
	$ClipEvent = 0
EndFunc   ;==>_GetClipBoardData

Func _ClosePreview(ByRef $btnSaveSnippet)
	If _GUICtrlEdit_GetModify($CodeEdit) Then
		_GUICtrlEdit_Undo($CodeEdit)
		_GUICtrlEdit_SetModify($CodeEdit, False)
		$tmp_cat = ""
		$tmp_name = ""
	EndIf
	GUICtrlSetState($btnSaveSnippet, $GUI_DISABLE)
	_GUICtrlListView_SetItemSelected($ListView, -1, False)
	_GuiCtrlStatusBar_SetText($StatusBar, "", $SB_SIMPLEID)
	_ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
	$New_Flag = 0
EndFunc   ;==>_ClosePreview

Func _SaveSnippet(ByRef $btnSaveSnippet)
	If GUICtrlRead($SnippetCat) <> "" And GUICtrlRead($SnippetName) <> "" Then
		If Not _IsBadName(GUICtrlRead($SnippetName)) Then
			If $New_Flag Then
				If _SnippetExists($SnippetCat, $SnippetName, $file) Then Return
			EndIf
			$New_Flag = 0
			_CheckEdit($CodeEdit, $tmp_cat, $tmp_name, $file, GUICtrlRead($SnippetCat), GUICtrlRead($SnippetName))
			GUICtrlSetState($btnSaveSnippet, $GUI_DISABLE)
			GUICtrlSetState($btnDelSnippet, $GUI_ENABLE)
			If $View = 1 Then
				_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
			Else
				_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
			EndIf
			_GuiCtrlStatusBar_SetText($StatusBar, "", $SB_SIMPLEID)
			_ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
		Else
			MsgBox(16 + 262144, "Error", "Ilegal character in file name")
		EndIf
	ElseIf GUICtrlRead($SnippetCat) = "" Then
		MsgBox(16 + 262144, "Error", "Please Select a Category")
	ElseIf GUICtrlRead($SnippetName) = "" Then
		MsgBox(16 + 262144, "Error", "Please Select a Snippet Name")
	EndIf
EndFunc   ;==>_SaveSnippet

Func _DeleteSnippet(ByRef $btnSaveSnippet)
	Local $Confirm
	If StringLen(GUICtrlRead($SnippetName)) = 0 Then
		MsgBox(16 + 262144, "Error", "Unable to Delete Snippet")
	Else
		$tmp_name = GUICtrlRead($SnippetName)
		$tmp_cat = GUICtrlRead($SnippetCat)
		$Confirm = MsgBox(52 + 262144, "Confirm Snippet Delete", "Are you sure you want to Delete the Snippet " & $tmp_name & "?")
		If $Confirm = 6 Then
			IniDelete($file, $tmp_cat, $tmp_name & Chr(160))
			FileDelete('"' & $snips_dir & '\' & $tmp_cat & '\' & $tmp_name & '.xml"')
			GUICtrlSetData($CodeEdit, "", "")
			If $View = 1 Then
				_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
				$tmp_sel = $LV_ERR
			Else
				_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
			EndIf
			GUICtrlSetState($btnSaveSnippet, $GUI_DISABLE)
			_GuiCtrlStatusBar_SetText($StatusBar, "", $SB_SIMPLEID)
			_ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
			_GUICtrlEdit_SetModify($CodeEdit, False)
		EndIf
	EndIf
EndFunc   ;==>_DeleteSnippet

Func _EnableDisableEdit(ByRef $btnSaveSnippet)
	If BitAND(WinGetState($GUI_Edit), 2) Then
		If BitAND(GUICtrlRead($EnableEdit), $GUI_CHECKED) Then
			GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, False, 0)
			GUICtrlSetState($btnSaveSnippet, $GUI_ENABLE)
		ElseIf BitAND(GUICtrlRead($EnableEdit), $GUI_UNCHECKED) Then
			GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, True, 0)
			If _GUICtrlEdit_GetModify($CodeEdit) Then
				GUICtrlSetState($btnSaveSnippet, $GUI_ENABLE)
			Else
				GUICtrlSetState($btnSaveSnippet, $GUI_DISABLE)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_EnableDisableEdit

Func _SetSnippetDir()
	Local $snippet_folder, $szDrive, $szDir, $szFName, $szExt, $TestPath
	$snippet_folder = FileSelectFolder("Select folder to store snippets in", "", 7, $snips_dir)
	If Not @error And $snippet_folder <> "" Then
		$TestPath = _PathSplit($snippet_folder, $szDrive, $szDir, $szFName, $szExt)
		If Not _IsBadName($TestPath[3]) Then
			IniWrite($file, "~xx123Data", "SnipsDir", $snippet_folder)
		Else
			MsgBox(16 + 262144, "Error", "Ilegal character in folder name")
		EndIf
	EndIf
EndFunc   ;==>_SetSnippetDir

Func _ClipGet()
	Local $Selected, $NewText
	If Not BitAND(WinGetState($GUI_Edit), 2) Then
		$New_Flag = 1
		$NewText = ClipGet()
		$tmp_name = ""
		$tmp_cat = ""
		If StringLen($NewText) > 0 Then
			If $View = 0 Then
				$Selected = GUICtrlRead($TreeView, 1)
				If @error = 0 Then $tmp_cat = $Selected
			EndIf
			GUICtrlSetData($CodeEdit, $NewText, "")
			GUICtrlSetData($SnippetName, $tmp_name)
			_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
			_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
			_GUICtrlEdit_SetModify($CodeEdit, True)
			GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, False, 0)
			GUICtrlSetState($EnableEdit, $GUI_CHECKED)
			GUICtrlSetState($btnDelSnippet, $GUI_DISABLE)
			_ShowPreview($GUI_Edit, $DockItPos, $Dock)
		Else
			MsgBox(16 + 262144, "Error", "No code selected")
		EndIf
	Else
		MsgBox(64 + 262144, "Preview", "Close Snippet Preview before selecting another.")
	EndIf
EndFunc   ;==>_ClipGet

Func _NewSnippet(ByRef $btnSaveSnippet)
	Local $Selected, $NewText
	If Not BitAND(WinGetState($GUI_Edit), 2) Then
		$New_Flag = 1
		$NewText = _GetCurrentSciteSelection(1)
		$tmp_name = ""
		$tmp_cat = ""
		If StringLen($NewText) > 0 Then
			If $View = 0 Then
				$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
				If $Selected <> "" And StringRight($Selected, 1) <> Chr(160) Then $tmp_cat = $Selected
			EndIf
			GUICtrlSetData($CodeEdit, $NewText, "")
			GUICtrlSetData($SnippetName, $tmp_name)
			_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
			_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
			_GUICtrlEdit_SetModify($CodeEdit, True)
			GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, False, 0)
			GUICtrlSetState($EnableEdit, $GUI_CHECKED)
			GUICtrlSetState($btnSaveSnippet, $GUI_ENABLE)
			GUICtrlSetState($btnDelSnippet, $GUI_DISABLE)
			_ShowPreview($GUI_Edit, $DockItPos, $Dock)
		Else
			MsgBox(16 + 262144, "Error", "No code selected")
		EndIf
	Else
		MsgBox(64 + 262144, "Preview", "Close Snippet Preview before selecting another.")
	EndIf
EndFunc   ;==>_NewSnippet

Func _CopyToScite()
	If StringLen(GUICtrlRead($CodeEdit)) = 0 Then
		MsgBox(16 + 262144, "Error", "No Snippet to Insert")
		Return
	ElseIf StringLen(GUICtrlRead($CodeEdit)) > 0 Then
		_InsertIntoScite(GUICtrlRead($CodeEdit))
		_ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
	EndIf
EndFunc   ;==>_CopyToScite

Func _CopyToClipBoard()
	If StringLen(GUICtrlRead($CodeEdit)) = 0 Then
		MsgBox(16 + 262144, "Error", "No Snippet to Copy")
		Return
	ElseIf StringLen(GUICtrlRead($CodeEdit)) > 0 Then
		ClipPut(GUICtrlRead($CodeEdit))
		_ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
	EndIf
EndFunc   ;==>_CopyToClipBoard

Func _NewCategory()
	$CatRaw = InputBox("New Category", "Please type the new Category Name", "", "", 240, 60)
	If StringLen($CatRaw) Then
		$CatName = $CatRaw
		IniWrite($file, $CatName, "", "")
		IniDelete($file, $CatName, "")
		If $View = 1 Then
			_IniGetSectionNamesListView($ListView, $CodeFilter, $SnippetCat, $file)
		Else
			_IniGetSectionNamesTreeView($TreeView, $SnippetCat, $file)
		EndIf
	EndIf
EndFunc   ;==>_NewCategory

Func _ExportSnippet()
	Local $tmp_folder, $szDrive, $szDir, $szFName, $szExt, $TestPath
	Local $Selected, $Parent
	If $View = 1 Then
		If _GUICtrlListView_GetSelectedCount($ListView) > 0 Then
			$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
			$tmp_name = _GUICtrlListView_GetItemText($ListView, $tmp_sel)
			$tmp_cat = _GUICtrlListView_GetItemText($ListView, $tmp_sel, 1)
			$tmp_folder = FileSelectFolder("Select folder to store Exported Snippet in", "", 7, $export_folder)
		Else
			MsgBox(16 + 262144, "Error", "Please select a Snippet")
			Return
		EndIf
	Else
		$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
		If $Selected == "" Or StringRight($Selected, 1) <> Chr(160) Then
			MsgBox(16 + 262144, "Error", "Please select a Snippet")
			Return
		Else
			$tmp_name = $Selected
			$Parent = _GUICtrlTreeView_GetText($TreeView,_GUICtrlTreeView_GetParentParam($TreeView))
			$tmp_cat = $Parent
			$tmp_folder = FileSelectFolder("Select folder to store Exported Snippet in", "", 7, $export_folder)
		EndIf
	EndIf
	If Not @error And $tmp_folder <> "" Then
		$TestPath = _PathSplit($tmp_folder, $szDrive, $szDir, $szFName, $szExt)
		
		If Not _IsBadName($TestPath[3]) Then
			$export_folder = $tmp_folder
			FileWrite($export_folder & "\" & $tmp_name & ".au3", LoadSnippet($tmp_cat, $tmp_name))
			IniWrite($file, "~xx123Data", "ExportDir", $export_folder)
			MsgBox(64 + 262144, "Export", $tmp_name & " Export is finished")
		Else
			MsgBox(16 + 262144, "Error", "Ilegal character in folder name")
		EndIf
	EndIf
EndFunc   ;==>_ExportSnippet

Func _PreviewSnippet()
	Local $Selected, $Parent
	If $View = 1 Then
		If _GUICtrlListView_GetSelectedCount($ListView) > 0 And Not BitAND(WinGetState($GUI_Edit), 2) Then
			$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
			$tmp_name = _GUICtrlListView_GetItemText($ListView, $tmp_sel)
			$tmp_cat = _GUICtrlListView_GetItemText($ListView, $tmp_sel, 1)
		ElseIf BitAND(WinGetState($GUI_Edit), 2) Then
			MsgBox(64 + 262144, "Preview", "Close Snippet Preview before selecting another.")
			Return
		EndIf
	Else
		$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
		If $Selected == "" Or StringRight($Selected, 1) <> Chr(160) Then
			MsgBox(16 + 262144, "Error", "Please select a Snippet")
			Return
		ElseIf BitAND(WinGetState($GUI_Edit), 2) Then
			MsgBox(64 + 262144, "Preview", "Close Snippet Preview before selecting another.")
			Return
		Else
			$Parent = _GUICtrlTreeView_GetText($TreeView,_GUICtrlTreeView_GetParentParam($TreeView))
			$tmp_name = StringReplace($Selected, Chr(160), "")
			$tmp_cat = $Parent
		EndIf
	EndIf
	GUICtrlSetData($CodeEdit, LoadSnippet($tmp_cat, $tmp_name), "")
	GUICtrlSetData($SnippetName, $tmp_name)
	_GUICtrlComboBox_SetCurSel($SnippetCat, _GUICtrlComboBox_FindString($SnippetCat, $tmp_cat, 1))
	_GuiCtrlStatusBar_SetText($StatusBar, "Category: " & $tmp_cat, $SB_SIMPLEID)
	_GUICtrlEdit_SetModify($CodeEdit, False)
	GUICtrlSendMsg($CodeEdit, $EM_SETREADONLY, True, 0)
	GUICtrlSetState($EnableEdit, $GUI_UNCHECKED)
	_ShowPreview($GUI_Edit, $DockItPos, $Dock)
EndFunc   ;==>_PreviewSnippet

Func _SendToSciTE()
	Local $Selected
	If $View = 1 Then
		If _GUICtrlListView_GetSelectedCount($ListView) > 0 Then
			$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
			$tmp_name = _GUICtrlListView_GetItemText($ListView, $tmp_sel)
			$tmp_cat = _GUICtrlListView_GetItemText($ListView, $tmp_sel, 1)
		Else
			MsgBox(16 + 262144, "Error", "Please select a Snippet")
			Return
		EndIf
	Else
		$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
		If $Selected == "" Or StringRight($Selected, 1) <> Chr(160) Then
			MsgBox(16 + 262144, "Error", "Please select a Snippet")
			Return
		Else
			$tmp_cat = _GUICtrlTreeView_GetText($TreeView,_GUICtrlTreeView_GetParentParam($TreeView))
			$tmp_name = $Selected
		EndIf
	EndIf
	_InsertIntoScite(LoadSnippet($tmp_cat, $tmp_name))
	If BitAND(WinGetState($GUI_Edit), 2) Then _ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
EndFunc   ;==>_SendToSciTE

Func _SendToClipBoard()
	Local $Selected
	If $View = 1 Then
		If _GUICtrlListView_GetSelectedCount($ListView) > 0 Then
			$tmp_sel = Int(_GUICtrlListView_GetSelectedIndices($ListView))
			$tmp_name = _GUICtrlListView_GetItemText($ListView, $tmp_sel)
			$tmp_cat = _GUICtrlListView_GetItemText($ListView, $tmp_sel, 1)
		Else
			MsgBox(16 + 262144, "Error", "Please select a Snippet")
			Return
		EndIf
	Else
		$Selected = _GUICtrlTreeView_GetText($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
		If $Selected == "" Or StringRight($Selected, 1) <> Chr(160) Then
			MsgBox(16 + 262144, "Error", "Please select a Snippet")
			Return
		Else
			$tmp_cat = _GUICtrlTreeView_GetText($TreeView,_GUICtrlTreeView_GetParentParam($TreeView))
			$tmp_name = $Selected
		EndIf
	EndIf
	ClipPut(LoadSnippet($tmp_cat, $tmp_name))
	If BitAND(WinGetState($GUI_Edit), 2) Then _ShowPreview($GUI_Edit, $DockItPos, $Dock, 0)
EndFunc   ;==>_SendToClipBoard

Func _LocateSnippet(ByRef $ctrl_snippet, $t_input, $b_fuzzy)
	Local $found_snippet = 0, $x, $s_comp, $s_comp2, $col_width, $lv_rect, $row_height
	Local Const $LVM_GETITEMRECT = ($LVM_FIRST + 14)
	$t_input = StringUpper($t_input)
	GUISetCursor($Cursor_WAIT, 1)
	If $View = 1 Then
		$col_width = Int(_GUICtrlListView_GetColumnWidth($ctrl_snippet,1))
		$lv_rect = DllStructCreate("int;int;int;int")
		DllStructSetData($lv_rect,1,$LVIR_BOUNDS)
		GUICtrlSendMsg($ctrl_snippet,$LVM_GETITEMRECT,0,DllStructGetPtr($lv_rect))
		$row_height = Int(DllStructGetData($lv_rect,4)) - Int(DllStructGetData($lv_rect,2))
		If _GUICtrlListView_GetNextItem($ctrl_snippet) <> $LV_ERR And _
				_GUICtrlListView_GetNextItem($ctrl_snippet) <> _GUICtrlListView_GetItemCount($ctrl_snippet) - 1 Then
			For $x = _GUICtrlListView_GetNextItem($ctrl_snippet) + 1 To _GUICtrlListView_GetItemCount($ctrl_snippet) - 1
				$s_comp = StringUpper(_GUICtrlListView_GetItemText($ctrl_snippet, $x))
				$s_comp2 = StringUpper(_GUICtrlListView_GetItemText($ctrl_snippet, $x, 1))
				If (($b_fuzzy And (StringInStr($s_comp, $t_input) Or (StringInStr($s_comp2, $t_input) And $col_width))) Or _
					($b_fuzzy = 0 And ($s_comp = $t_input Or ($s_comp2 = $t_input And $col_width)))) Then
					GUICtrlSetState($ctrl_snippet, $GUI_FOCUS)
					_GUICtrlListView_SetItemSelected($ctrl_snippet, $x)
					_GUICtrlListView_Scroll($ctrl_snippet, 0, (_GUICtrlListView_GetItemCount($ctrl_snippet) * $row_height) * - 1)
					_GUICtrlListView_Scroll($ctrl_snippet, 0, $x * $row_height)
					$found_snippet = 1
					ExitLoop
				EndIf
			Next
			If Not $found_snippet Then
				For $x = 0 To _GUICtrlListView_GetNextItem($ctrl_snippet)
					$s_comp = StringUpper(_GUICtrlListView_GetItemText($ctrl_snippet, $x))
					$s_comp2 = StringUpper(_GUICtrlListView_GetItemText($ctrl_snippet, $x, 1))
					If (($b_fuzzy And (StringInStr($s_comp, $t_input) Or (StringInStr($s_comp2, $t_input) And $col_width))) Or _
						($b_fuzzy = 0 And ($s_comp = $t_input Or ($s_comp2 = $t_input And $col_width)))) Then
						GUICtrlSetState($ctrl_snippet, $GUI_FOCUS)
						_GUICtrlListView_SetItemSelected($ctrl_snippet, $x)
						_GUICtrlListView_Scroll($ctrl_snippet, 0, (_GUICtrlListView_GetItemCount($ctrl_snippet) * $row_height) * - 1)
						_GUICtrlListView_Scroll($ctrl_snippet, 0, $x * $row_height)
						$found_snippet = 1
						ExitLoop
					EndIf
				Next
			EndIf
		Else
			For $x = 0 To _GUICtrlListView_GetItemCount($ctrl_snippet) - 1
				$s_comp = StringUpper(_GUICtrlListView_GetItemText($ctrl_snippet, $x))
				$s_comp2 = StringUpper(_GUICtrlListView_GetItemText($ctrl_snippet, $x, 1))
				If (($b_fuzzy And (StringInStr($s_comp, $t_input) Or (StringInStr($s_comp2, $t_input) And $col_width))) Or _
					($b_fuzzy = 0 And ($s_comp = $t_input Or ($s_comp2 = $t_input And $col_width)))) Then
					GUICtrlSetState($ctrl_snippet, $GUI_FOCUS)
					_GUICtrlListView_SetItemSelected($ctrl_snippet, $x)
					_GUICtrlListView_Scroll($ctrl_snippet, 0, (_GUICtrlListView_GetItemCount($ctrl_snippet) * $row_height) * - 1)
					_GUICtrlListView_Scroll($ctrl_snippet, 0, $x * $row_height)
					$found_snippet = 1
					ExitLoop
				EndIf
			Next
		EndIf
		;===============================================================================
		; treeview search
		;===============================================================================
	Else
		Local $h_item, $hChild, $Selected, $hold
		$x = 0
		$Selected = _GUICtrlTreeView_GetItemHandle  ($TreeView, GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, $TVI_ROOT))
		$h_item = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CARET, $TVI_ROOT)
		;===============================================================================
		; search from selected to end
		;===============================================================================
		Do
			$hChild = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CHILD, $h_item)
			$s_comp = StringReplace(StringUpper(_GUICtrlTreeView_GetText($TreeView, $hChild)), Chr(160), "")
			If $hChild > 0 Then
				If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
						($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) <> $Selected Then
					GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $hChild)
					$found_snippet = 1
					ExitLoop
				EndIf
				Do
					$hChild = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_NEXT, $hChild)
					$s_comp = StringReplace(StringUpper(_GUICtrlTreeView_GetText($TreeView, $hChild)), Chr(160), "")
					If $hChild > 0 Then
						If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
								($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) <> $Selected Then
							GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $hChild)
							$found_snippet = 1
							ExitLoop 2
						EndIf
					EndIf
				Until $hChild <= 0
			EndIf
			$hold = $h_item
			$h_item = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_NEXT, $h_item)
			$s_comp = StringUpper(_GUICtrlTreeView_GetText($TreeView, $h_item))
			If $h_item > 0 Then
				If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
						($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $h_item) <> $Selected Then
					GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $h_item)
					$found_snippet = 1
					ExitLoop
				EndIf
			Else
				$h_item = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_PARENT, $hold)
				$h_item = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_NEXT, $h_item)
			EndIf
		Until $h_item <= 0
		;===============================================================================
		; search from start to selected
		;===============================================================================
		If Not $found_snippet Then
			$x = 0
			Do
				If $x == 0 Then
					$x += 1
					$h_item = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CHILD, $TVI_ROOT)
					$s_comp = StringUpper(_GUICtrlTreeView_GetText($TreeView, $h_item))
					If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
							($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $h_item) <> $Selected Then
						GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $h_item)
						$found_snippet = 1
						ExitLoop
					EndIf
					If _GUICtrlTreeView_GetItemHandle ($TreeView, $h_item) = $Selected Then ExitLoop
					$hChild = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CHILD, $h_item)
					$s_comp = StringReplace(StringUpper(_GUICtrlTreeView_GetText($TreeView, $hChild)), Chr(160), "")
					If $hChild > 0 Then
						If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
								($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) <> $Selected Then
							GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $hChild)
							$found_snippet = 1
							ExitLoop
						EndIf
						If _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) = $Selected Then ExitLoop
						Do
							$hChild = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_NEXT, $hChild)
							$s_comp = StringReplace(StringUpper(_GUICtrlTreeView_GetText($TreeView, $hChild)), Chr(160), "")
							If $hChild > 0 Then
								If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
										($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) <> $Selected Then
									GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $hChild)
									$found_snippet = 1
									ExitLoop 2
								EndIf
							EndIf
							If _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) = $Selected Then ExitLoop 2
						Until $hChild <= 0
					EndIf
				Else
					$h_item = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_NEXT, $h_item)
					$s_comp = StringUpper(_GUICtrlTreeView_GetText($TreeView, $h_item))
					If $h_item > 0 Then
						If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
								($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $h_item) <> $Selected Then
							GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $h_item)
							$found_snippet = 1
							ExitLoop
						EndIf
						If _GUICtrlTreeView_GetItemHandle ($TreeView, $h_item) = $Selected Then ExitLoop
						$hChild = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_CHILD, $h_item)
						$s_comp = StringReplace(StringUpper(_GUICtrlTreeView_GetText($TreeView, $hChild)), Chr(160), "")
						If $hChild > 0 Then
							If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
									($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) <> $Selected Then
								GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $hChild)
								$found_snippet = 1
								ExitLoop
							EndIf
							If _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) = $Selected Then ExitLoop
							Do
								$hChild = GUICtrlSendMsg($TreeView, $TVM_GETNEXTITEM, $TVGN_NEXT, $hChild)
								$s_comp = StringReplace(StringUpper(_GUICtrlTreeView_GetText($TreeView, $hChild)), Chr(160), "")
								If $hChild > 0 Then
									If (($b_fuzzy And StringInStr($s_comp, $t_input)) Or _
											($b_fuzzy = 0 And $s_comp = $t_input)) And _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) <> $Selected Then
										GUICtrlSendMsg($TreeView, $TVM_SELECTITEM, $TVGN_CARET, $hChild)
										$found_snippet = 1
										ExitLoop 2
									EndIf
									If _GUICtrlTreeView_GetItemHandle ($TreeView, $hChild) = $Selected Then ExitLoop 2
								EndIf
							Until $hChild <= 0
						EndIf
					EndIf
				EndIf
			Until $h_item <= 0
		EndIf
	EndIf
	If Not $found_snippet Then
		_GuiCtrlStatusBar_SetText($StatusBar, $t_input & ' "NOT FOUND"', $SB_SIMPLEID)
	Else
		_GuiCtrlStatusBar_SetText($StatusBar, '', $SB_SIMPLEID)
	EndIf
	GUISetCursor($Cursor_ARROW, 1)
EndFunc   ;==>_LocateSnippet
#endregion Begin Helper functions section

#region Begin About section
;===============================================================================
; Function Name:    _About()
; Description:      Self describing
; Parameter(s):		$TITLE       - Script Title
;					$MAIN_WINDOW - control ID
; Requirement(s):   None
; Return Value(s):  None
; Author(s):        Gary Frost <custompcs@charter.net>
;===============================================================================

Func _About($TITLE, $MAIN_WINDOW, $g_szVersion)
	Local $CLOSE, $msg, $ABOUT_WINDOW
	Local $ABOUT_AUTHOR = "Gary Frost"
	Local $ABOUT_TEXT = $g_szVersion & @CRLF & _
			"Purpose / Logic:" & @CRLF & _
			"   Help in Managing Code Snippets" & @CRLF & _
			"   Original Concept/Code by MikeOsdx" & @CRLF & _
			"   Thanks to Jos for Help with" & @CRLF & _
			"       Interface to SciTE" & @CRLF & _
			"Modifications:" & @CRLF & _
			"      01/19/06 - Started program" & @CRLF & _
			"      Last Modified date: 12/04/07" & @CRLF & @CRLF & _
			"Devolopment Team:" & @CRLF & $ABOUT_AUTHOR
	If BitAND(WinGetState($TITLE), 1) Then Return
	Local $MAILTO = "CustomPCs@charter.com"
	$ABOUT_WINDOW = GUICreate($TITLE, 250, 220, -1, -1, BitOR($WS_CAPTION, $DS_MODALFRAME), -1, $MAIN_WINDOW)
	GUISetIcon(@SystemDir & "\shell32.dll", 23, $ABOUT_WINDOW)
	#Region --- CodeWizard generated code Start ---
	If Not IsDeclared('Cadet_Blue_3') Then Local $Cadet_Blue_3 = 0x7AC5CD
	GUISetBkColor($Cadet_Blue_3)
	#EndRegion --- CodeWizard generated code End ---
	$hl_hwnd[0] = _GuiCtrlHyperLinkCreate ($ABOUT_WINDOW, $ABOUT_TEXT, "mailto:" & $MAILTO, $ABOUT_AUTHOR, 25, 10, 200, 170, $WS_DLGFRAME, $WS_EX_CLIENTEDGE)
	$CLOSE = GUICtrlCreateButton("Close", 35, 190, 100, 20)
	GUICtrlCreateIcon(@SystemDir & "\clipbrd.exe", 0, 180, 185)
	GUISetState()
	Do
		$msg = GUIGetMsg()
		Select
			Case $msg = $CLOSE
				ExitLoop
		EndSelect
	Until $msg = $GUI_EVENT_CLOSE
	GUIDelete($ABOUT_WINDOW)
EndFunc   ;==>_About
#endregion End About section

#region Begin functions for Send/Recieve with SciTE
Func _GetCurrentSciteSelection($CleanUp = 0)
	Opt("WinSearchChildren", 1)
	; Get SciTE DirectorHandle
	Local $Scite_hwnd = WinGetHandle("DirectorExtension")
	; Get My GUI Handle numeric
	Local $My_Hwnd = GUICreate("SciTE interface")
	Local $My_Dec_Hwnd = Dec(StringTrimLeft($My_Hwnd, 2))
	$Scite_WM_COPYDATA = ""
	;Send Scite Director my GUI handle so it will report info back from SciTE
	_SciTE_Send_Command($My_Hwnd, $Scite_hwnd, "identity: " & $My_Dec_Hwnd)
	_SciTE_Send_Command($My_Hwnd, $Scite_hwnd, "askproperty:CurrentSelection")
	Sleep(500)   ; give SciTE time to send the selection via WM_DATACOPY
	GUIDelete($My_Hwnd)
	;remove "macro:stringinfo:"
	$Scite_WM_COPYDATA = StringTrimLeft($Scite_WM_COPYDATA, 17)
	;Translate \\ -> \, \t -> tab and \r\n -> chr(26)
	$Scite_WM_COPYDATA = StringReplace($Scite_WM_COPYDATA, "\\", Chr(01))
	$Scite_WM_COPYDATA = StringReplace($Scite_WM_COPYDATA, "\r\n", Chr(26))
	$Scite_WM_COPYDATA = StringReplace($Scite_WM_COPYDATA, "\t", @TAB)
	$Scite_WM_COPYDATA = StringReplace($Scite_WM_COPYDATA, Chr(01), "\")
	If $CleanUp Then Return StringReplace($Scite_WM_COPYDATA, Chr(26), Chr(13) & Chr(10), 0)
	Return $Scite_WM_COPYDATA
EndFunc   ;==>_GetCurrentSciteSelection

Func _InsertIntoScite($DataToInsert)
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then _DebugPrint ('_InsertIntoScite-->' & $DataToInsert)
	;----------------------------------------------------------------------------------------------
	Opt("WinSearchChildren", 1)
	Local $Scite_hwnd = WinGetHandle("DirectorExtension")
	$DataToInsert = StringReplace($DataToInsert, "\", "\\")
	$DataToInsert = StringReplace($DataToInsert, @TAB, "\t")
	$DataToInsert = StringReplace($DataToInsert, @CRLF, "\r\n")
	_SciTE_Send_Command(0, $Scite_hwnd, "insert:" & $DataToInsert)
EndFunc   ;==>_InsertIntoScite

;
; Send command to SciTE
Func _SciTE_Send_Command($My_Hwnd, $Scite_hwnd, $sCmd)
	;----------------------------------------------------------------------------------------------
	If $DebugIt Then _DebugPrint ('_SciTE_Send_Command-->' & $sCmd)
	;----------------------------------------------------------------------------------------------
	Local $CmdStruct = DllStructCreate('Char[' & StringLen($sCmd) + 1 & ']')
	If @error Then Return
	DllStructSetData($CmdStruct, 1, $sCmd)
	Local $COPYDATA = DllStructCreate('Ptr;DWord;Ptr')
	DllStructSetData($COPYDATA, 1, 1)
	DllStructSetData($COPYDATA, 2, StringLen($sCmd) + 1)
	DllStructSetData($COPYDATA, 3, DllStructGetPtr($CmdStruct))
	_SendMessage($Scite_hwnd, $WM_COPYDATA, $My_Hwnd, DllStructGetPtr($COPYDATA), 0, "hwnd", "ptr")
	$CmdStruct = 0
EndFunc   ;==>_SciTE_Send_Command
#endregion End functions for Send/Recieve with SciTE
