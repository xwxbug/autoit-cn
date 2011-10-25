
#include  <GDIPlus.au3>
#include  <ScreenCapture.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hBitmap, $hImage, $sCLSID, $tData, $tParams

	; 捕捉屏幕
	_ScreenCapture_Capture(@MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 初始化GDI+库
	_GDIPlus_Startup()

	; 加载图像
	$hImage = _GDIPlus_ImageLoadFromFile(@MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 获取JPEG编码器CLSID
	$sCLSID = _GDIPlus_EncodersGetCLSID("JPG")

	; 建立90度旋转参数
	$tData = DllStructCreate("int Data")
	DllStructSetData($tData, "Data", $GDIP_EVTTRANSFORMROTATE90)
	$tParams = _GDIPlus_ParamInit(1)
	_GDIPlus_ParamAdd($tParams, $GDIP_EPGTRANSFORMATION, 1, $GDIP_EPTLONG, DllStructGetPtr($tData, "Data"))

	; 保存旋转的图像
	_GDIPlus_ImageSaveToFileEx($hImage, @MyDocumentsDir & "\GDIPlus_Image2.jpg", $sCLSID, DllStructGetPtr($tParams))

	; 关闭GDI+库
	_GDIPlus_ShutDown()

endfunc   ;==>_Main


