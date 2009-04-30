=========================================================
程序名称:Autoit
程序版本:3.3.X.X 第一汉化版
汉化作者:thesnoW
中文论坛:http://www.autoit.net.cn
=========================================================
绿色安装方法:解压缩到 任意目录.
绿色卸载方法:不爽删除就是.
正常安装方法:直接运行自解压程序.
正常卸载汉化:使用AU3工具箱>程序相关设置>卸载这个程序.
命令行安装  : "au3tool.exe /s"
命令行卸载  : "au3tool.exe /u"
autoit工具箱提供了安装卸载功能.
=========================================================
	[H]汉化 [G]官方 [!]更新 [*]修正 [+]新增 [-]移除
=========================================================
3.3.X.0 (2009-X-X) (第一汉化版)
Autoit:
[H][+]新增:工具箱支持在线更新汉化版本(测试阶段)
[H][!]更新:更新汉化的例子.
[H][!]更新:更新汉化的帮助.
Scite:
[H][!]更新:更新SCITE为1.78 20090427版本.
[H][+]新增:增加两个新的SCITE接口表,SciTe\api\Scintilla.iface 和 IFaceTable.cxx
KODA:
[G][*]修正: TAObj control loose it's dimensions after reloading [FS#40] (thanks BaKaMu)
[G][*]修正: font for the TAdate control is not generating [FS#39] (thanks BaKaMu)
ADF:
[H][+]新增:_API_CoInitialize,_API_DllRegisterServer,_API_DllUnregisterServer三个ADF.用于注册DLL.
[H][+]新增:AddFontResourceA,AddFontResourceW,RemoveFontResourceA,RemoveFontResourceW,WM_FONTCHANGE五个ADF.用于注册字体.

3.3.0.0 (2009-4-4) (第三汉化版)
Autoit:
[H][*]修正:AU3工具箱无帮助/无WMI查看器的问题.
[H][+]新增:Microsoft Spy++ 9.0中文版(英文版不移除)
[H][!]更新:汉化部分例子程序.
[H][!]更新:Autoit工具箱增加帮助项目,WMI项目,以及解决SVN更新后直接安装的问题.
Scite:
[H][-]移除:移除部分过时或者不工作的工具.
[H][+]新增:ACNWrapper 支持指定一个EXE或者DLL作为文件图标(采用文件中的第一个图标)
[H][!]更新:ACNWrapper 支持对控制台输出文本的替换(用于汉化),参考 SciTe\ACNWrapper\TranslateError.ini
[H][+]新增:ACNWrapper 版本属性中,支持\n \r换行, \t为制表符, \xtm为™, \xcp为© , \xrt为®.
[H][!]更新:对ACNWrapper程序的优化.对路径更智能的判断.
[H][*]修正:修正CTRL+J在UserInclude包含目录的文件无法跳转的问题.
[G][!]更新:更新TIDY(代码整理)到2.0.27.0
[G][!]更新:更新Obfuscator(代码迷惑)到1.0.26.9
KODA:
[G][!]更新:更新到 Beta 1.7.0.10 (2009-03-25) RC1
[G][*]修正:将ACN汉化的语言文件加入KODA官方.
[G][*]修正:导入文件后时得到错误的客户区宽度,高度与坐标 [FS#36] (thanks Zedna)
[G][+]新增:特殊"控件组"控件[FS#19] (thanks Zedna)
AUF:
[H][+]新增:指由ACN收集的,编写的UDF.目前由SxD进行SVN维护.

3.3.0.0 (2009-2-24) (第二汉化版)
Autoit:
[H][-]移除:Send2A3X(过老)
[H][!]更新:Autoit工具箱使用ini配置文件定义菜单.
[H][!]更新:程序更新移除汉化版本信息.
[H][!]说明:汉化版不再以小版本表示(如3.3.0.0.1).和官方同样表示(3.3.0.0).
[H][!]更新:Autoit帮助汉化版本更新为SVN39
UDFs:
[H][!]更新:UDF帮助汉化版本更新为SVN39
[H][+]新增:UDF: FTP.au3,用于操作FTP
[H][-]移除:_FileListToArrayNew2g.zip,官方UDF已经存在.
SCITE:
[G][!]更新:更新TIDY(代码整理)到2.0.25.0
[G][!]更新:更新Obfuscator(代码迷惑)到1.0.26.8
[H][!]更新:更新SCITE为1.78版本.
Koda:
Beta 1.7.0.9 (2009-02-09)
[G][*]修正: AU3导入时 "-1" 句柄问题.
[G][+]新增: 可以给按钮选择一个标准的小图标(thanks socratessa)
[G][*]修正: handling of CustomPath where was icons with index (thanks socratessa)
[G][*]修正: Koda 可以操作未压缩的 256x256 Vista 图标
[G][*]修正: 窗口排列计算错误 (thanks Valik)
[G][*]修正: 在更新脚本时缩排 (thanks Valik)
[G][*]修改: 在 Updown 控件中输入一个错误值出现的问题 (thanks Valik)
[G][*]修正: 状态栏与最后的面板排列问题 (thanks Zedna)
[G][*]修正: 在主图标列表中出现按键不灵的问题 (thanks Zedna)
[G][*]修改: order of menus in code generator output to fix "main menu" issue (thanks Zedna)



3.3.0.0 (17:27 2008-12-31) (正式版)
Autoit:
[G][!]说明:未修改.
[H][!]更新:汉化版本对VISTA/2008/7系统的兼容性.
UDFs:
[G][!]说明:有新增函数.下一个版本再说明.

3.2.13.13 (1:52 2008-12-23) (Beta)

AutoIt:
[G][+]新增: #744: StringFromASCIIArray() 和 StringToASCIIArray() 现在允许指定编码.
[G][*]修正: Send() 在使用{ASC 0xNNNN}格式时错误是插入了一个前导零(0).
[G][*]修正: DllStructSetData() 不能正常的终止以前使用的字符串缓冲区.
[G][*]修正: #743: AutoIt 当托盘函数使用无效ID时崩溃.
[G][*]修正: #748: AutoIt 使用 DllCall(0,...) 时崩溃.
[G][!]更新: #734: StringRegExpReplace() 文档向后引用(参考)
[H][!]更新: 更新代码迷惑为1.0.25.0.
[H][!]更新: 更新代码整理(TIDY)为2.0.24.4.
[H][+]新增: 完美皮肤DLL(USKIN3.0)
[H][!]更新: skinengine(皮肤引擎3.54)
[H][+]新增: skinengine的十几二十个皮肤.
[H][!]注意: 此版开始默认使用UNICODE编码编译,如果不正常,请修改预编译信息的#AutoIt3Wrapper_UseAnsi=y

UDFs:
[G][!]更新: _SQLite 3.6.6.2 -> 3.6.7

3.2.13.12.1 (2:04 2008-12-11) (Beta)
NOTE:官方目前未发布文档更新,暂时停止更新文档.

AutoIt:
[G][*]修改: #596: StringFromASCIIArray() and StringToASCIIArray() now correctly handle embedded terminators.  Also, StringToASCIIArray() no longer inserts a trailing 0 into arrays.
[G][*]修正: 当使用BinaryToString()中有无效的UTF16输入字符串时程序崩溃.  BinaryToString() 现在有了新的 @error 代码来支持无效输入的诊断.
[G][*]修正: ControlGetText() 在上一个beta的不稳定表现.
[G][!]更新: Shutdown 文档.
[H][*]修正: SCITE汉化错误(感谢kxbit)
[H][!]更新: SCITE为SVN 2008-12-7的代码(主要更新Scintilla的健壮性以及对新语言的支持,虽然我们用不着).
UDFs:
[G][+]新增: _GDIPlus_StringFormatSetAlign (monoceres)

[G][!]更新: StringAddThousandsSep params in regards to #442
[G][!]更新: _SQLite 3.6.5 -> 3.6.6.2
[G][!]更新: #733: _GUICtrlButton_SetImageList 的文档
[G][*]修正: #693: _DateTimeFormat() 时间格式
[G][*]修正: #701: _GUICtrlListView_ClickItem() 当点击在错误的空间时 $fMove = True
[G][*]修正: #700: _GUICtrlTreeView_ClickItem() 当点击在错误的空间时 $fMove = True
[G][*]修正: #703: _GUICtrlListBox_ClickItem() 当点击在错误的空间时 $fMove = True
[G][*]修正: #705: _GUICtrlToolbar_ClickButton() 当点击在错误的空间时 $fMove = True
[G][*]修正: #707: _GUICtrlMonthCal_Create() 宽度与高度



3.2.13.11 (2008-11-17) (Beta)

AutoIt:
[G][*]修正: #669: Dec() 例子排版.
[G][*]修正: #659: 文档中 UNC 路径(网络路径)不支持时使用 FileSelectFolder().
[G][*]修正: #671: 使用 $WS_EX_MDICHILD 时如果未指定父窗口,程序崩溃.

AutoItX:
[G][+]新增: COM: WinList 方法.
[G][*]修正: Native DLL: 返回字符串有时会意外终止.
[G][*]修正: PixelChecksum() 不返回修正值.

UDFs:
[G][*]修正: #674: _GUICtrlTab_ClickTab() 当点击在错误的空间时 $fMove = True
[G][!]更新: _SQLite 3.6.4 -> 3.6.5
[G][!]更新: #442: _StringAddThousandsSep() 允许局部设置

3.2.13.10.1 (14:04 2008-11-12) (Beta)

AutoIt:
[G][+]新增: #645: IniDelete() 现在支持默认关键字为第三个参数.
[G][*]修正: #628: GuiCtrlRead($ctxmenu, $adv) 返回错误的值 (Saunders)
[G][*]修正: #640: PCRE 不支持 \L, \l, \N, \U, or \u : 文档更新
[G][*]修正: StringToASCIIArray() 崩溃 (Part of issue #596).
[G][*]修正: #646: Call() now sets specific @error and @extended values when it fails to find a function.
[G][*]修改: StringToASCIIArray() 与 StringFromASCIIArray() 使用 UNICODE 代码 (Part of issue #596)
AutoItX:
[G][*]修正: 上一BETA版本中一些 unicode 引起的相关问题.
UDFs:
[G][+]新增: _StringExplode() (WeaponX)
[G][*]修正: #610: _WinAPI_CreateFile() 打开文件失败返回错误值.
[G][*]修正: #619: _GUICtrlListView_SetItemSelected 内存分配问题.
[G][*]修正: #617: 更新修正6个 GDI+ ImageGet 帮助文件例子.
[G][*]修正: #621: _StringAddThousandsSep 不工作于负数.
[G][*]修正: #635: _GuiCtrlTab_ClickTab() 文档列表未使用 $fPopupScan 参数.
[G][*]修正: #650: 丢失 BorderConstants.au3
[G][*]修正: #656: 当文件只有一行时 _FileCountLines 返回0的问题.
[G][*]修改: _Soundxxxx 函数 (RazerM)
[G][*]修改: #599: _FileListToArray 速度优化 (code65536)
[G][*]修改: _SQLite 3.5.9 -> 3.6.4.
SCITE:
[H][!]更新: Merged the updates of SciTE v 1.77 by Neil Hodgson with our own version of SciTE v 1.77. (thesnow)
11/2/2008
[G][!]更新: Merged the updates of SciTE v 1.77 by Neil Hodgson with our own version of SciTE v 1.77. (Jos)
[G][!]更新: Tidy.exe v2.0.23.24 (Jos)
[G][*]修正: some reported report issues.
[G][!]更新: Obfuscator.exe v1.0.24.23 (Jos)
[G][*]修正: internal changes and fixes.
--------------------------------------------------------------------------------------------------
10/20/2008
[G][!]更新: AutoIt3Wrapper_Gui/AutoIt3Wrapper v1.10.1.14 (Jos)
[G][*]修正: Removed #RequireAdmin causing issues when running in "User" mode.
[G][!]更新: Tidy.exe v2.0.23.23 (Jos)
[G][+]新增: remove comments option for EndFunc and EndRegion. (see documentation for details) 
[G][*]修正: recognition of ]then and )then on an line with If statement.
[G][*]修正: recognition of Enum declared variable and continuation character after Global.

3.2.13.9 (12th October, 2008) (Beta)
AutoIt:
[G][*]修正: #601: Tooltip return 0 when title length >99.
[G][*]修正: #608: listView GUICtrlSetBkColor not redrawn.
[G][*]修正: Regression in writing Unicode files introduced in 3.2.13.8.
UDFs:
[G][*]修正: #600: _ArraySearch fails with 2D array.
[G][*]修正: #603: _FileReadToArray() does not return an array if the file contains only a single line of text.

3.2.13.8.1 (4/10/2008) (Beta)
AutoIt:
[G][+]新增: #454: $FO_UTF8 允许 FileOpen() 在使用读取模式时读取 UTF8 文件不需要 BOM.
[G][+]新增: $FO_UTF16_LE, $FO_UTF16_BE 允许 FileOpen() 在使用读取模式时读取 UTF16 文件不需要 BOM.
[G][*]修正: #501: ProcessGetStats() 失败于进程运行于其它用户 (包括系统).
[G][*]修正: #92: DllStruct 数据使用 char[]/wchar[] 时,数据被删减的问题.
[G][*]修正: #562: 指定标题属性导致其他属性丢失(窗口标题匹配).
[G][*]修正: GuiCtrlSetState($graphic, $GUI_HIDE) 不能隐藏.
[G][*]修正: GuiCtrlSetResizing($graphic, ) 不能移动.
[G][*]修正: GuiCreate(...,不带标题的样式) 不能严格的设置窗口大小.
[G][*]修正: GuiSetStyle(标题修改) 不能严格的设置窗口大小.
[G][*]修正: GuiCtrlSetState($listviewitem) 不能返回错误.
[G][*]修正: #569 TCPRecv 文档例子.
[G][*]修正: #589: 一些比较操作不能返回布尔值.
[G][*]修正: #583: @MSEC 在文档中描述错误.
[G][*]修正: #574: Using 0 for the SendKeyDelay or SendKeyDownDelay removes the respective delay when using Send().
[G][*]修正: #542: 崩溃于正则表达式.
[G][*]修正: #531: 改写了一些关于 GUICtrlSetGraphic()的注释(帮助文档).
[G][*]修正: #539: StringSplit() 使用标志 2 并且不匹配分隔符不能返回完整字符串的问题(应该返回).
[G][*]修改: PCRE 正则表达式引擎更新到 7.8.
[H][!]更新: SPY++ 更新为9.0版(VS2008中提取)
UDFs:
[G][*]修正: #495: _GUICtrlTreeView_GetTree returns only 1 parent
[G][+]新增: _WinAPI_CreatePen, _WinAPI_DrawLine, _WinAPI_LineTo, _WinAPI_MoveTo, _WinAPI_GetBkMode, _WinAPI_SetBkMode (Zedna)
[G][*]修正: #503: _Date_Time_FileTimeToLocalFileTime example (cbruce)
[G][+]新增: _ArrayCombinations, _ArrayPermute, _ArrayUnique (litlmike)
[G][*]修正: #510: _GUICtrlListView_ClickItem: If columns inside listview exceed visible area, clicks outside of the control
[G][+]新增: _GDIPlus_ImageGetFlags, _GDIPlus_ImageGetHorizontalResolution, _GDIPlus_ImageGetPixelFormat, _GDIPlus_ImageGetRawFormat
         _GDIPlus_ImageGetType, _GDIPlus_ImageGetVerticalResolution (rover)
[G][+]新增: _PathGetRelative (wraithdu)
[G][*]修正: #500: _ChooseColor run on 64bit
[G][*]修正: #517: WinAPI UDF - bad error checking after DllCall()
[G][+]新增: _WinAPI_CombineRgn, _WinAPI_CreateRectRgn, _WinAPI_CreateRoundRectRgn, _WinAPI_SetWindowRgn (Zedna)
[G][*]修正: #533: Array functions dimension check
[G][*]修正:: various Timer Functions
[G][*]修正: #506: _FileCountLines deal with all common line-end-chars
[G][*]修正: #485: WinAPI 在帮助文件中丢失相关链接
[G][*]修正: #571: return value doc for _GUICtrlListBox_FindString, _GUICtrlListBox_GetAnchorIndex and _GUICtrlListBox_GetText
[G][*]修正: #586: _GuiCtrlListView_SetGroupInfo() destroyed group ID's.
[G][*]修正: #516: _ChooseFont 运行于 64位 系统
[G][*]修正: #595: _WinAPI_SetWindowsHookEx 帮助文件详细信息中的 $WH_KEYBOARD_LL
sqlite:
[H][!]更新: sqlite3.exe 更新为3.63版.
[H][!]更新: tclsqlite3.dll 更新为3.63版.
[H][!]更新: sqlite3.dll 更新为3.63版.
[H][!]更新: sqlite3_analyzer.exe 更新为3.61版
[H][!]更新: sqlite_文档更新为 3.63版.
scite:
[H][!]更新: 代码迷惑Obfuscator更新为1.0.24.23版.
[H][!]更新: 代码整理tidy更新为2.0.23.24版.
[H][!]更新: PCRE正则表达式测试更新为 7.8 版.
koda:
Beta 1.7.0.8 (2008-10-03)
[G][*]修正: 一些小的修正和对新代码的清理(2008-10-03)
[G][+]新增: 按钮可以支持颜色(2008-10-02)
[G][*]修改: 重写按钮控件支持新图标的代码(2008-10-02)
[G][+]新增: Picture editor may be invoked by doubleclick too(2008-10-01)
[G][*]修改: method of working with custom picture paths (changed method of loading break this anyway)(2008-10-01)
[G][*]修改: speedup loading of new Icon control, when icon loading from large libraries(2008-10-01)
[G][*]修正: Form Captor example generated non-closed warning tag that cause conversion failure(2008-09-30)
[G][+]新增: poFixed for form, where actual position not depend on form position (idea by Valik)(2008-09-30)
[G][*]修改: rewritten Picture Editor to support new Icon and other controls(2008-09-29)
[G][*]修改: rewritten Icon control (now much closer to an actual Autoit control & hi-color icons support)(2008-09-27)
[G][+]新增: help handlers and ID's to all property editors(2008-09-24)
Beta 1.7.0.7 (2008-09-24)
[G][*]修改: 完成重写图标支持, 现在已经支持高颜色图标(2008-09-24)
[G][*]修正: using wrong row when changing icon in list after deleting one of icon (感谢 Zedna)(2008-09-5)
[G][*]修正: AV when deleting (attached) context menu (long time bug)(2008-09-5)
[G][*]修正: AV when deleting attached toolbar or imagelist (感谢 Zedna)(2008-09-5)
[G][*]修正: AV when invoke taborder dialog on toolbutton (感谢 Zedna)(2008-09-5)
[G][*]修正: 标签对话框中没有工具栏图标 (感谢 Zedna)(2008-09-5)

3.2.13.7.2 (9:56 2008-9-22)
Scite:
[H][!]更新: 更新代码迷惑为1.0.24.21.
[H][!]更新: 更新代码整理(TIDY)为2.0.23.20.
[H][!]更新: 更新SCITE为CVS 2008-9-13(增强对会话的管理以及对部分其它程序语言的加强)
[H][*]修正: SCITE使用小键盘"-"不能添加注释的问题.
Koda:
Beta 1.7.0.6 (2008-09-03)
2008-09-03 [G][*]修改: experimental feature - not keep bitmaps inside form anymore (not supported customized paths yet)
2008-09-03 [G][+]新增: code generator part for toolbar/imagelist
2008-09-02 [G][+]新增: alignment for ListView columns
2008-09-02 [G][*]修正: form modified flag not set when editing properties (thanks Zedna)
2008-09-01 [G][+]新增: new imagelist implementation, icon resources
2008-05-10 [G][+]新增: initial toolbar and imagelist implementation

3.2.13.7.1 (13:53 2008-8-12) (Beta)
AutoIt:
[G][*]修正: 程序员犯一个低级错误!(Run函数).
[G][+]新增: #481: 在SplashTextOn()中的文本边上显示11像素. (参考 Vista UI 手册).
[G][+]新增: #468: 添加 @MSec 宏macro 获得当前秒的当前毫秒.
[G][+]新增: #277: @CPUArch 返回处理器兼容信息.
[G][*]修改: 编译优化(DEP/Image randomization 连接器选项).
[H][!]ACNWrapper汉化更新,并支持指定ICO图标文件时不需要加.ico。


3.2.13.6 (30-07-2008) (Beta)
AutoIt:
[H][!]更新: TIDY(代码整理)
[H][!]更新: Obfuscator(代码迷惑)
[G][*]修正: #475: StringSplit() 空分割符不工作的问题.
[G][*]修正: #464: 演示脚本 GUICtrlCreateAvi() 不能工作于 Vista的问题.
[G][+]新增: #328: StringToASCIIArray(), StringFromASCIIArray() functions.
[G][+]新增: New flag to Run()/RunAs() to fix issue #415 (添加新的 Constants.au3 常量: $STDIO_INHERIT_PARENT).
[G][+]新增: New flag to all Run functions for better CUI compatibility (添加新的 Constants.au3 常量: $RUN_CREATE_NEW_CONSOLE).
[G][*]修改: #393: 说明文档中 SoundSetWaveVolume() 在Windows Vista与其他系统工作方式不同.
[G][*]修改: PCRE 正则表达式引擎更新到7.7.
UDFs:
[G][+]新增: _ExcelHorizontalAlignSet, _ExcelFontSetProperties, _ExcelBookAttach (litlmike)
[G][*]修正: Excel 例子
[G][+]新增: _WinAPI_SetEndOfFile, _WinAPI_SetFilePointer (Zedna)
[G][*]修正: #465: _DateTimeSplit 第二个默认值为 -1, 现在默认为 0
Aut2Exe:
[G][+]新增: #460: 更多可能出现的 UPX 错误.

3.2.13.5 (24-07-2008) (Beta)
AutoIt:
[G][*]修正: #449: @SystemDir 不能返回 SysWOW64 (64位系统中的32位模式).
[G][*]修正: #440: 当脚本以 EOF (0x1A)结束时产生错误.
[G][*]修正: 当使用上次的图标编译时,编译器崩溃的问题.

3.2.13.4 (19-07-2008) (Beta)
AutoIt:
[G][*]修正: #346: FileOpenDialog/FileSaveDialog 筛选器长度限制的bug.
[G][*]修正: #387: 当函数使用一个无效的句柄时,DllClose() 和 DllCallbackFree() 崩溃.
UDFs:
[G][+]新增: #334: _SQLite 3.5.9 x86 和 X64 版本.
[G][*]修正: #422: _GDIPlus_GraphicsSetSmoothingMode $iSmooth 只能接受 0 - 4, 文档已经更新.
[G][+]新增: 缺失的 FrameConstants.au3
[G][+]新增: Excel UDFs
[H][!]更新: GuiComboBox 文档
Aut2Exe:
[G][*]修正: #436: 当使用GUI方式编译时,压缩等级忽略的BUG.

3.2.13.3 (22-06-2008) (Beta)
AutoIt:
[G][*]修正: #381: DirCreate() 会产生垃圾变量(旧的BUG带来,在优化时发现).
UDFs:
[G][*]修正: #388: _GUICtrlToolbar_SetButtonSize 例子.
[G][*]修正: #400: SQLite.dll.au3 @ProcessorArch 替换 @OSArch
[G][*]修正: #390: _viPrintf 替换返回值
[G][+]新增: _Timer_GetIdleTime, _WinAPI_GetWindowPlacement, _WinAPI_SetWindowPlacement (PsaltyDS)

3.2.13.2 第一汉化版(9:02 2008-6-20)
[H][*]修正:AU3TOOL中对autoit3a.exe的判断.
[H][*]修正:修正scriptomatic中部分汉化问题.
[H][-]移除:AU3TOOL中对ANSI版本的支持.多编译器的支持.
[H][!]更新:Dependency Walker更新为2.2.6000.0
AutoIt:
[G][*]修改: @ProcessorArch 修改为 @OSArch .不改有点使人误解的嫌疑.(处理器构架改为系统构架)
[G][*]修改: RegRead() and RegWrite() 的大小限制移除(以前版本使用 64KB 限制于一些注册表类型).
[G][*]修改: RegRead() and RegWrite() 不再使用 hex 字符串于 REG_BINARY 类型 - 强制使用native binary 数据类型.
[G][*]修正: #380: @OSVersion 识别 Windows XP 64-bit 版本.
[G][*]修正: 从上一个beta增强内存(Increased memory use since last beta).
UDFs:
[G][*]修正: #371: _GDIPlus_Startup 返回值. (wraithdu)
[G][*]修正: #368: _ArrayToClip 返回值.

3.2.13.1 第一汉化版(8:57 2008-6-10)
[H][!]更新:更新代码迷惑为1.0.24.19.
AutoIt:
[G][+]新增: 新的StringSplit()标志用于不返回0维的COUNT.
[G][*]修正: #358: 安装目录文档更清洁. (thanks Zedna)(汉化版本不存在此问题).
[G][*]修正: #355: Child not visible beta regression. (Thanks Ultima)
[G][*]修正: #366: AutoIt 崩溃于错误的表达式.
[G][*]修正: #360: RunAs() 运行于 Windows 2000.
[G][*]修正: #367: STDIO 函数在编译的脚本中可以工作了.
[G][-]移除: #357: @AutoItUnicode 宏.
UDFs:
[G][+]新增: 新增 _GUICtrlTab_ClickTab (Gary)
[G][*]修正: #361, #362: _GUICtrlListView_InsertItem 文档 (Zedna)
[G][-]移除: 移除 _StringSplit, 不需要了,程序内置.
[G][+]新增: _GUICtrlComboBoxEx_GetUnicode, _GUICtrlComboBoxEx_SetUnicode (Gary)

3.2.13.0 (7th June, 2008) (Beta)
AutoIt:
[G][*]修正: #309: RunAs() 与 RunAsWait() 现在使用 @SystemDir 为工作路径替代@WorkingDir,用户指定的工作路径不再有效.
[G][*]修正: #325: contextmenuitem 不能发生事件(事件模式).
[G][*]修正: #305: GUICtrlSetFont() for Combo causing highlight.
[G][*]修正: #318: GUICtrlSetTip() 于 TreeViewItem 必须返回 0.
[G][*]修正: #282: 标签切换时图标透明刷新.
[G][*]修正: #339: GUICtrlDelete() 崩溃.
[G][*]修正: #345: @OSVersion 识别 Windows 2008.
UDFs:
[G][*]修正: #285: _ChooseColor 例子 (water)
[G][*]修正: #299: _GUICtrlTab_SetItemText 缓存长度增加(Unicode) (benners)
[G][*]修正: #292: _EventLog__Clear 不能清除日志,然后备份参数会为空.
[G][!]更新: #290: _GDIPlus_DrawImagePoints (Zedna)
[G][*]修正: #258: _ClipBoard_GetData
[G][*]修正: #294: _FileReadToArray 文件中无 @LF 的识别.(GEOSoft)
[G][+]新增: _GDIPlus_GraphicsFillPolygon (smashly)
[G][*]修正: #303: Clock.au3 在 Examples\GUI\Advanced (thanks Jon)
[G][*]修正: _GUICtrlListView_SetItemEx 文本缓存. (thanks wraithdu)
[G][*]修正: #320: _WinNet_EnumResource struct pointers (thanks arcker)
[G][*]修正: #321: _GUICtrlStatusBar_GetText 缓存长度增加(Unicode)
[G][+]新增: #332: 备注 _GUICtrlStatusBar_Create


3.2.12.0 第一汉化版(20:54 2008-5-21)(正式版)
[H][!]更新:ACNWrapper 使用3.2.9.14.2编译(新版函数修正很麻烦)
[H][!]更新:更新UPX为3.03版本.
[H][!]更新:TIDY(代码整理)为2.0.23.14.
[H][!]更新:Obfuscator(代码迷惑)为1.0.24.17.
[H][-]移除:Winspector(一个窗口信息查看程序,汉化版中已包含SPY++)
[H][-]移除:UserTip(用户提示)
[H][-]移除:VS2005ImageLibrary.zip(VS2005图像库)
[H][-]移除:部分ICON图标.
[G][!]官方更新请参考帮助文档.
