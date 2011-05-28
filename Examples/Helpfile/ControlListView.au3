$hwnd=ControlGetHandle('Program Manager','','SysListView321')
ControlListView($hwnd, "", "SysListView321", "SelectAll")
ControlListView($hwnd, "", "SysListView321", "Deselect", 2, 5)
;得到第一个项目的文本
MsgBox(0, "", ControlListView($hwnd, "", "", "GetText", 0, 0))
;查找腾讯QQ
MsgBox(0, "", ControlListView($hwnd, "", "", "FindItem", "腾讯QQ", 1))
MsgBox(0, "", ControlListView($hwnd, "", "", "GetSelected", 1))
