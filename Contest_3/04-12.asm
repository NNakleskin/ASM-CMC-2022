%include "io.inc"

section .bss
    x1 resb 4
    y1 resb 4
    x2 resb 4; 1
    y2 resb 4; 4
    x3 resb 4; 3
    y3 resb 4; 2
    help resb 4
    help2 resb 4
    b resb 4

    

section .text

euc:
    push ebp
    mov ebp, esp
    push ecx
    push ebx
    
    mov eax, dword[ebp + 8]
    mov ebx, dword[ebp + 12]
    
    while:
        cmp ebx, 0
        je after
        cdq
        div ebx
        mov eax, ebx
        mov ebx, edx
        jmp while
        
    after:
    pop ebx
    pop ecx
    
    mov esp, ebp
    pop ebp
    ret


count:
    push ebp
    mov ebp, esp
    push ebx
    mov eax, dword[ebp + 8]
    mov ebx, dword[ebp + 12]
    sar ebx, 1
    sub eax, ebx
    add eax, 1
    pop ebx
    mov esp, ebp
    pop ebp
    ret
    
abs_int:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]; abs
    mov edx, eax
    sar edx, 31
    xor eax, edx
    sub eax, edx
    mov esp, ebp
    pop ebp
    ret

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_UDEC 4, x1
    GET_UDEC 4, y1
    GET_UDEC 4, x2
    GET_UDEC 4, y2
    GET_UDEC 4, x3
    GET_UDEC 4, y3


    mov eax, dword[x1]
    mov ebx, dword[x2]
    sub eax, ebx
    push eax
    call abs_int
    add esp, 4
    mov dword[help], eax

    mov eax, dword[y1]
    mov ebx, dword[y2]
    sub eax, ebx
    push eax
    call abs_int
    add esp, 4

    mov ebx, dword[help]

    push eax
    push ebx
    call euc
    add esp, 8

    mov ecx, eax

    mov eax, dword[x2]
    mov ebx, dword[x3]
    sub eax, ebx
    push eax
    call abs_int
    add esp, 4
    mov dword[help], eax

    mov eax, dword[y2]
    mov ebx, dword[y3]
    sub eax, ebx
    push eax
    call abs_int
    add esp, 4

    mov ebx, dword[help]

    push eax
    push ebx
    call euc
    add esp, 8

    add ecx, eax

    mov eax, dword[x3]
    mov ebx, dword[x1]
    sub eax, ebx
    push eax
    call abs_int
    add esp, 4
    mov dword[help], eax

    mov eax, dword[y3]
    mov ebx, dword[y1]
    sub eax, ebx
    push eax
    call abs_int
    add esp, 4


    mov ebx, dword[help]

    push eax
    push ebx
    call euc
    add esp, 8
    
    add ecx, eax
    mov dword[b], ecx
    
 
    
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
    
    mov ebx, dword[b]
    push ebx
    push eax
    call count
    add esp, 8
    
    PRINT_DEC 4, eax
    
    
    xor eax, eax
    ret