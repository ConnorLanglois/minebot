#include <Misc.au3>

Local $isToggled = False

_Main()

Func _Main()
	_Init()
	_Run()
EndFunc

Func _Init()
	HotKeySet('{END}', '_Exit')

	_Window_Attach()
EndFunc

Func _Run()
	While True
		ToolTip('     Toggled: ' & $isToggled, 0, 0, 'SprintLegit')

		If _IsPressed(46) Then
			_Module_SprintLegit_Toggle()
		EndIf

		Sleep(100)
	WEnd
EndFunc

Func _Module_SprintLegit_Toggle()
	Local Const $key = 'LSHIFT'

	If Not $isToggled Then
		Send('{' & $key & ' down}')
	Else
		Send('{' & $key & ' up}')
	EndIf

	$isToggled = Not $isToggled

	Sleep(50)
EndFunc

Func _Window_Attach()
	Local $hWnd = WinWait('Minecraft', '', 5)

	If $hWnd = 0 Then
		MsgBox(0, 'ERROR', 'Unable to locate window', 5)
		_Exit()
	EndIf

	WinActivate($hWnd)

	If Not WinWaitActive($hWnd, '', 5) Then
		MsgBox(0, 'ERROR', 'Unable to activate window', 5)
		_Exit()
	EndIf
EndFunc

Func _Exit()
	Exit
EndFunc
