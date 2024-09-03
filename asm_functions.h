#ifndef ASM_FUNCTIONS_H
#define ASM_FUNCTIONS_H

#ifdef _WIN64
extern int asm_add(int a, int b);
#else
extern int __asm_add(int a, int b);
#define asm_add __asm_add
#endif

#endif // ASM_FUNCTIONS_H
