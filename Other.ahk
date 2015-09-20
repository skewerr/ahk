; Multi-purpose ahk script.

CoordMode, Mouse, Screen
SendMode Input
SetTitleMatchMode 1
#InstallKeybdHook
#NoEnv

; Global Variables
SysMonitor := 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                              ;
;                MOVING WINDOWS                ;
;                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


^+Right::
  WinGetPos, X, Y, , , A
  Xr := ++X
  WinMove, A,, %Xr%, %Y%
return

^+Left::
  WinGetPos, X, Y, , , A
  Xl := --X
  WinMove, A,, %Xl%, %Y%
return

^+Down::
  WinGetPos, X, Y, , , A
  Yd := ++Y
  WinMove, A,, %X%, %Yd%
return

^+Up::
  WinGetPos, X, Y, , , A
  Yu := --Y
  WinMove, A,, %X%, %Yu%
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                              ;
;              RESIZING WINDOWS                ;
;                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


^!Right::
  WinGetPos, , , W, H, A
  Wr := ++W
  WinMove, A,, , , %Wr%, %H%
return

^!Left::
  WinGetPos, , , W, H, A
  Wr := --W
  WinMove, A,, , , %Wr%, %H%
return

^!Up::
  WinGetPos, , , W, H, A
  Hr := ++H
  WinMove, A,, , , %W%, %Hr%
return

^!Down::
  WinGetPos, , , W, H, A
  Hr := --H
  WinMove, A,, , , %W%, %Hr%
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                              ;
;           TILING LAYOUT POSITIONS            ;
;                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


^Numpad1::    WinMove, A,,   73,   68,  808,  630
^Numpad2::    WinMove, A,,  887,   68,  406,  323
^Numpad3::    WinMove, A,,  887,  375,  406,  323
^Numpad4::    WinMove, A,,  887,   68,  406,  630
^Numpad5::    WinMove, A,,   76,   93, 1214,  602
^Numpad6::    WinMove, A,,   74,   69,  806,  628
^Numpad7::    WinMove, A,,   73,   68, 1220,  630
^Numpad8::    WinMove, A,,   73,   68,  607,  630
^Numpad9::    WinMove, A,,  686,   68,  607,  630

^!Numpad1::   WinMove, A,,   76,   93,  802,  602
^!Numpad2::   WinMove, A,,  890,   93,  400,  295
^!Numpad3::   WinMove, A,,  890,  400,  400,  295
^!Numpad4::   WinMove, A,,  483,  132,  400,  502
^!Numpad5::   WinMove, A,,   73,   96,  406,  575
^!Numpad6::   WinMove, A,,  887,   96,  406,  575
^!Numpad7::   WinMove, A,,   12,   22,  866,  744
^!Numpad8::   WinMove, A,,  483,   96,  400,  575
^!Numpad9::   WinMove, A,,  483,  121,  400,  547

^NumpadEnd::  WinMove, A,,  153,  128,  648,  510
^NumpadLeft:: WinMove, A,,  890,   93,  400,  602


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                              ;
;               STARTING PROGRAMS              ;
;                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Start Notepad2

#n::
    if WinExist("ahk_class Notepad2U")
    {
      WinActivate
    }
    else
    {
      run notepad.exe
      WinWait, ahk_class Notepad2U
      ToggleMenu( WinExist("ahk_class Notepad2U") )
      MacType() ; Restart MacType rendering.
      WinActivate, ahk_class Notepad2U
    }
return

; Start an explorer window on Libraries.

#e::
    if WinExist("ahk_class CabinetWClass")
    {
      WinActivate
    }
    else
    {
      run C:\Users\spoonm\AppData\Roaming\Microsoft\Windows\Libraries\
      WinWait, ahk_class CabinetWClass
      WinMove, ahk_class CabinetWClass,, 887,68,406,323
      MacType() ; Restart MacType rendering.
      WinActivate, ahk_class CabinetWClass
    }
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                              ;
;                OTHER HOTKEYS                 ;
;                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Restart MacType rendering.
CapsLock::
    MacType()
return

