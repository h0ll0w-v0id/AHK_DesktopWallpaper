/*
	--------------------------------------------------------
	REVISION BLOCK
		
	Project Name: Windows_Wallpaper
	
	Revision History:
	
	Date		Rev		Change Description
	--------------------------------------------------------
	10/16/14	1.0.0		Beta release
	10/29/14	1.0.1		Updated commnets
	--------------------------------------------------------

	Project Overview:
	
		A very simple AutoHotkey script that changes Windows 7 wallpaper
	
	Project Features:
	
		NA
			
	Project Notes:

		Requires PC Running Windows 7
		
		Requires a specified image in the script dir	
			
	--------------------------------------------------------
*/
; ----------------------------------------------------------
; Info .........: reference - http://msdn.microsoft.com/en-us/library/ms724947%28v=vs.85%29.aspx#Desktop
; ----------------------------------------------------------

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

	; set image
	Image1 := "Desert.JPG"
	Wallpaper1 := A_ScriptDir . "\" . Image1

	; call dll and capture return
	returnVar := DllCall("SystemParametersInfo", UInt, 0x0014, UInt, 0, Str, Wallpaper1, UInt, 1)

	; if error
	If !returnVar
	{
		MsgBox, 262192, Error Setting Wallpaper,
		(LTrim
		There was an error in setting %Wallpaper1% as the wallpaper.
		`nVerify `'%Wallpaper1%`' resides in `'%A_ScriptDir%`' and run script again...
		)
	}
	
ExitApp
