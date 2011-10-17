19
 _GUICtrlDTP_GetMonthCal     _GUICtrlDTP_GetMonthCal   
获取子月历控件句柄 
 
#Include 
<GuiDateTimePicker.au3> 
_GUICtrlDTP_GetMonthCal($hWnd) 
 
   
参数    
 $hWnd  控件句柄  
   
返回值 成功: 月历句柄 
失败: 0 
 
   
备注 当用户点击上下箭头时($DTN_DROPDOWN通知)DTP创建一个子月历控件. 
当月历不再需要时, 
它将被销毁并发送$DTN_CLOSEUP通知. 因而你的应用程序不用依赖一个固定的DTP控件子月历句柄. 
  
