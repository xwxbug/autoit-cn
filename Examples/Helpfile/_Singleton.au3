 $iFlag  操作选项 
0 - 当存在另一实例时以-1作为退出代码退出脚本 
1 - 不退出脚本由函数返回 
2 - 允许系统中的任意用户获取对象. 在多用户环境中指定一个"Global\"对象非常有用.    
   
返回值 成功: 用于同步的对象的句柄(a mutex). 
失败: 0 
   
备注 可放置对象在一个以"Global\"或"Local\"为前缀的命名空间中. 带有标记2的"Global\"对象在多用户环境中非常有用. 
   
示例  
 
 #include  <Misc.au3> 
 if  _Singleton ( "test" , 1 )  =  0  Then 
     Msgbox ( 0 , "Warning" , "An occurence of test is already running" ) 
     Exit 
 EndIf 
 Msgbox ( 0 , "OK" , "the first occurence of test is running" ) 
 

