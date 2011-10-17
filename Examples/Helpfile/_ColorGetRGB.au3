18
 _ColorGetRGB     _ColorGetRGB   
返回指定颜色包含的成分的数组 
 
#Include <Color.au3> 
_ColorGetRGB($nColor) 
 
   
参数    
 $nColor  RGB颜色(十六进制代码).  
   
返回值 成功: 范围在0-255的各组分值的数组 
    [0] 红色组分 
    [1] 绿色组分 
    [3] 蓝色组分 
失败: 设置@error为1 
   
相关  _ColorSetRGB ,  _ColorGetRed ,  _ColorGetBlue ,  _ColorGetGreen  
    
