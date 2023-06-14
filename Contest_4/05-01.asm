%include "io.inc"

section .bss
    x resb 4
    

section .data
    op db "%ud", 0
    op2 db `0x%08X\n`, 0

section .text

CEXTERN printf
CEXTERN scanf



global CMAIN
CMAIN:
    .WHILE:
        sub esp, 4
        push x
        push op
        
        call scanf
        
        add esp, 12
        
        cmp eax, -1
        je .finish
        
        sub esp, 4
        push dword[x]
        push op2
        
        call printf
        
        add esp, 12
        jmp .WHILE
    
    .finish:
    
    xor eax, eax
    ret