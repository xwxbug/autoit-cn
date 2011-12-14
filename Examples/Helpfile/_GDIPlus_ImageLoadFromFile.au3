#include <GDIPlus.au3>
#include <ScreenCapture.au3>

_Main()

Func _Main()
	Local $hImage, $sCLSID, $tData, $tParams

	; 屏幕捕获
	_ScreenCapture_Capture(@MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 初始化 GDI+ 库
	_GDIPlus_Startup()

	; 加载图像
	$hImage = _GDIPlus_ImageLoadFromFile(@MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 获取 JPEG 编码器的 CLSID
	$sCLSID = _GDIPlus_EncodersGetCLSID("JPG")

	; 建立表示旋转 90 度的参数
	$tData = DllStructCreate("int Data")
	DllStructSetData($tData, "Data", $GDIP_EVTTRANSFORMROTATE90)
	$tParams = _GDIPlus_ParamInit(1)
	_GDIPlus_ParamAdd($tParams, $GDIP_EPGTRANSFORMATION, 1, $GDIP_EPTLONG, DllStructGetPtr($tData, "Data"))

	; 保存旋转后的图像
	_GDIPlus_ImageSaveToFileEx($hImage, @MyDocumentsDir & "\GDIPlus_Image2.jpg", $sCLSID, DllStructGetPtr($tParams))

	; 关闭 GDI+ 库
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main
