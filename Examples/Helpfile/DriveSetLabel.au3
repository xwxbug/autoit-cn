;得到当前卷标
Local $var=DriveGetLabel("c:\")
;设置卷标
DriveSetLabel("C:\", "新卷标")
MsgBox(32,"","卷标已设置")
DriveSetLabel("C:\", $var)
