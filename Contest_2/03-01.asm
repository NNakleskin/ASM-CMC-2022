section .bss
    max resb 12
    n resb 4
    temp resb 4
    
section .rodata
    op dw `%d`, 0
    op2 dw `%d `, 0
    op3 dw `%d\n`, 0

section .text
extern printf
extern scanf
global main
main:
    mov ebp, esp; for correct debugging
    mov dword[max], -2147483648
    mov dword[max + 4], -2147483648
    mov dword[max + 8], -2147483648
    
    sub esp, 4
    push n
    push op
    call scanf
    add esp, 12
    
    xor ebx, ebx

    
    .scanf:
        inc ebx
        sub esp, 4
        push temp
        push op
        call scanf
        add esp, 12
        
        mov eax, dword[temp]
        cmp dword[max], eax
        jle .save_1
        cmp dword[max + 4], eax
        jle .save_2
        cmp dword[max + 8], eax
        jle .save_3
        .continue:
        cmp ebx, dword[n]
        je .fin
        jmp .scanf
        
        
    .save_1:
        mov eax, dword[max]
        mov ecx, dword[max + 4]
        mov dword[max + 4], eax
        mov dword[max + 8], ecx
        mov eax, dword[temp]
        mov dword[max], eax
        jmp .continue
    .save_2:
        mov eax, dword[max + 4]
        mov dword[max + 8], eax
        mov eax, dword[temp]
        mov dword[max + 4], eax
        jmp .continue
    .save_3:
        mov eax, dword[temp]
        mov dword[max + 8], eax
        jmp .continue
    
    .fin:
    sub esp, 4
    push dword[max]
    push op2
    call printf
    add esp, 12
    
    sub esp, 4
    push dword[max + 4]
    push op2
    call printf
    add esp, 12
    
    sub esp, 4
    push dword[max + 8]
    push op3
    call printf
    add esp, 12
    
    xor eax, eax
    ret