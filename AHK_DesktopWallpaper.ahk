/*
	--------------------------------------------------------
	REVISION BLOCK
		
	Project Name: AHK_DesktopWallpaper.ahk
	
	Revision History:
	
	Date		Rev		Change Description
	--------------------------------------------------------
	10/16/14	1.0.0		Beta release
	10/29/14	1.0.1		Updated commnets
	04/07/15	1.0.2		Renamed for GitHub
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

	fileList =
	fileCount = 0
	
	; find images in script directory
	Loop, Files, *.jpg
   	{
   		fileList = %fileList%%A_LoopFileName%`n
   		fileCount++
	}
	Random, randFile, 1, fileCount
	newWallpaper := fileList%randFile%
	MsgBox %, newWallpaper
	; Image1 := "Desert.JPG"
	; Wallpaper1 := A_ScriptDir . "\" . Image1

	; call dll and capture return
	returnVar := DllCall("SystemParametersInfo", UInt, 0x0014, UInt, 0, Str, newWallpaper, UInt, 1)

	; if error
	If !returnVar
	{
		MsgBox, 262192, Error Setting Wallpaper,
		(LTrim
		There was an error in setting %newWallpaper% as the wallpaper.
		`nVerify `'%newWallpaper%`' resides in `'%A_ScriptDir%`' and run script again...
		)
	}
	
ExitApp
