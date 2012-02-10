#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Global Const $IDC_ARROW = 32512

Global Const $sClass = ' MyWindowClass '
Global Const $sName = ' MyProg '

Global $tWCEX, $tClass, $tIcon, $hProc, $hInstance, $hCursor, $hIcon, $hIconSm, $Exit = False

; 获取当前进程的模块的句柄
$hInstance = _WinAPI_GetModuleHandle(0)

; 创建类光标
$hCursor = _WinAPI_LoadCursor(0, $IDC_ARROW)

; 创建类图标(大和小)
$tIcon = DllStructCreate('ptr;ptr')
_WinAPI_ExtractIconEx(@SystemDir & ' \shell32.dll ', 130, DllStructGetPtr($tIcon, 1), DllStructGetPtr($tIcon, 2), 1)
$hIcon = DllStructGetData($tIcon, 1)
$hIconSm = DllStructGetData($tIcon, 2)

; 创建DLL回调函数(窗体进程)
$hProc = DllCallbackRegister('_WndProc ', 'lresult ', 'hwnd;uint;wparam;lparam')

; 创建并填充$tagWNDCLASSEX结构
$tWCEX = DllStructCreate($tagWNDCLASSEX)
$tClass = DllStructCreate('wchar[' & StringLen($sClass) + 1 & ' ]')
DllStructSetData($tClass, 1, $sClass)
DllStructSetData($tWCEX, 'Size ', DllStructGetSize($tWCEX))
DllStructSetData($tWCEX, 'Style ', 0)
DllStructSetData($tWCEX, 'hWndProc ', DllCallbackGetPtr($hProc))
DllStructSetData($tWCEX, 'ClsExtra ', 0)
DllStructSetData($tWCEX, 'WndExtra ', 0)
DllStructSetData($tWCEX, 'hInstance ', $hInstance)
DllStructSetData($tWCEX, 'hIcon ', $hIcon)
DllStructSetData($tWCEX, 'hCursor ', $hCursor)
DllStructSetData($tWCEX, 'hBackground ', _WinAPI_CreateSolidBrush( _WinAPI_GetSysColor($COLOR_3DFACE)))
DllStructSetData($tWCEX, 'MenuName ', 0)
DllStructSetData($tWCEX, 'ClassName ', DllStructGetPtr($tClass))
DllStructSetData($tWCEX, 'hIconSm ', $hIconSm)

; 初测窗体类
_WinAPI_RegisterClassEx($tWCEX)

; 创建窗体
_WinAPI_CreateWindowEx(0, $sClass, $sName, BitOR($WS_CAPTION, $WS_POPUPWINDOW, $WS_VISIBLE), (@DesktopWidth - 400) / 2, (@DesktopHeight - 400) / 2, 400, 400, 0)

While 1
	Sleep(100)
	If $Exit Then
		ExitLoop
	EndIf
WEnd

; 注销窗体类并释放无用资源
_WinAPI_UnregisterClass($sClass, $hInstance)
_WinAPI_DestroyCursor($hCursor)
_WinAPI_DestroyIcon($hIcon)
_WinAPI_DestroyIcon($hIconSm)
DllCallbackFree($hProc)

Func _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)

	Local $Ret = DllCall('user32.dll ', 'lresult ', 'DefWindowProcW ', 'hwnd ', $hWnd, 'uint ', $iMsg, 'wparam ', $wParam, 'lparam ', $lParam)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
endfunc   ;==>_WinAPI_DefWindowProcW

Func _WndProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $WM_CLOSE
			$Exit = 1
	EndSwitch
	Return _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)
endfunc   ;==>_WndProc

