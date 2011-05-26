=========================================================
程序名称:AutoIt
程序版本:3.3.7.2 第一汉化版 PRE
汉化作者:thesnoW(ALL),Sxd(ADF),rikthhpgf2005(ADF),kodin(Example)
中文论坛:http://www.AutoItX.com
=========================================================
绿色安装方法:解压缩到 任意目录.
绿色卸载方法:不爽删除就是.
正常安装方法:直接运行自解压程序.
正常卸载汉化:使用AU3工具箱>程序相关设置>卸载这个程序.
命令行安装  : "au3tool.exe /s"
命令行卸载  : "au3tool.exe /u"
AutoIt工具箱提供了安装卸载功能.
=========================================================
	[H]汉化 [G]官方 [!]更新 [*]修正 [+]新增 [-]移除
=========================================================
3.3.7.2 (2011-05-26) 第一汉化版 PRE
3.3.7.2 (Beta)
[G][!]新增: 在 DllStructCreate() 中使用 Struct/EndStruct 来解决 X86/X64 数据对齐问题.
[G][!]更新: 使用 VC10 编译(VS2010). 解决 Win2000/XP 下 AutoIt, Aut2Exe, Au3Info, Au3Check 和 AutoItHelp的执行问题.
[G][*]修正: #1860: DriveStatus 空参数下返回READY.
[G][*]修正: #1854: StringIsFloat 在非浮点数上返回 1.
[G][*]修正: #1910: 修改 $TTN_GETDISPINFO 为 $TTN_GETDISPINFOW.
[G][*]修正: #1844: SplashTextOn 当使用opt(可选参数)和@CRLF / @LF时损坏变量.
[G][*]修正: #1932: 卸载器, 注册表, 应用程序路径. (+beta).
[G][*]修正: #1929: SetMenuColor() 不能工作于64位系统.
[G][*]修正: #1479: 64位 ListView WM_NOTIFY 消息.

UDFs:
[G][*]修正: #1920: Security.au3 中第 85 行的错误报告导致脚本崩溃
[G][*]修正: #1895: _GUIScrollBars_Init() Bug.
[G][*]修正: #1891: _ArrayDisplay (......,i$iTranspose,...) 描述错误.


3.3.7.1 (Beta)
[G][*]修正: 一些文件未使用静态库编译.


3.3.7.0 (Beta)
AutoIt 3.3.7.1 (2011-05-25):
[G][*]修正: #1040: _ScreenCapture_Capture(): 光标捕捉时 GDI 对象泄漏.
[G][*]修正: #1599: TraySetItemText() 回到默认菜单项目.
[G][*]修正: #1282: 当GUI创建时 WinMove 前调用 GUICtrlSetPos 的问题.
[G][*]修正: #1397: HotKeySet() 不能检测部分俄文键盘.
[G][*]修正: #1531: 输入框,编辑框,列表,组合框,上下按钮在黑色系统主题下的文本颜色. 
[G][*]修正: #1617: GuiCreate 创建失败后,当 AutoIt 退出时,GuiDelete 可能泄漏到一个循环(loop).
[G][*]修正: #1596: GUICtrlSetPos() 默认(default) = 无修改.
[G][*]修正: #1485: ContinueCase 时崩溃.
[G][*]修正: #1626: TCPRecv()/TCPSend() 文档关于 Unicode 传输.
[G][*]修正: #1653: WM_KEYLAST Windows 2000 消息文档.
[G][*]修正: #1669: StringRegExpReplace() 文档中关于替换字符串中含有双反斜杠 "\".
[G][*]修正: #1673: WinGetProcess() 文档例子.
[G][*]修正: #1677: 多级循环中出现无效ContinueLoop.
[G][*]修正: #1684: FileRead() 二进制读取内存分配错误.
[G][*]修正: #1685: BitRotate() shift 参数.
[G][*]修正: #1734: GUICtrlCreateAVI() 崩溃于负子字段.
[G][*]修正: #1923: 当 FileOpen/FileClose 时消耗大量内存.
[G][*]修正: #1883: IsHWnd(), 返回值. (问题: 值(Value) = 布尔(Bool)).
[H][!]更新: ACNWrapper GUI控件位置修正.
[H][!]更新: ACNWrapper 对 au3check 的汉化的补全.
[G][!]更新: WinAPIEx UDF库 更新到3.3版.
[G][!]新增: WinHttp 1.6.1.8 UDF库.
[H][-]移除: 移除AU3TOOL.exe对配置文件的修正,目前已由SciTe处理.
[H][!]更新: MPRESS 更新到2.18版.

AutoItX:
[G][*]修正: #1686: AU3_PixelSearch 崩溃.

UDFs:
[G][!]新增: _DebugSetup() 可以报告到一个记事本窗口.
[G][!]新增: #1371: 允许默认关键字于 _TempFile().
[G][!]新增: #1527: Test example to have doc example working.
[G][!]新增: #1636: _Security__LookupAccountSID() 在远程系统工作.
[G][!]新增: #1569: _ArraySearch() $iPartial (->$iCompare) 扩展为支持匹配相同类型变量.
[G][!]新增: #1557: VK_xBUTTON 于 Constants.au3.
[G][*]修正: #1542: _DebugSetup() 关闭后使用GUI句柄事件.
[G][*]修正: #1549: _SQLite_Escape() crash for strings > 64K (> 3.3.0.0).
[G][*]修正: #1517: _GUICtrlListView_simpleSort with checkbox.
[G][*]修正: #1588: AUtoIt3.exe stay active for all processes using the Window report.
[G][*]修正: #1615: _GUICtrlTreeView_SetStateImageIndex() 在 index = 0 时.
[G][*]修正: #1620: _DebugOut() 或者 _DebugReportVar() 包含 '.
[G][*]修正: #1513: 允许 _GUI...() 使用通知回调 (LPSTR_TEXTCALLBACK).
[G][*]修正: #1608: _Crypt_EncryptFile() 时无法处理大于 1Mb 的文件.
[G][*]修正: #1644: _InetMail() 使用 Windows Live mail.
[G][*]修正: #1453: _Net_Share_ShareCheck 总是返回 0.
[G][*]修正: #1664: _GUICtrlTab_GetItem() 不返回文本.
[G][*]修正: #1671: _WinAPI_WideCharToMultiByte() 文档.
[G][*]修正: #1672: _WinAPI_GetObject() 引用 ANSI 版本.
[G][*]修正: #1665: _ScreenCapture_CaptureWnd() 当运行在 Aero 主题下的bug.
[G][*]修正: #1689: _Debug...() 不能使用代码迷惑.
[G][*]修正: #1712: _FileWriteFromArray() 崩溃在数组上.
[G][*]修正: #1754: _PathFull() 可选参数文档.
[G][*]修正: #1756: _GDIPlus_Startup() 错误时的漏洞.
[G][!]更新: _SQLite 3.6.22 -> 3.7.2.0

Au3Check:
[G][!]新增: #forcedef 定义 来强制定义变量定义为后式分配[Assign()].
[G][!]新增: -w 7 检查 ByRef 参数传递.
[G][*]修正: Const Enum 不正确错误.
[G][*]修正: 全局(Global)声明在函数中(func)不能检测.
[G][*]修正: #1051: no ERROR if keyword not followed by a separator as Local$a.

