%include "io.inc"
section .bss
    a resd 1
    b resd 1
    c resd 1
    d resd 1
    e resd 1
    f resd 1
    count resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, a
    GET_UDEC 4, b
    GET_UDEC 4, c
    GET_UDEC 4, d
    GET_UDEC 4, e
    GET_UDEC 4, f
    
    mov eax, dword[e]
    mov ebx, dword[f]
    add eax, ebx
    mov ebx, dword[a]
    imul eax, ebx
    mov dword[count], eax
    
    
    mov eax, dword[d]
    mov ebx, dword[f]
    add eax, ebx
    mov ebx, dword[b]
    imul eax, ebx
    add dword[count], eax
    
    
    mov eax, dword[e]
    mov ebx, dword[d]
    add eax, ebx
    mov ebx, dword[c]
    imul eax, ebx
    add dword[count], eax
    
    PRINT_DEC 4, count
    
    xor eax, eax
    ret