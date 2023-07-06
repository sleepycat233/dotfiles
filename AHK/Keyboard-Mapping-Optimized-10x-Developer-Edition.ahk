#NoEnv
#SingleInstance, Force
; #KeyHistory 0
; Process, Priority, , A
; ListLines, Off

#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000

SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1

SetBatchLines, -1

SendMode Input
SetWorkingDir, %A_ScriptDir%


;How long the Shift should stay active this value is in seconds. use 0.5 for half secondif you want a capital A, then press and release Shift, then press 'a' within two seconds after the timeout has elapsed, the shift is no longer in effect
timeout := 0.3

;Should tapping shift twice turn on Capslock? this value is either 'true' or 'false' with no quotes default is 'false', which means a double tap of Shift will cancel the shift
double_shift_for_caps := true

;Allow the sequence "Shift,Space,Key" to still shift the Key this value is either 'true' or 'false' with no quotes this means that the Spacebar will not cancel the shift a user wanted to press Shift+Space to be able to shift the next char after Space
skip_spacebar := true

; we don't want Control as end key, because we need to be able to press Shift,Ctrl+Left
; we don't want Alt as end key, because Shift+Alt+F should still open up File menu bars
; we don't want Win as end key, because it Shift+Win+D should still send Shift+D
; don't want CapsLock as end key, because Shift down, Caps down/up, Shift still down + M, should invert CapsLock
end_keys := "{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}"
. "{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{PrintScreen}{Pause}{AppsKey}{LShift}{RShift}"
; test := 0

; F11::ListHotkeys
; Esc::ExitApp

Hotkey, LShift, Shift_Down, on
Hotkey, RShift, Shift_Down, on
Hotkey, LShift Up, Shift_Up , on
Hotkey, RShift Up, Shift_Up , on

