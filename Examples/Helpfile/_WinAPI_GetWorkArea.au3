#include <WinAPISys.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Local $tRECT = _WinAPI_GetWorkArea()
Local $Width = DllStructGetData($tRECT, 'Right') - DllStructGetData($tRECT, 'Left')
Local $Height = DllStructGetData($tRECT, 'Bottom') - DllStructGetData($tRECT, 'Top')
Local $X = DllStructGetData($tRECT, 'Left')
Local $Y = DllStructGetData($tRECT, 'Top')

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $Width, $Height, $X, $Y, $WS_POPUP, $WS_EX_TOPMOST)
GUISetBkColor(0, $hForm)
WinSetTrans($hForm, '', 128)
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
