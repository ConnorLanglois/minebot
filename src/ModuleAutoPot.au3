Local $hWnd

Local $clientSize
Local $width
Local $height

Local $nPotsUsed
Local $nPotsReloaded

_Main()

Func _Main()
	_Init()
	_Run()
EndFunc

Func _Init()
	HotKeySet('{END}', '_Exit')
	AutoItSetOption('PixelCoordMode', 2)
	AutoItSetOption('MouseCoordMode', 2)
	AutoItSetOption('SendKeyDelay', 50)

	_Window_Attach()
	_Window_SetDimensions()
EndFunc

Func _Run()
	_Window_SetDimensions()
	AdlibRegister('_EventManager_FireEvent_Tick', 250)

	While True
		Sleep(5000)
	WEnd
EndFunc

Func _EventManager_FireEvent_Tick()
	ToolTip('     Pots Used: ' & $nPotsUsed & @CRLF & _
			'     Pots Reloaded: ' & $nPotsReloaded, 0, 0, 'AutoPot')
	_Pot_UseIfNeeded()
EndFunc

Func _Pot_UseIfNeeded()
	If _Pot_IsNeeded() Then
		_Pot_Use()
	EndIf
EndFunc

Func _Pot_Use()
	Local Const $nAvailableSlots = 8
	Local Const $throwKey = 'q'
	Local Const $mainSlot = 1

	If $nPotsUsed > 0 And Mod($nPotsUsed, 8) = 0 Then
		_Pot_Reload()
	EndIf

	Send(Mod($nPotsUsed, $nAvailableSlots) + 2)
	Sleep(25)
	MouseClick('secondary')
	Sleep(25)
	Send($throwKey & $mainSlot)

	$nPotsUsed += 1
EndFunc

Func _Pot_Reload()
	Local Const $slotDim = 36

	Send('e{LSHIFT down}')
	Sleep(50)

	For $i = 0 To 7
		If $nPotsReloaded = 22 Then
			$nPotsReloaded = 0

			ExitLoop
		EndIf

		MouseClick('secondary', $width / 2 - 4 * $slotDim + Mod($nPotsReloaded, 9) * $slotDim, $height / 2 + Int($nPotsReloaded / 9) * $slotDim, 1, 0)

		$nPotsReloaded += 1
	Next

	Sleep(50)
	Send('{LSHIFT up}e')
EndFunc

Func _Pot_IsNeeded()
	Local Const $maxHealthLoss = 7
	Local Const $x = $width / 2 - 22 - 8 * $maxHealthLoss - 4
	Local Const $y = $height - 68

	If PixelGetColor($x, $y, $hWnd) = 0x282828 Then
		Return True
	EndIf
EndFunc

Func _Window_SetDimensions()
	$clientSize = WinGetClientSize($hWnd)
	$width = $clientSize[0]
	$height = $clientSize[1]
EndFunc

Func _Window_Attach()
	$hWnd = WinWait('Minecraft', '', 5)

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
