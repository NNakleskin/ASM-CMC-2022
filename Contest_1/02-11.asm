%include "io.inc"

section .bss
    x resd 1
    y resb 1

section .text
global CMAIN
CMAIN:
    GET_CHAR x
    GET_DEC 4, y
    
    sub dword[x], 'A'

    mov eax, dword[x]
    mov ebx, 7
    sub ebx, eax
    mov dword[x], ebx
    
    mov eax, dword[y]
    mov ebx, 8
    sub ebx, eax
    mov dword[y], ebx
    
    mov eax, dword[x]
    mov ebx, dword[y]
    imul eax, ebx
    mov dword[x], eax
    
    mov eax, dword[x]
    mov edx, 0
    mov ebx, 2
    div ebx
    mov dword[x], eax
 
    PRINT_DEC 4, x
      
    xor eax, eax
    ret