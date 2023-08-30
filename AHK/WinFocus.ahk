hName := "XYplorer.exe"
hPath := ""
jName := "msedge.exe"
jPath := ""
kName := "Code.exe"
kPath := ""
yName := "GitHubDesktop.exe"
yPath := ""
uName := "Obsidian.exe"
uPath := "C:\Users\nzdlb\AppData\Local\Obsidian\Obsidian.exe"
iName := "sioyek.exe"
iPath := ""

#h::
IfWinExist, ahk_exe %hName%
{
    WinActivate
}
Return

#j::
IfWinExist, ahk_exe %jName%
{
    WinActivate
}
Return

#k::
IfWinExist, ahk_exe %kName%
{
    WinActivate
}
Return

#y::
IfWinExist, ahk_exe %yName%
{
    WinActivate
}
Return

#u::
IfWinExist, ahk_exe %uName%
{
    WinActivate
}
else
{
    Run, %uPath%
}
Return

#i::
IfWinExist, ahk_exe %iName%
{
    WinActivate
}
Return

#o::Reload