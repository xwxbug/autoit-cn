23
 _WinAPI_WindowFromPoint     _WinAPI_WindowFromPoint   
获取包含指定点的窗口的句柄  
#Include <WinAPI.au3> 
_WinAPI_WindowFromPoint(ByRef 
$tPoint) 
 
   
参数    
 $tPoint  定义被检查的点的 $tagPOINT 结构  
   
返回值 成功: 包含点的窗口句柄 
失败: 0 
 
   
备注 WindowFromPoint 函数不会获取一个隐藏窗口或失效窗口的句柄, 尽管点在该窗口上. 

 
   
相关 $tagPOINT  
   
参考 搜索 
MSDN知识库中WindowFromPoint的相关信息  
   
