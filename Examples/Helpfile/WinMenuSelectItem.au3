; 将会选择记事本的>文本>页面设置菜单
Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")

WinMenuSelectItem("[CLASS:Notepad]", "", "文件(&F)", "页面设置(&U)..." )
