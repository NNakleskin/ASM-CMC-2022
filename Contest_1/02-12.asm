section .bss
    a resb 4
    temp resb 4
    help resb 4
    suit resb 16
    num resb 52
    
section .rodata
    op dw `%d`, 0
    op2 dw `%c`, 0
    op3 dw `%d\n`, 0
    

section .text
extern printf
extern scanf
global main
main:
    mov ebp, esp; for correct debugging
    
    mov dword[suit], "S"
    mov dword[suit + 4], "C"
    mov dword[suit + 8], "D"
    mov dword[suit + 12], "H"
    
    mov dword[num], "2"
    mov dword[num + 4], "3"
    mov dword[num + 8], "4"
    mov dword[num + 12], "5"
    mov dword[num + 16], "6"
    mov dword[num + 20], "7"
    mov dword[num + 24], "8"
    mov dword[num + 28], "9"
    mov dword[num + 32], "T"
    mov dword[num + 36], "J"
    mov dword[num + 40], "Q"
    mov dword[num + 44], "K"
    mov dword[num + 48], "A"
    
    
    
    
    sub esp, 4
    push a
    push op
    call scanf
    add esp, 12
    
    mov eax, dword[a]
    sub eax, 1
    mov ebx, 13
    cdq
    div ebx
    
    
    
    mov ebx, dword[num + 4 * edx]
    mov dword[temp], ebx
    
    mov eax, dword[suit + 4 * eax]
    mov dword[help], eax
    

    sub esp, 4
    push dword[temp]
    push op2
    call printf
    add esp, 12
    
    sub esp, 4
    push dword[help]
    push op2
    call printf
    add esp, 12
    
    xor eax, eax
    ret