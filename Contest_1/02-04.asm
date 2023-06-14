section .bss
    x resb 4
    n resb 4
    m resb 4
    y resb 4
    
section .rodata
    op dw "%d", 0

section .text
extern scanf
extern printf
global main
main:
    sub esp, 4
    push x
    push op
    call scanf
    add esp, 12
    
    sub esp, 4
    push n
    push op
    call scanf
    add esp, 12
    
    sub esp, 4
    push m
    push op
    call scanf
    add esp, 12
    
    sub esp, 4
    push y
    push op
    call scanf
    add esp, 12
    
    mov eax, dword[y]
    sub eax, 2011
    
    mov ebx, dword[x]
    
    mov ecx, dword[n]
    imul ecx, eax
    
    add ebx, ecx
    
    mov ecx, dword[m]
    imul ecx, eax
    
    sub ebx, ecx
    
    sub esp, 4
    push ebx
    push op
    call printf
    add esp, 12
    
    
    
    xor eax, eax
    ret