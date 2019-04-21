[ENABLE]

aobscanmodule(noclip_entry, metro.exe, 89 87 E8 00 00 00 41)
alloc(noclip_cave, 0x1000, "metro.exe"+89E02F)

label(return)

noclip_cave:
    mov [rdi+000000E8], eax
    jmp return

noclip_entry:
    jmp noclip_cave
    nop
return:

registersymbol(noclip_entry)

[DISABLE]

noclip_entry:
    mov [rdi+000000E8], eax

unregistersymbol(noclip_entry)
dealloc(noclip_cave)
