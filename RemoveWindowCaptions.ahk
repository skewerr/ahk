CoordMode, Mouse, Screen
; Uncomment this if you want a hotkey to set it for every
; !+r::GoSub, AdjustAllWindows

; Initalise the hook
GoSub, HookWindow
; Run it once for every window
GoSub, AdjustAllWindows
Return

HookWindow:
    ; New Window Hook
    Gui +LastFound
    hWnd := WinExist()

    DllCall( "RegisterShellHookWindow", UInt,hWnd )
    MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
    OnMessage( MsgNum, "ShellMessage" )

    ShellMessage(wParam,lParam) {
        If (wParam = 1) ;  HSHELL_WINDOWCREATED := 1
        {
            Sleep, 10
            AdjustWindow(lParam)
        }
    }
Return

; Adjust Window
AdjustWindow(id)
{
    WinId := id
    WinTitle := id = "A" ? "A" : "ahk_id " . id
    WinGetTitle, WindowTitle, %WinTitle%

    ; This is to check if the window is shown in the alt-tab menu, you don't want to do it on every single frame
;    WinGet, WinExStyle, ExStyle, %WinTitle%
;    If (WinExStyle & 0x80)
;    {
;        Return
;    }
;
;    ; This is to match classes and/or processes
    WinGetClass, WinClass, %WinTitle%
    WinGet, WinProcess, ProcessName, %WinTitle%
;    
;    ; Explorer
;    If WinClass In % "CabinetWClass"
;    If WinProcess In % "explorer.exe"
;    {
;        WinSet, Style, -0xC00000, %WinTitle%
;    }
;    
;    ; foobar2000
;    If WinClass In % "{E7076D1C-A7BF-4f39-B771-BCBE88F2A2A8}"
;    {
;        ; This removes titlebar AND borders, just an example
;        WinSet, Style, -0xC40000, %WinTitle%
;    }
;    
;    ; uTorrent
;    If WinProcess In % "uTorrent.exe"
;    {
;        WinSet, Style, -0xC00000, %WinTitle%
;    }
    
    ; Uncomment this and comment the above if you don't want it to work on every window
    If WinClass In % "MozillaWindowClass"
    {
        Browser := "Vimperator"
        IfNotInString, WindowTitle, %Browser%
        {
            WinSet, Style, -0xC00000, %WinTitle%
            WinGetPos, , , W, H, %WinTitle%
            Hr := H--
            WinMove, %WinTitle%,, , , %W%, %H%
            WinMove, %WinTitle%,, , , %W%, %Hr%
        }
    }
}

AdjustAllWindows:
    WinGet, id, list,,, Program Manager
    Loop, %id%
    {
        AdjustWindow(id%A_Index%)
    }
Return