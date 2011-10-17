20
 _ColorSetRGB     _ColorSetRGB   
由COLORREF返回RGB颜色 
 
#Include <Color.au3> 
_ColorSetRGB($aColor) 
 
   
参数    
 $aColor  0-255的值的数组. 
[0] 红色组分 
[1] 绿色组分 
[2] 蓝色组分  
   
返回值 成功: 返回16进制的RGB颜色代码 
失败: 设置@error为: 
   1 - 无效数组 
   2 - 无效颜色值 
   
相关  _ColorSetRGB ,  _ColorGetRed ,  _ColorGetBlue ,  _ColorGetGreen  
    
