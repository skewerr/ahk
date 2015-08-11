#NoEnv
SendMode Input
SetTitleMatchMode 1

; Variables

AIMP = ahk_class TAIMPMainForm
ATray = ahk_class TAIMPTrayControl
HexC = HexChat: 

WorkId := 1

; Hotkeys

#Numpad1::
    Switch(1)
    Send #{Numpad1}
    GetKeyState, state, #
    if state = D
        Send {# UP}
return

#Numpad2::
    Switch(2)
    Send #{Numpad2}
    GetKeyState, state, #
    if state = D
        Send {# UP}
return

#Numpad3::
    Switch(3)
    Send #{Numpad3}
    GetKeyState, state, #
    if state = D
        Send {# UP}
return

#Numpad4::
    Switch(4)
    Send #{Numpad4}
    GetKeyState, state, #
    if state = D
        Send {# UP}
return

#Numpad5::
    Switch(5)
    Send #{Numpad5}
    GetKeyState, state, #
    if state = D
        Send {# UP}
return

!Numpad0::
    AIMPswitch()
return

; Functions

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
    
    WinGet, HexStat%WorkId%, MinMax, %HexC%
    IfEqual, HexStat%WorkId%, -1, WinRestore, %HexC%
    WinGetPos, Xhex%WorkId%, Yhex%WorkId%, Whex%WorkId%, Hhex%WorkId%, %HexC%
    
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
        WinActivate, %ATray%
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
            Send !{Numpad0}
            WinWait, %AIMP%
            Send !{Numpad1}
            Send !{Numpad0}
        }
    }
    else
    {
        AIMPStat%WorkId% := 2
        
        if (AIMPStat%n% = 0)
        {
            Send !{Numpad0}
            WinWait, %AIMP%
            Send !{Numpad1}
            Send !{Numpad0}
            Sleep 200
            WinActivate, ahk_class TAIMPTrayControl
            WinMove, %ATray%,, Xtray%n%, Ytray%n%, Wtray%n%, Htray%n%
        }
        else if (AIMPStat%n% = 1)
        {
            Send !{Numpad0}
            WinWait, %AIMP%
            Send !{Numpad1}
            WinMove, %AIMP%,, Xaimp%n%, Yaimp%n%, Waimp%n%, Haimp%n%
        }
    }
    
    WinMove, %HexC%,, Xhex%n%, Yhex%n%, Whex%n%, Hhex%n%
    IfEqual, HexStat%n%, -1, WinMinimize, %HexC%
    IfEqual, HexStat%n%, 0, WinRestore, %HexC%
    
    WorkId = %n%
}