SciTe:
[H][+]新增: 新增$(AutoItPath)全局变量,用于替代以前设置中的绝对路径.
[H][!]更新: 修改$(SciteUserHome)全局变量路径由%APPDATA%改到SciTe目录下的UserHome路径下.
[H][!]更新: 将选项下的所有"导入配置"菜单项目放入"打开导入文件[I]"子菜单.
[H][!]更新: 更新SciTe到2.25版.
[H][+]新增: 新增快捷键CTRL+K,用于转换文本为AU3字符串表达式
[G][!]更新: 更新tidy为2.1.0.12
[G][!]更新: 更新代码迷惑为1.0.28.15

3.3.6.1 (2010-11-03) 第二汉化版
AutoIt:
[H][!]更新: MPRESS 更新到2.17版.
[H][+]新增: SPY++ VS2010 版.
[H][+]新增: WinHttp 1.6.1.7 UDF库.
[H][+]新增: BlockInputEx 1.5 UDF库.
[H][+]新增: WinINet 2010.01.02 UDF库.
[H][+]新增: SQLite数据库管理工具 SQLiteQuery.
[G][!]更新: WinAPIEx UDF库 更新到3.0版.
[H][*]修正: 修正AU3TOOL.exe被某卫士误报的问题.
[H][!]更新: 更新AU3工具箱(AU3TOOL),不再设置标题来检测是否重复运行.
[H][!]更新: 更新UPX到3.07版本,只是修复bug.

SciTe:
[H][!]更新: 更新SciTe到2.22版.
[G][*]修正: 修正lua脚本不能工作于中文目录的问题.
[H][!]更新: 可以修改au3.properties中的autoquote.au3.disable和autobrackets.au3.disable关闭自动补全.
[G][!]更新: 更新tidy为2.1.0.8
[G][!]更新: 更新代码迷惑为1.0.28.11
[H][!]更新: ACNWrapper 将在编译完成后通知系统进行图标刷新(win7中图标缓存的问题).

koda:
Release 1.7.3.0 build 252 (2010-07-30)
[G][*]修正: 语言文件小修正(俄语)
Beta 1.7.2.9 build 250 RC2 (2010-06-29)
[G][*]修正: partially, toolbars showing issue (thanks Spence)
[G][*]修正: AV when selecting non-existent recent file (thanks Fire)
[G][+]新增: release date to About dialog
[G][*]修正: crash when changing language in situations when code dialog was opened before

3.3.6.1 (2010-06-07) 第一汉化版
AutoIt:
[G][*]修正: #1515: FileOpen 总是在某些情况下总是使用独占模式打开文件.
[G][!]更新: WinAPIEx UDF库 更新到2.6版.
[H][*]修正: 工具箱中"编译一个脚本[&GUI]"失效的问题.
[H][!]更新: MPRESS 更新到2.15版.
[H][!]更新: 工具箱中对来自SVN的副本不再检测SciTe属性设置文件的编码.
		以支持新版本SciTe的UNICODE模式.
[H][!]更新: 工具箱中自动检测SciTe目录下setting.ini的配置,覆盖安装时不再弹出设置模板的消息框.
[H][!]更新: 更新UPX到3.05版本,只是修复bug.

SciTe:
[H][+]新增: 集成SciTe帮助于主帮助.
[H][+]新增: SciTe 新增加了打开文件所在目录的功能.
[H][+]新增: SciTe 新增括号,引号的自动补全功能.
[H][*]修正: 修正工具栏图标透明/带锯齿问题
[H][*]修正: ACNLUA 脚本中的打开include文件无法找到当前脚本目录下文件的问题.
[H][*]修正: ACNLUA 脚本中的插入书签行不可用的问题,并改名为[复制书签所在行到这里].
[H][*]修正: SciTe 中 LUA 脚本不能正常运行的问题(不影响AU3).
[H][*]修正: ACNWrapper 编译不带wrapper信息的脚本时出现变量未声明的问题.
[H][*]修正: ACNWrapper GUI编译处理脚本指定的非ICO图标的支持.
[H][!]更新: ScriptoMatic 生成的脚本能通过必须声明变量检查"Opt("MustDeclareVars", 1)"
[H][!]更新: 更新SciTe到2.12版本,程序已经完全UNICODE化(原先是ANSI的).目前已经相对稳定.
[H][!]更新: 更新SciTe的属性设置文件为UTF-8编码,以支持UNICODE.
[H][!]更新: ACNWrapper 对带有#AutoIt3Wrapper_NoBuild指令的脚本默认不再检查语法.
[G][!]更新: 更新tidy为2.1.0.1

