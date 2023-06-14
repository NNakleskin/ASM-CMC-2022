%include "io.inc"

section .bss
    x1 resb 4
    y1 resb 4
    x2 resb 4; 1
    y2 resb 4; 4
    x3 resb 4; 3
    y3 resb 4; 2

    

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, x1
    GET_UDEC 4, y1
    GET_UDEC 4, x2
    GET_UDEC 4, y2
    GET_UDEC 4, x3
    GET_UDEC 4, y3
    
    
    mov eax, dword[x2]; (x2 - x1)
    mov ebx, dword[x1]
    sub eax, ebx
    mov dword[x2], eax
    
    mov eax, dword[y3]; (y3 - y1)
    mov ebx, dword[y1]
    sub eax, ebx
    mov dword[y3], eax
    
    mov eax, dword[x3]; (x3 - x1)
    mov ebx, dword[x1]
    sub eax, ebx
    mov dword[x3], eax

    
    mov eax, dword[y2]; (y2 - y1)
    mov ebx, dword[y1]
    sub eax, ebx
    mov dword[y2], eax

    
    mov eax, dword[x2]; (x2 - x1)(y3 - y1)
    mov ebx, dword[y3]
    imul eax, ebx
    mov dword[x2], eax
    
    
    mov eax, dword[x3]; (x3 - x1)(y2 - y1)
    mov ebx, dword[y2]
    imul eax, ebx
    mov dword[x3], eax

    
    mov eax, dword[x2]; (x2 - x1)(y3 - y1) - (x3 - x1)(y2 - y1)
    mov ebx, dword[x3]
    sub eax, ebx
    mov dword[x2], eax


    mov eax, dword[x2]; abs
    mov edx, eax
    sar edx, 31
    xor eax, edx
    sub eax, edx
    mov dword[x2], eax
    
    mov eax, dword[x2]; 1/2 * (x2 - x1)(y3 - y1) - (x3 - x1)(y2 - y1)
    mov edx, 0
    mov ebx, 2
    div ebx
    
    PRINT_UDEC 4, eax

    
    imul edx, 5
    
    PRINT_CHAR "."
    
    PRINT_UDEC 4, edx
    
    
    
    xor eax, eax
    ret