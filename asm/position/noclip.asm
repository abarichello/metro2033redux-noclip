// Coordinate Offsets:
// X: rdi+000000E8
// Z: rdi+000000EC
// Y: rdi+000000F0

[ENABLE]

define(DISP, 2000)

aobscanmodule(noclip_entry, metro.exe, 89 87 E8 00 00 00 41)
alloc(noclip_cave, 0x1000, "metro.exe"+89E02F)

label(return)

noclip_cave:
    pushf
    // push    'X'
    // call    USER32.GetAsyncKeyState
    // test    ax, ax
    // je      skip_x
    popf
    add     [rdi+000000E8], DISP
    jmp     return

noclip_entry:
    jmp     noclip_cave
    nop
return:

registersymbol(noclip_entry)
registersymbol(noclip_cave)

[DISABLE]

noclip_entry:
    mov     [rdi+000000E8], eax

unregistersymbol(noclip_cave)
unregistersymbol(noclip_entry)
dealloc(noclip_cave)
