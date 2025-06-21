#Requires AutoHotkey v2.0

#HotIf !GetKeyState("AppsKey","P")
    #h::#1
    #j::#2
    #k::#3
    #y::#4
    #u::#5
    #i::#6
    #c::#7
    #v::#8
    #b::#9
    #n::#0
    #m::Send "#{t}{Home}{Right 10}{Enter}"
#HotIf

#+h::return

~LWin::Send "{Blind}{vkE8}"

#p::Reload

; copilot key remap
; #+f23::!+r

; copilot sends rcontrol + win
<+<#f23:: Send "{Blind}{LShift Up}{RControl Down}"
<+<#f23 Up:: Send "{RControl Up}{LWin Up}"

; remap f22
f22:: Send "{Blind}{LControl Down}{LWin Down}"
f22 Up:: Send "{LControl Up}{LWin Up}"

; #^c:: MsgBox "trigger"
#^.::!+r ; whispering