#Requires AutoHotkey v2.0

#h::#1
#j::#2
#k::#3
#y::#4
#u::#5
#i::#6
#c::#7
#v::#8
#n::#9
#m::#0
#f::Send "#{t}{Home}{Right 10}{Enter}"

~LWin::Send "{Blind}{vkE8}"

#p::Reload

; copilot key remap
; #+f23::!+r

<+<#f23:: Send "{Blind}{LShift Up}{RControl Down}"
<+<#f23 Up:: Send "{RControl Up}{LWin Up}"
; copilot sends rcontrol + win

; #^c:: MsgBox "trigger"
#^.::!+r ; whispering
