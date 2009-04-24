#include <ScreenCapture.au3>

; 捕捉全屏
_ScreenCapture_Capture(@MyDocumentsDir & "\GDIPlus_Image1.jpg")

; 捕捉区域
_ScreenCapture_Capture(@MyDocumentsDir & "\GDIPlus_Image2.jpg", 0, 0, 796, 596)

