#include <IE.au3> 
_IEAttach ( $s_string [, $s_mode = "Title" [, $i_instance = 1]] ) 
 
   
参数    
 $s_string  搜索的字符串 (对于 "embedded" 或 "dialogbox", 使用标题子串或者窗口句柄)  
 $s_mode  可选: 指定搜索模式 
Title = (默认t) 整个文档标题的子串 
WindowTitle = 窗口标题的子串(代替文档标题) 
URL =当前网页的url或者url子串 
Text 
      =当前网页body标签内的文字或者子串 
HTML =当前网页body标签内的HTML或者子串 
HWND =浏览器窗口句柄 
Embedded =嵌入控制窗口的句柄或者标题子串 
DialogBox =模态/非模态的对话框的句柄或者标题子串 
Instance = $s_string 被忽略, 浏览器参考(通过匹配事例子号码)所有返回的可用浏览器实例 
 
 $i_instance  可选: 与$s_string和$s_mode匹配的1基索引的浏览器组或内嵌浏览器. 
  见备注.  
   
返回值 成功: 返回返回指向InternetExplorer.Application对象的对象变量 
失败: 返回0并设置@ERROR为: 
    0 ($_IEStatus_Success) = 无错误 
    5 ($_IEStatus_InvalidValue) = 无效值 
    7 ($_IEStatus_NoMatch) = 不匹配 
    @Extended: 包含无效参数数量 
   
备注 _IEAttach提供了 " dialogbox " 参数附加到浏览器创建的模态和非模态对话框. 要指出的是 , 并非所有通过浏览器交互创建的对话框 , 都可以这种方式附加和控制. 许多这些对话实际上是标准的窗口 , 并且可以通过传统AutoIt窗口函数控制. 
一种可靠的方式区分这些类型的窗口是使用 " AutoIt窗口信息 " 工具来检查 , 如果窗口包含一个名为 " Internet Explorer Server " 的控件然后你就可以使用该函数连接到它,如果没有标准窗口且必须用传统AutoIt窗口函数来控制它. 
HyperTextApplication(.hta)窗口可以使用 " embedded " 选项. 
 
相对于标准Win*函数的可用的高级窗口标题选项语法可用于替换 " dialogbox " 及 " embedded " 模式的标题子串. 
 
" embedded " 模式的 " $i_instance " 的使用: 用于返回WebBrowser的指定实例的引用特别是对于在特定窗口中含有多个实例时. 如果使用内嵌模式将$s_string传递到窗口标题 , 则仅首个窗体匹配标题. 如果所需的WebBrowser在另一窗口中则必须传递窗体句柄而不是标题 , 或使用相对于标准Win*函数的可用的高级窗口标题选项语法. 
 
除 " embedded " 模式以外的 " $i_instance " 的使用: 用于返回与$s_string和$s_mode匹配的所有窗体组中的一个浏览器的引用. Instance order for DialogBox模式通过由匹配标题的WinList()返回的顺序决定. 所有其他模式的实例顺序由Shell.Windows集决定. 
 
当使用 " hwnd " 模式或在 " DialogBox " 模式中使用以$s_string传递HWnd时 , 如果 " $i_instance " >1则将被设置为1并显示警告消息. 
 
DialogBox和Embedded模式可用于获取标准浏览器窗口 , 但返回的对象是that浏览器中的顶层窗口而不是InternetExplorer对象. 
Window对象不具有InternetExplorer对象的所有属性(如状态文本 , 地址栏等). 
另外 , 由于IE7已使用标签页如果在一个对象上使用如_IENavigate的函数将会收到COM错误. 
该方法对于查找浏览器实例很有用 , 但推荐以不同模式及与InternetExplorer对象关联的窗体对象的信息使用_IEAttach. 
 
   
相关  _IECreate , _IECreateEmbedded , _IEQuit  
   
示例  
 ; ******************************************************* 
 ; 示例1 - 打开标题为"AutoIt"的浏览器并显示网址 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IEAttach ( " AutoIt " ) 
 MsgBox ( 0 , " The URL ", _IEPropertyGet ( $oIE , " locationurl " )) 
 
 ; ******************************************************* 
 ; 示例2 - 打开顶层文档中包含"The quick brown fox"文本的浏览器 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IEAttach ( " The quick brown fox ", " text " ) 
 
 ; ******************************************************* 
 ; 示例3 - 打开内嵌在另一窗口中的浏览器控件 
 ; ******************************************************* 
 ; 
 #include  <IE.au3> 
 $oIE = _IEAttach ( " A Window Title ", " embedded " ) 
 
 ; ******************************************************* 
 ; 示例4 - 打开第三个内嵌在另一窗口中的浏览器控件 
 ;        使用高级窗口标题语法来使用第二个标题中带有'ICQ'字符串的窗口 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IEAttach ( " [REGEXPTITLE:ICQ; INSTANCE:2] ", " embedded ", 3 ) 
 
 ; ******************************************************* 
 ; 示例5 - 创建当前浏览器所有引用的实例对象的数组. 数组首个元素为实例数量 
 ; ******************************************************* 
 ; 
 #include  <IE.au3> 
 
 Dim $aIE [ 1 ] 
 $aIE [ 0 ] = 0 
 
 $i = 1 
 While 1 
   $oIE = _IEAttach ( " ", " instance ", $i ) 
   If @error = $_IEStatus_NoMatch Then ExitLoop 
   ReDim $aIE [ $i + 1 ] 
   $aIE [ $i ] = $oIE 
   $aIE [ 0 ] = $i 
   $i += 1 
 WEnd 
 
 MsgBox ( 0 , " Browsers Found ", " Number of browser instances in the array:  " & $aIE [ 0 ]) 
 
