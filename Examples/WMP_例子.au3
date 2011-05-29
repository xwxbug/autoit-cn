#include <GUIConstants.au3>
#include <wmp.au3>
; == GUI generated with Koda ==
$Form1 = GUICreate("AForm1", 518, 439, 192, 125)
$wmp = _wmpcreate(1, 8, 8, 425, 425);creates object
_wmpsetvalue( $wmp, "nocontrols" );hides controls
GUISetState(@SW_SHOW)
_wmploadmedia( $wmp, @HomeDrive & "\WINDOWS\clock.avi" );loads media
;Sleep(1000)
;_wmpsetvalue( $wmp, "controls" );shows controls
While 1
    $msg = GuiGetMsg()
    Select
    Case $msg = $GUI_EVENT_CLOSE
        ExitLoop
    Case Else
;;;;;;;
    EndSelect
WEnd
Exit