^CapsLock::
    if (SysMonitor == 1)
    {
        Run, C:\bbZero\blackbox.exe -exec @BBInterface Control SetWindowProperty SysMon2 IsVisible false
        Run, C:\bbZero\blackbox.exe -exec @BBInterface Control SetWindowProperty SystemMonitor IsVisible false
        SysMonitor := 0
    }
    else
    {
        Run, C:\bbZero\blackbox.exe -exec @BBInterface Control SetWindowProperty SysMon2 IsVisible true
        Run, C:\bbZero\blackbox.exe -exec @BBInterface Control SetWindowProperty SystemMonitor IsVisible true
        SysMonitor := 1
    }
return

; Center active window.

^+c:: CenterWindow("A")
^!c:: CenterWindowOne("A")

; Show coordinates of active window.

^+g::
    WinGetPos , X, Y, W, H, A
    MsgBox, X: %X%, Y: %Y%, W: %W%, H: %H%
return

; Show current pointer coordinates and active
; window coordinates.

^+m::
    MouseGetPos, Xm, Ym
    WinGetPos, X, Y, W, H, A
    MsgBox, Mouse: %Xm%, %Ym%`nWindow: %X%, %Y%, %W%, %H%
return

; Show current active window class.

^!+c::
  WinGetClass, class, A
  MsgBox, The active window's class is "%class%".
return

; Toggle the window caption bar.

#h:: WinSet, Style, -0xc00000, A
#s:: WinSet, Style, +0xc00000, A

; Disable Ctrl+W hotkey using right Ctrl key.
; Make it behave as AltGr+W instead.

RControl & W:: SendInput ?

; Toggle menu bar on active window.

^+p:: ToggleMenu( WinExist("A") )

; Change my taskbar border to white on win maximize

~#Up::
    Run, C:\bbZero\blackbox.exe -exec @BBInterface Control SetAgent Border Image Bitmap "C:\bbZero\barw.png"
return

; Change my taskbar border to black on win minimize

~#Down::
    Run, C:\bbZero\blackbox.exe -exec @BBInterface Control SetAgent Border Image Bitmap "C:\bbZero\bar.png"
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                              ;
;                  FUNCTIONS                   ;
;                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Hide or bring back menu bars.
; Not mine, and I don't have credits for it, sorry.

ToggleMenu( hWin )
{
    global
    
    if ToggleMenu_a[%hWin%]_menuHandle = 0
        return 0

    if ToggleMenu_a[%hWin%]_menuHandle =
    {
        ToggleMenu_a[%hWin%]_menuHandle := DllCall("GetMenu", "uint", hWin)
        ToggleMenu_a[%hWin%]_visible := true
    }
    
    if (ToggleMenu_a[%hWin%]_visible)
            DllCall("SetMenu", "uint", hWin, "uint", 0)
    else    DllCall("SetMenu", "uint", hWin, "uint", ToggleMenu_a[%hWin%]_menuHandle )

    ToggleMenu_a[%hWin%]_visible := !ToggleMenu_a[%hWin%]_visible
    return 1
}

; Center a window relative to the screen.

CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)-1
}

; Center a window relative to tiling position 1.

CenterWindowOne(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2)-206, (A_ScreenHeight/2)-(Height/2)-1
}

; Restart MacType rendering through tray icon.

MacType()
{
    WinGetClass, windowClass, A
    MouseGetPos, X, Y
    MouseMove, 0,755, 0
    Sleep 10
    MouseMove, 28, 755, 0
    Sleep 10
    SendInput {RButton}
    Sleep 50
    SendInput r
    MouseMove, %X%, %Y%, 0
    Sleep 10
    Class = ahk_class %windowClass%
    WinActivate, %Class%
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                              ;
;          PROGRAM EXCLUSIVE HOTKEYS           ;
;                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Windows Explorer

#IfWinActive, ahk_class CabinetWClass

; Make a new folder.
^z::
    SendInput !FWF
return

; Rename active item.
CapsLock:: SendInput {F2}

#IfWinActive

; ConEmu

#IfWinActive, ahk_class VirtualConsoleClass

; Toggle tab bar, but keep window size and position.

#t::
    WinGetPos, A,, X_c, Y_c, W_c, H_c
    SendInput #t
    WinMove, A,, %X_c%,%Y_c%,%W_c%,%H_c%
return

#IfWinActive

; HexChat

#IfWinActive, ahk_class gdkWindowToplevel

; Disable Ctrl+W
^W:: return

#IfWinActive
