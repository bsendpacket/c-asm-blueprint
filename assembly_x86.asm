section .text
global ___asm_add

___asm_add:
  ; Function prologue
  push ebp
  mov ebp, esp

  ; Add the two parameters
  ; In 32-bit cdecl calling convention, parameters are on the stack
  mov eax, [ebp + 8]   ; First parameter
  add eax, [ebp + 12]  ; Add second parameter to eax

  ; Function epilogue
  mov esp, ebp
  pop ebp
  ret
