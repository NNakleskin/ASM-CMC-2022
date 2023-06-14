%include "io.inc"

section .bss
    month resb 4
    day resb 4
    res resb 4

section .text
global CMAIN
CMAIN:
    GET_DEC 4, month
    GET_DEC 4, day
    
    mov eax, dword[month]
    sub eax, 1
    imul eax, 42
    mov dword[res], eax
    
    mov eax, dword[month]
    mov edx, 0
    mov ebx, 2
    div ebx
    
    mov ebx, dword[res]
    sub ebx, eax
    mov eax, dword[day]
    add ebx, eax
    
    PRINT_DEC 4, ebx
    
    xor eax, eax
    ret