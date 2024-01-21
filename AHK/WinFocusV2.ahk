#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Define your key-value pairs with hotkey modifiers
kv := {"#u":"Obsidian", "#i":"sioyek", "#j":"msedge", "#k":"Code", "#h": "XYplorer", "#y": "GitHubDesktop"}

; Create a group for each executable
for key, value in kv {
    groupName := "Group" . value   ; Create a unique group name for each executable
    GroupAdd, %groupName%, ahk_exe %value%.exe  ; Add all windows of this executable to the group
}

; Loop through each key-value pair and create a hotkey
for key, value in kv {
    Hotkey, %key%, LaunchAndCenter  ; Use the key directly as it includes the hotkey modifier
}

; Function called by the hotkey
LaunchAndCenter:
    ; Get the hotkey (including the modifier) that triggered the function
    TriggeredHotkey := A_ThisHotkey

    ; Get the corresponding value (executable name)
    ExecutableName := kv[TriggeredHotkey]
    groupName := "Group" . ExecutableName

    ; Activate the window
    IfWinExist, ahk_exe %ExecutableName%.exe
    {
        ; MsgBox, activate %groupName%
        ; WinActivate
        GroupActivate, %groupName%, R  ; Activate the next window in the group
        Sleep, 100 ; Give some time for the window to activate
        WinGet, active_id, ID, A
        CenterCursorInWindow(active_id)
    }
    else
        ; MsgBox, % "Window for " . ExecutableName . " not found."
return

; #C::
;     WinGet, active_id, ID, A
;     CenterCursorInWindow(active_id)
; Return

CenterCursorInWindow(active_id) {
    ; Get the size and position of the active window
    WinGetPos, X, Y, Width, Height, ahk_id %active_id%

    ; Calculate the center position
    CenterX := Width / 2
    CenterY := Height / 2

    ; Debug
    ; ToolTip, active_id: %active_id%`nX:%X%`nY:%Y%`nWidth: %Width%`nHeight: %Height%`nCenterX: %CenterX%`nCenterY: %CenterY%

    ; Move the mouse to the center of the active window
    MouseMove, CenterX, CenterY, 2
}

#p::Reload

; Hotkey: Win + C
; #C::
;     ; Get the Active Window's ID
;     WinGet, active_id, ID, A

;     ; Get the size and position of the active window
;     WinGetPos, X, Y, Width, Height, ahk_id %active_id%

;     ; Calculate the center position
;     CenterX := (Width / 2)
;     CenterY := (Height / 2)

;     ; Debug
;     WinGet, ahk_pid, PID, ahk_id %active_id%
;     ToolTip, ahk_pid: %ahk_pid%`nactive_id: %active_id%`nX:%X%`nY:%Y%`nWidth: %Width%`nHeight: %Height%`nCenterX: %CenterX%`nCenterY: %CenterY%

;     ; Move the mouse to the center of the active window
;     MouseMove, CenterX, CenterY, 10  ; The '0' makes the movement instant. Increase the value for a gradual mouse move.
; Return