 ; ******************************************************* 
 ; 示例 - 获取并显示IE.au3版本信息 
 ; ******************************************************* 
 ; 
 #include <IE.au3> 
 $aVersion = _IE_VersionInfo () 
 MsgBox ( 0 , " IE.au3 Version ", $aVersion [ 5 ] & "  released  " & $aVersion [ 4 ]) 
 
