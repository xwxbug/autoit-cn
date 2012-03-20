MsgBox(4096,0,'请注意看桌面图标')

; 返回列表项目总数
$GetItemCount=ControlListView('Program Manager','','SysListView321','GetItemCount')
MsgBox(4096,'返回列表中项目的数量',$GetItemCount)

; 搜索指定字符串
$FindItem=ControlListView('Program Manager','','SysListView321','FindItem','Internet Explorer')
MsgBox(4096,'搜索字符串','Internet Explorer  位置:'&$FindItem)


; 切换当前的视图
ControlListView('Program Manager','','SysListView321','ViewChange','details')
Sleep(1000)
ControlListView('Program Manager','','SysListView321','ViewChange','smallicons')

; 选择其中几个项目
$Select=ControlListView('Program Manager','','SysListView321','Select',1,3)
WinActivate('Program Manager') ; 激活窗口来预览效果
Sleep(1000)

; 返回选中项目的位置
$GetSelected=ControlListView('Program Manager','','SysListView321','GetSelected',1)
If $GetSelected<>'' Then MsgBox(4096,'当前选中项目的位置',$GetSelected)
; 返回子项目的数量
$GetSubItemCount=ControlListView('Program Manager','','SysListView321','GetSubItemCount')
MsgBox(4096,'返回子项目的数量',$GetSubItemCount)
; 返回指定项目/子项目的文本
$GetText=ControlListView('Program Manager','','SysListView321','GetText',0)
MsgBox(4096,'返回指定项目/子项目的文本',$GetText)

WinActivate('Program Manager') ; 激活窗口来预览效果
ControlListView('Program Manager','','SysListView321','SelectAll')
Sleep(1000)
ControlListView('Program Manager','','SysListView321','DeSelect',1,3)
Sleep(1000)
ControlListView('Program Manager','','SysListView321','SelectInvert')
Sleep(1000)
ControlListView('Program Manager','','SysListView321','SelectClear')
Sleep(1000)
MsgBox(4096,0,'没了!睡觉吧!')