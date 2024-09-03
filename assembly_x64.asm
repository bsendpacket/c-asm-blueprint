section .text
global asm_add

asm_add:
  ; Function prologue
  push rbp
  mov rbp, rsp

  ; Add the two parameters
  ; In 64-bit Windows calling convention, 
  ; the first parameter is in rcx and the second is in rdx
  mov rax, rcx    ; Move the first parameter to rax
  add rax, rdx    ; Add the second parameter to rax

  ; Function epilogue
  pop rbp
  ret
