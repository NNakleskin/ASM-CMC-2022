section .bss
    n resb 4
    array resb 4
    max resb 4

section .rodata
    op dw `%d`, 0

section .text
extern printf
extern scanf
extern malloc
extern free
global main
main:
    mov ebp, esp; for correct debugging
    sub esp, 4
    push n
    push op
    call scanf
    add esp, 12
    
    mov dword[max], 1
    
    mov eax, dword[n]
    imul eax, 4
    
    sub esp, 8
    push eax
    call malloc
    add esp, 12
    
    mov dword[array], eax
    
    xor ebx, ebx
    .scanf:
        mov eax, dword[array]
        lea eax, [eax + 4 * ebx]
        sub esp, 4
        push eax
        push op
        call scanf
        add esp, 12
        inc ebx
        cmp ebx, dword[n]
        jne .scanf
    
    xor ebx, ebx
    mov edi, 1
    .find:
        inc ebx
        cmp ebx, dword[n]
        je .fin
        mov eax, dword[array]
        
        lea ecx, [eax + 4 * ebx]
        mov ecx, dword[ecx]
        
        mov esi, ebx
        dec esi
        lea edx, [eax + 4 * esi]
        mov edx, dword[edx]
        
        cmp ecx, edx
        jg .add
        jmp .not
        .add:
            inc edi
            mov eax, dword[max]
            cmp eax, edi
            jg .find
            mov dword[max], edi
            jmp .find
        .not:
            mov edi, 1
            jmp .find

    
    .fin:
    sub esp, 4
    push dword[max]
    push op
    call printf
    add esp, 12
    
    sub esp, 8
    push dword[array]
    call free
    add esp, 12
    
    xor eax, eax
    ret