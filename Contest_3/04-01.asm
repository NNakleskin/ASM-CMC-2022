%include "io.inc"

section .bss
    a1 resb 4
    a2 resb 4
    a3 resb 4
    a4 resb 4
    d1 resb 4
    d2 resb 4
    d3 resb 4
    

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

global CMAIN
CMAIN:
    GET_UDEC 4, a1
    GET_UDEC 4, a2
    GET_UDEC 4, a3
    GET_UDEC 4, a4
    
    push dword[a1]
    push dword[a2]
    
    call euc 
    
    pop dword[a2]
    pop dword[a1]
    
    
    mov dword[d1], eax
    
    
    push dword[d1]
    push dword[a3]
    
    call euc 
    
    pop dword[a3]
    pop dword[d1]
    
    mov dword[d2], eax
    
    push dword[d2]
    push dword[a4]
    
    call euc 
    
    pop dword[a4]
    pop dword[d2]
    
    
    PRINT_UDEC 4, eax
    
    
    
    xor eax, eax
    ret