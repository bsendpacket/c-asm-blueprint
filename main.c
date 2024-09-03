#include "asm_functions.h"
#include <stdio.h>
#include <windows.h>

int main() {
#ifdef _WIN64
  const char *arch = "x64";
#else
  const char *arch = "x86";
#endif

  int result = asm_add(5, 3);
  printf("Arch: %s\n", arch);
  printf("The sum of 5 and 3 is: %d\n", result);

  MessageBoxA(NULL, "Did the assembly work?", "NASM TEST", MB_YESNOCANCEL);
  return 0;
}
