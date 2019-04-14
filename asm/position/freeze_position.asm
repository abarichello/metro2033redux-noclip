[ENABLE]

metro.exe+89E029:
  jmp metro.exe+89E06B  // Skip saving of calculated positions to memory

[DISABLE]

metro.exe+89E029:
  je metro.exe+89E06B
