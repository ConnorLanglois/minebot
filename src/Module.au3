#include <Misc.au3>

Local $isToggled = False

__Main()

Func __Main()
	__Init()
	__Run()
EndFunc

Func __Init()
	HotKeySet('{END}', '__Exit')
	__Window_Attach()

	_Init()
EndFunc

Func __Run()
	While True
		If _IsPressed(_Module_GetKey()) Then
			__Module_OnToggle()
		EndIf

		ToolTip('     Toggled: ' & $isToggled, 0, 0, _Module_GetName())

		_Run()

		Sleep(50)
	WEnd
EndFunc

Func __Module_OnToggle()
	$isToggled = Not $isToggled

	_Module_OnToggle()

	Sleep(50)
EndFunc

Func __Module_IsToggled()
	Return $isToggled
EndFunc

Func __Window_Attach()
	Local $hWnd = WinWait('Minecraft', '', 5)

	If $hWnd = 0 Then
		MsgBox(0, 'ERROR', 'Unable to locate window', 5)
		__Exit()
	EndIf

	WinActivate($hWnd)

	If Not WinWaitActive($hWnd, '', 5) Then
		MsgBox(0, 'ERROR', 'Unable to activate window', 5)
		__Exit()
	EndIf
EndFunc

Func __Exit()
	Exit
EndFunc
