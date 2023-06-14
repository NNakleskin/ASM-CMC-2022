section .bss
    a resb 4
    
section .rodata
    op dw `%d`, 0
    op2 dw `%d\n`, 0

section .text
extern scanf
extern printf
global main
main:
    sub esp, 4
    push a
    push op
    call scanf
    add esp, 12
    
    mov eax, dword[a]; abs
    mov edx, eax
    sar edx, 31
    xor eax, edx
    sub eax, edx
    
    sub esp, 4
    push eax
    push op2
    call printf
    add esp, 12
    
    xor eax, eax
    ret