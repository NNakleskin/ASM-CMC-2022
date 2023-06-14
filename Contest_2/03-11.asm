%include "io.inc"

section .bss 
    a resb 4
    b resb 4

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, a
    GET_UDEC 4, b
    
    mov eax, dword[a]
    mov ebx, dword[b]
    cmp eax, ebx
    jng mark
    
    mov ebx, dword[a]
    mov eax, dword[b]
    
    mark:
        cdq
        div ebx
        mov eax, ebx
        mov ebx, edx
        cmp ebx, 0
        jne mark
    
    PRINT_UDEC 4, eax
    xor eax, eax
    ret