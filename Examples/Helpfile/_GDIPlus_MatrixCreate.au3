#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>

_Main()

Func _Main()
	Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphic, $width, $height

	; 初始化 GDI+ 库
	_GDIPlus_Startup()

	; 捕获整个屏幕
	$hBitmap1 = _ScreenCapture_Capture("")
	$hImage1 = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap1)

	; 捕获屏幕区域
	$hBitmap2 = _ScreenCapture_Capture("", 0, 0, 400, 300)
	$hImage2 = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap2)

	$width = _GDIPlus_ImageGetWidth($hImage2)
	$height = _GDIPlus_ImageGetHeight($hImage2)

	; 在一幅图像上描绘另一幅图像
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage1)

	;DrawInsert($hGraphic, $hImage2, $iX, $iY, $nAngle,    $iWidth,    $iHeight, $iARGB = 0xFF000000, $nWidth = 1)
	DrawInsert($hGraphic, $hImage2, 350, 100, 0, $width + 2, $height + 2, 0xFFFF8000, 2)
	DrawInsert($hGraphic, $hImage2, 340, 50, 15, 200, 150, 0xFFFF8000, 4)
	DrawInsert($hGraphic, $hImage2, 310, 30, 35, $width + 4, $height + 4, 0xFFFF00FF, 4)
	DrawInsert($hGraphic, $hImage2, 320, 790, -35, $width, $height)

	; 保存由此产生的图像
	_GDIPlus_ImageSaveToFile($hImage1, @MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 清理资源
	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_ImageDispose($hImage2)
	_WinAPI_DeleteObject($hBitmap1)
	_WinAPI_DeleteObject($hBitmap2)
	; 关闭 GDI+ 库
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main

; #FUNCTION# ==================================================================================================
;Name...........: DrawInsert
; Description ...: Draw one image in another
; Syntax.........: DrawInsert($hGraphic, $hImage2, $iX, $iY, $nAngle, $iWidth, $iHeight, $iARGB = 0xFF000000, $nWidth = 1)
; inserts Graphics $hImage2 into $hGraphic
; Parameters ....: $hGraphics   - Handle to a Graphics object
;                  $hImage      - Handle to an Image object to be inserted
;                  $iX          - The X coordinate of the upper left corner of the inserted image
;                  $iY          - The Y coordinate of the upper left corner of the inserted image
;                  $iWidth      - The width of the rectangle Border around insert
;                  $iHeight     - The height of the rectangle Border around insert
;                  $iARGB       - Alpha, Red, Green and Blue components of pen color - Border colour
;                  $nWidth      - The width of the pen measured in the units specified in the $iUnit parameter - Border Width

; Return values .: Success      - True
;                  Failure      - False
;==================================================================================================
Func DrawInsert($hGraphic, $hImage2, $iX, $iY, $nAngle, $iWidth, $iHeight, $iARGB = 0xFF000000, $nWidth = 1)
	Local $hMatrix, $hPen2

	;旋转矩阵
	$hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixRotate($hMatrix, $nAngle, "False")
	_GDIPlus_GraphicsSetTransform($hGraphic, $hMatrix)

	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage2, $iX, $iY)

	;get pen + color
	$hPen2 = _GDIPlus_PenCreate($iARGB, $nWidth)

	; 在插入的图像周围描绘边框
	_GDIPlus_GraphicsDrawRect($hGraphic, $iX, $iY, $iWidth, $iHeight, $hPen2)

	; 清理资源
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_PenDispose($hPen2)
	Return 1
EndFunc   ;==>DrawInsert
