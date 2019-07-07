#include 'Module.au3'

Func _Init()
	Global $cps = 15
	Global $timer = TimerInit()
EndFunc

Func _Run()
	If __Module_IsToggled() And TimerDiff($timer) >= 1000 / $cps Then
		_EventManager_FireEvent_OnTick()

		$timer = TimerInit()
	EndIf
EndFunc

Func _Module_ClickBot_Click()
	MouseClick('primary')
EndFunc

Func _EventManager_FireEvent_OnTick()
	_Module_ClickBot_Click()
EndFunc

Func _Module_OnToggle()

EndFunc

Func _Module_GetKey()
	Return 52
EndFunc

Func _Module_GetName()
	Return 'ClickBot'
EndFunc
