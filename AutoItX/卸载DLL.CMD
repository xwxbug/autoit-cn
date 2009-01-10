@echo off
color 0a
REGSVR32 /S /U %windir%\system32\AutoItX3.dll
cls
ECHO 卸载完成,按下任意键退出.
PAUSE >NUL