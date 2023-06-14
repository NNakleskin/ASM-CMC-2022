section .bss
    n resb 4
    k resb 4
    
section .rodata
    op dw "%u", 0
    op2 dw `%u\n`, 0

section .text
extern scanf
extern printf
extern labs
global main
main:
    mov ebp, esp; for correct debugging
    sub esp, 4
    push n
    push op
    call scanf
    add esp, 12
    
    sub esp, 4
    push k
    push op
    call scanf
    add esp, 12
    
    mov ecx, 32
    sub ecx, dword[k]
    mov ebx, dword[n]
    
    sal ebx, cl
    ror ebx, cl

    
    
    sub esp, 4
    push ebx
    push op2
    call printf
    add esp, 12
    
    
    xor eax, eax
    ret