koda:
Beta 1.7.2.8 build 247 RC1 (2010-04-15)
[G][*]修正:  menu separator "" not generating
[G][*]修正:  save button state not updated after end editing text in tree
[G][*]修正:  toolbars not saving when executing config dialog from toolbar context menu (thanks Zedna)
[G][*]修正:  option "use caption instead name" worked only for label (thanks Zedna)
[G][+]新增:  "show grid" option for graphic editor
[G][+]新增:  hourglass cursor when opening Object browser
[G][+]新增:  invoke Object browser by doubleclick
[G][*]修正:  various translation fixes (thanks Zedna)
[G][*]修正:  regression in "SciTe mode" (Koda not closed when click insert button) (thanks asdf8)
[G][*]修正:  form modified state was not set when changing styles [FS#123]
[G][*]修正:  missed $ at first variable in Resizing output [FS#122]
[G][*]修正:  poDesktopCenter not always generated -1 for position (thanks asdf8)
[G][*]修正:  GUI_SS_DEFAULT_GUI was not generated for GUI [FS#120]

Beta 1.7.2.7 build 241 (2010-03-25)
[G][*]修正: 创建窗体时使用撤销功能会崩溃
[G][*]修正: 删除Imagelist时(可能) AV(AV可能是指报病毒) 
[G][*]修正: 当删除Imagelist时, "Images" 属性将清除所有控件
[G][+]新增: option to show control caption (if exists) as default tree description
[G][+]新增: ability for rearrange tabs in Tab control (Alt+Left/Alt+Right)
[G][*]修正: subcontrols for Group/Tab are not showing in the tree after paste
[G][+]新增: Resizing property for Form, that set default resizing
[G][+]新增: ability to edit properties for multiple selected menu items
[G][+]新增: autogenerating hotkeys for Menu and ContextMenu
[G][*]修正: some init messages now show translated
[G][*]修改: optimized modules interaction (internal)
[G][*]修改: optimized translation initializing (internal)

Beta 1.7.2.6 build 229 (2010-03-15)
[G][+]新增: 模板库支持高色彩
[G][+]新增: 标准模板使用漂亮的图标
[G][*]修正: UpDown(上下按钮控件)事件位置错误 [FS#112] (thanks Luciano Scilletta)
[G][*]修正: 关闭一些窗口崩溃
[G][+]新增: double percent %% at beginning of string tell generator not parse all remainding string
[G][*]修正: ImageList (and other controls) can not be placed on toolbar anymore
[G][+]新增: ability to downloading new/localized help files from options dialog
[G][+]新增: forgotten help contexts
[G][*]修正: wrongly generating "default" styles for styles that have not them [FS#113] (thanks asdf8)


3.3.5.6 (2010-03-04) 第一汉化版
AutoIt:
[G][*]修正: 3.3.5.5版本中 StringRegExp() 函数被不小心移除掉.
[H][+]新增: 集成 WinAPIEx UDF库.

koda:
Beta 1.7.2.5 build 222 (2010-03-02)
[G][+]新增: generating GUI_SS_DEFAULT_* styles (non-zero) [FS#22]
[G][*]修正: revised all default/forced control styles
[G][+]新增: "Stretch" design-time property for Pic and Icon control [FS#111]
[G][*]修正: optimized Styles Editor and styles definition file
[G][*]修正: attached updown not saving it's value [FS#110]
[G][*]修改: nicer Spin control in the inteface
[G][*]修正: wrong font on "Reset" buttons under Win7 (maybe Vista too)
[G][*]修正: removed duplicated XP manifest
[G][+]新增: UAC-compatible association setting
[G][*]修改: "default menu" for TrayMenu is enabled by default
[G][+]新增: forgotten F2 hotkey for edit labels in tree

3.3.5.5
AutoIt:
[G][*]修正: #1475: TrayItemSetState($Value, $Tray_Checked) 不能正确启用已禁用的托盘项目.
[G][*]修正: StringToASCIIArray() 不能正确截断 UTF-16 中的 8 位(bits)值.

UDFs:
[G][*]修正: #1445: Documentation updated for _MemGlobalFree().
[G][*]修正: #1469: _GDIPlus_BitmapCloneArea() 文档更新.
[G][*]修正: #1466: _GUICtrlEdit_GetLine() 返回意外字符.

3.3.5.4
AutoIt:
[H][-]移除: 移除AppFace皮肤库,过老.
[H][-]移除: 移除Skin++皮肤库,过老.官方只接受定制.不再更新.
[H][-]移除: 移除SkinSharpForVC免费版V0.1.2,过老.
[H][-]移除: 移除SQLite Database Browser,过老,新版本过大.
[H][-]移除: 移除 ID3.au3 ADF库,原因:变量声明未通过检测.
[H][-]移除: 移除 Audio.au3 ADF库,原因:变量声明未通过检测.
[H][-]移除: 移除 _Joystick.au3 ADF库,原因:变量声明未通过检测.
[H][*]修正: 修正部分 ADF 变量声明未通过检测的问题.
[G][*]修改: FileWriteLine() performance improved.
[G][!]更新: 更新正则表达式测试工具pcretest到7.9
[G][+]新增: ControlCommand() "SendCommandID" - 用于发送 WM_COMMAND 控件 ID 消息. 
	允许自动化操作 ToolBarWindow32 控件(或者其他). 例如:
	Internet Explorer的"后退"按钮. 使用 Au3Info 从工具栏标签得到命令 ID.

[G][*]修正: #1458: Inet sizes were capped to 32-bits.
[G][*]修正: #1459: Hard crash when too much recursion is used.
[G][*]修正: #1464: Regular expressions with a single character * pattern were stopping after the first null match.
[G][*]修正: #1463: StringToASCIIArray() 使用 UTF8 字符时不正常工作.

Au3Info:
[G][*]修正: #1391: ToolbarWindow32 信息只显示第一个工具栏.
[G][*]修改: 更好的识别鼠标下方的控件 (现在...)

UDFs:
[G][*]修正: #1441: _GUICtrlRichEdit_GetText() 使用错误的缓冲区长度.
[G][*]修正: #1446: _ScreenCapture_Capture() was using height/width of 1 pixel less.

SciTe:
[H][*]修正: 修正切换等宽字体(Ctrl+F11)失效问题
[G][+]新增: "全局设置"中增加"Exit.NoAnimateWindow=1"用于关闭SciTe关闭时的淡出效果.
[G][!]更新: 更新tidy为2.1.0.0

koda:
Beta 1.7.2.4 build 214 (2010-02-18)
[G][*]修改: styles definition changed to new method of handling styles
[G][+]新增: support for handling state for certain styles [FS#107]
[G][+]新增: option to keep tree fully expanded or not
[G][*]修改: object tree now is not mandatory to be fully expanded
[G][+]新增: editable control's description in the object tree

Beta 1.7.2.3 build 207 (2010-02-11)
[G][*]修改: cleanups in property inspector code
[G][*]修改: control styles editor is fully rewritten to support multiple selection
[G][*]修正: serious flaw in translator [FS#101] (thanks Tlem)


3.3.5.3 (2010-02-08) 第一汉化版
AutoIt:
[G][*]修正: FileOpen() 不允许打开文件于写入模式时再以只读模式打开.
[G][*]修正: #1449: GUICtrlDelete() 不能工作于 for GUICtrlCreateDummy() 类型.
[G][*]修正: 使用RegDelete()函数可能导致的载入错误(Windows XP).

Au3Info:
[G][*]修正: #1444: 当应用程序控件离开焦点时,仍然被高亮(比如注册表编辑器).
[G][*]修改: 更好的鼠标下方控件的标识.

UDFs:
[G][*]修正: #1454: StringBetween() 不能正确工作.


3.3.5.2 (2010-02-06) (Beta)
AutoIt:
[G][*]修正: #1448: #OnAutoItStartRegister 不能工作于已编译脚本.
[G][*]修正: #961: RegDelete() 当使用32位版本的 AutoIt ,并使用HKLM64时不能很好的工作.

AutoItX:
[G][*]修正: 重新添加 .lib 文件(静态库).

UDFs:
[G][*]修正: #1438: 当使用 _ArrayCombinations() 时出现 AutoIt 错误.

SciTe:
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.28.4

KODA:
Beta 1.7.2.2 build 204 (2010-02-04)
[G][+]新增: option to not generate ImageList itself when using for Listview/Treeview
[G][+]新增: warning if user have outdated "styles.xml" file
[G][+]新增: forgotten styles for Toolbar buttons
[G][+]新增: ability to generate TreeView with icons
[G][+]新增: ability to generate ListView with icons
[G][*]修正: visual appearance of ListView control [FS#86]
[G][+]新增: checking of actual clipboard content on paste [FS#7][FS#57]
[G][+]新增: ability to save settings in the AppData folder under restricted account
[G][*]修正: crash when running Koda first time under restricted account (thanks Sh3llC043r)
[G][*]修正: small cosmetic issue with translation files (thanks Zedna)
[G][*]修正: various bugs with Graphic editor (thanks Zedna)
[G][+]新增: ability to generate tabs with icons (GUITab.au3 incluse used)
[G][*]修正: wrong styles visually appearing after form loading [FS#83] (thanks monter.FM)
[G][*]修正: events for menus generated in wrong place [FS#78]
[G][*]修正: event for Tab generated in wrong place [FS#87]
[G][+]新增: forgotten Icon property for TrayMenu
[G][+]新增: ability to copy Dummy controls [FS#60]
[G][*]修改: redone a bit invisible components handling (internal)
[G][*]修改: all Dummy controls are generating in one place [FS#51]
[G][*]修正: generating of custom image path with macro [FS#68]
[G][*]修正: index for GUI icon was not generated [FS#80]
[G][*]修正: enabled states for different items [FS#95] (thanks Tlem)
[G][*]修正: wrong include for Group [FS#90]
[G][+]新增: French language file (thanks Tlem)
[G][+]新增: Chinese(Traditional) language file (thanks rexx)
[G][*]修正: form position not reloaded when position is poFixed
[G][*]修正: flaw in saving form options (thanks martin)

3.3.5.1 (2010-01-27) 第一汉化版
AutoIt:
[G][*]修正: #1428: AdlibRegister/Unregister() 不能正确的区分函数名大小写.
[G][*]修改: Send() 和 ControlSend() 现在允许使用更多的Unicode字符,终于可以放弃SendX了.
[H][-]移除: 移除 SendX ADF函数.因为官方已经支持发送UNICODE字符.

Aut2Exe:
[G][*]修正: #1409: 转换快捷键 Ctrl+C 不再被支持. 现在是 Ctrl+G (Go),防止复制文本操作时被捕获.

SciTe:
[H][*]修改:删除行快捷键改为ALT+W,还原CTRL+D的功能.

3.3.5.0 (2010-01-24) 第一汉化版

AutoIt:
[G][+]新增: #1376: FileOpen() 模式参数现在是可选的(意思是可以不需要参数). 默认模式为读取.
[G][+]新增: #1054: 添加 FileGetEncoding().

AutoIt3Help:
[G][*]修正: #1423: "打开这个脚本" 按钮可能不工作.

SciTe:
[H][+]新增: 应kodin要求,增加SciTe的快捷键帮助.参考SciTe菜单>帮助>ACN SciTe说明

ADF:
[H][+]新增: 新增arcker的服务控制UDF(Services.au3/ServicesConstants.au3)
	以替换原有ServiceControl.au3(暂未移除)


3.3.3.3 (2010-01-10) 第一汉化版
AutoIt:
[G][+]新增: #1311: MouseGetCursor() 返回手型光标. 
[G][*]修正: #1403: 当 FileWrite() 使用 UTF8 时,输出流不能正确转换为 UTF8(by thesnoW).

SciTe
[H][*]修正: 修正ACNWrapper中选择图标与实际输出图标不对应问题.

UDFs:
[G][*]修正: #1398: 修复 GuiRichEdit.au3 函数中的$tagPARAFORMAT2数据结构声明.
[G][*]修正: #1353: _FileWriteToLine() 过分严格的检测输入文本类型.
[G][*]修正: SQLite.au3 变量错误于 _SQLite_FetchData, $iCharSize, _SQLite_QuerySingleRow,
	    _SQLite_GetTable2d, _SQLite_Display2DResult 函数(by jchd).

3.3.3.2 (2010-01-08) 第一汉化版
AutoIt:
[G][+]新增: FileRead() 可以使用@extended宏返回读取的字符/字节数量.
[G][+]新增: AutoIt 脚本使用换行字符 "_" 时不再限制每行最多只能 4095 个字符.
[G][*]修正: #1392: 使用 OnAutoItExitRegister() 时崩溃.
[G][*]修正: #1396: DllCallbackGetPtr() 函数使用一个无效句柄时崩溃.
[G][*]修正: #1352: StringSplit() 直接崩溃于二进制数据.

UDFs:
[G][*]修改: _SQLite 3.6.21 -> 3.6.22

SciTe:
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.28.4
[H][!]更新: 更新ACNWrapper更好的支持官方Wrapper的语法.

3.3.3.1 (2010-01-06) 第一汉化版
AutoIt:
[H][*]修正: 修正3.3.2.0第一汉化版中帮助文件运行脚本默认不在SciTe打开的问题.
[H][-]移除: 由于可以直接指定其它EXE/DLL作为图标源,移除部分图标.
[H][!]更新: 更新ResHacker到3.5.2.84.
[G][+]新增: #682: 移除 FileReadLine() 函数64KB限制
[G][*]修正: 使用Stdio重定位时崩溃.
[G][-]移除: InetGet("abort"), @InetGetActive 和 @InetGetBytesRead 正式移除.
[G][-]移除: AdlibEnable() 和 AdlibDisable() 正式移除.
[G][-]移除: OnAutoItStart 和 OnAutoItExit 正式移除.

SciTe:
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.28.3
[H][!]更新: 更新ACNWrapper到1.0.0.6,解决UPX压缩率不是最高以及64位编译的一些问题.
[H][+]新增: ACNWrapper新增64位压缩的支持(使用Mpress压缩).
[H][+]新增: 3.3.0.0 第三汉化版起 ACNWrapper 支持指定一个EXE或者DLL作为文件图标.
            现在可以使用[EXE/DLL文件名|图标索引]来指定图标了,不用再使用默认的第一个图标了.

UDFs:
[G][*]修正: #1389: _IEAttach() 调用多个项目时可能失败.

ADF:
[H][+]新增: 新增HASH解码编码的ADF.
[H][+]新增: 新增迅雷链,快车链,QQ链的解码编码ADF.
[H][+]新增: 新增_RefreshIconMSG用于替换原先的_Refreshicon(刷新图标)的ADF.
[H][+]新增: _API_PickIconDlg(ACN_API_Shell.au3)用于替换原先的ADF(_SetIconByFileName.au3).
[H][-]移除: _SetIconByFileName.au3


3.3.3.0 (2010-01-03) (Beta)
AutoIt:
[G][+]新增: 现在读写 UTF-8 文件可以不使用BOM,读取时也会自动检测.

[G][*]修正: #1345: Number() 失败于尾数是小数点(这样写也行?).
[G][*]修正: #384: Under certain circumstances the network credentials flag would prevent the process from starting when launched with RunAs() or RunAsWait().
[G][*]修正: #1370: StringInStr() 将崩溃于一个负数顺序,且开始位置超过字符串长度.
[G][*]修正: #1367: 从 GUIRegisterMsg() 调用 GUIDelete() 时,回调函数将返回 $GUI_RUNDEFMSG ,这将导致 AutoIt 崩溃.
[G][*]修正: #1363: FileSetPos() 在设置原点为当前坐标时,函数不再工作.
[G][*]修正: #1355: Regression in how unsigned numbers are displayed when returned from DllCall().

[G][-]移除: FileOpen() 函数 "RAW" 读取模式已经移除.

UDFs:
[G][*]修改: _SQLite 3.6.19 -> 3.6.21
[G][*]修正: #1338: 无效 _ArrayDisplay() GUI 坐标错误.
[G][*]修正: #1362: _WinAPI_WindowFromPoint() 不能工作于 64 位 AutoIt.

AutoIt3Help:
[G][*]修正: #1327: 部分关键词不能在SciTe中打开帮助. 3.3.1.7汉化版已经修正.

3.3.2.0 (2009-12-19) 第一汉化版
SciTe:
[H][-]移除: 不再使用SciTe-ru的修改版,问题很多.还原thesnoW修改版.
[H][-]移除: 复制块的快捷键
[H][+]新增: 删除行功能for sxd(Ctrl+D)

3.3.1.7 (2009-12-10) (Beta) 第一汉化版
AutoIt:
[G][*]修正: 当 Mod() 出现一个意想不到的数据输出时,会自动转换浮点数来保持正确性.
[G][*]修正: DllStructCreate() 不支持 _ 于数据名称.  报告为数据名称包含无效字符.
[G][*]修正: 当使用 ControlCommand("GetSelected") 到一个非编辑控件将导致程序崩溃.
[G][*]修正: #1328: StringFormat() 不再接受像%000s这样的顺序.
[H][!]更新: 安装时更好的对来自SVN的拷贝的支持.
[H][*]修正: 安装时如果选择取消,WIN7会弹出程序可能未正确安装的问题.
[H][+]新增: au3及a3x文件支持拖放句柄.(文件拖放到脚本文件上运行).
[H][-]移除: 去掉脚本右键的"编辑脚本(记事本)"选项.

UDFs:
[G][*]修正: #1312: _GUIImageList_BeginDrag() 例子中出现错误.
[G][*]修正: #1320: _GUIImageList_DragMove() 文档中包含的一个参数并不存在.
[G][*]修正: #1325: 一些日期函数尝试访问一个无效的数组.
[G][*]修正: MenuConstants.au3 中出现无效表达式.

SciTe:
[H][*]修正: 按F1部分函数无法弹出帮助的Bug.

3.3.1.6 (2009-11-23) (Beta) 第一汉化版
AutoIt:

[G][+]新增: DllStructSetData() 和 DllStructGetData() 索引参数现在可以支持默认(Default)关键字.
[G][+]新增: #1270: GuiSetIcon() 可以自动查找适合大小的图标.

[G][*]修正: #1285: 还原到版本 rev5025 和所有它引起的错误修改导致的无效句柄.
[G][*]修正: #1288: 文档中 DllStructSetData() 和 DllStructGetData() 工作于数组而忽略索引参数.
[G][*]修正: #1300: 当DLLCall()调用了一个无效函数,可能导致DLL被卸载..
[G][*]修正: #1295: 一个确切区域(China)的 Unicode 到 ANSI 转换崩溃问题.
[G][*]修正: #1294: 修正一个死锁,当运行下面的函数于一个挂起的窗口时: WinGetTitle, WinSetTitle, WinGetText, WinFlash, WinSetOnTop
[G][*]修正: #975: Backgrounds of controls on tabs should be less likely to corrupt.
[H][!]更新: 更新OLEview为6.1.7600.16385(WIN7版本)

UDFs:
[G][*]修正: #1287: _Debug 函数可能屏蔽输入.
[G][*]修正: #1276: _TicksToTime() 不正确的秒数.
[G][*]修正: #1277: _GDIPlus_ImageGetGraphicsContext 资源清理例子脚本.
[G][*]修正: #1304: _GDIPlus_BitmapLockBits() 现在正确的宽度与高度参数代替右侧与底部.
[G][*]修正: #1290: 当使用 _GUICtrlTreeView_DisplayRectEx() 返回无效的左侧坐标.
[G][*]修正: #1296: _GUICtrlTreeView_ClickItem() 可能点击到控件父窗口外面.

Aut2Exe:
[G][*]修正: #1283: 添加新选项 /x86 用于强制使用 32-位 编译.

Au3Check:
[G][*]修正: #1299: #include 使用单括号不工作的问题.

SciTe:
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.28.0


3.3.1.5 (2009-11-7) (Beta) (第一汉化版)
AutoIt:
[G][+]新增: #1056: 新的 Inet 选项传递强制连接上线(防止断线).

[G][*]修正: #1248: Regression in IsHWND() that caused it to erroneously return true in some cases.
[G][*]修正: #1234: COM 方法修改布尔参数为int.
[G][*]修正: #1066: FileOpen() 模式 1 现在可以允许文本覆盖(如果使用了写入坐标).
[G][*]修正: #1258: 当尝试离开控件菜单时,会显示窗口系统菜单.

[G][*]修改: InputBox() 不再必须传递X,Y坐标或者宽度,高度.

UDFs:
[G][+]新增: #1228: _FTP_SetStatusCallback(), _FTP_DecodeInternetStatus() 于 FTPEx.au3. (Thanks Beege)

[G][*]修正: Regression in _InetGetSource().  Also includes a new parameter to control how the data is returned.
[G][*]修正: #1247: 部分 _GUICtrlComboBoxEx_* 函数当然不能正确的工作于文档说明的样式.
[G][*]修正: #1260: 潜在的缓冲器溢出于 _WinAPI_GetLastErrorMessage().

Au3Check:
[G][*]修正: #1239: 搜索库的顺序程序.

SciTe:
[G][!]更新: 更新tidy为2.0.29.0
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.27.0


3.3.1.4 (2009-11-4) (Beta) (第一汉化版)
AutoIt:
[G][+]新增: #508: Static 关键字.

[G][*]修正: #906: ActiveX controls were not told what their initial size was.
[G][*]修正: 布尔(Boolean)测试于二进制字符串现在能更好的工作.
[G][*]修正: #1242: Beta Regression in _WinAPI_WideCharToMultiByte(). (Thanks Valik)
[G][*]修正: 一些地方使用负数会导致致命错误.
[G][*]修改: PCRE 正则表达式引擎更新到 8.00.

SciTe:
[H][*]修正: 修正3.3.1.3汉化版中SciTe语法提示显示错误.(一堆显示出来.此为SciTe官方问题.)

UDFs:
[G][*]修正: #1223: _GUICtrlStatusBar_EmbedControl() 失败.
[G][*]修正: #1226: _DateDayOfWeek() had an off-by-one error.
[G][*]修正: _WinAPI_MakeQWord() 文档中参数顺序错误.
[G][*]修正: #1168: _ExcelBookOpen() 现在选中第一个可见的工作表,防止发生 COM 错误.
[G][*]修改: _SQLite 3.6.18 -> 3.6.19

3.3.1.3 (2009-10-X) (Beta) (第一汉化版)

AutoIt:
[G][*]修正: Hex() 不再崩溃.

ADF:
[H][+]新增: Access 相关操作的 ADF.
[H][+]新增: 磁盘卷 相关操作的 ADF.
UDFs:
[G][*]修正: #1215: _ArraySearch() 不能搜索 2D 数组.
[G][*]修正: _Crypt_EncryptData() 文档与 _Crypt_EncryptFile 例子文本错误.
[G][*]修正: GDIPlus 返回值.
[G][*]修正: #1026: GDIPlus 位图例子与文档使用正确的方法释放资源.

3.3.1.2 (2009-10-14) (Beta)
AutoIt:
[H][+]新增: 增加 插入数组的快速调试语言(by Sxd)
[H][!]更新: 更新UPX到3.04版本.对压缩率没影响,只是修复bug.
[G][+]新增: 新的 DllCall 和 DllStruct 类型,避免和 MSDN 描述混淆. 特别是 X64 错误.
[G][+]新增: #967: Ftp 通过代理能正常工作于 Inet 函数.
[G][+]新增: #351: PixelSearch() 现在支持从右到左,从下向上搜索.
[G][*]修改: AutoIt exit callback functions are called in reverse order of registration.
[G][*]修改: AdlibUnRegister() now returns the count of remaining Adlib functions that are registered.
[G][*]修改: AdlibUnRegister()'s function argument is now optional.  Called without arguments causes the last registered function to be unregistered.
[G][*]修改: @YDAY 现在返回 001 - 366 代替 - 366.  它将更好和其它语言结合.  这是一个脚本破坏修改.
[G][*]修改: #1080: InetGet background downloads now return immediately instead of connecting to the remote host first.
[G][*]修改: #1137: RegEnumKey() and RegEnumVal() now correctly return an empty string on failure instead of an error message string.
[G][*]修改: PixelChecksum() 可以计算从右到左,从下向上的校检和.
[G][*]修正: #1013: MDI 子窗体不能自适应父窗口客户区. (Thanks monoceres)
[G][*]修正: 当一个Adlib函数正在运行时进行反注册可能导致的崩溃.
[G][*]修正: Adlib functions no longer dominate when more than one are registered.
[G][*]修正: #1005: TraySetClick(64) = hovering. (Thanks timsky, MrCreatoR)
[G][*]修正: #1049: InetRead() 插入任意空终止符.
[G][*]修正: ClipPut("") 不为空.
[G][*]修正: #1068: Binary 转 Int. (Thanks amel27)
[G][*]修正: #1087: Checkbox 或者 Radio 控件在鼠标经过后进行重绘.
[G][*]修正: 标签控件上双 GUICtrlSetPos() 错误绘图.
[G][*]修正: #1094: Send("{LSHIFT UP}") 无法弹起按键. (Thanks nick.weltha)
[G][*]修正: #1074: Inputbox() 坐标于多显示器. (Thanks partypooper)
[G][*]修正: #1079: GUISetFont(), GUICrlSetFont() 文档链接不可用 #918
[G][*]修正: #1105: 禁用着色的多行按钮不能正常的显示.
[G][*]修正: #1077: GUICtrlSetBkColor() 错误着色. (Thanks Mulder)
[G][*]修正: #1116: GUICtrlCreateGraphic 不跟随 ResizeMode (可改变大小)模式.
[G][*]修正: #1102: 更好的文档说明 StringInStr() 计数参数.
[G][*]修正: #1161: 移除所有关于颜色模式的文档(注:采用RGB颜色,弃用AutoIt v2使用的GBR颜色).
[G][*]修正: #1156: AutoItSetOption()/Opt() 现在设置 @error 代替无效输入产生的失败错误.
[G][*]修正: #1093: StringFormat() 测试非拉丁字符
[G][*]修正: 比较指针(pointers)现在工作正确.

SciTe:
[H][!]更新: SciTe部分代码采用SciTe-ru(一个俄罗斯修改版)
[G][!]更新: 更新tidy为2.0.28.7
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.26.23

AutoItX:
[G][-]移除: 颜色模式选项从 AutoItSetOption() 中移除.

Aut2Exe:
[G][*]修正: #1036: Inet-相关函数编译不再出错.

Au3Info:
[G][-]移除: BGR颜色模式不再支持(目前为RGB,BGR为了和AU2兼容,目前AU3已经成熟).

UDFs:
[G][+]新增: GuiRichEdit 与函数
[G][+]新增: _WinAPI_GetGuiResources()
[G][+]新增: #981: _WinAPI_WideCharToMultiByte(), _WinAPI_MultiByteToWideChar() support IN/OUT as "strings"
[G][+]新增: #1157: Encryption functions in Crypt.au3.
[G][+]新增: #1128: _WinAPI_PathFindOnPath() in WinAPI.au3.
[G][*]修正: #999: _GUICtrlTreeView_SetFocused documentation
[G][*]修正: #1016: _WordDocSaveAs() Doc for error handling. (Thanks Volly)
[G][*]修正: Sound positioning in case of VBR Format Sound. (Thanks Melba23, RazerM)
[G][*]修正: #1031: _Clipboard_SetData() fix. (Thanks Ascend4nt)
[G][*]修正: #1040: _ScreenCapture_Capture() leak memory. (Thanks rover)
[G][*]修正: #1026: _Gdiplus_BitmapCreate*() doc examples. (Thanks wraithdu)
[G][*]修正: #1092: _Timer_...() datatype for X64. (Thanks Ascend4nt)
[G][*]修正: #1059: Incorrect error handling in _FileListToArray(). (Thanks Spiff59)
[G][*]修正: #1101: _NowTime(), _NowDate() Doc. (Thanks danullman)
[G][*]修正: _WinAPI_GetWindowLong(), _WinAPI_SetWindowLong support X64.
[G][*]修正: #1111: Bad grammar in comments for _DateAdd().
[G][*]修正: #1155: _WinAPI_CreateSolidBitmap() updated (Thanks Yashied)
[G][*]修正: all includes use Unicode for Dllcall and SendMessage
[G][*]修正: _WinAPI_Get/SetWindowLong under X64
[G][*]修正: UDF library now uses #include "" instead of #include <>.
[G][*]修正: #1033: UDF library now has better and more consistent error handling when DllCall() is used.
[G][*]修改: _SQLite 3.6.14.2 -> 3.6.18
[G][*]修改: _InetGetSource() 现在使用 InetRead().
[G][-]移除: #1112: __WinAPI_Check() has been removed as have all calls to it.



3.3.1.1 (2009-9-7) (第二汉化版)
AutoIt:
[H][!]更新: 更新对64位系统的支持.
[H][!]更新: 更新spy++ 中文版为9.0.30729.1(VS2008 SP1)
[H][!]更新: 更新spy++ 目录中的VS2008运行库为9.0.30729.01(VS2008 SP1)
[H][!]更新: 更新OLEview为6.0.6000.16384(Vista,VS2008SP1版本)
[H][-]移除: 移除ANSI编译器支持.
[H][!]更新: 帮助文档使用UTF-8编码处理,方便汉化,正确显示所有UNICODE字符.
SciTe:
[H][!]更新: 更新SciTe为2.01
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.26.21
[G][!]更新: 更新tidy为2.0.28.6
KODA:
[G][!]更新: 更新Koda到 Beta 1.7.2.1 build 191 (2009-07-09)
[G][+]新增: 载入图像使用 API 函数 OleLoadPicture 代替内部 Delphi 函数 (实验性质的!)
[G][+]新增: 图像/图标/图像列表 打开对话框现在可以自定义并可以显示库预览.
[G][+]新增: 图形控件的图形编辑器
[G][*]修正: 当添加 256x256 图标时,图标错误. [FS#65]
[G][+]新增: 状态栏上双击调用面板编辑器 [FS#26] (thanks Zedna)
[G][+]新增: 图像列表编辑器添加一个按钮,允许保存列表为一个32位图标库.
[G][*]修正: 16-位图标库可以在 Vista 及更高系统载入,但是会显示警告.

[G][!]更新: 更新Koda到 Release 1.7.2.0 build 180 (2009-06-27)
[G][*]修正: 语言工具更新(KODA本身语言)
[G][*]修改: 改良的翻译系统, 英语总是保持最新, lang_eng.xml 不再需要.
[G][+]新增: 更新检查功能显示正式版说明.
[G][+]新增: 关于对话框显示 Koda 编译版本(revision)(build)
[G][+]新增: TabItem 带有提示.
[G][+]新增: Combo(组合框)带有颜色.
[G][*]修正: 不能设置控件颜色等于系统默认颜色 [FS#64] (thanks Valik)
[G][*]修改: 格式更新检查, 更多信息现在有效.
[G][*]修正: 再次 - 当更新脚本时更好的进行缩排 [FS#63] (thanks Valik)
[G][*]修正: 从对象树上下文菜单粘贴控件 -> 控件坐标超出窗体 [FS#53] (thanks Zedna)
[G][*]修正: selection was not shown in Object Tree when calling Select All, and when mouse cursor was on the tree [FS#52] (thanks Zedna)
[G][*]修正: 在 120 dpi(解析度单位)下导入对话框大小错误 [FS#50] (thanks Ernst Mathys)
[G][*]修正: 检查过时链接 [FS#54] (thanks Zedna)
ADF:
[G][+]新增: _API_AnimateWindow函数

3.3.1.1 (2009-6-19) (第一汉化版)
AutoIt:
[G][+]新增: #529: 添加 "NAME" 属性,允许检测搜索 for .NET WinForm 控件名称.
[G][+]新增: PixelChecksum() 扩展参数选择 CRC32 代替 ADLER 算法.
[G][+]新增: #984: @OSVersion 现在可以为 Windows XP Embedded 返回 "WIN_XPe".
[G][+]新增: #938: UDPOpen() 标志可以允许广播 255.255.255.255 地址. (Thanks skyteddy)
[G][*]修正: #969: FileFindNextFile() 不能设置 @extended ,如果第一个找到的项目为目录. (Thanks wraithdu)
[G][*]修正: #975: Checkbox 或者 Radio 背景颜色在标签项目上出错(有系统主题情况下). (Thanks GEOSoft, jchd)
[G][*]修正: #983: InetGet() 崩溃于 IE6.
[G][*]修正: #1006: @MSEC 当值 < 100 时返回错误值.
[G][*]修正: #1010: FileRead() UTF8 +BOM 文件返回太多的字符.
[G][*]修改: #968: AutoUpdateIt 更新到支持新的 Inet 特性(但是汉化版编译了无法运行).
[H][*]修正: AU3托盘工具箱对WIN7的兼容性以及点击项目会自动选定的问题.
[H][-]移除: 移除 WIN32.HLP,文件过大,且使用人少.

AU3Info:
[G][+]新增: 控件信息现在包含 .NET WinForm (如果有效)(注意:文件尚未汉化).

UDFs:
[G][*]修正: #979: _ArrayDisplay() - 头(页眉)错误.
[G][*]修正: #974: _WinAPI_WindowFromPoint tagPoint 数据结构
[G][*]修正: #1000: _GUICtrlListBox_Create 返回错误消息 _WinAPI_CreateWindowEx: 不能找到窗口类(Cannot find window class)
[G][*]修正: #1004: _PathFull() 返回无效结果.
[G][*]修正: #1015: _SQLite_SaveMode() 重命名为 _SQLite_SafeMode(). (Thanks Zedna)
[G][*]修正: #1019: _GUICtrlListView_SetItemCut, _GUICtrlListView_SetItemFocused, _GUICtrlListView_SetItemDropHilited enabled(启用)标志不能正常工作.
[G][*]修改: 使用 UTF8 信息时显示于 SciTe 控制台出息错误信息. 外部参数于 _SQLite_Startup().
[G][*]修改: _SQLite 3.6.14.1 -> 3.6.14.2
[G][-]移除: _StringAddThousandsSep() 已被移除.

SciTe:
[G][!]更新: 更新Tidy(代码整理)到2.0.28.3
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.26.14
[G][!]更新: 更新SciTe4AutoIt的properties(属性文件).
[H][*]修正: 3.3.1.0中SciTe单词缩写不可用问题.
[H][*]修正: AutoIt3Wrapper 对WIN7的兼容性.


3.3.1.0 (2009-5-26) (第一汉化版)
注意:因为官方文档包未发布,帮助文件有部分函数不是最新状态.将在下一个汉化版中补齐.
AutoIt:
[H][+]新增: 工具箱支持在线更新汉化版本(测试阶段,请不要使用)
[H][!]更新: 更新汉化的例子.
[H][!]更新: 更新汉化的帮助.
[G][+]新增: #757: Set defaults for MouseClick()'s x/y parameters.
[G][+]新增: #764: ProcessWait() , WinWait(), WinWaitActive, WinActivate(), WinActive(), WinMove() 当成功时返回进程句柄.
[G][+]新增: #414: 更好的操作 OnAutoItStart/OnAutoItExit, 现在使用 #OnAutoItStartRegister, OnAutoItExitRegister() 和 OnAutoItExitUnRegister().
[G][+]新增: 更好的操作 AdlibEnable/AdlibDisable, 现在使用 AdlibRegister(), AdlibUnRegister() 和 AdlibDisable().
[G][+]新增: #351: 反向 PixelSearch().
[G][+]新增: #769: FileFlush() 函数.
[G][+]新增: #333: #NoAutoIt3Execute 可以关闭 /AutoIt3ExecuteScript 或者 /AutoIt3ExecuteLine.
[G][+]新增: #604: $GUI_BKCOLOR_TRANSPARENT (背景透明)可以用于标签,组,多选,单选控件.
[G][+]新增: #135: FileSetPos(), FileGetPos() 函数用于移动设置文件指针.
[G][+]新增: #582: GUICtrlSetTip() 可以用于设置标签项目控件(TabItem). (Thanks ProgAndy)
[G][+]新增: #699: Shutdown() 现在当失败时返回 @error=GetLastError().
[G][+]新增: #461: StringReplace() 可以从右到左匹配,当 occurrence <0 as for StringInStr().
[G][+]新增: GUICtrlSetColor() and GUICtrlSetBkColor() for Combo Controls.
[G][+]新增: GUI 没有标题栏 (no $WS_CAPTION) 可以使用鼠标移动窗体.
[G][+]新增: #815: 临时变量可以传递 ByRef.
[G][+]新增: #837: FileFindNextFile() 设置 @extended ,如果返回的项目是一个目录. (Thanks pdaughe)
[G][+]新增: #839: Shutdown() 函数重写,更好的工作于非交互式用户.
[G][+]新增: Shutdown() 现在可以定义理由代码(WINDOWS 2003及以上需要).
[G][+]新增: #846: _PathFull() now supports strange but valid syntax where drives do not  have a trailing slash.
[G][+]新增: #869: @MUILang 宏帮助 MUI 环境脚本. (Thanks Emiel Wieldraaijer)
[G][+]新增: #918: 添加一个质量参数到 GUICtrlSetFont() 和 GUISetFont().
[G][+]新增: ProcessClose() 当错误时返回信息.
[G][*]修正: CtrlSetStyle listview on non selected tab. (Thanks Ultima)
[G][*]修正: #763: GUICtrlCreateIcon() 当错误时创建空图标. (Thanks Jos)
[G][*]修正: no mouse move when invalid button used in MouseClick() or MouseClickDrag().
[G][*]修正: #779: infinite loop on Exit due to GUICreate() child badly created.
[G][*]修正: #774: GuiCtrlSetBkColor() 显示错误的label. (Thanks MvGulik)
[G][*]修正: #790: Windows region constant $ERROR rename in $ERRORREGION.
[G][*]修正: StringInStr("aaa", "aa", 2) 不返回 0.
[G][*]修正: #802: 按高度属性搜索控件.
[G][*]修正: Checkbox 或者 radio 在标签(tab)上绘图错误. (Thanks einaman)
[G][*]修正: #816: data for GUI date control doc clarification. (Thanks anonymous)
[G][*]修正: #819: 崩溃于事件日志函数.
[G][*]修正: #814: InetGet() 当通过的代理需要认证会失败.
[G][*]修正: #813: bad handling of Windows advanced matching for [HANDLE:...] in X64 version. (Thanks bsobottke@nero.com)
[G][*]修正: #863: DirMove() extra dot. (Thanks dRsrb)
[G][*]修正: #867: UDPRecv() 可以从 IP/Port 返回. (Thanks Martin, livewire)
[G][*]修正: #886: More explicit documentation that operator == is a forced string comparison.
[G][*]修正: #885: Default compared to False returned True instead of False.
[G][*]修正: #888: Send("{}}") .
[G][*]修正: #916: Line inversion in INet.au3
[G][*]修正: DllCall() 返回 64-bit int. (Thanks wraithdu)
[G][*]修正: GuiCtrlSetImage() 自后 GUI 被重设大小. (Thanks JackDinn)
[G][*]修正: DirMove() 返回值错误于XP.
[G][*]修正: #931: 无效的 GUICtrlSetResizing() 于图形控件. (Thanks martin)
[G][*]修正: #934: MouseGetCursor() hogging mouse double click. (Thanks martin)
[G][*]修正: #615: 许可更新,减小部分限制(注:原先的许可是AutoIt所生成的文件也是属于AutoIt Team的).
[G][*]修正: #919: 添加 ConsoleWrite(), ConsoleWriteError() 和 StdinWrite() 的备注,regarding how those functions handle binary data and non-ANSI characters.
[G][*]修正: #897: StringToASCIIArray() 为什么不能接受二进制输入的文档说明 (首先转换为字符串).
[G][*]修正: #937: Opt("TrayMenuMode",1) 出现错误但事件句柄
[G][*]修改: It is now possible to read from files opened for writing.
[G][*]修改: PCRE 正则表达式引擎更新到 7.9.
[G][*]修改: #899: ShellExecute[Wait]() no longer uses "open" as the default verb.  See remarks section for those functions for more information.
[G][*]修改: Inet 函数被重新,有以下附加修改:
	- 移除: URLDownloadToFile() 为 InetGet()的一个别名.
	- 新增: HttpSetUserAgent(), InetClose(), InetGetInfo() and InetRead() functions.
	- 新增: InetGet() 可以支持多个文件背景下载.
	- 新增: #408: 新标准由于忽略HTTPS连接中的 SSL 错误.
	- 新增: #884: 模式0中使用更好但代理支持.
	- 新增: #949: user-agent 可以被修改.
	- 修改: InetGet() returns a handle which must be closed.
	- 修改: @InetGetBytes, @InetGetActive 和 InetGet("abort") 已经没有存在的意义,故移除于特性.
AU3Info:
[G][+]新增: #140: 工具栏按钮信息.
SciTe:
[G][!]更新: 更新Obfuscator(代码迷惑)到1.0.26.11
[H][!]更新: 更新SciTe为1.78 20090513版本.
[H][+]新增: SciTe可以使用一个名为skin.msstyles的皮肤.
[H][!]更新: SciTe工具栏美化.
[H][+]新增: 增加两个新的SciTe接口表,SciTe\api\Scintilla.iface 和 IFaceTable.cxx
KODA:
[G][!]更新: 更新到 Release 1.7.1.0 (2009-04-27)
[G][*]修正: AV when resetting Style/ExStyle [FS#48] (thanks Zedna)
[G][*]修正: Resizing - 生成代码错误 (default) [FS#47] (thanks Zedna)
[G][+]新增: Dummy 控件热键属性[FS#45] (thanks BaKaMu)
[G][*]修正: 移除一些多余属性
[G][*]修正: TAObj control loose it's dimensions after reloading [FS#40] (thanks BaKaMu)
[G][*]修正: TAdate 控件设置但字体步生成 [FS#39] (thanks BaKaMu)
UDFs:
[G][+]新增: _GDIPlus_BrushGetSolidColor, _GDIPlus_BrushSetSolidColor (smashly)
[G][+]新增: $tagWIN32_FIND_DATA 和相应但属性常量.
[G][+]新增: #868: _WinAPI_GetLayeredWindowAttributes(), _WinAPI_SetLayeredWindowAttributes(). (Thanks Prog@ndy)
[G][+]新增: _Date_Time_ ... Str() 可以返回日期为 yyyy/mm/dd.
[G][+]新增: #271: FTPEx.au3 添加于 _FTP_...(). (Thanks ProgAndy, Wouter)
[G][+]新增: #932: 鼠标事件常量于 WinDowsConstants.au3. (Thanks Spiff59)
[G][+]新增: #952: _ArrayDisplay() 扩展参数,由于处理列头文本. (Thanks Zedna)
[G][+]新增: #957: _Assert() 于 Debug.au3. (Thanks Nutster)
[G][*]修正: #755: _FileReadToArray() 移除空终止行.
[G][*]修正: #773: _GUICtrlStatusBar_SetParts 文档错误 (Thanks Zedna)
[G][*]修正: #786: _SQLite_Exec() 不能返回 @error. (Thanks tayoufabrice)
[G][*]修正: _ClipBoard_SetData 添加文档
[G][*]修正: #793: _WinNet_EnumResource 错误总是返回
[G][*]修正: _StringAddThousandsSep adding leading comma with negative numbers (Zedna)
[G][*]修正: #809: _Soundxxx() 第一个参数最为文件名.
[G][*]修正: #850: _ExcelReadSheetToArray 不能工作于德文版 Excel 2003 (Prog@ndy) 注意: 未在其它语言中测试
[G][*]修正: #887: 相关段可以基于调节(帮助文件).
[G][*]修正: #958: _ArrayDisplay - 调节窗口宽度后错误居中.
[G][*]修正: #951: _ArrayDisplay() 为 nb 项目 >4000 时做出速度改进. (Thanks Zedna)
[G][*]修正: _SoundOpen() 设置 @error 于 MCI 错误.
[G][*]修改: _StringBetween 移除最后一个可选参数 (不再需要)(SmOke_N)
[G][!]更新: Excel 文档 (litlmike)
[G][!]更新: _SQLite 3.6.7 -> 3.6.14.1
[G][!]更新: _ArrayCombinations, _ArrayPermute, _ArrayUnique (litlmike)
[G][-]移除: _WinAPI_MakeDWord
ADF:
[H][+]新增: _API_CoInitialize,_API_DllRegisterServer,_API_DllUnregisterServer三个ADF.用于注册DLL.
[H][+]新增: AddFontResourceA,AddFontResourceW,RemoveFontResourceA,RemoveFontResourceW,WM_FONTCHANGE五个ADF.用于注册字体.

3.3.0.0 (2009-4-4) (第三汉化版)
AutoIt:
[H][*]修正:AU3工具箱无帮助/无WMI查看器的问题.
[H][+]新增:Microsoft Spy++ 9.0中文版(英文版不移除)
[H][!]更新:汉化部分例子程序.
[H][!]更新:AutoIt工具箱增加帮助项目,WMI项目,以及解决SVN更新后直接安装的问题.
SciTe:
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
AutoIt:
[H][-]移除:Send2A3X(过老)
[H][!]更新:AutoIt工具箱使用ini配置文件定义菜单.
[H][!]更新:程序更新移除汉化版本信息.
[H][!]说明:汉化版不再以小版本表示(如3.3.0.0.1).和官方同样表示(3.3.0.0).
[H][!]更新:AutoIt帮助汉化版本更新为SVN39
UDFs:
[H][!]更新:UDF帮助汉化版本更新为SVN39
[H][+]新增:UDF: FTP.au3,用于操作FTP
[H][-]移除:_FileListToArrayNew2g.zip,官方UDF已经存在.
SciTe:
[G][!]更新:更新TIDY(代码整理)到2.0.25.0
[G][!]更新:更新Obfuscator(代码迷惑)到1.0.26.8
[H][!]更新:更新SciTe为1.78版本.
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
AutoIt:
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
[H][*]修正: SciTe汉化错误(感谢kxbit)
[H][!]更新: SciTe为SVN 2008-12-7的代码(主要更新Scintilla的健壮性以及对新语言的支持,虽然我们用不着).
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
SciTe:
[H][!]更新: Merged the updates of SciTe v 1.77 by Neil Hodgson with our own version of SciTe v 1.77. (thesnow)
11/2/2008
[G][!]更新: Merged the updates of SciTe v 1.77 by Neil Hodgson with our own version of SciTe v 1.77. (Jos)
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
SciTe:
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
[G][*]修改: rewritten Icon control (now much closer to an actual AutoIt control & hi-color icons support)(2008-09-27)
[G][+]新增: help handlers and ID's to all property editors(2008-09-24)
Beta 1.7.0.7 (2008-09-24)
[G][*]修改: 完成重写图标支持, 现在已经支持高颜色图标(2008-09-24)
[G][*]修正: using wrong row when changing icon in list after deleting one of icon (感谢 Zedna)(2008-09-5)
[G][*]修正: AV when deleting (attached) context menu (long time bug)(2008-09-5)
[G][*]修正: AV when deleting attached toolbar or imagelist (感谢 Zedna)(2008-09-5)
[G][*]修正: AV when invoke taborder dialog on toolbutton (感谢 Zedna)(2008-09-5)
[G][*]修正: 标签对话框中没有工具栏图标 (感谢 Zedna)(2008-09-5)

3.2.13.7.2 (9:56 2008-9-22)
SciTe:
[H][!]更新: 更新代码迷惑为1.0.24.21.
[H][!]更新: 更新代码整理(TIDY)为2.0.23.20.
[H][!]更新: 更新SciTe为CVS 2008-9-13(增强对会话的管理以及对部分其它程序语言的加强)
[H][*]修正: SciTe使用小键盘"-"不能添加注释的问题.
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
[H][*]修正:AU3TOOL中对AutoIt3a.exe的判断.
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
