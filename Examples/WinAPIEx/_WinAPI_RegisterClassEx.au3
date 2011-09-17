#Include <APIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global Const $sClass = 'MyWindowClass'
Global Const $sName = 'MyProg'

Global $tWCEX, $tClass, $tIcon, $hProc, $hInstance, $hCursor, $hIcon, $hIconSm, $Exit = False

; 获取当前进程的模块句柄
$hInstance = _WinAPI_GetModuleHandle(0)

; 创建类光标
$hCursor = _WinAPI_LoadCursor(0, 32512) ; IDC_ARROW

; 创建类图标 (大和小)
$tIcon = DllStructCreate('ptr;ptr')
_WinAPI_ExtractIconEx(@SystemDir & '\shell32.dll', 130, DllStructGetPtr($tIcon, 1), DllStructGetPtr($tIcon, 2), 1)
$hIcon = DllStructGetData($tIcon, 1)
$hIconSm = DllStructGetData($tIcon, 2)

; 创建 DLL 回调函数 (窗口过程)
$hProc = DllCallbackRegister('_WndProc', 'lresult', 'hwnd;uint;wparam;lparam')

; 创建并填充 $tagWNDCLASSEX 结构
$tWCEX = DllStructCreate($tagWNDCLASSEX)
DllStructSetData($tWCEX, 'Size', DllStructGetSize($tWCEX))
DllStructSetData($tWCEX, 'Style', 0)
DllStructSetData($tWCEX, 'hWndProc', DllCallbackGetPtr($hProc))
DllStructSetData($tWCEX, 'ClsExtra', 0)
DllStructSetData($tWCEX, 'WndExtra', 0)
DllStructSetData($tWCEX, 'hInstance', $hInstance)
DllStructSetData($tWCEX, 'hIcon', $hIcon)
DllStructSetData($tWCEX, 'hCursor', $hCursor)
DllStructSetData($tWCEX, 'hBackground', _WinAPI_CreateSolidBrush(_WinAPI_GetSysColor($COLOR_3DFACE)))
DllStructSetData($tWCEX, 'MenuName', 0)
DllStructSetData($tWCEX, 'ClassName', _WinAPI_CreateString($sClass, $tClass))
DllStructSetData($tWCEX, 'hIconSm', $hIconSm)

; 注册窗口类
_WinAPI_RegisterClassEx($tWCEX)

; 创建窗口
_WinAPI_CreateWindowEx(0, $sClass, $sName, BitOR($WS_CAPTION, $WS_POPUPWINDOW, $WS_VISIBLE), (@DesktopWidth - 400) / 2, (@DesktopHeight - 400) / 2, 400, 400, 0)

While 1
    Sleep(100)
    If $Exit Then
        ExitLoop
    EndIf
WEnd

; 注消窗口类并释放不需要的资源
_WinAPI_UnregisterClass($sClass, $hInstance)
_WinAPI_DestroyCursor($hCursor)
_WinAPI_DestroyIcon($hIcon)
_WinAPI_DestroyIcon($hIconSm)
DllCallbackFree($hProc)

Func _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)

	Local $Ret = DllCall('user32.dll', 'lresult', 'DefWindowProcW', 'hwnd', $hWnd, 'uint', $iMsg, 'wparam', $wParam, 'lparam', $lParam)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_DefWindowProcW

Func _WndProc($hWnd, $iMsg, $wParam, $lParam)
    Switch $iMsg
        Case $WM_CLOSE
            $Exit = 1
    EndSwitch
    Return _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_WndProc
