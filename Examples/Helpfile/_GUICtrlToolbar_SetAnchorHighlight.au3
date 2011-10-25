
#include  <GuiToolbar.au3>
#include  <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_TB = False ; 检查传递给函数的类名,
设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hToolbar, $fEnabled

	Run( "explorer.exe /root,
	, ::{20D04FE0 - 3AEA - 1069 - A2D8 - 08002B30309D}" )
	WinWaitActive( "My
	Computer" )
	Sleep(1000)
	$hToolbar = _GUICtrlToolbar_FindToolbar("[CLASS:CabinetWClass]", "&File")
	$fEnabled = _GUICtrlToolbar_GetAnchorHighlight($hToolbar)
	MsgBox(4096, "Information", "Anchor highlight
	enabled: "  &  $fEnabled )
	_GUICtrlToolbar_SetAnchorHighlight($hToolbar, Not $fEnabled)
	MsgBox(4096, "Information", "Anchor highlight enabled:" & _GUICtrlToolbar_GetAnchorHighlight($hToolbar))

endfunc   ;==>_Main

