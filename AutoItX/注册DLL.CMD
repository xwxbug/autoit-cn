@echo off
color 0a
copy AutoItX3.dll %windir%\system32\AutoItX3.dll
CLS
REGSVR32 /S %windir%\system32\AutoItX3.dll
ECHO 注册完成,按下任意键退出.
PAUSE >NUL