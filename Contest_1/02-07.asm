%include "io.inc"

section .bss
    a resb 1
    b resb 1
    c resb 1
    d resb 1
    res resb 4
    

section .text
global CMAIN
CMAIN:
    GET_UDEC 1, a
    GET_UDEC 1, b
    GET_UDEC 1, c
    GET_UDEC 1, d
    
    mov eax, dword[res]
    mov ebx, dword[a]
    or eax, ebx
    mov dword[res], eax
    
    mov eax, dword[res + 1]
    mov ebx, dword[b]
    or eax, ebx
    mov dword[res + 1], eax
    
    mov eax, dword[res + 2]
    mov ebx, dword[c]
    or eax, ebx
    mov dword[res + 2], eax
    
    mov eax, dword[res + 3]
    mov ebx, dword[d]
    or eax, ebx
    mov dword[res + 3], eax
    
    
    PRINT_UDEC 4, res
    xor eax, eax
    ret