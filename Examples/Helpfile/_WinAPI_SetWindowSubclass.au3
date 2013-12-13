#include <WinAPIShellEx.au3>
#include <Extras\WMDebug.au3>
#include <GUIConstantsEx.au3>

OnAutoItExitRegister('OnAutoItExit')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'))

; Register DLL callback that will be used as window subclass procedure
Local $hDll = DllCallbackRegister('_SubclassProc', 'lresult', 'hwnd;uint;wparam;lparam;uint_ptr;dword_ptr')
Local $pDll = DllCallbackGetPtr($hDll)

; Install window subclass callback
_WinAPI_SetWindowSubclass($hForm, $pDll, 1000, 0)

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _SubclassProc($hWnd, $iMsg, $wParam, $lParam, $ID, $pData)
	#forceref $ID, $pData
	; Declared in WMDebug.au3
	_WM_Debug($hWnd, $iMsg, $wParam, $lParam)
	Return _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_SubclassProc

Func OnAutoItExit()
	_WinAPI_RemoveWindowSubclass($hForm, $pDll, 1000)
	DllCallbackFree($hDll)
EndFunc   ;==>OnAutoItExit