Hotkey, *h, Off
Hotkey, *j, Off
Hotkey, *k, Off
Hotkey, *l, Off
Hotkey, *o, Off
Hotkey, *u, Off
Hotkey, *e, Off
; Hotkey, *h, Off
; Hotkey, *[, Off
Hotkey, *s, Off
Hotkey, *f, Off
Hotkey, *., Off
Hotkey, *`,, Off
Hotkey, *m, Off
Hotkey, *w, Off
Hotkey, *q, Off
Hotkey, *c, Off
Hotkey, *x, Off
Hotkey, *v, Off
Hotkey, *r, Off
Hotkey, *z, Off
Hotkey, *y, Off
Hotkey, *t, Off
Hotkey, *a, Off
Hotkey, *d, Off
Hotkey, *`;, Off
; Hotkey, *g, Off
Hotkey, *t, Off
Hotkey, *b, Off
; Hotkey, *p, Off
Hotkey, *i, Off
; Hotkey, *!, Off
; Hotkey, *@, Off
; Hotkey, *#, Off
; Hotkey, *$, Off
; Hotkey, *`%, Off
; Hotkey, *^, Off
; Hotkey, 1, Off
; Hotkey, 2, Off
; Hotkey, 3, Off
; Hotkey, 4, Off
; Hotkey, 5, Off
; Hotkey, 6, Off
; Hotkey, *9, Off
Hotkey, *n, Off
; Hotkey, 0, Off

*AppsKey::
    Hotkey, *h, on
    Hotkey, *j, on
    Hotkey, *k, on
    Hotkey, *l, on
    Hotkey, *o, on
    Hotkey, *u, on
    Hotkey, *e, on
    ; Hotkey, *h, on
    ; Hotkey, *[, on
    Hotkey, *s, on
    Hotkey, *f, on
    Hotkey, *., on
    Hotkey, *`,, on
    Hotkey, *m, on
    Hotkey, *w, on
    Hotkey, *q, on
    Hotkey, *c, on
    Hotkey, *x, on
    Hotkey, *v, on
    Hotkey, *r, on
    Hotkey, *z, on
    Hotkey, *y, on
    Hotkey, *t, on
    Hotkey, *a, on
    Hotkey, *d, on
    Hotkey, *`;, on
    ; Hotkey, *g, on
    Hotkey, *t, on
    Hotkey, *b, on
    ; Hotkey, *p, on
    Hotkey, *i, on
    ; Hotkey, *!, on
    ; Hotkey, *@, on
    ; Hotkey, *#, on
    ; Hotkey, *$, on
    ; Hotkey, *`%, on
    ; Hotkey, *^, on
; Hotkey, 1, On
; Hotkey, 2, On
; Hotkey, 3, On
; Hotkey, 4, On
; Hotkey, 5, On
; Hotkey, 6, On
    ; Hotkey, *9, on
    Hotkey, *n, on
    ; Hotkey, 0, on
return

*AppsKey up::
    Hotkey, *h, off
    Hotkey, *j, off
    Hotkey, *k, off
    Hotkey, *l, off
    Hotkey, *o, Off
    Hotkey, *u, Off
    Hotkey, *e, Off
    ; Hotkey, *h, Off
    ; Hotkey, *[, Off
    Hotkey, *s, Off
    Hotkey, *f, Off
    Hotkey, *., Off
    Hotkey, *`,, Off
    Hotkey, *m, Off
    Hotkey, *w, Off
    Hotkey, *q, Off
    Hotkey, *c, Off
    Hotkey, *x, Off
    Hotkey, *v, Off
    Hotkey, *r, Off
    Hotkey, *z, Off
    Hotkey, *y, Off
    Hotkey, *t, Off
    Hotkey, *a, Off
    Hotkey, *d, Off
    Hotkey, *`;, Off
    ; Hotkey, *g, Off
    Hotkey, *t, Off
    Hotkey, *b, Off
    ; Hotkey, *p, Off
    Hotkey, *i, Off
    ; Hotkey, *!, Off
    ; Hotkey, *@, Off
    ; Hotkey, *#, Off
    ; Hotkey, *$, Off
    ; Hotkey, *`%, Off
    ; Hotkey, *^, Off
    ; Hotkey, 1, Off
    ; Hotkey, 2, Off
    ; Hotkey, 3, Off
    ; Hotkey, 4, Off
    ; Hotkey, 5, Off
    ; Hotkey, 6, Off
    ; Hotkey, *9, Off
    ; Hotkey, 0, Off
    Hotkey, *n, Off
return

;RALT combos:
*k::send {blind}{up}
*j::send {blind}{down}
*h::send {blind}{left}
*l::send {blind}{right}
*o::send {blind}{end}
*y::send {blind}{home}
*i::send {blind}{PgUp} ;(Page) page up or down
*u::send {blind}{PgDn} ;(Page) page up or down

;
; Custom commands are software-dependent and needing manual configuration for the keybinds.
; Below are the required extensions for VSCode:
;"Bracket Select" publisher:"Chunsen Wang"
;"Quick and Simple Text Selection" publisher:"David Bankier"
;"change-case" publisher:"wmaurer"
;"Go to Next/Previous Member" publisher:"Mishkin Faustini"
;"Any Swap" by publisher:"wolray"
;"copy word in cursor" publisher:"Alessandro Fragnani"
;"Semicolon Insertion Shortcut" publisher:"Christian Valentin"
;"Multiple clipboards for VSCode" publisher:"slevesque"
;"Metago"
;

*w::send {blind}{LCtrl Down}{d}{LCtrl Up} ;(Word) select word, press again to select next occurrence
*c::send {LCtrl Down}{c}{LCtrl Up} ;(Copy) copy word ! "copy word in cursor"
*x::send {LCtrl Down}{x}{LCtrl Up} ;(X) cut word/selection !need above extension
*v::send {LCtrl Down}{v}{LCtrl Up} ;(V) Paste
;*r::send {LCtrl Down}{d}{v}{LCtrl Up}    ;(Replace) replace Word with the clipboard
*z::send {Blind}{LCtrl Down}{z}{LCtrl Up} ;(Z) undo
; *y::send {LCtrl Down}{y}{LCtrl Up} ;(Y) redo
*t::send {home}{LShift Down}{end}{LShift Up} ;(Text) select all Text in line (excluding the indent)
*a::send {Blind}{LCtrl Down}{g}{LCtrl Up} ;(All) select all things in a line including the indent
*r::send {LCtrl Down}{LShift Down}{r}{LShift Up}{LCtrl Up}

; *e::send {LCtrl Down}{k}{LCtrl Up}{LShift Down}{,}{LShift Up} ;select inside angled brackets ! "Quick and Simple Text Selection" (extension.selectAngleBrackets)
; *h::send {LCtrl Down}{k}{LCtrl Up}{LShift Down}{.}{LShift Up} ;select inside HTML tag ! "Quick and Simple Text Selection" (extension.selectInTag)
; *[::send {blind}{LCtrl Down}{k}{LCtrl Up}{[}   ;select inside square/curly bracket ! "Quick and Simple Text Selection"
*b::send {blind}{F13} ;(Flip case) flip to lower/upper/camal/firstUpper case !"change-case" (extension.changeCase.lower, extension.changeCase.upper, extension.changeCase.upperFirst)
*.::send {blind}{F14} ;swap argument right !"Any Swap" (anySwap.forward)
*,::send {blind}{F15} ;swap argument left (anySwap.Backward)
*q::send {blind}{F16} ;(Quote) select inside quote !"Bracket Select" (bracket-select.select)
*m::send {blind}{F17} ;(Member) jump to next/previous member !"Go to Next/Previous Member" (gotoNextPreviousMember.nextMember, gotoNextPreviousMember.previousMember)
*e::send {blind}{LCtrl Down}{l}{LCtrl Up}{e} ;Balance (outward)

*;::send {blind}{LCtrl Down}{LShift Down}{;}{LShift Up}{LCtrl Up}    ;add ;: at end of line !Semicolon Insertion Shortcut

; *s::send {LCtrl Down}{LShift Down}{LAlt Down}{g}{LAlt Up}{LShift Up}{LCtrl Up} ;(Select to)
*f::send {Blind}{F18} ; Metago
*s::send {Blind}{F19}
*d::send {LAlt Down}{d}{LAlt Up} ;(Delete to)
; *d::send {Blind}{Delete}

; 1::send {LCtrl Down}{k}{LCtrl Up}{LCtrl Down}{i}{LCtrl Up}   ;display hover
; 2::send {LAlt Down}{F12}{LAlt Up} ;peek definition
; 3::send {LShift Down}{LAlt Down}{h}{LAlt Up}{LShift Up} ;hierarchy
; 4::send {LCtrl Down}{LShift Down}{o}{LShift Up}{LCtrl Up} ;goto symbol
; 5::send {F12} ;goto definition
; 6::send {LCtrl Down}{d}{t}{LCtrl Up}   ;transpose

; *b::send {end}{space}{{}{}}{left}{enter}    ;add bracket{}and start a new line
*n::send {LCtrl Down}{k}{LCtrl Up}{n}

;;;standalone keys: "[" key send DELETE, Use it if the Delete key is distant on your keyboard.
; *=::Send {Blind}{BackSpace} ;(Backspace)
; *-::Send {Blind}{Delete} ;(Delete)
; ^\::Send {LShift Down}{end}{LShift Up}{BackSpace} ;don't send {delete} to avoid triggering the alt+ctrl+delete system-wide command on windows
;; ^[::Send {LCtrl Down}{Delete}{LCtrl Up}

*`::Escape ;backtick "`" key to send ESCAPE

*1::send {Blind}{!} ;
*2::send {Blind}{@}
*3::send {Blind}{#}
*4::send {Blind}{$}
*5::send {Blind}{`%}
*6::send {Blind}{^}

; *6::Send {Blind}{Delete}
*7::Send {Blind}{Delete} ;
*8::Send {Blind}{BackSpace} ;(Backspace)
; *8::Sendmode("{Blind}{BackSpace}", "{Delete}")
*9::Send {Blind}{_}    ;
*0::Send {Blind}{-} ;
*-::Send {Blind}{=} ;
*[::Send {Blind}{Enter} ;

#F11::
; Send, ^s ; To save a changed script
Sleep, 300 ; give it time to save the script
Reload
Return

#F12::
Suspend, Toggle
if (A_IsSuspended) {
    SetCapsLockState, Off
}
else {
    SetCapsLockState, AlwaysOff
}
Return

; */::Send {blind}{?} ;
; *'::Send {blind}{"} ;
;;;END of standalone keys

; CapsLock Mode 1: double press CapsLock to turn on, single press to turn off..
; CapsLock::
;     ; MsgBox, %A_PriorHotkey%
;     if (A_PriorHotkey != "*Capslock Up" or A_TimeSincePriorHotkey > timeout * 1000)
;     {
;         ; Too much time between presses, so this isn't a double-press
;         KeyWait, CapsLock
;         SetCapsLockState, off
;         CLState := 0
;         return
;     }
;     SetCapsLockState, On ;double-pressed
;     CLState := 1
; return

; ; CapsLock Mode 2: double press CapsLock to turn it on/off..
; CapsLock::
;     ; MsgBox, %A_PriorHotkey%
;     if (A_PriorHotkey == "*Capslock Up" and A_TimeSincePriorHotkey < timeout * 1000)
;     {
;         KeyWait, CapsLock

;         if GetKeyState("CapsLock", "T")
;         {
;             SetCapsLockState, off
;             CLState := 0
;         }
;         else
;         {
;             SetCapsLockState, on
;             CLState := 1
;         }
;     }
; Return

; *Capslock Up:: ; Fire the hotkey even if extra modifiers are being held down.
;     if (double_shift_for_caps == 1)
;     {
;         SetCapsLockState, off
;     }
;     else
;     {
;         if (CLState == 0)
;             SetCapsLockState, off
;     }
; return

Capslock Up::
SetCapsLockState, AlwaysOff
return

SendMode(key, mode) {
    LAlt := GetKeyState("LALT", "P")
    RAlt := GetKeyState("RALT", "P")

    if (LAlt || RAlt) {
        switch mode {
            case "assignment": Send, %key%=
            case "string": Send, %key%
            Default: Send, %mode% ; switch
        }
    }
    else {
        Send, %key%
    }
}

CapsLock & j::Send {Blind}{1}
CapsLock & k::Send {Blind}{2}
CapsLock & l::Send {Blind}{3}
CapsLock & u::Send {Blind}{4}
CapsLock & i::Send {Blind}{5}
CapsLock & o::Send {Blind}{6}
CapsLock & 7::Send {Blind}{7}
CapsLock & 8::Send {Blind}{8}
CapsLock & 9::Send {Blind}{9}
CapsLock & n::Send {Blind}{0}
CapsLock & p::SendMode("{+}", "assignment") ;P for Plus
CapsLock & 0::SendMode("{-}", "assignment") ;
CapsLock & m::SendMode("{*}", "assignment") ;m for Multiply
CapsLock & /::SendMode("{/}", "assignment")
CapsLock & h::SendMode("{&}", "assignment") ;
CapsLock & g::SendMode("{|}", "assignment") ;
CapsLock & `;::SendMode("{:}", "assignment")
CapsLock & e::SendMode("{<}", "assignment")
CapsLock & r::SendMode("{>}", "assignment")
CapsLock & t::SendMode("{-}{>}", "{=}{>}") ;-> (pointing To)

CapsLock & q::Send {[}
CapsLock & w::Send {]}
CapsLock & d::Send {(}
CapsLock & f::Send {)}
CapsLock & c::Send {{}
CapsLock & v::Send {}}

; CapsLock & 1::SendMode("{!}", "assignment")
; CapsLock & 2::Send {@}
; CapsLock & 3::Send {#}
; CapsLock & 4::Send {$}
; CapsLock & 5::SendMode("{`%}", "assignment")
; CapsLock & 6::SendMode("{^}", "assignment") ;xor B

; CapsLock & `::SendMode("{A}","{``}")
; CapsLock & !::SendMode("{B}", "{!}{=}")
; CapsLock & @::Send {C}
; CapsLock & #::Send {D}
; CapsLock & $::Send {E}
; CapsLock & %::SendMode("{F}", "{%}{=}") ;
;
; CapsLock & `::Send {0}
; CapsLock & !::Send {1}
; CapsLock & @::Send {2}
; CapsLock & #::Send {3}
; CapsLock & $::Send {4}
; CapsLock & %::Send {5}
; CapsLock & ^::Send {6}

; CapsLock & `::SendMode("{``}","{~}")
CapsLock & `::Send {``}
CapsLock & !::SendMode("{!}", "assignment") ;
CapsLock & @::SendMode("{@}", "{}") ;
CapsLock & $::SendMode("{$}", "{$}{{}") ;
CapsLock & %::SendMode("{`%}", "{`%}{=}")
CapsLock & ^::SendMode("{^}", "assignment")   ;

CapsLock & y::Send {?} ;
CapsLock & b::Send {~} ;
; CapsLock & s::SendMode(Chr(34), Chr(39))
CapsLock & s::Send {"}
CapsLock & a::Send {'} ;
CapsLock & z::Send {\} ;

; CapsLock & `::Send {``}

;placeholder:
CapsLock & x::Send {x} ;
CapsLock & =::Send {=} ;
CapsLock & -::Send {=}
CapsLock & [::Send {Blind}{Enter} ;
CapsLock & ]::Send {]} ;
CapsLock & ,::Send {,} ;
CapsLock & .::Send {.} ;
CapsLock & \::Send {Delete} ;
CapsLock & Backspace::Send {Backspace} ;
CapsLock & Enter::Send {Enter} ;
CapsLock & Space::Send {Space} ;
CapsLock & AppsKey::Send {} ;
; CapsLock & @::SendMode("ummmmm@gmail.com", "string")

; ;disable keys:
;disable keys:
;
; <+9::return ;disable left shift + 9
; <++::return
; <+8::return
; <+[::return
; <+]::return
; *[::return
; #l::return

Shift_Down:
    ;    tooltip, % "[" A_ThisHotkey "]" ++test ;"`nA_PriorKey=" A_PriorKey    ; if you hold down shift, you'll see this loops after each timeout, so Shift is a repeat key just like any letter, it keeps getting spammed
    if (caps_on)
    {
        SetCapsLockState, Off
        caps_on := false
        return
    }

    trigger_shift_key := A_ThisHotkey ; needs to be set because A_ThisHotkey gets overwritten by the Up hotkey
    , waiting_for_input := 1

    Send, {%trigger_shift_key% down}
    Input, key, V M L1 T%timeout%, %end_keys%
    ; inputErrorLevel := ErrorLevel

    if (ErrorLevel == "EndKey:LShift") || (ErrorLevel == "EndKey:RShift")
    {
        KeyWait, % SubStr(ErrorLevel, 8) ; careful, keywait sets its own errorlevel from this point forward
        if (double_shift_for_caps)
        {
            ; tooltip, a second shift press occurred.`ntrigger_shift_key: %trigger_shift_key%`ninputErrorLevel: %inputErrorLevel%
            ; sleep, 1000
            SetCapsLockState, On
            caps_on := true
        }
    }

    ; ; allow Shift,Space,Space,Space(etc),Letter to work:
    ; if (skip_spacebar)
    ;     while (key = " ")
    ;     Input key, V M L1 T%timeout%, %end_keys%

    ; tooltip, key=[%key%]`nA_ThisHotkey=[%A_ThisHotkey%]`ntrigger_shift_key=[%trigger_shift_key%]`ninputErrorlevel=%inputErrorLevel%`nhotkeys back on

    ;
    if !(GetKeyState(A_ThisHotkey))
    ; if !(GetKeyState(LShift))
        Send, {%trigger_shift_key% Up}
    waiting_for_input := 0 ; the order of this line could possibly matter, this seems like the best order
    Hotkey, LShift, on
    Hotkey, RShift, on
    Hotkey, LShift Up, on
    Hotkey, RShift Up, on
return

Shift_Up:
    ; tooltip, [%A_ThisHotkey%]`nshift_key=%trigger_shift_key%
    ;
    ; if we pressed and released Shift, then the down hotkey is waiting for the next char input
    ; so we want to turn off these hotkeys, so that we can detect another LShift as the Input EndKey
    if (waiting_for_input)
    {
        ; tooltip, turning off hotkeys
        Hotkey, RShift, off
        Hotkey, RShift Up, off
        Hotkey, LShift, off
        Hotkey, LShift Up, off
    }

    ; else, the down hotkey is no longer waiting for input.
    ; this only fires if the Up hotkey was triggered AFTER the Input was complete
    ; which means shift was held down during the Input, resulting in a normal Shift+letter simultanous chord.
    ; this is needed because without it, then shift would get 'stuck' down.
    ; test: hold down Shift, and the down hotkey above fires. while still holding shift, we press a letter.
    ; the Input cmd captures the letter and then finally its supposed to Send Shift Up
    ; but we're still physically holding down Shift, so i don't think the virtual Send Shift Up ever goes through
    ; or if it does go through, it somehow blocks our real Shift up release
    else
    {
        Send, {%A_ThisHotkey%}
    }
return
;   a;dljsdkfJJsakjfLLllllL=