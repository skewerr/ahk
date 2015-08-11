; Multi-purpose ahk script.

CoordMode, Mouse, Screen
SendMode Input
#InstallKeybdHook
#NoEnv


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


^Numpad1:: WinMove, A,, 73,58,808,630
^Numpad2:: WinMove,A,, 887,58,406,323
^Numpad3:: WinMove,A,, 887,365,406,323
^Numpad4:: WinMove,A,, 887,58,406,630
^Numpad5:: WinMove, A,, 76, 83, 1214, 602
^Numpad6:: WinMove,A,, 74,59,806,628
^Numpad7:: WinMove,A,, 73,58,1220,630
^Numpad8:: WinMove,A,, 73,58,607,630
^Numpad9:: WinMove,A,, 686,58,607,630

^!Numpad1:: WinMove, A,, 76,83,802,602
^!Numpad2:: WinMove,A,, 890,83,400,295
^!Numpad3:: WinMove, A,, 890,390,400,295
^!Numpad4:: WinMove,A,, 483,122,400,502
^!Numpad5:: WinMove,A,, 73,86,406,575
^!Numpad6:: WinMove,A,, 887,86,406,575
^!Numpad7:: WinMove,A,, 12,12,866,744
^!Numpad8:: WinMove,A,, 483,86,400,575
^!Numpad9:: WinMove,A,, 483,111,400,547

^NumpadEnd:: WinMove,A,, 153,118,648,510
^NumpadLeft:: WinMove,A,, 890,83,400,602


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
      WinMove, ahk_class CabinetWClass,, 887,58,406,323
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
^!r:: MacType()

; Center active window.

^+c:: CenterWindow("A")
^!c:: CenterWindowOne("A")

; Show coordinates of active window.

^+g::
    WinGetPos , X, Y, W, H, A
    MsgBox, X: %X%, Y: %Y%, W: %W%, H: %H%
return

; Show current pointer coordinates.

^+m::
    MouseGetPos, X, Y
    MsgBox, X: %X% Y: %Y%
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
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)-11
}

; Center a window relative to tiling position 1.

CenterWindowOne(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2)-206, (A_ScreenHeight/2)-(Height/2)-11
}

; Restart MacType rendering through tray icon.

MacType()
{
    WinGetClass, windowClass, A
    MouseGetPos, X, Y
    MouseMove, 0,755, 0
    Sleep 10
    MouseMove, 28, 755, 0
    Sleep 100
    SendInput {RButton}
    Sleep 200
    SendInput r
    MouseMove, %X%, %Y%, 0
    Sleep 50
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

^n::
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

#IfWinActive ahk_class gdkWindowToplevel

; Disable Ctrl+W
^W:: return

; Make CapsLock Tab.
Capslock:: SendInput {Tab}

#IfWinActive
