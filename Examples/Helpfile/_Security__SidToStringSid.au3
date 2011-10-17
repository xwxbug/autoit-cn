17
   _Security__SidToStringSid      _Security__SidToStringSid   
将二进制SID转化为字符串 
 
#Include <Security.au3> 
_Security__SidToStringSid($pSID) 
  
   
参数   
 $pSID  要转化的二进制SID的指针    
   
返回值 成功: 字符串格式的SID 
失败: 空字符串 
   
相关  _Security__StringSidToSid  
   
参考  搜索MSDN知识库中ConvertSidToStringSid的相关信息  
     
