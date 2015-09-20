#NoEnv
SendMode Input
SetTitleMatchMode 1
CoordMode, Mouse, Screen

; Variables

AIMP = ahk_class TAIMPMainForm
ATray = ahk_class TAIMPTrayControl
HexC = HexChat:

HexXM = 0
HexYM = 0

Wallp1 = bbZero\#65.png
Wallp2 = bbZero\#65.png
Wallp3 = bbZero\#65.png
Wallp4 = bbZero\#66.png
Wallp5 = bbZero\#66.png

WorkId := 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                  ;
;              HOTKEYS             ;
;                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#Numpad1::
    prevWall := Wallp%WorkId%
    Switch(1)
    
    if (Wallp1 != prevWall)
        Run, C:\bbZero\bsetbg.exe -full %Wallp1%
    
    Send #{Numpad1}
    GetKeyState, state, #
    if (state == D)
        Send {# UP}
return

#Numpad2::
    prevWall := Wallp%WorkId%
    Switch(2)
    
    if (Wallp2 != prevWall)
        Run, C:\bbZero\bsetbg.exe -full %Wallp2%
    
    Send #{Numpad2}
    GetKeyState, state, #
    if (state == D)
        Send {# UP}
return

#Numpad3::
    prevWall := Wallp%WorkId%
    Switch(3)
    
    if (Wallp3 != prevWall)
        Run, C:\bbZero\bsetbg.exe -full %Wallp3%
    
    Send #{Numpad3}
    GetKeyState, state, #
    if (state == D)
        Send {# UP}
return

#Numpad4::
    prevWall := Wallp%WorkId%
    Switch(4)
    
    if (Wallp4 != prevWall)
        Run, C:\bbZero\bsetbg.exe -full %Wallp4%
    
    Send #{Numpad4}
    GetKeyState, state, #
    if (state == D)
        Send {# UP}
return

#Numpad5::
    prevWall := Wallp%WorkId%
    Switch(5)
    
    if (Wallp5 != prevWall)
        Run, C:\bbZero\bsetbg.exe -full %Wallp5%
    
    Send #{Numpad5}
    GetKeyState, state, #
    if (state == D)
        Send {# UP}
return

; Switch between AIMP states.

!Numpad0::
    if ProcessExist("AIMP3.exe")
        AIMPswitch()
return

; Switch between wallpapers on current homescreen.

#+W::
    Wall := Wallp%WorkId%
    Wall1 = bbZero\#65.png
    Wall2 = bbZero\#66.png
    
    if (Wall = Wall1)
    {
        Wallp%WorkId% = bbZero\#66.png
        Wall := Wallp%WorkId%
        Run, C:\bbZero\bsetbg.exe -full %Wall%
        MsgBox, Wallpaper set to #66.png.
    }
    else
    {
        Wallp%WorkId% = bbZero\#65.png
        Wall := Wallp%WorkId%
        Run, C:\bbZero\bsetbg.exe -full %Wall%
        MsgBox, Wallpaper set to #65.png.
    }
return

; Store hexchat tray icon position.

+CapsLock::
    MouseGetPos, HexXM, HexYM
    MsgBox, Got X and Y of hexchat tray icon.
return

; Minimize/restore hexchat to/from tray.

^+CapsLock::
    hTray()
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                  ;
;            FUNCTIONS             ;
;                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


hTray()
{
    global
    
    MouseGetPos, X, Y
    MouseMove, 0, 755, 0
    Sleep 10
    MouseMove, %HexXM%,%HexYM%, 0
    SendInput {LButton}
    MouseMove, %X%, %Y%, 0
}

ProcessExist(Name)
{
	Process,Exist,%Name%
	return Errorlevel
}


AIMPswitch()
{
    global

    if WinExist("ahk_class TAIMPMainForm")
    {
        Send !{Numpad0}

        WinActivate, %ATray%
        WinMove, %ATray%,, Xtray%WorkId%, Ytray%WorkId%, Wtray%WorkId%, Htray%WorkId%
    }
    else if WinExist("ahk_class TAIMPTrayControl")
    {
        Send !{Numpad0}
        WinMove, %AIMP%,, Xaimp%WorkId%, Yaimp%WorkId%, Waimp%WorkId%, Haimp%WorkId%
    }
    else
    {
        Send !{Numpad0}
        WinMove, %AIMP%,, Xaimp%WorkId%, Yaimp%WorkId%, Waimp%WorkId%, Haimp%WorkId%
        Send !{Numpad1}
    }
}


Switch(n)
{
    global
    
    ; Grabbing status of hexchat if running.
    
    if ProcessExist("hexchat.exe")
    {
        if WinExist(HexC)
        {
            HexStat%WorkId% = 1
            WinGetPos, Xhex%WorkId%, Yhex%WorkId%, Whex%WorkId%, Hhex%WorkId%, %HexC%
        }
        else
            HexStat%WorkId% = 0
    }

    ; Grabbing status of AIMP3 if running.
    
    if WinExist("ahk_class TAIMPMainForm")
    {
        WinGetPos, Xaimp%WorkId%, Yaimp%WorkId%, Waimp%WorkId%, Haimp%WorkId%, %AIMP%
        AIMPStat%WorkId% := 1

        if (AIMPStat%n% = 0)
        {
            Send !{Numpad0}

            WinActivate, ahk_class TAIMPTrayControl
            WinMove, %ATray%,, Xtray%n%, Ytray%n%, Wtray%n%, Htray%n%
        }
        else if (AIMPStat%n% = 1)
        {
            WinMove, %AIMP%,, Xaimp%n%, Yaimp%n%, Waimp%n%, Haimp%n%
        }
        else if (AIMPStat%n% = 2)
        {
            Send !{Numpad1}
            Send !{Numpad0}
        }
    }
    else if WinExist("ahk_class TAIMPTrayControl")
    {
        ; WinActivate, %ATray%
        
        WinGetPos, Xtray%WorkId%, Ytray%WorkId%, Wtray%WorkId%, Htray%WorkId%, %ATray%
        AIMPStat%WorkId% := 0

        if (AIMPStat%n% = 0)
        {
            WinActivate, %ATray%
            WinMove, %ATray%,, Xtray%n%, Ytray%n%, Wtray%n%, Htray%n%
        }
        else if (AIMPStat%n% = 1)
        {
            Send !{Numpad0}
            WinWait, %AIMP%
            WinMove, %AIMP%,, Xaimp%n%, Yaimp%n%, Waimp%n%, Haimp%n%
        }
        else if (AIMPStat%n% = 2)
        {
            Send !{Numpad1}
        }
    }
    else if ProcessExist("AIMP3.exe")
    {
        AIMPStat%WorkId% := 2

        if (AIMPStat%n% = 0)
        {
            Send !{Numpad1}
            WinWait, %ATray%
            WinActivate, ahk_class TAIMPTrayControl
            WinMove, %ATray%,, Xtray%n%, Ytray%n%, Wtray%n%, Htray%n%
        }
        else if (AIMPStat%n% = 1)
        {
            Send !{Numpad0}
            Send !{Numpad1}
            WinMove, %AIMP%,, Xaimp%n%, Yaimp%n%, Waimp%n%, Haimp%n%
        }
    }
    
    ; Changing status of hexchat if running.
    
    if ProcessExist("hexchat.exe")
    {
        if (HexStat%n% != HexStat%WorkId%)
            hTray()
        
        IfEqual, HexStat%n%, 1, WinMove, %HexC%,, Xhex%n%, Yhex%n%, Whex%n%, Hhex%n%
    }

    WorkId = %n%
}