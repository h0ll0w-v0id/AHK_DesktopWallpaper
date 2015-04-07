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

	; set vars
	fileList =
	fileCount := 0
	fileDirectory := A_ScriptDir
	
	; find images in script directory
	Loop, Files, %fileDirectory%\*.jpg
   	{
   		fileList = %fileList%%A_LoopFileName%`n
   		fileCount++
	}
	; pick a random from 1 to the total file count
	Random, randFile, 1, fileCount
	
	; loop back through the file array and find the one we want
	Loop, Parse, fileList, `n
	{
	    If A_LoopField =  ; Omit the last linefeed (blank item) at the end of the list.
	        continue
	    If (A_Index = randFile)
	    {
	    	newWallpaper := A_LoopField
	    	break
	    }
	}
	
	; newWallpaper := fileList%randFile%
	; MsgBox %newWallpaper% %randFile% %fileCount% %fileList%
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
