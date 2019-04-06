[ENABLE]

metro.exe+89E029:
  jmp metro.exe+89E06B  // Skip loading of camera positions from memory

[DISABLE]

metro.exe+89E029:
  je metro.exe+89E06B
