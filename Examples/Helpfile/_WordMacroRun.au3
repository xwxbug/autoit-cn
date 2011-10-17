 ; ******************************************************* 
 ; 示例 - 创建一个word窗体, 打开一个文档, 带参数"Text"运行一个 
 ;        名为"My Macro"的宏, 然后不保存退出. 
 ; ******************************************************* 
 #include <Word.au3> 
 $oWordApp = _WordCreate ( @ScriptDir & , " \Test.doc " ) 
 _WordMacroRun ( $oWordApp , " My Macro ", " Test " ) 
 _WordQuit ( $oWordApp , 0 ) 
 
 
