%include "io.inc"

section .bss
    x1 resb 4
    x2 resb 4
    y1 resb 4
    y2 resb 4
    res resb 4
    help resb 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_CHAR x1
    GET_UDEC 4, y1
    GET_CHAR x2
    GET_CHAR x2
    GET_UDEC 4, y2
    
    mov ebx, dword[x1]
    mov eax, dword[x2]
    sub eax, 'A'
    sub ebx, 'A'
    add eax, 1
    add ebx, 1
    sub eax, ebx   
    mov dword[res], eax
    
    mov eax, dword[res]; abs
    mov edx, eax
    sar edx, 31
    xor eax, edx
    sub eax, edx
    mov dword[res], eax


    mov ebx, dword[y1]
    mov eax, dword[y2]
    sub eax, ebx
    mov dword[help], eax

    
    mov eax, dword[help]; abs
    mov edx, eax
    sar edx, 31
    xor eax, edx
    sub eax, edx
    mov dword[help], eax

    
    mov eax, dword[res]
    mov ebx, dword[help]
    add eax, ebx
    mov dword[res], eax
    
    PRINT_UDEC 1, res
    

    xor eax, eax
    ret