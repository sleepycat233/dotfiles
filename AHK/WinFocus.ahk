#h::
IfWinExist, ahk_exe XYplorer.exe
{
    IfWinActive, ahk_exe XYplorer.exe
    {
        WinMinimize
    }
    else
    {
        WinActivate
    }
}
Return

#j::
IfWinExist, ahk_exe msedge.exe
{
    IfWinActive, ahk_exe msedge.exe
    {
        WinMinimize
    }
    else
    {
        WinActivate
    }
}
Return

#k::
IfWinExist, ahk_exe Code.exe
{
    IfWinActive, ahk_exe Code.exe
    {
        WinMinimize
    }
    else
    {
        WinActivate
    }
}
Return

#y::
IfWinExist, ahk_exe GitHubDesktop.exe
{
    IfWinActive, ahk_exe GitHubDesktop.exe
    {
        WinMinimize
    }
    else
    {
        WinActivate
    }
}
Return

#u::
; Check if Obsidian window exists
IfWinExist, ahk_exe Obsidian.exe
{
    ; Check if Obsidian window is the active window
    IfWinActive, ahk_exe Obsidian.exe
    {
        ; If it's active, minimize it
        WinMinimize
    }
    else
    {
        ; If it exists but is not active, bring it to the front
        WinActivate
    }
}
Return

#i::
IfWinExist, ahk_exe sioyek.exe
{
    IfWinActive, ahk_exe sioyek.exe
    {
        WinMinimize
    }
    else
    {
        WinActivate
    }
}
Return

#o::Reload