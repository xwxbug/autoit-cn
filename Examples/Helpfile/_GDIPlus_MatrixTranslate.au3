#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

; 创建 GUI
Local $hWnd = GUICreate("GDI+ Example", 400, 300)
GUISetState()

; 初始化 GDI+
_GDIPlus_Startup()
Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hWnd)

Local $hMatrix = _GDIPlus_MatrixCreate()
; 向着中心把矩阵的高度和宽度变成原来的一半
_GDIPlus_MatrixTranslate($hMatrix, 200, 150)
_GDIPlus_MatrixRotate($hMatrix, 45)
_GDIPlus_GraphicsSetTransform($hGraphics, $hMatrix)

Local $hPen = _GDIPlus_PenCreate(0xFF00FF00, 10)

_GDIPlus_GraphicsClear($hGraphics)
; 在 GUI 的左上角描绘, 不过由于我们平移了矩阵, 所以对象将出现在 GUI 的中心
_GDIPlus_GraphicsDrawRect($hGraphics, -50, -50, 100, 100, $hPen)


Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

; 清理资源
_GDIPlus_PenDispose($hPen)
_GDIPlus_MatrixDispose($hMatrix)
_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_Shutdown()
