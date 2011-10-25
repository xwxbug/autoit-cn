
#include  <GUIConstantsEx.au3>
#include  <GDIPlus.au3>

; 创建界面
$hWnd = GUICreate("GDI+ 示例", 400, 300)
GUISetState()

; Start GDI+
_GDIPlus_Startup()
$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hWnd)

$hMatrix = _GDIPlus_MatrixCreate()
; 将矩阵向中心移动半宽及半高
_GDIPlus_MatrixTranslate($hMatrix, 200, 150)
_GDIPlus_MatrixRotate($hMatrix, 45)
_GDIPlus_GraphicsSetTransform($hGraphics, $hMatrix)

$hPen = _GDIPlus_PenCreate(0xFF00FF00, 10)

_GDIPlus_GraphicsClear($hGraphics)
; 绘制GUI左上角, 由于已经移动了矩形, 对象将出现在GUI中心
_GDIPlus_GraphicsDrawRect($hGraphics, -50, -50, 100, 100, $hPen)


Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

; 清除资源
_GDIPlus_PenDispose($hPen)
_GDIPlus_MatrixDispose($hMatrix)
_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_Shutdown()

